function [] = KLT_imageAnalysis(app)  % Starting analysis

%Clear and create some necessary variables
app.backgroundImage = [];
app.init_track      = {};
app.fin_track       = {};
app.success_track   = {};
app.visHR           = [];
app.uvHR            = [];
app.uvHR            = [];
xyzA_conv           = [];

% Define the pre-processing settings
app.prepro          = 1; %zero = disabled; one = enabled
pre_pro_params      = zeros(1,11); %empty array
pre_pro_params(1)   = []; %roirect
pre_pro_params(2)   = []; %clahe
pre_pro_params(3)   = []; %clahesize
pre_pro_params(4)   = 1; %highp
pre_pro_params(5)   = 30; %highpsize
pre_pro_params(6)   = []; %intenscap
pre_pro_params(7)   = 0; %wienerwurst
pre_pro_params(8)   = 8; %wienerwurstsize
pre_pro_params(9)   = 0; %minintens
pre_pro_params(10)  = 1; %maxintens
pre_pro_params(11)  = 0; %background subtraction
                   
switch app.ProcessingModeDropDown.Value
    case {'Single Video'}
        V                   = VideoReader(strjoin ({app.directory, app.file},''));
        app.videoDuration   = V.Duration; % Extract the length of the video
        app.videoFrameRate  = V.FrameRate; % Extract the frame rate of the video
end

