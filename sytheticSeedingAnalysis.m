
function [] = sytheticSeedingAnalysis(app)  % Starting analysis

[dirName] = uigetdir(pwd,'Select the root of the seeding folders');
listing = dir(dirName);
listing = listing(3:end,:);
listing = listing([listing(:).isdir]);
levelOneList = listing;

for a = 1:length(levelOneList)
    
    listing = dir([dirName '\' levelOneList(a).name]);
    listing = listing(3:end,:);
    t1 = strfind({listing(:).name}, '.tif');
    t2 = transpose(cellfun(@isempty,t1) == 0);
    levelFourList = listing(t2);
     
TextIn = {'Begining image processing'};
TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
TimeIn = strjoin(TimeIn, ' ');
app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
printItems(app)
pause(0.01);
app.ListBox.scroll('bottom');

% Clear some necessary variables
app.visHR = [];
app.uvHR = [];
app.uvHR = [];

V = VideoReader(strjoin ({app.directory, app.file},''));
app.videoDuration = V.Duration; % Extract the length of the video
app.videoFrameRate = V.FrameRate; % Extract the frame rate of the video
app.iter = round(V.FrameRate./(1/app.ExtractionratesEditField.Value)); %set extraction rate
tempBlocksize = app.BlocksizepxEditField.Value;
if bitget(tempBlocksize,1) %odd
    app.Blocksize = [app.BlocksizepxEditField.Value app.BlocksizepxEditField.Value];
else %even
    app.Blocksize = [tempBlocksize+1 tempBlocksize+1];
end

objectRegion = [1, 1, app.imgsz(2), app.imgsz(1)]; %[TopLeftX,TopLeftY,LengthX,LengthY]

% Run the camera parameters function
cameraParameters(app)

%Read, track, display points, and results in each video frame.
nFrame = 1;
totalFrames = round(app.videoDuration.*app.videoFrameRate);
restartWhen = (1:app.iter:totalFrames); % Create a buffer of a few seconds
extractWhen = (app.iter:app.iter:totalFrames);
app.s2 = 1;

% Query the length of clip the user wants to analyse
videoClip = str2num(cell2mat(inputdlg(['Video is ' num2str(round(app.videoDuration)) ' seconds long. Reduce?'],...
    'Query', [1 60], {num2str(round(app.videoDuration))})));

% Define the total number of frames to analyse
totNum =  (videoClip.* app.videoFrameRate);
if totNum > V.NumFrames
    totNum = V.NumFrames;
end

if strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation + GCPs') == 1
    stabiliseImageInput(app, V, totNum); % Stabilise all of the frames first
end

while app.s2 < totNum
    set(app.RUNButton,'Text',strjoin({'Processing: ' int2str((app.s2-1)/(videoClip.*app.videoFrameRate)*100) '% Complete'},''));
    pause(0.01)
    restartTrack = find(nFrame == restartWhen);
    if find(nFrame == restartWhen) > 0 % If it is the start of a new loop
        if app.s2 == 1
            template = '00000';
            inputNum = num2str(app.s2);
            p1 = template(1:end-length(num2str(app.s2)));
            p2 = inputNum;
            fileNameIteration = [p1,p2];
            
            uvA = [];
            uvB = [];
            app.gcpA = app.UITable.Data;
            available = find(app.gcpA(:,4) > 0);
            app.gcpA = app.gcpA(available,:);
            V.CurrentTime = 0; % access the first frame
            if strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation + GCPs') == 0
                app.objectFrame = images.internal.rgb2graymex(readFrame(V));
            else
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
            end
            
            orthorectification(app) % Run the starting orthoscript
            camA_previous = app.camA;
            app.camA_first = app.camA;
            
            points = detectMinEigenFeatures(app.objectFrame, 'ROI', objectRegion); % set the nFrame image as the new reference to be used
            oldPoints = points; % Make a copy of the points to be used
            tracker = vision.PointTracker('MaxBidirectionalError', 1,...
                'BlockSize', app.Blocksize); % Create a new tracker; error allowed of up-to one cell
            initialize(tracker, points.Location, app.objectFrame); % Restart the tracker for the new image (I.e. the 10th image is used as the base)
            clear oldInliersExtract temp2 app.k1
            
            % convert the ROI into metric units
            TextIn = {'Calculating ROI in metric units. Please wait'};
            app.ListBox.Items = [app.ListBox.Items, TextIn'];
            printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
            if length(app.boundaryLimitsPx) > 1
                app.boundaryLimitsM = app.camA.invproject(app.boundaryLimitsPx,app.TransX,app.TransY,app.Transdem);
            end
            
            % Extract the index of the original GCP marker points. This should stay constant through all of the video frames
            numPoints = double(oldPoints.Location);
            
            if strcmp (app.OrientationDropDown.Value, 'Dynamic: GCPs') == 1
                [sizer1, ~] = size(app.gcpA); % accounts for small numbers of GCPs
                for a = 1:sizer1 % automatically search for GCPs
                    temper4 = abs(numPoints(:,1)-app.gcpA(a,4)); % Less sensitive - just finds closest match
                    temper5 = abs(numPoints(:,2)-app.gcpA(a,5));
                    tot = min(temper4 + temper5);
                    val = find([temper4 + temper5] == tot);
                    if ~isempty(val)
                        app.k1(a,1:2) = [val,val];
                    else
                        app.gcpA(a,1:5) = [NaN];
                    end
                    clear temp4 temp5
                end
            else
                app.k1(:,1) = app.gcpA(:,4);
                app.k1(:,2) = app.gcpA(:,5);
            end
            
        else
            % if its the 11th, 21st etc then track the gcp's before resetting the tracking
            V.CurrentTime = app.s2.*1/app.videoFrameRate; % access the first frame
            
            if strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation + GCPs') == 0
                app.objectFrame = images.internal.rgb2graymex(readFrame(V));
            else
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
            end
            
            [app.newPoints, ~] = step(tracker, app.objectFrame); % Track the features through the next frame
            release(tracker); %Release the tracker
            clear tracker points oldInliersExtract temp2 oldPoints
            points = detectMinEigenFeatures(app.objectFrame, 'ROI', objectRegion); % set the 11th, 21st etc image as the new reference to be used
            oldPoints = points; % Make a copy of the points to be used
            tracker = vision.PointTracker('MaxBidirectionalError', 1,...
                'BlockSize', app.Blocksize); % Create a new tracker; error allowed of up-to one cell
            initialize(tracker, points.Location, app.objectFrame); % Restart the tracker for the new image (I.e. the 10th image is used as the base)
            clear oldInliersExtract temp2 app.k1 2265
            
            % Extract the index of the new reference frame GCP marker points. This should stay constant through all of the video frames
            numPoints = double(oldPoints.Location);
            
            [sizer1, ~] = size(app.gcpA); % accounts for small numbers of GCPs
            for a = 1:sizer1
                if app.gcpA(a,5) > 0
                    [n,~]=knnsearch(numPoints(:,1:2), [app.gcpA(a,4) app.gcpA(a,5)]); % Find the index of the camera in mesh space
                    app.k1(a,1:2) = n; % new index for searching
                else
                    app.k1(a,1:2) = NaN;
                end
            end
            
            % Re update the GCP positions based on the new feature scan
            try
                [sizer1, ~] = size(app.gcpA); % accounts for small numbers of GCPs
                for a = 1:sizer1
                    if ~isnan(app.k1(a)) == 1
                        app.gcpA(a,4) = numPoints(app.k1(a),1);
                        app.gcpA(a,5) = numPoints(app.k1(a),2);
                    else
                        app.gcpA(a,4) = NaN;
                        app.gcpA(a,5) = NaN;
                    end
                end
            catch % this needs to be more robust to errors
                disp('Some GCPs are no longer visible')
            end
            
            camA_previous = app.camA;
            orthorectificationProgessive(app); % Run the continuous orthoscript to determine the movement of the UAV
        end
        app.s2 = app.s2 + 1;
        template = '00000';
        inputNum = num2str(app.s2);
        p1 = template(1:end-length(num2str(app.s2)));
        p2 = inputNum;
        fileNameIteration = [p1,p2];
        nFrame = nFrame + 1;
        
    else % if its not the start of a new cycle
        
        V.CurrentTime = app.s2.*1/app.videoFrameRate; % access the first frame
        
        if strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation + GCPs') == 0
            app.objectFrame = images.internal.rgb2graymex(readFrame(V));
        else
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
        end
        
        [app.newPoints, isFound] = step(tracker, app.objectFrame); % Track the features through the next frame
        visiblePoints = app.newPoints(isFound, :);
        oldInliers = oldPoints(isFound, :);
        temp1 = find(nFrame == extractWhen);
        if temp1 > 0 % if the frame is selected to be extracted then...
            [temp2, ~] = size(visiblePoints);
            xDist = ones(temp2,1); horizontalValue = ones(temp2,1); verticalValue = ones(temp2,1);
            horizontalValue2 = ones(temp2,1); verticalValue2 = ones(temp2,1);
            s = 1;
            while s < temp2 + 1
                oldInliersExtract = oldInliers.Location(s,:);
                horizontalValue(s,1) = oldInliersExtract(1); % Extract the x-axis co-ordinates for the reference features
                verticalValue(s,1) = oldInliersExtract(2); % Extract the y-axis co-ordinates for the reference features
                horizontalValue2(s,1) = visiblePoints(s,1); % Extract the x-axis co-ordinates for the final tracked features
                verticalValue2(s,1) = visiblePoints(s,2); % Extract the y-axis co-ordinates for the final tracked features
                s = s + 1;
            end
            
            if strcmp (app.IgnoreEdgesDropDown.Value, 'Yes') == 1 % remove edges if required
                foi = horizontalValue(:,1) > app.imgsz(2)-0.9*app.imgsz(2) & horizontalValue(:,1) < 0.9*app.imgsz(2) & verticalValue(:,1) > app.imgsz(1)-0.9*app.imgsz(1) & verticalValue(:,1) < 0.9*app.imgsz(1);
            else
                foi = horizontalValue(:,1) > [0] & horizontalValue(:,1) < [app.imgsz(2)] & verticalValue(:,1) > [0] & verticalValue(:,1) < [app.imgsz(1)];
            end
            
            if app.s2 > 0 % only extract data from the 40th frame onwards due to poor encoding at the start
                %Extract the starting and finishing tracked positions
                uvA_initial(:,1) = vertcat(horizontalValue(foi)); %Place the starting x values into the first column
                uvA_initial(:,2) = vertcat (verticalValue(foi)); %Place the starting y cells in the second column
                uvB_initial(:,1) = vertcat(horizontalValue2(foi));%Place the finish x values into the first column
                uvB_initial(:,2) = vertcat(verticalValue2(foi));%Place the finish y values into the first column            %uvA = double(uvA_initial);
                
                temper1 = camA_previous.invproject(uvA_initial,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                temper2 = app.camA.invproject(uvB_initial,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                
                xyz = [temper1(:,1:2); temper2(:,1:2)];
                xyzA_initial = xyz(1:length(uvA_initial),1:2); % Starting positions that have been rectified
                xyzB_initial = xyz(length(uvA_initial)+1:end,1:2); % Finish positions that have been rectified
                
                if length (uvA) > 1
                    initialSize = length(uvA);
                    uvA(1:length(uvA)+length(uvA_initial),1) = vertcat(uvA(:,1),uvA_initial(:,1)); % this is new
                    uvA(1:initialSize+length(uvA_initial),2) = vertcat(uvA(1:initialSize,2),uvA_initial(:,2)); % this is new
                    uvB(1:length(uvB)+length(uvB_initial),1) = vertcat(uvB(:,1),uvB_initial(:,1));% this is new
                    uvB(1:initialSize+length(uvB_initial),2) = vertcat(uvB(1:initialSize,2),uvB_initial(:,2));% this is new
                    
                    initialSize = length(xyzA);
                    xyzA(1:length(xyzA)+length(xyzA_initial),1) = vertcat(xyzA(:,1),xyzA_initial(:,1)); % this is new
                    xyzA(1:initialSize+length(xyzA_initial),2) = vertcat(xyzA(1:initialSize,2),xyzA_initial(:,2)); % this is new
                    xyzB(1:length(xyzB)+length(uvB_initial),1) = vertcat(xyzB(:,1),xyzB_initial(:,1));% this is new
                    xyzB(1:initialSize+length(xyzB_initial),2) = vertcat(xyzB(1:initialSize,2),xyzB_initial(:,2));% this is new
                else
                    uvA = uvA_initial;
                    uvB = uvB_initial;
                    xyzA = xyzA_initial;
                    xyzB = xyzB_initial;
                end
            end
            clear xyzA_initial xyzB_initial uvA_initial uvB_initial verticalValue2 verticalValue horizontalValue2 horizontalValue
        end
        
        nFrame = nFrame + 1;
        app.s2 = app.s2 + 1;
        template = '00000';
        inputNum = num2str(app.s2);
        p1 = template(1:end-length(num2str(app.s2)));
        p2 = inputNum;
        fileNameIteration = [p1,p2];
        TextIn = {['Frame ' int2str(app.s2-1) ' of ' int2str(videoClip.* app.videoFrameRate) ' completed. Please wait']};
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
    end
    clear uvAorig uvBorig uvIndex markers markerColors out
end % length of video

if length(app.boundaryLimitsM)>1
    [in,on] = inpolygon(xyzA(:,1),xyzA(:,2),app.boundaryLimitsM(:,1),app.boundaryLimitsM(:,2));
    app.xyzA_final = xyzA(in,1:2);
    app.xyzB_final = xyzB(in,1:2);
else
    app.xyzA_final = xyzA(:,1:2);
    app.xyzB_final = xyzB(:,1:2);
end
TextIn = {'Image processing completed'};
TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
TimeIn = strjoin(TimeIn, ' ');
app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
printItems(app)
pause(0.01);
app.ListBox.scroll('bottom');
end %function