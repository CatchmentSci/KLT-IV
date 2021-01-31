
function []  = stabiliseImageInputPlanet(app, V, totNum)

if length(app.firstFrame) > 1
    polyNum = 1;
    looper = true;
    app.boundaryLimitsPx = {};
    [roiPoints] = KLT_readPoints(app.firstFrame,100,5,app,[])'; hold on;
    roiPoints = replace_num(roiPoints,0,NaN);
    useVals = ~isnan(roiPoints(:,1));
    app.boundaryLimitsPx{polyNum,1} = polyshape(roiPoints(useVals,1),roiPoints(useVals,2));
    plot(app.boundaryLimitsPx{polyNum,1});
    
    while looper == true
        
        answer = questdlg('Would you like to specify more stabilisation areas?', ...
            'Draw additional polygons?', ...
            {'Yes','No'});
        
        switch answer
            case 'Yes'
                polyNum = polyNum + 1;
                [roiPoints] = KLT_readPoints(app.firstFrame,100,5,app,[])'; hold on;
                roiPoints = replace_num(roiPoints,0,NaN);
                useVals = ~isnan(roiPoints(:,1));
                app.boundaryLimitsPx{polyNum,1} = polyshape(roiPoints(useVals,1),roiPoints(useVals,2));
                plot(app.boundaryLimitsPx{polyNum,1});
            case 'No'
                looper = false;
                title ('Close the window and continue');
        end
    end
    
    pass = 1;
    answer = 'Yes';
    while pass < 3
        s3 = 1;
        if pass == 1 % initial pass settings
            fractionUse = 1.00;
            pyramids = 5;
            blockSize = 21;
            totNum =  V.NumFrames;
        elseif pass == 2 % refines  the solution
            fractionUse = 1.00;
            pyramids = 5;
            blockSize = 5;
            pause (0.2); % wait for close
            V = VideoReader([app.directory_save '\stabilisedFrames\pass' num2str(pass-1) '\stabilisedFramesOut.avi']); % update the input to the stabilised video based on the first pass
            totNum =  V.NumFrames;
        end
        
        while s3 < totNum
            template = '00000';
            inputNum = num2str(s3);
            p1 = template(1:end-length(num2str(s3)));
            p2 = inputNum;
            fileNameIteration = [p1,p2];
            if s3 == 1
                V.CurrentTime = V.CurrentTime; % access the first frame
                app.objectFrame = im2uint8(images.internal.rgb2graymex(readFrame(V)));
                app.firstFrame = app.objectFrame;
                importedBoundBox = app.boundaryLimitsPx;
            elseif s3 > 1
                V.CurrentTime = s3.*1/app.videoFrameRate; % access the s3 frame
                app.objectFrame = im2uint8(images.internal.rgb2graymex(readFrame(V)));
            end
            
            A = double(app.objectFrame);
            app.rgbHR=nan(size(app.objectFrame,1),size(app.objectFrame,2),1);
            for jj = 1:1 % only one as it is a grayscale image
                app.rgbHR(:,:,jj) = reshape(A,size(app.rgbHR));
            end
            %x = app.rgbHR ./ max(app.rgbHR(:));  % Scale to [0,1]
            x = app.rgbHR./255; % No scaling
            app.currentFrame = x; % this is the starting, non-corrected orthophoto
            app.currentFrame = replace_num(app.currentFrame,NaN,0); % switch NaNs for zeros to enable tracking
            app.currentFrame = im2uint8(app.currentFrame);
            points = detectMinEigenFeatures(app.firstFrame); % set the nFrame image as the new reference to be used
            
            T1 = find (points.Location(:,1) < (size(app.firstFrame,2)./2) & points.Location(:,2) < (size(app.firstFrame,1)./2)); % top left
            limits = length(T1);
            T2 = find (points.Location(:,1) > (size(app.firstFrame,2)./2) & points.Location(:,2) < (size(app.firstFrame,1)./2));  % top right
            if length(T2) < limits; limits = length(T2); end
            T3 = find (points.Location(:,1) < (size(app.firstFrame,2)./2) & points.Location(:,2) > (size(app.firstFrame,1)./2));  % bottom left
            if length(T3) < limits; limits = length(T3); end
            T4 = find (points.Location(:,1) > (size(app.firstFrame,2)./2) & points.Location(:,2) > (size(app.firstFrame,1)./2));  % bottom right
            if length(T4) < limits; limits = length(T4); end
            pointsIn = points(T1);
            bestPoints = pointsIn.selectStrongest(round(limits.*fractionUse));
            pointsIn = points(T2);
            bestPoints = [bestPoints; pointsIn.selectStrongest(round(limits.*fractionUse))];
            pointsIn = points(T3);
            bestPoints = [bestPoints; pointsIn.selectStrongest(round(limits.*fractionUse))];
            pointsIn = points(T4);
            bestPoints = [bestPoints; pointsIn.selectStrongest(round(limits.*fractionUse))];
            
            % Clip the features in the channel from the template
            extractedPoints = [];
            for z = 1:length(importedBoundBox)
                [in, ~] = inpolygon(bestPoints.Location(:,1),bestPoints.Location(:,2),importedBoundBox{z,1}.Vertices(:,1),importedBoundBox{z,1}.Vertices(:,2));
                extractedPoints = [extractedPoints; bestPoints.Location(in,1:2)];
            end
            
            bestPoints = extractedPoints;
            bestPoints = unique(bestPoints,'rows');
            % Initialize the tracker for the first frame
            tracker2 = vision.PointTracker('MaxBidirectionalError', 1,...
                'BlockSize', [blockSize blockSize],'NumPyramidLevels',pyramids); % Create a new tracker; error allowed of up-to one cell
            initialize(tracker2, bestPoints, app.firstFrame);
            clear oldInliersExtract temp2 app.k1
            
            % Next step to the current frame and find all matches
            [newPointsT, isFound] = step(tracker2, app.currentFrame); % Track the features through the next frame
            release(tracker2); %Release the tracker
            visiblePoints = double(newPointsT(isFound, :));
            oldInliers = double(bestPoints(isFound, :));
            
            % Conduct a similarity transformation and plot the results
            % Initial -- can only be used with golabal transformations
            mytform = fitgeotrans(visiblePoints,oldInliers, 'projective');
            [xFig, yFig] = transformPointsForward(mytform, visiblePoints(:,1),visiblePoints(:,2));
            
            app.currentFrame = imwarp(app.currentFrame,mytform,'OutputView',imref2d(size(app.currentFrame)));
            if s3 > 1
                %clf(gcf);
                %h1 = imshow(app.currentFrame); hold on;
                %h2 = scatter(xFig, yFig,'r','+');
                %title (['Results of image transformation and tie-points used for frame ' num2str(s3)])
            end
            
            % Save the orthophotos
            dirIn = [app.directory_save '\stabilisedFrames\pass' num2str(pass) '\'];
            if s3 == 1
                mkdir (dirIn);
            end
            filenameJpg = [dirIn app.file(1:end-4) '_frame' fileNameIteration '.jpg' ];
            x = im2double(app.currentFrame) ./ max(im2double(app.currentFrame(:)));  % Scale to [0,1]
            
            if s3 == 1 && exist(filenameJpg,'file') > 0
                if pass == 1
                    line1 = ['Previously stabilised frames have been found in the output directory.'];
                    line2 = ['Would you like to overwrite files in:'];
                    line3 = [dirIn '?'];
                    line4 = ['If not, the previously stabilised frames will be used.'];
                    answer = questdlg([line1, newline, line2, newline, line3, newline, line4],...
                        'Overwrite previously stabilised frames?');
                end
                if strcmp(answer,'Yes') == 0
                    pass = 3;
                    if exist([app.directory_save '\stabilisedFrames\pass2\'],'dir') > 0
                        app.subDir = [app.directory_save '\stabilisedFrames\pass2\'];
                    else
                        app.subDir = [app.directory_save '\stabilisedFrames\pass1\'];
                    end
                    break
                else
                    %f1 = figure(); hold on;
                    %h1 = imshow(app.currentFrame); hold on;
                    %h2 = scatter(xFig, yFig,'r','+');
                    %title (['Results of image transformation and tie-points used for frame ' num2str(s3)])
                end
            else
                if s3 == 1
                    %f1 = figure(); hold on;
                end
                %h1 = imshow(app.currentFrame); hold on;
                %h2 = scatter(xFig, yFig,'r','+');
                %title (['Results of image transformation and tie-points used for frame ' num2str(s3)])
                
            end
            
            imwrite(x,filenameJpg)
            
            % Ensure the first frame is the reference used
            app.previousFrame = replace_num(app.firstFrame,NaN,0); % switch NaNs for zeros to enable tracking
            
            % Display the updated status
            TextIn = {['Stabilisation for frame ' num2str(s3) ' completed']};
            app.ListBox.Items = [app.ListBox.Items, TextIn'];
            KLT_printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
            s3 = s3 + 1;
        end
        
        try
            close (f1);
        catch
        end
        creatingVideosFromImages_KLT(app, pass, answer); % Create and play the stabilised video
        if pass < 2
            line1 = ['Would you like to refine the stabilisation further?'];
            line2 = ['If so, a second pass over the frames will be run'];
            answer2 = questdlg([line1, newline, line2, newline],...
                'Refine the stabilisation further?');
            if strcmp(answer2,'Yes') == 0
                pass = 3; % force the break
                app.subDir = [app.directory_save '\stabilisedFrames\pass1\'];
            else
                pass = pass + 1;
                app.subDir = [app.directory_save '\stabilisedFrames\pass2\'];
            end
        else
            pass = pass + 1;
        end
        clear answer2
    end
    
else
    %Display an error - need to load video
end

end