function []  = KLT_stabiliseImageInputGPS(app, V, totNum)

if length(app.firstFrame) > 1
    polyNum = 1;
    looper = true;
    restartWhen = (app.s2:app.iter:totNum); % Create a buffer of a few seconds
    start_s2 = app.s2;
    nFrame = app.s2; % don't overwrite s2 as it is used later in the process
    ii = 0;
    pass = 1;
    starter = 1;
    restarter = 0;
    
    previousOrtho = questdlg('Has the sequence already been orthorectified?', ...
        'Already orthorectified?', ...
        {'Yes','No'});
    
    switch previousOrtho
        case 'Yes'
            if length(app.directory) < 1
                app.directory_ortho = uigetdir; %Specify where the located where they were saved
            else
                [app.directory_ortho] = uigetdir(app.directory);
            end
            uvA = [];
            uvB = [];
            V.CurrentTime = nFrame.*1/app.videoFrameRate;
            
            % rollback for newer versions of Matlab - 20220120
            try
                app.objectFrame   = images.internal.rgb2graymex(readFrame(V)); % new method for large files
            catch
                app.objectFrame   = rgb2gray(readFrame(V));
            end
            
            KLT_orthorectification(app) % Run the starting orthoscript
            camA_previous = app.camA;
            app.camA_first = app.camA;
            %app.directory_save = fileparts(app.directory_ortho); % Modify the output directory
            
        case 'No'
            try
                delete ([app.directory_save '\stabilisedFrames\pass' num2str(pass) '\*'])
                delete ([app.directory_save '\orthorectified\*'])
            catch
            end
            
            % First orthorectify the imagery
            while nFrame < totNum
                set(app.RUNButton,'Text',strjoin({'Processing: ' int2str((nFrame-1)/totNum*100) '% Complete'},''));
                pause(0.01)
                % This is the start of the tracking sequence
                %if ~isempty(find(nFrame == restartWhen) > 0) || ii == 0 % If it is the start of a new loop or frame 1 -- enable this if only analysed frames are going to be stabilised
                if ii == 0 % if its the first frame
                    ii = 1;
                    uvA = [];
                    uvB = [];
                    V.CurrentTime = nFrame.*1/app.videoFrameRate;
                    
                    % rollback for newer versions of Matlab - 20220120
                    try
                        app.objectFrame   = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                    catch
                        app.objectFrame   = rgb2gray(readFrame(V));
                    end
                    
                    orthorectification(app) % Run the starting orthoscript
                    camA_previous = app.camA;
                    app.camA_first = app.camA;
                else %find(nFrame == restartWhen) > 0% if its not the start of a new cycle
                    V.CurrentTime = nFrame.*1/app.videoFrameRate; % access the first frame
                    
                    % rollback for newer versions of Matlab - 20220120
                    try
                        app.objectFrame   = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                    catch
                        app.objectFrame   = rgb2gray(readFrame(V));
                    end
                    
                    KLT_orthorectificationProgessive(app); % Run the continuous orthoscript to determine the movement of the UAV
                end
                %end
                nFrame = nFrame + 1;
                app.s2 = app.s2 + 1;
            end
    end
    
    % Check for stabilised frames
    previousStabilised = questdlg('Has the sequence already been stabilised?', ...
        'Already orthorectified?', ...
        {'Yes','No'});
    switch previousStabilised
        case 'Yes'
            if length(app.directory) < 1
                app.directory_stab = uigetdir; %Specify where the located where they were saved
            else
                [app.directory_stab] = uigetdir(app.directory);
            end
            %app.directory_save = fileparts(app.directory_stab); % Modify the output directory
            
        case 'No'
            % Setup the initialised state
            pass = 1;
            answer = 'Yes';
            while pass < 3
                s3 = 1;
                if pass == 1 % initial pass settings
                    fractionUse = 0.1;
                    pyramids = 3;
                    blockSize = 31;
                    totNum =  V.NumFrames;
                elseif pass == 2 % refines  the solution
                    fractionUse = 1.00;
                    pyramids = 5;
                    blockSize = 5;
                    pause (0.2); % wait for close
                    V = VideoReader([app.directory_save '\stabilisedFrames\pass' num2str(pass-1) '\stabilisedFramesOut.avi']); % update the input to the stabilised video based on the first pass
                    totNum =  V.NumFrames;
                end
                
                % Load the required frames
                dirIn = [app.directory_save '\orthorectified\'];
                app.directory_stab = [app.directory_save '\stabilisedFrames\pass1']; % Modify the output directory
                listing = dir(dirIn);
                for a = 1:length(listing)
                    temp1 = cellstr(listing(a).name);
                    if ~isempty(temp1(contains(temp1,'.jpg')))
                        textIn = char(temp1);
                        Index = strfind(textIn, 'frame');
                        frameIn{a,1} = textIn;
                        frameSelected(a,1) = str2num(textIn(Index+5:end-4));
                    end
                end
                frameSelected = replace_num(frameSelected,0,NaN);
                startingFrameIn = char(frameIn(find(diff(frameSelected) == mode(diff(frameSelected)), 1 )));
                startingFrameIdx = find(diff(frameSelected) == mode(diff(frameSelected)), 1 );
                
                % Save the first (reference) orthophoto into the stabilised folder
                dirOut = [app.directory_save '\stabilisedFrames\pass' num2str(pass) '\'];
                mkdir (dirOut);
                
                % Save the stabilised orthophotos
                template = '00000';
                inputNum = num2str(frameSelected(startingFrameIdx));
                p1 = template(1:end-length(num2str(frameSelected(startingFrameIdx))));
                p2 = inputNum;
                fileNameIteration = [p1,p2];
                filenameJpg = [dirOut app.file(1:end-4) '_frame' num2str(fileNameIteration) '.jpg' ];
                referenceFrame = imread([dirIn, startingFrameIn]);
                referenceFrame = replace_num(referenceFrame,NaN,0);
                x = im2double(referenceFrame) ./ max(im2double(referenceFrame(:)));  % Scale to [0,1]
                imwrite(x,filenameJpg)
                
                for iter = startingFrameIdx + 1:length(frameSelected)
                    
                    % Manually select the areas to stabilise the image
                    if starter == 1
                        app.boundaryLimitsPx = {};
                        looper = true;
                        [roiPoints] = KLT_readPoints(referenceFrame,100,5,app,[])'; hold on;
                        roiPoints = replace_num(roiPoints,0,NaN);
                        useVals = ~isnan(roiPoints(:,1));
                        app.boundaryLimitsPx{polyNum,1} = polyshape(roiPoints(useVals,1),roiPoints(useVals,2));
                        plot(app.boundaryLimitsPx{polyNum,1});
                        
                        while looper == true
                            answer = questdlg('Would you like to specify more stabilisation areas? Press cancel to restart the current selection' , ...
                                'Draw additional polygons?', ...
                                {'Yes','No'});
                            
                            switch answer
                                case 'Yes'
                                    polyNum = polyNum + 1;
                                    [roiPoints] = KLT_readPoints(referenceFrame,100,5,app,[])'; hold on;
                                    roiPoints = replace_num(roiPoints,0,NaN);
                                    useVals = ~isnan(roiPoints(:,1));
                                    app.boundaryLimitsPx{polyNum,1} = polyshape(roiPoints(useVals,1),roiPoints(useVals,2));
                                    plot(app.boundaryLimitsPx{polyNum,1});
                                case 'No'
                                    looper = false;
                                    polyNum = 1;
                                    roiPoints = []; useVals = [];
                                    title ('Close the window to continue');
                                    try
                                        close (f1);
                                    catch
                                    end
                                case 'Cancel' % this needs testing
                                    polyNum = 1;
                                    app.boundaryLimitsPx = [];
                                    [roiPoints] = KLT_readPoints(referenceFrame,100,5,app,[])'; hold on;
                                    roiPoints = replace_num(roiPoints,0,NaN);
                                    useVals = ~isnan(roiPoints(:,1));
                                    app.boundaryLimitsPx{polyNum,1} = polyshape(roiPoints(useVals,1),roiPoints(useVals,2));
                                    plot(app.boundaryLimitsPx{polyNum,1});
                            end
                        end
                        importedBoundBox = app.boundaryLimitsPx;
                    end
                    
                    looper2 = 1;
                    while looper2 > 0
                        points = detectMinEigenFeatures(referenceFrame); % set the nFrame image as the new reference to be used
                        fractionUse = 0.3;
                        % Quadrants approach - doesn't work cos theres such a  big area - therefore use all points within the polygons
                        pointsIn = points;
                        numberToUse = round(length(pointsIn).*fractionUse);
                        bestPoints = pointsIn.selectStrongest(numberToUse);
                        
                        % Create a polygon just inside the area of the image containing data
                        th=10;
                        a=referenceFrame(:,:,1)>th; % find pixel values greater than 10
                        a=bwareaopen(a,50); % find 50 connected pixels
                        B = bwboundaries(a,'noholes');
                        B1 = B{1,1};
                        k = boundary(B1); %(:,1),B1(:,2),1); % [x,y]: outline
                        filled = polyshape (B1(k,2),B1(k,1)); % polyshape
                        q = polybuffer(filled,-5); %shrink the boundary by 5 pixels
                        % Filter the selected points based on removal of points close to the edge -- remnove those where teh image is black
                        filteredIdx = inpolygon(bestPoints.Location(:,1),bestPoints.Location(:,2),q.Vertices(:,1),q.Vertices(:,2)); % filtered best points
                        
                        % Clip the features in the channel from the template
                        extractedPoints = []; in = []; inComp = [];
                        inComp = [];
                        for z = 1:length(importedBoundBox)
                            [in, ~] = inpolygon(bestPoints.Location(:,1),bestPoints.Location(:,2),importedBoundBox{z,1}.Vertices(:,1),importedBoundBox{z,1}.Vertices(:,2));
                            extractedPoints = [extractedPoints; bestPoints.Location(in,1:2)];
                            inComp = [inComp, in];
                        end
                        
                        filteredIdx2 = sum(inComp,2);
                        filteredIdx2 = filteredIdx2 > 0;
                        idx = find(filteredIdx + filteredIdx2 == 2);
                        filteredPoints = [bestPoints.Location(idx,1),bestPoints.Location(idx,2)];
                        
                        % Initialize the tracker for the first frame
                        tracker2 = vision.PointTracker('MaxBidirectionalError', 0.5,...
                            'BlockSize', [31 31],'NumPyramidLevels',5); % Create a new tracker; error allowed of up-to one cell
                        initialize(tracker2, filteredPoints, referenceFrame);
                        nextFrame = imread([dirIn char(frameIn(iter))]);
                        [newPointsT, isFound] = step(tracker2, nextFrame); % Track the features through the next frame
                        visiblePoints = double(newPointsT(isFound, :));
                        oldInliers = double(filteredPoints(isFound, :));
                        
                        % Conduct a similarity transformation and plot the results
                        mytform = estimateGeometricTransform(visiblePoints,oldInliers, 'similarity'); %returns a 2-D geometric transform object, tform. The tform object maps the inliers in matchedPoints1 to the inliers in matchedPoints2.
                        mytform.T % projective and affine are bad
                        [regParams,~,~] = absor(visiblePoints',oldInliers'); % Horn's criterion with no scaling, only rotation + translation
                        regParams.M = regParams.M'; % transpose the matrix
                        hornsTrans = mytform;
                        hornsTrans.T = regParams.M; % Overwrite the original affine with the Horn-based approach
                        
                        if ~exist('myPrevious','var')
                            myPrevious = mytform.T;
                        end
                        if abs(mytform.T (1) - myPrevious(1)) > 0.005 % Test whether the scaling differs by more than 0.5% between successive frames
                            referenceFrame = framePlusOne;
                            if looper2 == 2
                                mytform.T = hornsTrans.T; % Horn's doesn't give good enough results but a useful backup
                                [xFig, yFig] = transformPointsForward(mytform, visiblePoints (:,1),visiblePoints(:,2));
                                registeredFrame = imwarp(nextFrame,mytform,'OutputView',imref2d(size(nextFrame)));
                                looper2 = 0;
                                restarter = 1;
                            else
                                looper2 = looper2 + 1;
                                startingVals = length(oldInliers); % force same size
                            end
                        else % else if all good with the transformations diagnosis
                            looper2 = 0;
                            [xFig, yFig] = transformPointsForward(mytform, visiblePoints (:,1),visiblePoints(:,2));
                            registeredFrame = imwarp(nextFrame,mytform,'OutputView',imref2d(size(nextFrame)));
                            
                            if starter == 1 % if the first of a new sequence
                                startingVals = length(oldInliers);
                                starter = 2;
                                % save the frame after the reference frame
                                framePlusOne = registeredFrame;
                            end
                        end
                        
                        myPrevious = mytform.T; % save the transformation matrix for comparison
                        
                        % Update the reference frame when points disappear
                        if length(oldInliers)./startingVals < 0.7 || restarter == 1
                            referenceFrame = registeredFrame; % The new frame is now used as the reference
                            starter = 1;
                            restarter = 0;
                            looper2 = 0;
                            clear myPrevious
                        end
                        
                    end
                    
                    % Save the stabilised orthophotos
                    template = '00000';
                    inputNum = num2str(frameSelected(iter));
                    p1 = template(1:end-length(num2str(frameSelected(iter))));
                    p2 = inputNum;
                    fileNameIteration = [p1,p2];
                    filenameJpg = [dirOut app.file(1:end-4) '_frame' num2str(fileNameIteration) '.jpg' ];
                    x = (registeredFrame) ./ max(im2double(registeredFrame(:)));  % Scale to [0,1]
                    imwrite(x,filenameJpg)
                    
                    % Display a status update
                    TextIn = {['Stabilisation completed for frame ' num2str(frameSelected(iter))]};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    KLT_printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                end
                
                % reset the app.s2 value
                app.s2 = start_s2;
                %creatingVideosFromImages_KLT(app, pass, 'Yes'); % Create and play the stabilised video
                pass = 3;
            end
    end

else
    %Display an error - need to load video
end

end