% Lessons learnt: Matching with the first frame is the way forward
% Block size of 11 + seems to work well, but not lower (i.e. 5)
% Projective transform doesn't always work particularly well
% 5 pyramid levels work better than 3 for Bassento but this needs testing
% for the other examples.
% Having a higher fraction could cause a greater skewness in the number of
% features detected between the different quadrants
% for 11 there are more features at the top, for 21, more in the middle
% 11 is better than 21 for the initial iteration
% Optimal solution seems to be a first pass at 21px_5pyra_0.1, with a second
% pass with 5px_5pyra_0.1, but 11px as a first pass also works well.

function []  = KLT_stabiliseImageInput(app, V, totNum)
pass = 1;
answer = 'Yes';
set(app.RUNButton,'Text','Stabilising image sequence');
while pass < 3
    s3 = 1;
    if pass == 1 % initial pass settings
        fractionUse = 0.1;
        pyramids = 5;
        blockSize = 21;
        totNum =  V.NumFrames;
    elseif pass == 2 % refines  the solution
        fractionUse = 0.1;
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
            
            % rollback for newer versions of Matlab - 20220120
            try
                app.objectFrame   = im2uint8(images.internal.rgb2graymex(readFrame(V))); % new method for large files
            catch
                app.objectFrame   = rgb2gray(readFrame(V));
            end
            
            %collatedFrames{s3} = app.objectFrame;
            app.firstFrame = app.objectFrame;
            importedBoundBox = app.boundaryLimitsPx;
        elseif s3 > 1
            V.CurrentTime = s3.*1/app.videoFrameRate; % access the s3 frame
            
            % rollback for newer versions of Matlab - 20220120
            try
                app.objectFrame   = im2uint8(images.internal.rgb2graymex(readFrame(V))); % new method for large files
            catch
                app.objectFrame   = rgb2gray(readFrame(V));
            end
            
            %collatedFrames{s3} = app.objectFrame;
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
        
		% This section looks within each of the four quadrants of the image and stores the best 10% of features present within each quadrant
        T1 = find (points.Location(:,1) < (size(app.firstFrame,2)./2) & points.Location(:,2) < (size(app.firstFrame,1)./2)); % top left
        limit1 = length(T1);
        if limit1 > 0
            pointsIn = points(T1);
            bestPoints = pointsIn.selectStrongest(round(limit1.*fractionUse));
        else
            bestPoints = [];
        end
        
        T2 = find (points.Location(:,1) > (size(app.firstFrame,2)./2) & points.Location(:,2) < (size(app.firstFrame,1)./2));  % top right
        limit2 = length(T2);
        if limit2 > 0
            pointsIn = points(T2);
            bestPoints = [bestPoints; pointsIn.selectStrongest(round(limit2.*fractionUse))];
        end
        
        T3 = find (points.Location(:,1) < (size(app.firstFrame,2)./2) & points.Location(:,2) > (size(app.firstFrame,1)./2));  % bottom left
        limit3 = length(T3);
        if limit3 > 0
            pointsIn = points(T3);
            bestPoints = [bestPoints; pointsIn.selectStrongest(round(limit3.*fractionUse))];
        end
        
        T4 = find (points.Location(:,1) > (size(app.firstFrame,2)./2) & points.Location(:,2) > (size(app.firstFrame,1)./2));  % bottom right
        limit4 = length(T4);
        if limit4 > 0
            pointsIn = points(T4);
            bestPoints = [bestPoints; pointsIn.selectStrongest(round(limit4.*fractionUse))];
        end
        
	    % error catch for no ROI
        if isempty(importedBoundBox) == true 
            message = sprintf('Error! \nNo ROI defined.');
            msgbox(message, 'Error','error');
            TextIn = ' No ROI defined, please define and try again';
            TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
            TimeIn = strjoin(TimeIn, ' ');
            app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
            KLT_printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
            error('Breaking out of function');
        end

        % Clip the features in the channel from the template
        [in, ~] = inpolygon(bestPoints.Location(:,1),bestPoints.Location(:,2),importedBoundBox(:,1),importedBoundBox(:,2));
        bestPoints = bestPoints(~in);
        
        % Initialize the tracker for the first frame
        tracker2 = vision.PointTracker('MaxBidirectionalError', 1,...
            'BlockSize', [blockSize blockSize],'NumPyramidLevels',pyramids); % Create a new tracker; error allowed of up-to one cell
        
        if isempty(bestPoints.Location) % if no features available
            if  s3 == 1
                % Display the updated status
                TextIn = {['No features suitable for stabilisation were detected, original images will be the output']};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
        else
        
        initialize(tracker2, bestPoints.Location, app.firstFrame);
        clear oldInliersExtract temp2 app.k1
        
        % Next step to the current frame and find all matches
        [newPointsT, isFound] = step(tracker2, app.currentFrame); % Track the features through the next frame
        release(tracker2); %Release the tracker
        visiblePoints = double(newPointsT(isFound, :));
        oldInliers = double(bestPoints.Location(isFound, :));
        
        % Conduct a similarity transformation and plot the results
        % Initial -- can only be used with golabal transformations
        mytform = fitgeotrans(visiblePoints,oldInliers, 'similarity');
        [xFig, yFig] = transformPointsForward(mytform, visiblePoints(:,1),visiblePoints(:,2));
        
        % For higehr-order transformations, the Inverse must be called but
        % teh imwarp command needs to be modified for it to work
        %mytform = fitgeotrans(oldInliers, visiblePoints, 'polynomial', 3); %'pwl');
        %mytform = fitgeotrans(oldInliers, visiblePoints, 'pwl'); %'pwl');
        %mytform = cp2tform(oldInliers, visiblePoints, 'piecewise linear') ;
        %[xFig, yFig] = transformPointsInverse(mytform, visiblePoints(:,1),visiblePoints(:,2));
        %[xFig, yFig] = tforminv(mytform, visiblePoints(:,1),visiblePoints(:,2))
        %[xFig, yFig] = transformPointsInverse(mytform, visiblePoints(:,1),visiblePoints(:,2));
        
        app.currentFrame = imwarp(app.currentFrame,mytform,'OutputView',imref2d(size(app.currentFrame)));
        if s3 > 1
            %clf(gcf);
            %h1 = imshow(app.currentFrame); hold on;
            %h2 = scatter(xFig, yFig,'r','+');
            %title (['Results of image transformation and tie-points used for frame ' num2str(s3)])
        end
        
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
    KLT_creatingVideosFromImages(app, pass, answer); % Create and play the stabilised video
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


% assign proper first frame if not the first frame of the video
if abs(app.s2 - round(1 + (app.videoStart.*app.videoFrameRate))) < 1
    
    template = '00000';
    inputNum = num2str(app.s2);
    p1 = template(1:end-length(num2str(app.s2)));
    p2 = inputNum;
    fileNameIteration = [p1,p2];
    
    filenameJpg = [dirIn app.file(1:end-4) '_frame' fileNameIteration '.jpg' ];
    x_init = imread(filenameJpg);
    app.firstFrame = x_init;
    
end

set(app.RUNButton,'Text','Image sequence stabilisation complete');