TextIn              = {'Begining image processing'};
TimeIn              = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
TimeIn              = strjoin(TimeIn, ' ');
app.ListBox.Items   = [app.ListBox.Items, TimeIn, TextIn'];
KLT_printItems(app)
pause(0.01);
app.ListBox.scroll('bottom');

% Configure the block size correctly
tempBlocksize       = app.BlocksizepxEditField.Value;

if bitget(tempBlocksize,1) %odd
    app.Blocksize   = [app.BlocksizepxEditField.Value app.BlocksizepxEditField.Value];
else %even
    app.Blocksize   = [tempBlocksize+1 tempBlocksize+1];
end

% Set the region of interest for analysis as the entire frame
% [TopLeftX,TopLeftY,LengthX,LengthY]
objectRegion = [1, 1, app.imgsz(2), app.imgsz(1)]; 

% Run the camera parameters function
KLT_cameraParameters(app)

% Overwrite the default frame rate?
% Only run for the first video
if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1
    defaultValue        = {num2str(app.videoFrameRate)};
    titleBar            = 'Manually overwrite the frame rate present in the meta-data?';
    userPrompt          = {'Defined frame rates: '};
    caUserInput         = inputdlg(userPrompt, titleBar, [1, 60], defaultValue);
    app.videoFrameRate  = str2double(caUserInput{1});
end

% Define the total number of frames available
if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
    
    try
        totNum = V.NumFrames; % sometimes doesn't exist
    catch
        totNum = floor(V.Duration.*V.FrameRate); % estimate frame number
    end
    
else
    totNum = length(app.objectFrameStacked);
end

nFrame      = 1;
app.iter    = round(app.videoFrameRate./(1/app.ExtractionratesEditField.Value)); %set extraction rate
restartWhen = (1:app.iter:totNum);
ii          = 0;

if app.videoDuration == 0
    app.videoDuration = (totNum./app.videoFrameRate); %20210430
end

% Enter the start and stop of the video analysis
% Only run for the first video
if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1 
    defaultValue    = {'0', num2str(round(app.videoDuration))};
    titleBar        = 'Define the start and end of the video in seconds';
    userPrompt      = {'Starting point (s): ', 'Finishing point (s): '};
    caUserInput     = inputdlg(userPrompt, titleBar, [1, 80], defaultValue);
    app.videoStart  = str2num(caUserInput{1});
    app.videoClip   = str2num(caUserInput{2});
    if abs(app.videoClip -  round(app.videoDuration)) > 0 % if video is clipped
        app.clipped = true;
    else
        app.clipped = false;
    end
end

% Ensure that the inputs for s2 and nFrame are okay for all orientations
if isempty (app.s2_mod)
    app.s2      = round(1 + (app.videoStart.*app.videoFrameRate));
    [~,idx]     = min(abs(restartWhen-app.s2));
    app.s2      = restartWhen(idx(1));
    if app.clipped == true
        totNum      = floor(app.videoClip.*app.videoFrameRate); % added 20210312
        nFrame      = app.s2;
    end
else
    app.s2      = round(1 + (app.s2_mod.*app.videoFrameRate));
    if app.clipped == true
        totNum      = floor(app.videoClip.*app.videoFrameRate);
        nFrame      = round(nFrame + (app.s2_mod.*app.videoFrameRate));
    end
end

% Check if manual time is greater than video time
if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true && ...
        totNum > numel(app.objectFrameStacked)
    totNum = numel(app.objectFrameStacked);
end

% Run the stabilisation functions as required
switch app.OrientationDropDown.Value

    case {'Dynamic: GCPs + Stabilisation', 'Dynamic: Stabilisation'}
        KLT_stabiliseImageInput(app, V, totNum);
    case 'Dynamic: GPS + IMU'
        KLT_stabiliseImageInputGPS(app, V, totNum);
    case 'Planet [beta]'
        KLT_stabiliseImageInputPlanet(app, V, totNum);
        
end

% This is the main part of the feature tracking
while app.s2 < totNum -1
    if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
        set(app.RUNButton,'Text',strjoin({'Processing: ' int2str((app.s2-1)/totNum*100) '% Complete'},''));
        pause(0.01)
        
        if length(find(~cellfun(@isempty,app.ListBox.Items))) == 1000
            for x = 1:1000 % create an empty listbox again
                app.ListBox.Items(x) = {['']};
            end
        end
        
    end
    
    % If it is the start of a new loop or frame 1
    if ~isempty(find(nFrame == restartWhen) > 0) || ii == 0 
        if ii == 0 % if its the first frame
            ii          = 1;
            template    = '00000';
            inputNum    = num2str(app.s2);
            p1          = template(1:end-length(num2str(app.s2)));
            p2          = inputNum;
            fileNameIteration = [p1,p2];
            
            uvA         = [];
            uvB         = [];
            app.gcpA    = app.UITable.Data;
            available   = find(app.gcpA(:,4) > 0);
            app.gcpA    = app.gcpA(available,:);
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                
                if app.s2.*1/app.videoFrameRate < V.Duration
                    V.CurrentTime = app.s2.*1/app.videoFrameRate;
                else
                    break
                end
            end
            
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GCPs + Stabilisation') == true || ...
                    strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation') == true || ...
                    strcmp (app.OrientationDropDown.Value,'Planet [beta]') == true
                
                % Load the stabilised exported files
                listing = dir(app.subDir);
                for a = 1:length(listing)
                    fileNamesIn(a,1) = cellstr(listing(a).name);
                end
                
                fileNamesIn = fileNamesIn(contains(fileNamesIn,'.jpg'));
                Index = find(contains(fileNamesIn,fileNameIteration));
                if Index > 0
                    app.objectFrame = imread([app.subDir '\' char(fileNamesIn(Index))]);
                else
                    break
                end
                
            elseif strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                % Load the stabilised exported files
                listing = dir (app.directory_stab);
                for a = 1:length(listing)
                    fileNamesIn(a,1) = cellstr(listing(a).name);
                end
                fileNamesIn         = fileNamesIn(contains(fileNamesIn,'.jpg'));
                Index               = find(contains(fileNamesIn,fileNameIteration));
                
                %if s2 matches the first image in the sequence bring it in
                if Index > 0% 
                    app.objectFrame = imread([app.directory_stab '\' char(fileNamesIn(Index))]);
                    restartWhen     = (app.s2:app.iter:totNum); % Feed in the correct values
                else
                    % Otherwise do nothing
                end
                
            elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                % Load the correct frame in the video sequence
                app.objectFrame = app.objectFrameStacked{nFrame};
                
            else
                app.objectFrame = rgb2gray(readFrame(V));
            end
            
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                objectRegion = [1 1 flip(size(app.objectFrame))];
            end
            
            % set the nFrame image as the new reference to be used
            if app.prepro == 0
                points      = detectMinEigenFeatures(app.objectFrame, 'ROI', objectRegion);
                points      = points.Location;
            end
            
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                % Create a polygon just inside the area of the image containing data
                th      = 10;
                a       = app.objectFrame(:,:,1)>th; % find pixel values greater than 10
                a       = bwareaopen(a,50); % find 50 connected pixels
                B       = bwboundaries(a,'noholes');
                B1      = B{1,1};
                k       = boundary(B1); %(:,1),B1(:,2),1); % [x,y]: outline
                filled  = polyshape (B1(k,2),B1(k,1)); % polyshape
                
                % Next extract the points towards the edges of the image
                q_length    = sqrt(polyarea(filled.Vertices(:,1),filled.Vertices(:,2)));
                q_length_t  = q_length.*0.10;
                q           = polybuffer(filled,-q_length_t); %shrink the boundary by the square root of the area imaged
                filteredIdx = inpolygon(points(:,1),points(:,2),q.Vertices(:,1),q.Vertices(:,2)); % filtered best points
                points      = [points(filteredIdx,1),points(filteredIdx,2)];
                oldPoints   = points; % Make a copy of the points to be used
                numPoints   = double(oldPoints);% locate the origins of the GCPs
                
            else
                if app.prepro == 0
                    oldPoints   = points; % Make a copy of the points to be used
                    numPoints   = double(oldPoints); % locate the origins of the GCPs
                end
            end
            
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == false
                
                if app.prepro == 1
                    app.firstFrame = app.objectFrame;
                end
                
                KLT_orthorectification(app) % Run the starting orthoscript
                KLT_orthorectificationProgessive(app)
                if app.prepro == 1
                    app.objectFrame = PIVlab_preproc (app,app.rgbHR,pre_pro_params);
                    app.rgbHR = app.objectFrame;
                    KLT_imageExport(app)

                    points = detectMinEigenFeatures(app.objectFrame); %, 'ROI', objectRegion);
                    points = points.Location;
                    oldPoints   = points; % Make a copy of the points to be used
                    numPoints   = double(oldPoints); % locate the origins of the GCP
                    
                end
                
                camA_previous = app.camA;
                app.camA_first = app.camA;
                
                if strcmp (app.OrientationDropDown.Value, 'Dynamic: GCPs') == true
                    [sizer1, ~] = size(app.gcpA); % accounts for small numbers of GCPs
                    for a = 1:sizer1 % automatically search for GCPs
                        temper4 = abs(numPoints(:,1)-app.gcpA(a,4)); % Less sensitive - just finds closest match
                        temper5 = abs(numPoints(:,2)-app.gcpA(a,5));
                        tot = min(temper4 + temper5);
                        val = find([temper4 + temper5] == tot);
                        if ~isempty(val)
                            app.k1(a,1:2) = [val,val];
                            app.gcpA(a,4:5) = [numPoints(val,1),numPoints(val,2)];
                        else
                            app.gcpA(a,1:5) = [NaN];
                        end
                        clear temp4 temp5
                    end
                else
                    temp11 = length(app.gcpA(:,4));
                    app.k1(1:temp11,1) = app.gcpA(:,4);
                    app.k1(1:temp11,2) = app.gcpA(:,5);
                    clear temp11
                end
            end
            
            tracker = vision.PointTracker('MaxBidirectionalError', 1.0,...
                'BlockSize', app.Blocksize); % Create a new tracker; error allowed of up-to one cell
            initialize(tracker, points, app.objectFrame); % Restart the tracker for the new image (I.e. the 10th image is used as the base)
            clear oldInliersExtract temp2 app.k1
            
            % convert the ROI into metric units
            TextIn = {'Calculating ROI in metric units. Please wait'};
            app.ListBox.Items = [app.ListBox.Items, TextIn'];
            KLT_printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == false
                if length(app.boundaryLimitsPx) > 1 && ...
                        strcmp (app.OrientationDropDown.Value, 'Dynamic: Stabilisation') == false && ...
                        strcmp (app.OrientationDropDown.Value, 'Planet [beta]') == false
                    app.boundaryLimitsM = app.camA.invproject(app.boundaryLimitsPx,app.TransX,app.TransY,app.Transdem);
                elseif length(app.boundaryLimitsPx) > 1 && ...
                        strcmp (app.OrientationDropDown.Value, 'Dynamic: Stabilisation') == true
                    app.boundaryLimitsM = app.boundaryLimitsPx.*app.imageResolution;
                elseif strcmp (app.OrientationDropDown.Value, 'Planet [beta]') == true
                    % do nothing
                end
            end
        else
            %% This is the end of the tracking sequence
            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                if app.s2.*1/app.videoFrameRate < V.Duration
                    V.CurrentTime = app.s2.*1/app.videoFrameRate;
                else
                    break
                end
            end
            
            % Update the file name input
            p1 = template(1:end-length(num2str(app.s2)));
            p2 = num2str(app.s2);
            fileNameIteration = [p1,p2];
            
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GCPs + Stabilisation') == true || ...
                    strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation') == true || ...
                    strcmp (app.OrientationDropDown.Value,'Planet [beta]') == true
                % Load the stabilised exported files
                listing = dir(app.subDir);
                for a = 1:length(listing)
                    fileNamesIn(a,1) = cellstr(listing(a).name);
                end
                fileNamesIn = fileNamesIn(contains(fileNamesIn,'.jpg'));
                Index = find(contains(fileNamesIn,fileNameIteration));

                if Index > 0 && app.prepro == 1
                    app.objectFrame = imread([app.subDir '\' char(fileNamesIn(Index))]);
                    KLT_orthorectificationProgessive(app)
                    app.objectFrame = PIVlab_preproc (app,app.rgbHR,pre_pro_params);
                    KLT_imageExport(app)
                    
                elseif Index > 0
                    app.objectFrame = imread([app.subDir '\' char(fileNamesIn(Index))]);
                else
                    break
                end
                
            elseif strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                % Load the stabilised exported files
                listing = dir ([app.directory_stab '\']);
                
                for a = 1:length(listing)
                    fileNamesIn(a,1) = cellstr(listing(a).name);
                end
                fileNamesIn = fileNamesIn(contains(fileNamesIn,'.jpg'));
                Index = find(contains(fileNamesIn,fileNameIteration));
                if Index > 0% if s2 matches the first image in the sequence bring it in
                    app.objectFrame = imread([app.directory_stab '\' char(fileNamesIn(Index))]);
                else % Otherwise bring in the first stabilised image
                    break
                end
                
            elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                % Load the correct frame in the video sequence
                app.objectFrame = app.objectFrameStacked{nFrame};
                
            else
                app.objectFrame = rgb2gray(readFrame(V));
            end
            

            % After bringing in the new object, detect the
            % succesfully tracked features
            [app.newPoints, isFound] = step(tracker, app.objectFrame); % Track the features through the final frame of the sequence
            visiblePoints = app.newPoints(isFound, :);
            oldInliers = oldPoints(isFound, :);

            % extract the starting and finishing features of the tracking sequence
            idx_track                       = length(app.init_track)+1;
            app.init_track{idx_track}       = double(oldPoints);
            app.fin_track{idx_track}        = double(app.newPoints);
            app.success_track{idx_track}    = double(isFound);

            % Update the location of the GCPs
            if strcmp (app.OrientationDropDown.Value, 'Dynamic: GCPs') == true
                [sizer1, ~] = size(app.gcpA); % accounts for small numbers of GCPs
                for a = 1:sizer1
                    if app.newPoints(app.k1(a),1) > 0
                        app.gcpA(a,4) = app.newPoints(app.k1(a),1);
                        app.gcpA(a,5) = app.newPoints(app.k1(a),2); %this is not correct
                    else
                        app.gcpA(a,4) = NaN;
                    end
                end
            end
            
            [temp2, ~] = size(visiblePoints);
            xDist = ones(temp2,1); horizontalValue = ones(temp2,1); verticalValue = ones(temp2,1);
            horizontalValue2 = ones(temp2,1); verticalValue2 = ones(temp2,1);
            s = 1;
            while s < temp2 + 1
                oldInliersExtract = oldInliers(s,:);
                horizontalValue(s,1) = oldInliersExtract(1); % Extract the x-axis coordinates for the reference features
                verticalValue(s,1) = oldInliersExtract(2); % Extract the y-axis coordinates for the reference features
                horizontalValue2(s,1) = visiblePoints(s,1); % Extract the x-axis coordinates for the final tracked features
                verticalValue2(s,1) = visiblePoints(s,2); % Extract the y-axis coordinates for the final tracked features
                s = s + 1;
            end
            
            if strcmp (app.IgnoreEdgesDropDown.Value, 'Yes') == true && ...
                    strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false && ...
                    app.prepro == 0 % remove edges if required
                foi = horizontalValue(:,1) > app.imgsz(2)-0.9*app.imgsz(2) & horizontalValue(:,1) < 0.9*app.imgsz(2) & verticalValue(:,1) > app.imgsz(1)-0.9*app.imgsz(1) & verticalValue(:,1) < 0.9*app.imgsz(1);
            elseif strcmp (app.IgnoreEdgesDropDown.Value, 'Yes') == false && ...
                    strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false && ...
                    app.prepro == 0
                foi = horizontalValue(:,1) > [0] & horizontalValue(:,1) < [app.imgsz(2)] & verticalValue(:,1) > [0] & verticalValue(:,1) < [app.imgsz(1)];
            elseif strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == true
                foi = (1:length(horizontalValue)); % use all of the data
            elseif app.prepro == 1
                foi = (1:length(horizontalValue)); % use all of the data
            end
            
            if app.s2 > 0  && ~isempty(horizontalValue)
                %Extract the starting and finishing tracked positions
                uvA_initial(:,1) = vertcat(horizontalValue(foi)); %Place the starting x values into the first column
                uvA_initial(:,2) = vertcat (verticalValue(foi)); %Place the starting y cells in the second column
                uvB_initial(:,1) = vertcat(horizontalValue2(foi));%Place the finish x values into the first column
                uvB_initial(:,2) = vertcat(verticalValue2(foi));%Place the finish y values into the first column      
                
                if strcmp (app.OrientationDropDown.Value, 'Stationary: GCPs') == true
                    xyz = [uvA_initial; uvB_initial];
                    [initialSize, ~] = size(uvA_initial);
                    if isempty(xyzA_conv)
                        xyzA_conv = xyz(1:initialSize,1:2); % Starting positions that have been rectified
                        xyzB_conv = xyz(initialSize+1:end,1:2); % Finish positions that have been rectified
                    else
                        [aferSize, ~] = size(xyzA_conv);
                        [aferSize2, ~] = size(uvA_initial);
                        xyzA_conv(aferSize+1:aferSize+aferSize2,1:2) = xyz(1:initialSize,1:2); % Starting positions that have been rectified
                        xyzB_conv(aferSize+1:aferSize+aferSize2,1:2) = xyz(initialSize+1:end,1:2); % Finish positions that have been rectified
                    end
                end
                    
                
                if strcmp (app.OrientationDropDown.Value, 'Dynamic: Stabilisation') == false && ...
                        strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false && ...
                        strcmp (app.OrientationDropDown.Value, 'Planet [beta]') == false
                    camA_previous = app.camA;
                end
                
                if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == false
                    if app.prepro == 0
                        KLT_orthorectificationProgessive(app); % Run the continuous orthoscript to determine the movement of the UAV
                    end
                end
                
                if strcmp (app.OrientationValue, 'Dynamic: Stabilisation') == false && ...
                        strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false && ...
                        strcmp (app.OrientationDropDown.Value, 'Planet [beta]') == false 
                    
                    if length(app.TransX) > 1 && strcmp (app.OrientationDropDown.Value, 'Stationary: GCPs') == false
                        
                        if app.prepro == 0
                            temper1 = camA_previous.invproject(uvA_initial,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                            temper2 = app.camA.invproject(uvB_initial,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                            
                            % these lines are for te sdi index and needs to be developed further for unstable image sequences
                            %temper3 = camA_previous.invproject(cell2mat(app.init_track'),app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                            %temper4 = app.camA.invproject(cell2mat(app.fin_track'),app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                            
                            if ~isempty(temper1)
                                xyz = [temper1(:,1:2); temper2(:,1:2)];
                                [initialSize, ~] = size(uvA_initial);
                                xyzA_initial = xyz(1:initialSize,1:2); % Starting positions that have been rectified
                                xyzB_initial = xyz(initialSize+1:end,1:2); % Finish positions that have been rectified
                            else
                                temper1 = [];
                                temper2 = [];
                            end
                            
                        else
                            temper1 = uvA_initial;
                            temper2 = uvB_initial;
                            
                            xyz = [temper1(:,1:2); temper2(:,1:2)];
                            min_x = min(app.TransX(:),[],'omitnan') - (nanmean(diff(app.TransX(1,:)))/2);
                            min_y = min(app.TransY(:),[],'omitnan') - (nanmean(diff(app.TransY(:,1)))/2);
                            image_origin_m = [min_x, min_y];
                            xyz = xyz .* app.ResolutionmpxEditField.Value;
                            xyz(:,1) = image_origin_m(:,1) + xyz(:,1);
                            xyz(:,2) = image_origin_m(:,2) + xyz(:,2);
                            
                            %h1 = image(app.X(1,:),app.Y(:,1),app.objectFrame,'CDataMapping','scaled'); hold on;
                            %colormap(gray);
                            %scatter(xyz(:,1),xyz(:,2),'r+')

                            [initialSize, ~] = size(uvA_initial);
                            xyzA_initial = xyz(1:initialSize,1:2); % Starting positions that have been rectified
                            xyzB_initial = xyz(initialSize+1:end,1:2); % Finish positions that have been rectified
                        end
                    else
                        temper1 = [];
                        temper2 = [];
                    end
                else
                    if strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == true
                        app.imageResolution = app.ResolutionmpxEditField.Value; % Catch for GPS + IMU
                    end
                    temper1 = uvA_initial.*app.imageResolution;
                    temper2 = uvB_initial.*app.imageResolution;
                    xyz = [temper1(:,1:2); temper2(:,1:2)];
                    [initialSize, ~] = size(uvA_initial);
                    xyzA_initial = xyz(1:initialSize,1:2); % Starting positions that have been rectified
                    xyzB_initial = xyz(initialSize+1:end,1:2); % Finish positions that have been rectified
                end
                
                
                if length (uvA) > 1 && exist('xyzA','var') == 1 && ...
                        strcmp (app.OrientationDropDown.Value, 'Stationary: GCPs') == false
                    [initialSize, ~] = size(uvA);
                    [afterSize, ~] = size(uvA_initial);
                    uvA(1:initialSize+afterSize,1) = vertcat(uvA(:,1),uvA_initial(:,1));
                    uvA(1:initialSize+afterSize,2) = vertcat(uvA(1:initialSize,2),uvA_initial(:,2));
                    uvB(1:initialSize+afterSize,1) = vertcat(uvB(:,1),uvB_initial(:,1));
                    uvB(1:initialSize+afterSize,2) = vertcat(uvB(1:initialSize,2),uvB_initial(:,2));
                    
                    [initialSize, ~] = size(xyzA);
                    [afterSize, ~] = size(xyzA_initial);
                    xyzA(1:initialSize+afterSize,1) = vertcat(xyzA(:,1),xyzA_initial(:,1));
                    xyzA(1:initialSize+afterSize,2) = vertcat(xyzA(1:initialSize,2),xyzA_initial(:,2));
                    xyzB(1:initialSize+afterSize,1) = vertcat(xyzB(:,1),xyzB_initial(:,1));
                    xyzB(1:initialSize+afterSize,2) = vertcat(xyzB(1:initialSize,2),xyzB_initial(:,2));
                else
                    uvA = uvA_initial;
                    uvB = uvB_initial;
                    if exist('xyzA_initial','var')
                        xyzA = xyzA_initial;
                        xyzB = xyzB_initial;
                    end
                end
            end
            clear xyzA_initial xyzB_initial uvA_initial uvB_initial verticalValue2 verticalValue horizontalValue2 horizontalValue
            
            %% restart the tracking sequence
            release (tracker)
            
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                objectRegion = [1 1 flip(size(app.objectFrame))];
            end
            
            if app.prepro == 1
                %KLT_orthorectificationProgessive(app)
                points = detectMinEigenFeatures(app.objectFrame); %, 'ROI', objectRegion); % set the nFrame image as the new reference to be used
                points = points.Location;
            else
                
                points = detectMinEigenFeatures(app.objectFrame, 'ROI', objectRegion); % set the nFrame image as the new reference to be used
                points = points.Location;
            end
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                % Create a polygon just inside the area of the image containing data
                th=10;
                a=app.objectFrame(:,:,1)>th; % find pixel values greater than 10
                a=bwareaopen(a,50); % find 50 connected pixels
                B = bwboundaries(a,'noholes');
                B1 = B{1,1};
                k = boundary(B1); %(:,1),B1(:,2),1); % [x,y]: outline
                filled = polyshape (B1(k,2),B1(k,1)); % polyshape
                % Next extract the points towards the edges of the image
                q_length = sqrt(polyarea(filled.Vertices(:,1),filled.Vertices(:,2)));
                q_length_t = q_length.*0.10;
                q = polybuffer(filled,-q_length_t); %shrink the boundary by the square root of the area imaged
                filteredIdx = inpolygon(points(:,1),points(:,2),q.Vertices(:,1),q.Vertices(:,2)); % filtered best points
                points = [points(filteredIdx,1),points(filteredIdx,2)];
                oldPoints = points; % Make a copy of the points to be used
            else
                oldPoints = points; % Make a copy of the points to be used
            end
            
            tracker = vision.PointTracker('MaxBidirectionalError', 1.0,...
                'BlockSize', app.Blocksize); % Create a new tracker; error allowed of up-to one cell
            initialize(tracker, points, app.objectFrame); % Restart the tracker for the new image (I.e. the 10th image is used as the base)
            clear oldInliersExtract temp2 app.k1
            
            % find the locations of the GCPs again
            numPoints = double(oldPoints);
            if strcmp (app.OrientationDropDown.Value, 'Dynamic: GCPs') == true
                [sizer1, ~] = size(app.gcpA); % accounts for small numbers of GCPs
                for a = 1:sizer1 % automatically search for GCPs
                    temper4 = abs(numPoints(:,1)-app.gcpA(a,4)); % Less sensitive - just finds closest match
                    temper5 = abs(numPoints(:,2)-app.gcpA(a,5));
                    tot = min(temper4 + temper5);
                    val = find([temper4 + temper5] == tot);
                    if ~isempty(val)
                        app.k1(a,1:2) = [val,val];
                        app.gcpA(a,4:5) = [numPoints(val,1),numPoints(val,2)];
                    else
                        app.gcpA(a,1:5) = [NaN];
                    end
                    clear temp4 temp5
                end
            else
                app.k1 = [];
                app.k1(:,1) = app.gcpA(:,4);
                app.k1(:,2) = app.gcpA(:,5);
            end
            
           
        end
        
    else % if its a normal (non extraction frame)
        
        if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
            if app.s2.*1/app.videoFrameRate < V.Duration
                V.CurrentTime = app.s2.*1/app.videoFrameRate;
            else
                break
            end
        end
        
        if strcmp (app.OrientationDropDown.Value,'Dynamic: GCPs + Stabilisation') == true || ...
                strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation') == true || ...
                strcmp (app.OrientationDropDown.Value,'Planet [beta]') == true
            % Load the stabilised exported files
            listing = dir(app.subDir);
            for a = 1:length(listing)
                fileNamesIn(a,1) = cellstr(listing(a).name);
            end
            fileNamesIn = fileNamesIn(contains(fileNamesIn,'.jpg'));
            Index = find(contains(fileNamesIn,fileNameIteration));
            if Index > 0 && app.prepro == 1
                app.objectFrame = imread([app.subDir '\' char(fileNamesIn(Index))]);
                KLT_orthorectificationProgessive(app)
                app.objectFrame = PIVlab_preproc (app,app.rgbHR,pre_pro_params);
                app.rgbHR = app.objectFrame;
                KLT_imageExport(app)
   
            elseif Index > 0% && app.prepro == 1
                app.objectFrame = rgb2gray(readFrame(V));
            else
                break
            end
            
        elseif strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
            
            % Do nothing
            
        elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
            % Load the correct frame in the video sequence
            app.objectFrame = app.objectFrameStacked{nFrame};
            
        else
            try
                app.objectFrame = rgb2gray(readFrame(V)); % if no more frames
            catch
                app.s2 = totNum-2; % cause it to exit on the next cycle
            end
        end
        
        if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == false
            [app.newPoints, isFound] = step(tracker, app.objectFrame); % Track the features through the next frame
            visiblePoints = app.newPoints(isFound, :);
            oldInliers = oldPoints(isFound, :);
        end
        
    end
    app.s2 = app.s2 + 1;
    template = '00000';
    inputNum = num2str(app.s2);
    p1 = template(1:end-length(num2str(app.s2)));
    p2 = inputNum;
    fileNameIteration = [p1,p2];
    nFrame = nFrame + 1;
    
    TextIn = {['Frame ' int2str(app.s2) ' of ' int2str(totNum -1) ' completed. Please wait']};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
end
clear uvAorig uvBorig uvIndex markers markerColors out


% At the end of the stable routine convert the tracked GCPs
if strcmp (app.OrientationDropDown.Value, 'Stationary: GCPs') == true && ...
        app.prepro == 0
        
    if length(app.TransX) > 1 
        xyzA        = app.camA.invproject(xyzA_conv,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
        xyzB        = app.camA.invproject(xyzB_conv,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
        clear xyzA_conv xyzB_conv
        
        % convert all of the positions inc. unsuccesful points
        out1        = cell2mat(arrayfun(@(x) x.*ones(1,size(app.init_track{x},1)), 1:numel(app.init_track),'uni',0)).'; % 
        out2        = cell2mat(app.init_track');
        out3        = cell2mat(app.fin_track');
        temper3     = app.camA.invproject(out2,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
        temper4     = app.camA.invproject(out3,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
        
    end
end

if strcmp (app.OrientationDropDown.Value, 'Dynamic: GCPs + Stabilisation') == true && ...
        app.prepro == 0

        % convert all of the positions inc. unsuccesful points
        out1        = cell2mat(arrayfun(@(x) x.*ones(1,size(app.init_track{x},1)), 1:numel(app.init_track),'uni',0)).'; % 
        out2        = cell2mat(app.init_track');
        out3        = cell2mat(app.fin_track');
        temper3     = app.camA.invproject(out2,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
        temper4     = app.camA.invproject(out3,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
end

try
    if length(app.boundaryLimitsM)>1
        [in,~] = inpolygon(xyzA(:,1),xyzA(:,2),app.boundaryLimitsM(:,1),app.boundaryLimitsM(:,2));
        app.xyzA_final = xyzA(in,1:2);
        app.xyzB_final = xyzB(in,1:2);
        
        % this is for the sdi work
        if exist('out1','var') % only on the tested versions
            for a = 1:length(app.init_track)
                idx = find(out1 == a);
                [in,~] = inpolygon(temper3(idx,1), temper3(idx,2),app.boundaryLimitsM(:,1),app.boundaryLimitsM(:,2));
                app.success_track{a}(~in) = 2; % two means out of bounds
            end
        end

    else
        app.xyzA_final = xyzA(:,1:2);
        app.xyzB_final = xyzB(:,1:2);
    end
    
    if exist('out1','var') % only on the tested versions

        app.init_track_px = app.init_track; % save the pixel values
        app.fin_track_px = app.fin_track;

        app.init_track = {};
        app.fin_track = {};
        for a = 1:length(app.success_track)
            t1 = find(out1 == a);
            app.init_track{a}(1:length(t1),1:2) = temper3(t1,1:2);
            app.fin_track{a}(1:length(t1),1:2) = temper4(t1,1:2);
        end
    end
    % for sdi the outputs are:
    % app.init_track 
    % app.fin_track 
    % app.success_track
    
    TextIn = {'Image processing completed'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
catch
    TextIn = {'No trajectories stored. The program will terminate.'; ...
        'Check inputs e.g. custom FOV (if used) and WSE values and retry.'}; % Update the display
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    error('Breaking out of function');
end

end %function