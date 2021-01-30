classdef KLT < matlab.apps.AppBase
    
    % Properties that correspond to app components
    properties (Access = public)
        KLTIV_UIFigure                  matlab.ui.Figure
        CameraxyzLabel                  matlab.ui.control.Label
        RUNButton                       matlab.ui.control.Button
        ResolutionmpxEditFieldLabel     matlab.ui.control.Label
        ResolutionmpxEditField          matlab.ui.control.NumericEditField
        VideoInputsLabel                matlab.ui.control.Label
        AnalysisLabel                   matlab.ui.control.Label
        FlightPathPlotSwitchLabel       matlab.ui.control.Label
        FlightPathPlotSwitch            matlab.ui.control.Switch
        TrajectoriesPlotSwitchLabel     matlab.ui.control.Label
        TrajectoriesPlotSwitch          matlab.ui.control.Switch
        yawpitchrollEditFieldLabel      matlab.ui.control.Label
        GroundControlLabel              matlab.ui.control.Label
        SettingsLabel                   matlab.ui.control.Label
        OutputDirectoryButton           matlab.ui.control.Button
        OrthophotosSwitchLabel          matlab.ui.control.Label
        OrthophotosSwitch               matlab.ui.control.Switch
        CustomFOVEditFieldLabel_2       matlab.ui.control.Label
        CustomFOVEditFieldLabel_3       matlab.ui.control.Label
        CustomFOVEditFieldLabel_4       matlab.ui.control.Label
        CustomFOVEditFieldLabel_6       matlab.ui.control.Label
        CustomFOVEditFieldLabel_7       matlab.ui.control.Label
        Gauge                           matlab.ui.control.Gauge
        DischargeLabel                  matlab.ui.control.Label
        DefinecrosssectionButton        matlab.ui.control.Button
        UITable2                        matlab.ui.control.Table
        SearchDistanceEditFieldLabel    matlab.ui.control.Label
        SearchDistanceEditField         matlab.ui.control.NumericEditField
        CALCULATEButton                 matlab.ui.control.Button
        CrosssectionInputDropDownLabel  matlab.ui.control.Label
        CrosssectionInputDropDown       matlab.ui.control.DropDown
        alphaEditFieldLabel             matlab.ui.control.Label
        alphaEditField                  matlab.ui.control.NumericEditField
        yawpitchrollEditFieldLabel_2    matlab.ui.control.Label
        yawpitchrollEditFieldLabel_3    matlab.ui.control.Label
        AddVideoButton                  matlab.ui.control.Button
        CameraTypeDropDownLabel         matlab.ui.control.Label
        CameraTypeDropDown              matlab.ui.control.DropDown
        CameraxyzEditField              matlab.ui.control.NumericEditField
        CameraxyzEditField_2            matlab.ui.control.NumericEditField
        CameraxyzEditField_3            matlab.ui.control.NumericEditField
        yawpitchrollEditField           matlab.ui.control.NumericEditField
        yawpitchrollEditField_2         matlab.ui.control.NumericEditField
        yawpitchrollEditField_3         matlab.ui.control.NumericEditField
        OrientationDropDownLabel        matlab.ui.control.Label
        OrientationDropDown             matlab.ui.control.DropDown
        ExtractionratesEditFieldLabel   matlab.ui.control.Label
        ExtractionratesEditField        matlab.ui.control.NumericEditField
        BlocksizepxEditFieldLabel       matlab.ui.control.Label
        BlocksizepxEditField            matlab.ui.control.NumericEditField
        IgnoreEdgesDropDownLabel        matlab.ui.control.Label
        IgnoreEdgesDropDown             matlab.ui.control.DropDown
        VelocityDropDownLabel           matlab.ui.control.Label
        VelocityDropDown                matlab.ui.control.DropDown
        GCPDataDropDownLabel            matlab.ui.control.Label
        GCPDataDropDown                 matlab.ui.control.DropDown
        UITable                         matlab.ui.control.Table
        BufferaroundGCPsmetersEditFieldLabel  matlab.ui.control.Label
        BufferaroundGCPsmetersEditField  matlab.ui.control.NumericEditField
        CustomFOVEditField_2            matlab.ui.control.NumericEditField
        CustomFOVEditField_3            matlab.ui.control.NumericEditField
        CustomFOVEditField_4            matlab.ui.control.NumericEditField
        CustomFOVEditField_5            matlab.ui.control.NumericEditField
        WatersurfaceelevationmEditFieldLabel  matlab.ui.control.Label
        WatersurfaceelevationmEditField  matlab.ui.control.NumericEditField
        CheckGCPsSwitchLabel            matlab.ui.control.Label
        CheckGCPsSwitch                 matlab.ui.control.Switch
        ExportGCPdataSwitchLabel        matlab.ui.control.Label
        ExportGCPdataSwitch             matlab.ui.control.Switch
        ExporttrajectoriesSwitchLabel   matlab.ui.control.Label
        ExporttrajectoriesSwitch        matlab.ui.control.Switch
        ListBox                         matlab.ui.control.ListBox
        ProcessingModeDropDown          matlab.ui.control.DropDown
        ProcessingModeDropDownLabel     matlab.ui.control.Label
        AddVideoButtonLabel             matlab.ui.control.Label
        OutputDirectoryButtonText       matlab.ui.control.Label
        AddLevelButton                  matlab.ui.control.Button
        ExportDefaultValuesLabel        matlab.ui.control.Label
        ExportDefaultValuesButton       matlab.ui.control.Button
        LoadDefaultValuesLabel          matlab.ui.control.Label
        LoadDefaultValuesButton         matlab.ui.control.Button
        CameraxyzEditFieldLabel         matlab.ui.control.Label
        CameraxyzEditField_2Label       matlab.ui.control.Label
        CameraxyzEditField_3Label       matlab.ui.control.Label
        CrossSectionDropDownLabel       matlab.ui.control.Label
        CrossSectionDropDown            matlab.ui.control.DropDown
        ReferenceHeight                 matlab.ui.control.DropDown
        ReferenceHeightLabel            matlab.ui.control.Label
        InterpolationMethodLabel        matlab.ui.control.Label
        InterpolationMethod             matlab.ui.control.DropDown
        ProcessingModeDropDownLabel2    matlab.ui.control.Label
    end
    
    properties (Access = public)
        directory 
        file
        directory2
        file2
        Platformvalue
        firstFrame
        OrientationValue
        GCPData
        GCPfile
        GCPdirectory
        c
        f
        k
        p
        X
        Y
        dem
        TransX
        TransY
        Transdem
        imgsz
        camA
        GCPdims
        cameraModelParameters
        iter
        Blocksize
        k1
        gcpA
        newPoints
        objectFrame
        s2
        vel
        adjustedVel
        videoFrameRate
        Xout
        Yout
        uvA_final
        uvB_final
        xyzA_final
        xyzB_final
        directory_save
        magVelError
        xComponent
        yComponent
        velMagnitude
        requiredResolution
        VelocityOutputs
        pts
        end1
        start1
        camA_first
        normalVelocity
        tangentialVelocity
        testInputX
        testInputY
        firstOrthoImage
        XS_pts
        transectLength
        xInder
        yInder
        startXS
        endXS
        xs
        xsdims
        xsData
        xsfile
        xsdirectory
        transformNormal
        transformTangential
        rmse
        rgbHR
        imageGCPs
        GCPimageReal
        UAS_GPSfile
        UAS_GPSdirectory
        frame_uas_x
        frame_uas_y
        frame_uas_z
        currentFrame
        previousFrame
        WEBWINDOW
        scrollPane
        ControlsPanel
        CONTROLDIMS
        ControlHandles
        refValue
        flexVars
        previousLoad
        flexVarsComp
        videoDuration
        InitialGCP
        rollingGCPs
        gcpA_checked
        TempFileIn
        surveyFile
        surveyDirectory
        CrossSectionDropDownValue
        UAS_onboardfile
        UAS_onboarddirectory
        frameYprMatch
        surveyIn
        roiButton
        roiButtonText
        boundaryLimitsPx
        boundaryLimitsM
        imageResolution
        uvHR
        inframeHR
        visHR
        subDir
        s2_mod
        videoClip
        directory_stab
        directory_ortho
        masterImage
        masterImageX
        masterImageY
        videoDatesFormatted
        videoDirFileNames
        videoDatesFormattedNum
        fileNameAnalysis
        riverLevelTimeAnalysis
        riverLevelAnalysis
        subSample
        videoNumber
        directory_save_multiple
        objectFrameStacked
        totalQ
        QfileOut
        minVel
        maxVel
        videoStart
        startingVideo
        starterInd
        reloaded
        batchAnswer
        Cameraxyz_modifyXbox
        Cameraxyz_modifyYbox
        Cameraxyz_modifyZbox
    end
    
    methods (Access = private)
        
        function  [] = customFOV(app)
            if abs(app.CustomFOVEditField_2.Value) + abs(app.CustomFOVEditField_4.Value) > 0 || ...
                    abs(app.CustomFOVEditField_2.Value) + abs(app.CustomFOVEditField_4.Value) > 0 ...
                    && strcmp(app.CustomFOVEditField_2.Enable,'on') == true ...
                    && strcmp(app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false
                
                % Lower resolution DEM
                TransxIn = app.CustomFOVEditField_2.Value:0.1:app.CustomFOVEditField_4.Value;
                TransyIn = app.CustomFOVEditField_3.Value:0.1:app.CustomFOVEditField_5.Value;
                [app.TransX,app.TransY]=meshgrid(TransxIn,TransyIn);
                [params] = size(app.TransX);
                %disp(params)
                demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
                app.Transdem = demIn; % new insert - 20200510 (was 0 insead)
                
                % Large DEM
                looper = 1;
                while looper < 2
                    try % Try in case of memory issues
                        xIn = app.CustomFOVEditField_2.Value:app.ResolutionmpxEditField.Value:app.CustomFOVEditField_4.Value;
                        yIn = app.CustomFOVEditField_3.Value:app.ResolutionmpxEditField.Value:app.CustomFOVEditField_5.Value;
                        if (length(xIn) .* length(yIn)) > [180000000] % equivalent to 160 x 110m %[30000000] % equivalent to 40 x 60m
                            % Reduce resolution by a factor of two:
                            app.ResolutionmpxEditField.Value = app.ResolutionmpxEditField.Value.*2;
                            TextIn2 = (['The specified resolution of the orthophotos is too high']);
                            TextIn3 = (['Reducing the resolution and trying again']);
                            TextIn4 = (['Changing resolution of orthophotos to ' num2str(app.ResolutionmpxEditField.Value) ' m/px' ]);
                            TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                            TimeIn = strjoin(TimeIn, ' ');
                            app.ListBox.Items = [app.ListBox.Items, TimeIn,...
                                TextIn2', TextIn3', TextIn4', ];
                            printItems(app)
                            pause(0.01);
                            app.ListBox.scroll('bottom');
                            continue
                        else
                            [app.X,app.Y]=meshgrid(xIn,yIn);
                            [params] = size(app.X);
                            demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
                            app.dem = demIn;
                            looper = 2;
                        end
                    catch e
                        TextIn = (['An error occurred. The message was:']);
                        errorIn = {[ e.message ]};
                        TextIn2 = (['The specified resolution of the orthophotos is too high']);
                        TextIn3 = (['Reducing the resolution and trying again']);
                        TextIn4 = (['Changing resolution of orthophotos to ' num2str(app.ResolutionmpxEditField.Value.*2) ' m/px' ]);
                        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                        TimeIn = strjoin(TimeIn, ' ');
                        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn',...
                            errorIn', TextIn2', TextIn3', TextIn4', ];
                        printItems(app)
                        pause(0.01);
                        app.ListBox.scroll('bottom');
                        % Reduce reolution by a factor of two:
                        app.ResolutionmpxEditField.Value = app.ResolutionmpxEditField.Value.*2;
                    end
                end
                
            elseif strcmp(app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == true
                % Do nothing -- this is dealt with later on
                
            elseif strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation') == false && ...
                    strcmp (app.OrientationDropDown.Value,'Planet [beta]') == false
                
                % If no custom FOV has been defined
                GCPbuffer = app.BufferaroundGCPsmetersEditField.Value; % modify the buffer value
                
                % Lower resolution DEM
                TransxIn = nanmin(app.gcpA(:,1))-GCPbuffer:0.1:nanmax(app.gcpA(:,1))+GCPbuffer;
                TransyIn = nanmin(app.gcpA(:,2))-GCPbuffer:0.1:nanmax(app.gcpA(:,2))+GCPbuffer;
                [app.TransX,app.TransY]=meshgrid(TransxIn,TransyIn);
                [params] = size(app.TransX);
                
                if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1% if the first video
 
                    looper = 1;% Large DEM
                    while looper < 2
                        try % Try in case of memory issues
                            xIn = nanmin(app.gcpA(:,1))-GCPbuffer:app.ResolutionmpxEditField.Value:nanmax(app.gcpA(:,1))+GCPbuffer;
                            yIn = nanmin(app.gcpA(:,2))-GCPbuffer:app.ResolutionmpxEditField.Value:nanmax(app.gcpA(:,2))+GCPbuffer;
                            if (length(xIn) .* length(yIn)) > [30000000] % equivalent to 40 x 60m
                                % Reduce resolution by a factor of two:
                                app.ResolutionmpxEditField.Value = app.ResolutionmpxEditField.Value.*2;
                                TextIn2 = (['The specified resolution of the orthophotos is too high']);
                                TextIn3 = (['Reducing the resolution and trying again']);
                                TextIn4 = (['Changing resolution of orthophotos to ' num2str(app.ResolutionmpxEditField.Value) ' m/px' ]);
                                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                                TimeIn = strjoin(TimeIn, ' ');
                                app.ListBox.Items = [app.ListBox.Items, TimeIn,...
                                    TextIn2', TextIn3', TextIn4', ];
                                printItems(app)
                                pause(0.01);
                                app.ListBox.scroll('bottom');
                                continue
                            else
                                [app.X,app.Y]=meshgrid(xIn,yIn);
                                [params] = size(app.X);
                                demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
                                app.dem = demIn;
                                looper = 2;
                            end
                        catch e
                            TextIn = (['An error occurred. The message was:']);
                            errorIn = {[ e.message ]};
                            TextIn2 = (['The specified resolution of the orthophotos is too high']);
                            TextIn3 = (['Reducing the resolution and trying again']);
                            TextIn4 = (['Changing resolution of orthophotos to ' num2str(app.ResolutionmpxEditField.Value.*2) ' m/px' ]);
                            TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                            TimeIn = strjoin(TimeIn, ' ');
                            app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn',...
                                errorIn', TextIn2', TextIn3', TextIn4', ];
                            printItems(app)
                            pause(0.01);
                            app.ListBox.scroll('bottom');
                            % Reduce reolution by a factor of two:
                            app.ResolutionmpxEditField.Value = app.ResolutionmpxEditField.Value.*2;
                        end
                    end
                    
                else % If not the first video
                    [params] = size(app.X);
                    demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
                    app.dem = demIn;
                end
                
            else
                % If the known scale of the image is required
                TransxIn = (1:1:size(app.firstFrame,2)).*app.imageResolution;
                TransyIn = (1:1:size(app.firstFrame,1)).*app.imageResolution;
                [app.TransX,app.TransY]=meshgrid(TransxIn,TransyIn);
                [params] = size(app.TransX);
                demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
                app.Transdem = demIn;
                app.dem = demIn;
            end
            
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                
                if isempty(app.videoNumber) % Specify the file index
                    app.videoNumber = 1;
                end
                
                % Bring in the video for analysis
                
                ffmpeg_conversion_batch(app)
                
                V = VideoReader(strjoin ({app.directory, '\', app.fileNameAnalysis{app.videoNumber}},''));
                totNum = V.NumFrames;
                if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1
                    app.videoDuration = V.Duration; % Extract the length of the video
                    app.videoFrameRate = V.FrameRate; % Extract the frame rate of the video
                end
                
                if app.videoNumber == 1 % Pre-allocate the stacked array
                    app.objectFrameStacked = cell(1, totNum);
                    for a = 1:totNum
                        app.objectFrameStacked {a} = zeros(app.imgsz(1),app.imgsz(2),'uint8');
                    end
                end
                
                for a = 1:totNum
                    app.objectFrameStacked{a} = images.internal.rgb2graymex(readFrame(V));
                end
                
                % Define the save workspace
                app.directory_save_multiple = strjoin ({app.directory_save, '\', app.fileNameAnalysis{app.videoNumber}},'');
                app.directory_save_multiple = app.directory_save_multiple(1:end-4); % remove the extension
                try
                    mkdir (app.directory_save_multiple);
                catch
                end
                app.WatersurfaceelevationmEditField.Value = app.riverLevelAnalysis(app.videoNumber);
                demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
                [params2] = size(app.Transdem);
                app.Transdem(1:params2(1),1:params2(2)) = app.WatersurfaceelevationmEditField.Value;
            else
                demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
                [params2] = [size(TransyIn,2), size(TransxIn,2)];
                app.Transdem = zeros(params2);
                app.Transdem = replace_num(app.Transdem,0,app.WatersurfaceelevationmEditField.Value); % app.Transdem = demIn;
            end
            
            
        end
        
        function [] = imageAnalysis(app)  % Starting analysis
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                V = VideoReader(strjoin ({app.directory, app.file},''));
                app.videoDuration = V.Duration; % Extract the length of the video
                app.videoFrameRate = V.FrameRate; % Extract the frame rate of the video
                
            end
            
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
            
            % Configure the block size correctly
            tempBlocksize = app.BlocksizepxEditField.Value;
            if bitget(tempBlocksize,1) %odd
                app.Blocksize = [app.BlocksizepxEditField.Value app.BlocksizepxEditField.Value];
            else %even
                app.Blocksize = [tempBlocksize+1 tempBlocksize+1];
            end
            
            % Set the region of interest for analysis as the entire frame
            objectRegion = [1, 1, app.imgsz(2), app.imgsz(1)]; %[TopLeftX,TopLeftY,LengthX,LengthY]
            
            % Run the camera parameters function
            cameraParameters(app)
            
            % Overwrite the default frame rate?
            if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1% Only run for the first video
                defaultValue = {num2str(app.videoFrameRate)};
                titleBar = 'Manually overwrite the frame rate present in the meta-data?';
                userPrompt = {'Defined frame rates: '};
                caUserInput = inputdlg(userPrompt, titleBar, [1, 60], defaultValue);
                app.videoFrameRate = str2num(caUserInput{1});
            end
            
            % Define the total number of frames available
            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                totNum = V.NumFrames;
            else
                totNum = length(app.objectFrameStacked);
            end

            nFrame = 1;
            app.iter = round(app.videoFrameRate./(1/app.ExtractionratesEditField.Value)); %set extraction rate
            restartWhen = (1:app.iter:totNum);
            ii = 0;
            
            % Enter the start and stop of the video analysis
            if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1 % Only run for the first video
                defaultValue = {'0', num2str(round(app.videoDuration))};
                titleBar = 'Define the start and end of the video in seconds';
                userPrompt = {'Starting point (s): ', 'Finishing point (s): '};
                caUserInput = inputdlg(userPrompt, titleBar, [1, 80], defaultValue);
                app.videoStart = str2num(caUserInput{1});
                app.videoClip = str2num(caUserInput{2});
                %totNum = floor((app.videoClip.*app.videoFrameRate) + 1);
            end
            
            % Ensure that the inputs for s2 and nFrame are okay for all
            % orientations
            if isempty (app.s2_mod)
                app.s2 = round(1 + (app.videoStart.*app.videoFrameRate));
                [~,idx] = min(abs(restartWhen-app.s2));
                app.s2 = restartWhen(idx(1));
                nFrame = app.s2;
            else
                app.s2 = round(1 + (app.s2_mod.*app.videoFrameRate));
                nFrame = round(nFrame + (app.s2_mod.*app.videoFrameRate));
            end
            
            % Run the stabilisation functions if required
            if strcmp (app.OrientationDropDown.Value,'Dynamic: GCPs + Stabilisation') == true || ...
                    strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation') == true
                stabiliseImageInput(app, V, totNum); % Stabilise all of the frames first
            elseif strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                stabiliseImageInputGPS2(app, V, totNum) % Stabilise all of the frames first
            elseif strcmp (app.OrientationDropDown.Value,'Planet [beta]') == true
                stabiliseImageInputPlanet(app, V, totNum) % Stabilise all of the frames first
            end
            
            % This is the main part of the feature tracking
            while app.s2 < totNum -1
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    set(app.RUNButton,'Text',strjoin({'Processing: ' int2str((app.s2-1)/totNum*100) '% Complete'},''));
                    pause(0.01)
                    
                    if length(find(~cellfun(@isempty,app.ListBox.Items))) == 1000
                        for x=1:1000 % create an empty listbox again
                            app.ListBox.Items(x) = {['']};
                        end
                    end
                    
                end
                if ~isempty(find(nFrame == restartWhen) > 0) || ii == 0 % If it is the start of a new loop or frame 1
                    if ii == 0 % if its the first frame
                        ii = 1;
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
                            fileNamesIn = fileNamesIn(contains(fileNamesIn,'.jpg'));
                            Index = find(contains(fileNamesIn,fileNameIteration));
                            if Index > 0% if s2 matches the first image in the sequence bring it in
                                app.objectFrame = imread([app.directory_stab '\' char(fileNamesIn(Index))]);
                                restartWhen = (app.s2:app.iter:totNum); % Feed in the correct values
                            else
                                % Otherwise do nothing
                            end
                            
                            
                        elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                            % Load the correct frame in the video sequence
                            app.objectFrame = app.objectFrameStacked{nFrame};
                            
                        else
                            app.objectFrame = images.internal.rgb2graymex(readFrame(V));
                        end
                        
                        if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                            objectRegion = [1 1 flip(size(app.objectFrame))];
                        end
                        
                        points = detectMinEigenFeatures(app.objectFrame, 'ROI', objectRegion); % set the nFrame image as the new reference to be used
                        points = points.Location;
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
                            numPoints = double(oldPoints);% locate the origins of the GCPs
                        else
                            oldPoints = points; % Make a copy of the points to be used
                            numPoints = double(oldPoints);% locate the origins of the GCPs
                        end
                        
                        if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == false
                            orthorectification(app) % Run the starting orthoscript
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
                        printItems(app)
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
                            if Index > 0
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
                            app.objectFrame = images.internal.rgb2graymex(readFrame(V));
                        end
                        
                        % After bringing in the new object, detect the
                        % succesfully tracked features
                        [app.newPoints, isFound] = step(tracker, app.objectFrame); % Track the features through the final frame of the sequence
                        visiblePoints = app.newPoints(isFound, :);
                        oldInliers = oldPoints(isFound, :);
                        
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
                                strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false % remove edges if required
                            foi = horizontalValue(:,1) > app.imgsz(2)-0.9*app.imgsz(2) & horizontalValue(:,1) < 0.9*app.imgsz(2) & verticalValue(:,1) > app.imgsz(1)-0.9*app.imgsz(1) & verticalValue(:,1) < 0.9*app.imgsz(1);
                        elseif strcmp (app.IgnoreEdgesDropDown.Value, 'Yes') == false && ...
                                strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false
                            foi = horizontalValue(:,1) > [0] & horizontalValue(:,1) < [app.imgsz(2)] & verticalValue(:,1) > [0] & verticalValue(:,1) < [app.imgsz(1)];
                        elseif strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == true
                            foi = (1:length(horizontalValue)); % use all of the data
                        end
                        
                        if app.s2 > 0  && ~isempty(horizontalValue)
                            %Extract the starting and finishing tracked positions
                            uvA_initial(:,1) = vertcat(horizontalValue(foi)); %Place the starting x values into the first column
                            uvA_initial(:,2) = vertcat (verticalValue(foi)); %Place the starting y cells in the second column
                            uvB_initial(:,1) = vertcat(horizontalValue2(foi));%Place the finish x values into the first column
                            uvB_initial(:,2) = vertcat(verticalValue2(foi));%Place the finish y values into the first column            %uvA = double(uvA_initial);
                            
                            if strcmp (app.OrientationDropDown.Value, 'Dynamic: Stabilisation') == false && ...
                                    strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false && ...
                                    strcmp (app.OrientationDropDown.Value, 'Planet [beta]') == false
                                camA_previous = app.camA;
                            end
                            
                            if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == false
                                orthorectificationProgessive(app); % Run the continuous orthoscript to determine the movement of the UAV
                            end
                            
                            if strcmp (app.OrientationValue, 'Dynamic: Stabilisation') == false && ...
                                    strcmp (app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false && ...
                                    strcmp (app.OrientationDropDown.Value, 'Planet [beta]') == false
                                if length(app.TransX) > 1
                                    temper1 = camA_previous.invproject(uvA_initial,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                                    temper2 = app.camA.invproject(uvB_initial,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                                    if ~isempty(temper1)
                                        xyz = [temper1(:,1:2); temper2(:,1:2)];
                                        [initialSize, ~] = size(uvA_initial);
                                        xyzA_initial = xyz(1:initialSize,1:2); % Starting positions that have been rectified
                                        xyzB_initial = xyz(initialSize+1:end,1:2); % Finish positions that have been rectified
                                    else
                                        temper1 = [];
                                        tempter2 = [];
                                    end
                                else
                                    temper1 = [];
                                    tempter2 = [];
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
                            
                            if length (uvA) > 1 && exist('xyzA','var') == 1
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
                        
                        points = detectMinEigenFeatures(app.objectFrame, 'ROI', objectRegion); % set the nFrame image as the new reference to be used
                        points = points.Location;
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
                        
                        %app.s2 = app.s2 + 1;
                        %nFrame = nFrame + 1;
                        %template = '00000';
                        %inputNum = num2str(app.s2);
                        %p1 = template(1:end-length(num2str(app.s2)));
                        %p2 = inputNum;
                        %fileNameIteration = [p1,p2];
                        
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
                        if Index > 0
                            app.objectFrame = imread([app.subDir '\' char(fileNamesIn(Index))]);
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
                            app.objectFrame = images.internal.rgb2graymex(readFrame(V)); % if no more frames
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
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
            clear uvAorig uvBorig uvIndex markers markerColors out
            
            try
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
                
            catch
                TextIn = {'No trajectories stored. The program will terminate.'; ...
                    'Check inputs e.g. custom FOV (if used) and WSE values and retry.'}; % Update the display
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                error('Breaking out of function');
            end
            
        end %function
        
        
        function [] = trajectoryAdjustments(app)
            if strcmp (app.VelocityDropDown.Value, 'Normal Component') == 1
                
                TextIn = {'Computing the normal component of the flow. Please wait.'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                [t1, t2] = size(app.objectFrame); % Ensure the start stop positions don't exceed the size of the image
                if app.start1(1) < 0; app.start1(1) = 0; end
                if app.start1(1) > t2; app.start1(1) = t2; end
                if app.start1(2) < 0; app.start1(2) = 0; end
                if app.start1(2) > t1; app.start1(2) = t1; end
                if app.end1(1) < 0; app.end1(1) = 0; end
                if app.end1(1) > t2; app.end1(1) = t2; end
                if app.end1(2) < 0; app.end1(2) = 0; end
                if app.end1(2) > t1; app.end1(2) = t1; end
                
                if strcmp (app.OrientationValue, 'Dynamic: Stabilisation') == false && ...
                        strcmp (app.OrientationValue, 'Planet [beta]') == false
                    start1_rw = app.camA_first.invproject(app.start1,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
                    end1_rw =   app.camA_first.invproject(app.end1,app.TransX,app.TransY,app.Transdem);
                else
                    start1_rw = app.start1.*app.imageResolution;
                    end1_rw = app.end1.*app.imageResolution;
                end
                
                TextIn = {'Estimating the length of time the trajectory corrections will take. Please wait.'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                % Convert velocities to normal direction
                tic;
                if length(app.xyzA_final) > 100
                    len1 = 1000;
                else
                    len1 = length(app.xyzA_final);
                end
                
                for a = 1:len1
                    temper1 = normalVector([app.xyzA_final(a,1:2)', app.xyzB_final(a,1:2)'],start1_rw(1:2),end1_rw(1:2));
                end
                time = toc;
                
                TextIn = {'Would you like to speed up analysis by sub-sampling the data? See dialog box'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                eachIter = time./a; % seconds per sample
                timeS  = (length(app.xyzA_final)).*eachIter./60; %mins
                prompt = ['app.subSample data? You have ' num2str(length(app.xyzB_final)) ' features. This will take '...
                    num2str(round(timeS)) ' minutes'];
                dlgtitle = 'Query';
                definput = num2str(length(app.xyzA_final));
                app.subSample = str2num(cell2mat(inputdlg(prompt,dlgtitle,[1 60],{definput})));
                dataPoints = app.subSample;
                ind1 = randperm(length(app.xyzA_final));
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    set(app.RUNButton,'Text','Processing trajectories');
                end
                
                TextIn = {'Adjusting trajectories, please wait'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                for t = 1:dataPoints
                    if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                        set(app.RUNButton,'Text',strjoin({'Processing: ' int2str((t)/(dataPoints)*100) '% Complete'},''));
                    end
                    dataOut(t) = normalVector([app.xyzA_final(ind1(t),1:2)',app.xyzB_final(ind1(t),1:2)'],start1_rw(1:2),end1_rw(1:2));
                end
                
                dataOut = replace_num(dataOut,0,NaN);
                app.xyzA_final = app.xyzA_final(ind1(1:t),1:2);
                app.xyzB_final = app.xyzB_final(ind1(1:t),1:2);
                app.normalVelocity = abs(dataOut./(app.iter*1/app.videoFrameRate))'; % divided by time period between start and stop i.e. m s
                app.vel = app.xyzB_final - app.xyzA_final;% The raw velocity values - not direction specific
                app.adjustedVel = app.vel./(app.iter*1/app.videoFrameRate); % divided by time period between start and stop i.e. m s
                
                % Specify the minimum and maximum velocity for normal
                % component analysis
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                    app.refValue = app.normalVelocity(:,1);
                    if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1% if the first video
                        defaultValue = {'0.1', num2str(Inf)};
                        titleBar = 'Define the min and max velocities to be stored across all videos';
                        userPrompt = {'Minimum (m/s): ', 'Maximum (m/s): '};
                        caUserInput = inputdlg(userPrompt, titleBar, [1, 120], defaultValue);
                        app.minVel = str2num(caUserInput{1});
                        app.maxVel = str2num(caUserInput{2});
                    end
                    if ~isempty(app.minVel)
                        remover1 = find(app.refValue < app.minVel | app.refValue > app.maxVel);
                        app.refValue(remover1) = NaN;
                    end
                    
                elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    app.refValue = app.normalVelocity(:,1);
                    if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1 % if the first video
                        defaultValue = {'0.1', num2str(Inf)};
                        titleBar = 'Define the minimum and maximum velocities to be stored';
                        userPrompt = {'Minimum (m/s): ', 'Maximum (m/s): '};
                        caUserInput = inputdlg(userPrompt, titleBar, [1, 80], defaultValue);
                        app.minVel = str2num(caUserInput{1});
                        app.maxVel = str2num(caUserInput{2});
                    end
                    if ~isempty(app.minVel)
                        remover1 = find(app.refValue < app.minVel | app.refValue > app.maxVel);
                        app.refValue(remover1) = NaN;
                    end
                end
                
                TextIn = {'Trajectory adjustments completed, continue'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            elseif strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
                app.xyzA_final = app.xyzA_final(1:end,1:2);
                app.xyzB_final = app.xyzB_final(1:end,1:2);
                app.vel = app.xyzB_final - app.xyzA_final;% The raw velocity values - not direction specific
                app.adjustedVel = app.vel./(app.iter*1/app.videoFrameRate); % divided by time period between start and stop i.e. m s
                app.normalVelocity(1:length(app.xyzA_final),1) = NaN;
                app.refValue = sqrt(app.adjustedVel(:,1).^2 + app.adjustedVel(:,2).^2);
                
                % Specify the minimum and maximum velocity
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                    if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1% if the first video
                        defaultValue = {'0.1', num2str(Inf)};
                        titleBar = 'Define the min and max velocities to be stored across all videos';
                        userPrompt = {'Minimum (m/s): ', 'Maximum (m/s): '};
                        caUserInput = inputdlg(userPrompt, titleBar, [1, 120], defaultValue);
                        app.minVel = str2num(caUserInput{1});
                        app.maxVel = str2num(caUserInput{2});
                    end
                    if ~isempty(app.minVel)
                        remover1 = find(app.refValue < app.minVel | app.refValue > app.maxVel);
                        app.refValue(remover1) = NaN;
                    end

                elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1% if the first video
                        defaultValue = {'0.1', num2str(Inf)};
                        titleBar = 'Define the minimum and maximum velocities to be stored';
                        userPrompt = {'Minimum (m/s): ', 'Maximum (m/s): '};
                        caUserInput = inputdlg(userPrompt, titleBar, [1, 80], defaultValue);
                        app.minVel = str2num(caUserInput{1});
                        app.maxVel = str2num(caUserInput{2});
                    end
                    if ~isempty(app.minVel)
                        remover1 = find(app.refValue < app.minVel | app.refValue > app.maxVel);
                        app.refValue(remover1) = NaN;
                    end
                end

            end
        end
        
        function [] = trajectories(app)
            if strcmp (app.TrajectoriesPlotSwitch.Value, 'On') == 1
                try
                    TextIn = {'Initiating the particle trajectories plot. Please wait.'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    xyzA_final2 = app.xyzA_final(:,1:2);
                    xyzB_final2 = app.xyzB_final(:,1:2);
                    
                    limits = [nanmin(app.refValue); nanmax(app.refValue)];
                    normalised = app.refValue./nanmax(app.refValue);
                    f1 = figure ('units','pixels'); %,'outerposition',[0 0 1 1]);
                    init = get(0, 'MonitorPositions');
                    if size(init, 1) <= 1% v1.1 addition to account for dual monitors
                        set(f1,'Position',[0.05*init(4), 0.05*init(4), 0.90.*init(4), 0.90.*init(4)]) % square filling half the screen height
                    end
                    a1 = axes;  
                    hold on;
                    axis equal
                    axis tight
                    
                    % Plot the basemap image
                    % Merge the images into one complete image of the reach
                    if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                        app.masterImage = [];
                        app.masterImageX = [];
                        app.masterImageY = [];
                        listing = dir([app.directory_stab]);
                        for a = 1:app.iter: length(listing) % Show at the same rate as the extract rate
                            temp1 = cellstr(listing(a).name);
                            if ~isempty(temp1(contains(temp1,'.jpg')))
                                imageIn = imread(strjoin([app.directory_stab '\' temp1],''));
                                if isempty(app.masterImage)
                                    app.masterImage = imageIn;
                                end
                                missingVal = find(app.masterImage == 0); % missing from master image
                                valExists = find(imageIn > 10); % Exists in new image
                                [val,~]=intersect(missingVal,valExists); % meets both
                                if ~isempty(val)
                                    app.masterImage(val) = imageIn(val);
                                end
                            end
                        end
                        [axis1, axis2] = size(app.masterImage);
                        app.masterImageX = (1:axis2).*app.ResolutionmpxEditField.Value;
                        %app.masterImageY = fliplr((1:axis1).*app.ResolutionmpxEditField.Value);
                        app.masterImageY = (1:axis1).*app.ResolutionmpxEditField.Value;
                        h1 = image(app.masterImageX,app.masterImageY,...
                            app.masterImage,'CDataMapping','scaled');
                    else
                        h1 = image(app.X(1,:),app.Y(:,1),app.rgbHR,'CDataMapping','scaled');
                    end
                    
                    colormap(gray);
                    
                    % Define axes based on minimum of inputs (image or trajectories)
                    limOptTrajX = [nanmin([xyzA_final2(:,1); xyzB_final2(:,1)]), nanmax([xyzA_final2(:,1); xyzB_final2(:,1)])];
                    limOptTrajY = [nanmin([xyzA_final2(:,2); xyzB_final2(:,2)]), nanmax([xyzA_final2(:,2); xyzB_final2(:,2)])];
                    if ~isempty(app.X)
                        limOptImageX = [nanmin(app.X(1,:)),nanmax(app.X(1,:))];
                        limOptImageY = [nanmin(app.Y(:,1)),nanmax(app.Y(:,1))];
                        set(a1,'xlim', [max(limOptTrajX(1),limOptImageX(1)),...
                            min(limOptTrajX(2),limOptImageX(2))]);
                        set(a1,'ylim', [max(limOptTrajY(1),limOptImageY(1)),...
                            min(limOptTrajY(2),limOptImageY(2))]);
                    else
                        set(a1,'xlim', [nanmin([xyzA_final2(:,1); xyzB_final2(:,1)]), nanmax([xyzA_final2(:,1); xyzB_final2(:,1)])])
                        set(a1,'ylim', [nanmin([xyzA_final2(:,2); xyzB_final2(:,2)]), nanmax([xyzA_final2(:,2); xyzB_final2(:,2)])])
                    end
                    
                    xLims = get(a1,'xlim');
                    yLims = get(a1,'ylim');
                    set(a1,'xtick',[],'ytick',[]); %remove its ticks
                    set(a1,'TickLabelInterpreter','latex')
                    set(a1,'fontsize',14)
                    
                    a2 = axes;
                    hold on;
                    axis equal;
                    axis tight
                    set(a2,'xlim',xLims)
                    set(a2,'ylim',yLims)
                    set(a2,'color','none')
                    set(a2,'TickLabelInterpreter','latex')
                    set(a2,'fontsize',14)
                    linkaxes([a1,a2],'xy'); % link the x and y-axis
                    
                    %Create the colobar and set appropriate position
                    if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                        caxis([nanmin(app.refValue),prctile(app.refValue,99.99)])
                    else
                        caxis([nanmin(app.refValue),prctile(app.refValue,99)])
                    end
                    
                    restoredSize1 = get(a1, 'Position');
                    restoredSize2 = get(a2, 'Position');
                    d = colorbar;
                    set(a1, 'Position', restoredSize1 );
                    set(a2, 'Position', restoredSize2 );
                    
                    if strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
                        ylabel(d, 'Velocity Magnitude $\mathrm{(m \ s^{-1})}$' , 'Interpreter','LaTex');
                    elseif strcmp(app.VelocityDropDown.Value, 'Normal Component') == 1
                        ylabel(d, 'Normal Velocity $\mathrm{(m \ s^{-1})}$' , 'Interpreter','LaTex');
                    end
                    
                    d.FontSize = 14;
                    d.Location = 'eastoutside';
                    set(d,'TickLabelInterpreter','latex')
                    cd = colormap(a2, parula); % take your pick (doc colormap)
                    
                    if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                        cd = interp1(linspace(nanmin(app.refValue),prctile(app.refValue,99.99),length(cd)),cd,app.refValue); % map color to velocity values
                    else
                        cd = interp1(linspace(nanmin(app.refValue),prctile(app.refValue,99),length(cd)),cd,app.refValue); % map color to velocity values
                    end
                    cd = uint8(cd'*255); % need a 4xN uint8 array
                    xlabel('X-axis coordinates (m)', 'Interpreter','LaTex')
                    ylabel('Y-axis coordinates (m)', 'Interpreter','LaTex')
                    
                    if strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
                        zlabel(['Velocity Magnitude $\mathrm{(m \ s^{-1})}$'] , 'Interpreter','LaTex');
                    elseif strcmp(app.VelocityDropDown.Value, 'Normal Component') == 1
                        zlabel(['Normal Velocity $\mathrm{(m \ s^{-1})}$'] , 'Interpreter','LaTex');
                    end
                    
                    % Query how many trajectories to plot
                    if isempty(app.subSample)
                        prompt = ['How many vectors would you like to display? ' num2str(length(app.refValue)) ' were extracted '];
                        dlgtitle = 'Query';
                        definput = num2str(10000); % default value
                        if str2num(definput) > length(app.refValue)
                            definput = num2str(length(app.refValue)); % limited by array size
                        end
                        app.subSample = str2num(cell2mat(inputdlg(prompt,dlgtitle,[1 60],{definput})));
                    end
                    
                    dataPoints = app.subSample;
                    ind1 = randperm(length(app.refValue));
                    ind1 = ind1(1:dataPoints);
                    
                    % Catch to ensure too many are not attempted
                    if length(ind1) > length(app.refValue)
                        ind1 = ind1(1:length(app.refValue));
                    end
                    
                    for aa = 1:length(ind1)
                        h2 = plot([xyzA_final2(ind1(1,aa)), xyzB_final2(ind1(1,aa))],...
                            [xyzA_final2(ind1(1,aa),2), xyzB_final2(ind1(1,aa),2)]);
                        set(h2,'Color',cd(:,ind1(aa)))
                        hold on;
                    end
                    
                    TextIn = {'Exporting the plot of particle trajectories'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % Specify the save file options
                    if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                        try
                            temp1 = [app.directory_save_multiple '\trajectories.png'];
                            saveas(f1,temp1,'png')
                            cla(a1);
                            cla(a2);
                            reset(gcf);
                            reset(gca);
                            close (f1)
                            waitfor(f1)
                        catch
                        end
                    else
                        temp1 = [app.directory_save '\' app.file(1:end-4) '_trajectories.png'];
                        saveas(f1,temp1,'png')                        
                    end
                    
                    TextIn = {'Completed export of particle trajectories plot'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                catch
                    TextIn = {'Unable to generate and export the plot'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                end %try
            end %strmcmp switch
        end % function
        
        function [] = exportVelocity(app)
            
            if strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
                Ze1 = app.refValue;
                labels = {'X [m]', 'Y [m]', 'X component [m/s]', 'Y component [m/s]', 'Velocity magnitude [m/s]'};
            elseif strcmp(app.VelocityDropDown.Value, 'Normal Component') == 1
                Ze1 = app.normalVelocity(:,1);
                labels = {'X [m]', 'Y [m]', 'X component [m/s]', 'Y component [m/s]', 'Normal component [m/s]'};
                %Ze2 = app.tangentialVelocity(:,1);
            end
            outVars = ([app.xyzA_final, app.adjustedVel, Ze1]); % Populate the array
            outVars = round(outVars*100)/100; % Round to two decimal places
            dataOut = [labels;num2cell(outVars)];
            
            if strcmp(app.ExporttrajectoriesSwitch.Value, 'On') == 1
                
                TextIn = {'Initiating the export of velocity outputs'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                TextIn = {'Export started. Please wait.'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                    writetable( cell2table(dataOut), strjoin({app.directory_save_multiple, '\', ...
                        app.file(1:end-4), '_', char(datetime(now,'ConvertFrom','datenum','format', 'yyyyMMddHHmm' )), ...
                        '_VelocityOutputs.csv'},''), ...
                        'writevariablenames', false, 'quotestrings', true)
                    TextIn = strjoin({'Export completed. Saved to ' app.directory_save_multiple},'');
                else
                    writetable( cell2table(dataOut), strjoin({app.directory_save, '\', ...
                        app.file(1:end-4), '_', char(datetime(now,'ConvertFrom','datenum','format', 'yyyyMMddHHmm' )), ...
                        '_VelocityOutputs.csv'},''), ...
                        'writevariablenames', false, 'quotestrings', true);
                end
                
                TextIn = strjoin({'Export completed. Saved to ' app.directory_save},'');
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end %if strcmp
        end % function
        
        function [] = loadState(app)
            TextIn = {'Select the settings to load.'};
            app.ListBox.Items = [app.ListBox.Items, TextIn'];
            printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
            
            if length(app.directory) < 1
                % Create list of images inside the considered directory
                [settingsFileIn, settingsDirIn] = uigetfile('*.mat');
            else
                [settingsFileIn, settingsDirIn] = uigetfile({'*.mat' 'All Files'},'Select a file',app.directory);
            end
            if length(settingsFileIn) > 1
                direc = dir([settingsDirIn,filesep]); filenames={};
                [filenames{1:length(direc),1}] = deal(direc.name);
                filenames = sortrows(filenames); %sort all image files
                amount = length(filenames);
                textOutput = strjoin({settingsDirIn, settingsFileIn}, '');
                
                TextIn = strjoin({'Loading settings from: ' textOutput},'');
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                load(textOutput,'appEx');
                
                if exist('appEx','var')
                    fields = fieldnames(app);
                    for a = 1:length(fields)
                        [i1] =  strcmp(app.flexVarsComp, fields(a));
                        if max(i1) > 0
                            i1_idx = find (i1 == 1);
                            if strcmp(char(app.flexVars(1,i1)), 'UITable.Data') == 1
                                app.UITable = uitable(app.KLTIV_UIFigure);
                                app.UITable.Visible = 'on';
                                app.UITable.ColumnName = {'X [meters]'; 'Y [meters]'; 'Z [meters]'; 'X [px]'; 'Y [px]'};
                                app.UITable.RowName = {};
                                app.UITable.ColumnEditable = [true true true false false];
                                app.UITable.CellSelectionCallback = createCallbackFcn(app, @UITableCellSelection, true);
                                app.UITable.ForegroundColor = [0.149 0.149 0.149];
                                app.UITable.FontName = 'Ubuntu';
                                app.UITable.Position = [335 153 290 219];
                                eval(['app.' char(app.flexVars(1,i1))  '=' char(strjoin({'appEx.', char(app.flexVarsComp(1,i1_idx))},'')) ';'])
                                %CheckTable1 = get(app.UITable,'Data')
                                %set( app.UITable, 'Data', CheckTable1 )
                                pause(0.5)
                            else
                                eval(['app.' char(app.flexVars(1,i1))  '=' char(strjoin({'appEx.', char(app.flexVarsComp(1,i1_idx))},'')) ';'])
                                pause(0.5)
                                try % only certain vars have this
                                    eval(['app.' char(fields(a,1)) '.Visible = "Off";']);
                                    pause(0.5)
                                    eval(['app.' char(fields(a,1)) '.Visible = "On";']);
                                    pause(0.5)
                                catch
                                    pause(0.5)
                                end
                            end
                        end
                    end
                    OrientationDropDownValueChanged(app)
                    VelocityDropDownValueChanged(app)
                    bringInImage(app)
                    %TextIn = strjoin({'Output directory is: ', char(app.directory_save)}, '');
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TextIn = 'Settings succesfully loaded.';
                    app.ListBox.Items = [TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                end
                
            else
                TextIn = {'No settings file selected, please try again'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
        end
        
    end % methods
    
    
    methods (Access = private)
        
        % Code that executes after component creation
        function startupFcn(app)
            %saveState(app)
        end
        
        function CrossSectionDropDownValueChanged(app, ~)
            if strcmp (app.CrossSectionDropDown.Value, 'Referenced survey [m]') == 1
                app.UITable2.Data = [];
                app.xInder = [];
                app.yInder = [];
                [app.surveyFile, app.surveyDirectory] = uigetfile({'*.csv' '.csv Files'},'Select .csv containing cross-section survey data',app.directory);
                if length(app.surveyFile) > 1
                    % Update the display
                    TextIn = {'Loading Cross-section survey data - please wait'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app);
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    [data_text,~] = readtext(strjoin({app.surveyDirectory app.surveyFile },''), ',', '','','textual'); % read in the csv file
                    app.surveyIn = [];
                    app.surveyIn(:,1) = str2double(data_text(2:end,1)); % Extract the X coordinate of the scan
                    app.surveyIn(:,2) = str2double(data_text(2:end,2)); % Extract the Y coordinate of the scan
                    app.surveyIn(:,3) = str2double(data_text(2:end,3)); % Extract the Z coordinate of the scan
                    app.startXS = [ app.surveyIn(1,1),app.surveyIn(1,2) ];
                    app.endXS = [ app.surveyIn(end,1),app.surveyIn(end,2) ];
                    dist = abs(app.startXS - app.endXS); % [x y distances]
                    app.transectLength = sqrt(dist(1,1).^2 + dist(1,2).^2);
                    
                    % Convert from real-world to relative distances
                    out=cell2mat(cellfun(@(x) app.startXS-x ,{app.surveyIn(:,1:2)},'un',0));
                    surveyTemp = [sqrt(out(:,1).^2 + out(:,2).^2),app.surveyIn(:,3)] ;
                    app.UITable2.Data = surveyTemp;
                    
                    % Update the display
                    TextIn = {'Cross-section survey data succesfully loaded'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    TextIn = {['Selected cross-section length is ' num2str(app.transectLength) 'm']; ...
                        ['Please continue']};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                end
                
            elseif strcmp (app.CrossSectionDropDown.Value, 'Relative distances [m]') == 1
                app.UITable2.Data = [];
                app.xInder = [];
                app.yInder = [];
                
                % Update the display
                TextIn = {'Using the mouse first right click on the start location of the cross-section, then the end point of the cross-section'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                % Plot the basemap image
                % Merge the images into one complete image of the reach
                if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                    app.XS_pts = readPoints(app.masterImage, 2, 3, app); hold on;
                    app.startXS = [app.masterImageX(1,round(app.XS_pts(1,1))),app.masterImageY(round(app.XS_pts(2,1)))];
                    app.endXS = [app.masterImageX(1,round(app.XS_pts(1,2))),app.masterImageY(round(app.XS_pts(2,2)))];
                else
                    app.XS_pts = readPoints(app.firstOrthoImage, 2, 3, app); hold on;
                    app.startXS = [app.X(1,round(app.XS_pts(1,1))),app.Y(round(app.XS_pts(2,1)))];
                    app.endXS = [app.X(1,round(app.XS_pts(1,2))),app.Y(round(app.XS_pts(2,2)))];
                end
                
                dist = abs(app.startXS - app.endXS); % [x y distances]
                app.transectLength = sqrt(dist(1,1).^2 + dist(1,2).^2);
                %msgbox(['Transect length is ' num2str(app.transectLength) 'm'],'Value');
                TextIn = {['Selected cross-section length is ' num2str(app.transectLength) 'm']; ...
                    ['Close the Figure window when ready to continue']};
                printItems(app)
                
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                TextIn = {'Loading Cross-section survey data - please wait'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                [app.surveyFile, app.surveyDirectory] = uigetfile({'*.csv' '.csv Files'},'Select .csv containing cross-section survey data',app.directory);
                
                [data_text,~] = readtext(strjoin({app.surveyDirectory app.surveyFile },''), ',', '','','textual'); % read in the csv file
                surveyTemp(:,1) = data_text(2:end,1); % Extract the distance coordinate of the scan
                surveyTemp(:,2) = data_text(2:end,2); % Extract the Z coordinate of the scan
                surveyTemp = str2double(surveyTemp); % Convert to numeric if simple input
                
                in1 = (0:0.01:app.transectLength)'*(dist./app.transectLength);
                out=cell2mat(cellfun(@(x) app.startXS-x ,{in1},'un',0));
                out(:,3) = 0.01:0.01:(length(out)./100)';
                
                intermediateLength = surveyTemp (:,1); %sqrt(surveyIn(:,1).^2 + surveyIn(:,2).^2);
                
                for a = 1:length(intermediateLength)
                    t1(a,1) = findnearest(intermediateLength(a,1),out(:,3));
                end
                app.surveyIn = out(t1,1:2);
                app.UITable2.Data = surveyTemp;
                
            end
            
        end
        
        
        % Value changed function: OrientationDropDown
        function OrientationDropDownValueChanged(app, ~)
            app.OrientationValue = app.OrientationDropDown.Value;
            if strcmp (app.OrientationValue, 'Stationary: Nadir') == 1
                app.s2 = [];
                set(app.RUNButton,'Text','RUN');
                app.GCPfile = [];
                app.GCPData = [];
                app.GCPDataDropDown.Value = 'Make a selection:';
                app.UITable.Data = [0 0 0 0 0]; % just one GCP to set orientation
                app.gcpA = [0 0 0 0 0];
                app.GCPDataDropDown.Enable = 'off';
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'off') % disable the GCP buffer option
                app.CheckGCPsSwitch.Enable = 'off';
                app.UITable.Enable = 'off';
                app.ExportGCPdataSwitch.Enable = 'off';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.CustomFOVEditField_2.Enable = 'on';
                app.CustomFOVEditField_3.Enable = 'on';
                app.CustomFOVEditField_4.Enable = 'on';
                app.CustomFOVEditField_5.Enable = 'on';
                app.yawpitchrollEditField.Value = [0];
                app.yawpitchrollEditField.Enable = 'off';
                app.yawpitchrollEditField_2.Value = [1.57];
                app.yawpitchrollEditField_2.Enable = 'off';
                app.yawpitchrollEditField_3.Value = [0];
                app.yawpitchrollEditField_3.Enable = 'off';
                app.CameraTypeDropDown.Enable = 'on';
                app.CameraxyzEditField.Enable = 'on';
                app.CameraxyzEditField_2.Enable = 'on';
                app.CameraxyzEditField_3.Enable = 'on';
                app.WatersurfaceelevationmEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Visible = 'on';
                app.ProcessingModeDropDown.Enable = 'on';
                app.ResolutionmpxEditField.Enable ='on';
                app.OrthophotosSwitch.Value = 'Off';
                app.OrthophotosSwitch.Enable = 'on';
                app.roiButton.Enable = 'on'; app.boundaryLimitsPx = [];
                
                TextIn = {'No GCPs are used for the optimisation process';...
                    'The assumption is the camera is at nadir'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            elseif strcmp (app.OrientationValue, 'Dynamic: GCPs + Stabilisation') == 1
                
                app.UITable.Data = [0 0 0 0 0]; % just one GCP to set orientation
                app.gcpA = [0 0 0 0 0];
                app.s2 = [];
                app.GCPfile = [];
                app.GCPData = [];
                set(app.RUNButton,'Text','RUN');
                app.GCPDataDropDown.Value = 'Make a selection:';
                app.GCPDataDropDown.Enable = 'on';
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'on') % disable the GCP buffer option
                app.CheckGCPsSwitch.Enable = 'off';
                app.UITable.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.yawpitchrollEditField.Value = [0];
                app.yawpitchrollEditField.Enable = 'on';
                app.yawpitchrollEditField_2.Value = [1.57];
                app.yawpitchrollEditField_2.Enable = 'on';
                app.yawpitchrollEditField_3.Value = [0];
                app.yawpitchrollEditField_3.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.CameraTypeDropDown.Enable = 'on';
                app.CameraxyzEditField.Enable = 'on';
                app.CameraxyzEditField_2.Enable = 'on';
                app.CameraxyzEditField_3.Enable = 'on';
                app.CustomFOVEditField_2.Enable = 'on';
                app.CustomFOVEditField_3.Enable = 'on';
                app.CustomFOVEditField_4.Enable = 'on';
                app.CustomFOVEditField_5.Enable = 'on';
                app.WatersurfaceelevationmEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Visible = 'on';
                app.ProcessingModeDropDown.Enable = 'on';
                app.ResolutionmpxEditField.Enable = 'on';
                app.OrthophotosSwitch.Value = 'Off';
                app.OrthophotosSwitch.Enable = 'on';
                app.roiButton.Enable = 'on'; app.boundaryLimitsPx = [];
                
                TextIn = {'The images are stabilised and then orthorectification is carried out'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            elseif strcmp (app.OrientationValue, 'Dynamic: Stabilisation') == true
                
                app.UITable.Data = [0 0 0 0 0]; % just one GCP to set orientation
                app.s2 = [];
                app.GCPfile = [];
                app.GCPData = [];
                set(app.RUNButton,'Text','RUN');
                app.GCPDataDropDown.Value = 'Make a selection:';
                app.GCPDataDropDown.Enable = 'off';
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'off') % disable the GCP buffer option
                app.CheckGCPsSwitch.Enable = 'off';
                app.UITable.Enable = 'off';
                app.ExportGCPdataSwitch.Enable = 'off';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.yawpitchrollEditField.Value = [0];
                app.yawpitchrollEditField.Enable = 'off';
                app.yawpitchrollEditField_2.Value = [1.57];
                app.yawpitchrollEditField_2.Enable = 'off';
                app.yawpitchrollEditField_3.Value = [0];
                app.yawpitchrollEditField_3.Enable = 'off';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.CameraTypeDropDown.Enable = 'off';
                app.CameraxyzEditField.Enable = 'off';
                app.CameraxyzEditField_2.Enable = 'off';
                app.CameraxyzEditField_3.Enable = 'off';
                app.CustomFOVEditField_2.Enable = 'off';
                app.CustomFOVEditField_3.Enable = 'off';
                app.CustomFOVEditField_4.Enable = 'off';
                app.CustomFOVEditField_5.Enable = 'off';
                app.WatersurfaceelevationmEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Visible = 'on';
                app.ProcessingModeDropDown.Enable = 'on';
                app.ResolutionmpxEditField.Enable ='off';
                app.OrthophotosSwitch.Value = 'Off';
                app.OrthophotosSwitch.Enable = 'on';
                app.roiButton.Enable = 'on'; app.boundaryLimitsPx = [];
                
                app.imageResolution = str2num(cell2mat(inputdlg(['What is the image resolution (m/px)?'],...
                    'Query', [1 60], {num2str(0.01)})));
                app.ResolutionmpxEditField.Value = app.imageResolution;
                TextIn = {'Image resolution succesfully defined'};
                TextIn2 = {['1 px equates to ' num2str(app.imageResolution) ' m' ]};
                app.ListBox.Items = [app.ListBox.Items, TextIn', TextIn2'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                
            elseif strcmp (app.OrientationValue, 'Planet [beta]') == 1
                app.UITable.Data = [0 0 0 0 0]; % just one GCP to set orientation
                app.s2 = [];
                app.GCPfile = [];
                app.GCPData = [];
                set(app.RUNButton,'Text','RUN');
                app.GCPDataDropDown.Value = 'Make a selection:';
                app.GCPDataDropDown.Enable = 'off';
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'off') % disable the GCP buffer option
                app.CheckGCPsSwitch.Enable = 'off';
                app.UITable.Enable = 'off';
                app.ExportGCPdataSwitch.Enable = 'off';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.yawpitchrollEditField.Value = [0];
                app.yawpitchrollEditField.Enable = 'off';
                app.yawpitchrollEditField_2.Value = [1.57];
                app.yawpitchrollEditField_2.Enable = 'off';
                app.yawpitchrollEditField_3.Value = [0];
                app.yawpitchrollEditField_3.Enable = 'off';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.CameraTypeDropDown.Enable = 'off';
                app.CameraxyzEditField.Enable = 'off';
                app.CameraxyzEditField_2.Enable = 'off';
                app.CameraxyzEditField_3.Enable = 'off';
                app.CustomFOVEditField_2.Enable = 'off';
                app.CustomFOVEditField_3.Enable = 'off';
                app.CustomFOVEditField_4.Enable = 'off';
                app.CustomFOVEditField_5.Enable = 'off';
                app.WatersurfaceelevationmEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Visible = 'on';
                app.ProcessingModeDropDown.Enable = 'on';
                app.ResolutionmpxEditField.Enable ='off';
                app.OrthophotosSwitch.Value = 'Off';
                app.OrthophotosSwitch.Enable = 'on';
                
                app.imageResolution = str2num(cell2mat(inputdlg(['What is the image resolution (m/px)?'],...
                    'Query', [1 60], {num2str(0.01)})));
                app.ResolutionmpxEditField.Value = app.imageResolution;
                TextIn = {'Image resolution succesfully defined'};
                TextIn2 = {['1 px equates to ' num2str(app.imageResolution) ' m' ]};
                app.ListBox.Items = [app.ListBox.Items, TextIn', TextIn2'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                
            elseif strcmp (app.OrientationValue, 'Stationary: GCPs') == 1
                % Ensure that all of the required fields are enabled
                app.s2 = [];
                app.GCPfile = [];
                app.GCPData = [];
                set(app.RUNButton,'Text','RUN');
                app.GCPDataDropDown.Value = 'Make a selection:';
                app.CameraxyzEditField.Enable = 'on';
                app.CameraxyzEditField_2.Enable = 'on';
                app.CameraxyzEditField_3.Enable = 'on';
                app.yawpitchrollEditField.Enable = 'on';
                app.yawpitchrollEditField_2.Enable = 'on';
                app.yawpitchrollEditField_3.Enable = 'on';
                app.GCPDataDropDown.Enable = 'on';
                app.BufferaroundGCPsmetersEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Visible = 'on';
                app.UITable.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.UITable.Data = [0 0 0 0 0]; % just one GCP to set orientation
                app.CheckGCPsSwitch.Enable = 'off';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.CustomFOVEditField_2.Enable = 'on';
                app.CustomFOVEditField_3.Enable = 'on';
                app.CustomFOVEditField_4.Enable = 'on';
                app.CustomFOVEditField_5.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'on';
                app.CameraTypeDropDown.Enable = 'on';
                app.ProcessingModeDropDown.Enable = 'on';
                app.ResolutionmpxEditField.Enable ='on';
                %app.VelocityDropDown.Value = 'Make a selection:';
                app.VelocityDropDown.Enable = 'on';
                app.IgnoreEdgesDropDown.Value = 'No';
                app.IgnoreEdgesDropDown.Enable = 'on';
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                    app.roiButton.Enable = 'off';
                else
                    app.roiButton.Enable = 'on';
                end
                app.boundaryLimitsPx = [];
                app.FlightPathPlotSwitch.Value = 'Off';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.OrthophotosSwitch.Value = 'Off';
                app.OrthophotosSwitch.Enable = 'on';
                
                TextIn = {'GCPs are used for optimisation of the camera model'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            elseif strcmp (app.OrientationValue, 'Dynamic: GCPs') == 1
                % Ensure that all of the required fields are enabled/diabled
                app.s2 = [];
                app.GCPfile = [];
                app.GCPData = [];
                set(app.RUNButton,'Text','RUN');
                app.GCPDataDropDown.Value = 'Make a selection:';
                app.CameraxyzEditField.Enable = 'on';
                app.CameraxyzEditField_2.Enable = 'on';
                app.CameraxyzEditField_3.Enable = 'on';
                app.yawpitchrollEditField.Enable = 'on';
                app.yawpitchrollEditField_2.Enable = 'on';
                app.yawpitchrollEditField_3.Enable = 'on';
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'on') % disable to buffer field
                app.GCPDataDropDown.Enable = 'on';
                app.BufferaroundGCPsmetersEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Visible = 'on';
                app.UITable.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.UITable.Data = [0 0 0 0 0]; % just one GCP to set orientation
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'on') % disable the GCP buffer option
                app.CheckGCPsSwitch.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'on';
                app.CameraTypeDropDown.Enable = 'on';
                app.CustomFOVEditField_2.Enable = 'on';
                app.CustomFOVEditField_3.Enable = 'on';
                app.CustomFOVEditField_4.Enable = 'on';
                app.CustomFOVEditField_5.Enable = 'on';
                app.ProcessingModeDropDown.Enable = 'on';
                app.ResolutionmpxEditField.Enable ='on';
                app.roiButton.Enable = 'on'; app.boundaryLimitsPx = [];
                app.OrthophotosSwitch.Value = 'Off';
                app.OrthophotosSwitch.Enable = 'on';
                
                TextIn = {'GCPs are used for optimisation of the camera model';...
                    'Locations of the GCPs will be updated automatically'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            elseif strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == 1
                % Disable the required fields
                app.s2 = [];
                app.GCPfile = [];
                app.GCPData = [];
                set(app.RUNButton,'Text','RUN');
                app.GCPDataDropDown.Value = 'Make a selection:';
                app.CameraxyzEditField.Enable = 'off';
                app.CameraxyzEditField_2.Enable = 'off';
                app.CameraxyzEditField_3.Enable = 'off';
                app.yawpitchrollEditField.Enable = 'off';
                app.yawpitchrollEditField_2.Enable = 'off';
                app.yawpitchrollEditField_3.Enable = 'off';
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'off') % disable to buffer field
                app.UITable.Data = [0 0 0 0 0]; % just one GCP to set orientation
                app.GCPDataDropDown.Enable = 'off';
                app.BufferaroundGCPsmetersEditField.Enable = 'off';
                app.WatersurfaceelevationmEditField.Enable = 'off';
                app.WatersurfaceelevationmEditField.Visible = 'on';
                app.CheckGCPsSwitch.Enable = 'off';
                app.UITable.Enable = 'off';
                app.ExportGCPdataSwitch.Enable = 'off';
                app.FlightPathPlotSwitch.Enable = 'on';
                app.CameraTypeDropDown.Enable = 'on';
                app.CustomFOVEditField_2.Enable = 'off';
                app.CustomFOVEditField_3.Enable = 'off';
                app.CustomFOVEditField_4.Enable = 'off';
                app.CustomFOVEditField_5.Enable = 'off';
                app.ProcessingModeDropDown.Enable = 'on';
                app.ResolutionmpxEditField.Enable ='on';
                app.VelocityDropDown.Value = 'Velocity Magnitude';
                app.VelocityDropDown.Enable = 'off';
                app.IgnoreEdgesDropDown.Value = 'No';
                app.IgnoreEdgesDropDown.Enable = 'off';
                app.roiButton.Enable = 'off'; app.boundaryLimitsPx = [];
                app.FlightPathPlotSwitch.Value = 'Off';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.OrthophotosSwitch.Value = 'On';
                app.OrthophotosSwitch.Enable = 'off';
                
                % Reset the processing complete button
                set(app.RUNButton,'Text','Processing UAS and GPS data');
                pause(0.01)
                
                % Update the display
                TextIn = {'Optimising the camera model'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                TextIn2 = {'Select .pos containing UAS GPS data'};
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn', TextIn2'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                [app.UAS_GPSfile, app.UAS_GPSdirectory] = uigetfile({'*.pos' '.pos Files'},'Select .pos containing UAS GPS data',app.directory);
                if length(app.UAS_GPSfile) > 1
                    % Update the display
                    TextIn = {'Loading GPS data - please wait'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    [data_text,~] = readtext(strjoin({app.UAS_GPSdirectory app.UAS_GPSfile },''), ' ', '','','textual'); % read in the csv file
                    GPST = join([data_text(11:end,1) data_text(11:end,2)]);
                    GPST_numeric = datenum(GPST,'yyyy/mm/dd HH:MM:SS.FFF');
                    latIn = data_text(11:end,5);
                    longIn = data_text(11:end,8);
                    uas_hgt = str2num(cell2mat(data_text(11:end,11)));
                    UTMzone = utmzone(str2num(cell2mat(latIn(1))),str2num(cell2mat(longIn(1))));
                    utmstruct = defaultm('utm');
                    utmstruct.zone = UTMzone;
                    utmstruct.geoid = wgs84Ellipsoid;
                    utmstruct = defaultm(utmstruct);
                    [uas_x,uas_y] = mfwdtran(utmstruct,str2num(cell2mat(latIn)),str2num(cell2mat(longIn)));
                    
                    % Update the display
                    TextIn = {'GPS data converted from WGS84 to UTM'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    TextIn2 = {['Data acquired in UTM zone ' UTMzone]};
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn', TextIn2'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % Update the display
                    TextIn = {'Interpolating the GPS data to 0.01s sample intervals'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % linearlly interpolate the GPS data from 14Hz to 100Hz
                    constant1 = 1.1574e-05/100; % one hundredth of a second i.e (0.01s)
                    uas_x_interp = interp1(GPST_numeric,uas_x,min(GPST_numeric):constant1:max(GPST_numeric));
                    uas_y_interp = interp1(GPST_numeric,uas_y,min(GPST_numeric):constant1:max(GPST_numeric));
                    uas_hgt_interp = interp1(GPST_numeric,uas_hgt,min(GPST_numeric):constant1:max(GPST_numeric));
                    
                    % Show completion message
                    TextIn = {'Process Completed'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % Update the display
                    TextIn = {'What time did the video start in GPS time (yyyy/mm/dd HH:MM:SS.FFF)'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % Find out the time that the video started
                    startingTime = cell2mat(inputdlg(['What time did the video start in GPS time (yyyy/mm/dd HH:MM:SS.FFF)'],...
                        'Starting time', [1 60], {datestr(GPST_numeric(1),'yyyy/mm/dd HH:MM:SS.FFF')}));
                    startingTimeNum = datenum(startingTime,'yyyy/mm/dd HH:MM:SS.FFF');
                    
                    obj = VideoReader(strjoin ({app.directory, app.file},''));
                    app.videoDuration = obj.Duration; % Extract the length of the video
                    frameRateIn = obj.FrameRate; % Extract the frame rate of the video
                    clear obj
                    
                    % Show completion message
                    TextIn = {'Process Completed'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % Update the display
                    TextIn = {'Specify the water surface elevation from GPS data (m)'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % Find out the starting elevation of the UAS (i.e. water surface elevation)
                    startingElevation = cell2mat(inputdlg(['Enter the water surface elevation from GPS (m)'],...
                        'Water surface elevation', [1 60], {'30'}));
                    startingElevation = str2num(startingElevation);
                    app.WatersurfaceelevationmEditField.Value = startingElevation;
                    
                    % Show completion message
                    TextIn = {'Process Completed'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % Update the display
                    TextIn = {'Mapping the video frames to the GPS data'};
                    TextIn2 = {'Please wait'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn', TextIn2'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    % Calculate the time that each of the frames were collected
                    for a = 1:(app.videoDuration*frameRateIn)
                        if a == 1
                            secPerFrame = 1/frameRateIn;
                            [Y,M,D,H,MN,S_ori] = datevec(startingTimeNum);
                            S = floor(S_ori);
                            MS = S_ori - S;
                            dt(a) = datetime(Y,M,D,H,MN,S,MS,'Format', 'yyyy-MM-dd HH:mm:ss.SSS');
                            dt(a) = dt(a) + milliseconds(MS*1000);
                        else
                            dt(a) = dt(a-1) + seconds(secPerFrame); % add the secs per frame constant
                        end
                    end
                    DN = datenum(dt);
                    
                    % Find the values closest to the interpolated times
                    for a = 1:length(DN)
                        [~,c] = findnearest(DN(a), min(GPST_numeric):constant1:max(GPST_numeric));
                        idx1(a) = c(1);
                    end
                    
                    % Interpolate the GPS data
                    app.frame_uas_x = uas_x_interp(idx1);
                    app.frame_uas_y = uas_y_interp(idx1);
                    app.frame_uas_z = uas_hgt_interp(idx1) - startingElevation;
                    
                    % Would you like to start from the begining of the video?
                    answer = str2num(cell2mat(inputdlg(['How many seconds from the start of the video should be ignored?'],...
                        'Query', [1 60], {num2str(0)})));
                    app.s2_mod = answer;
                    startFrame = round((frameRateIn.*answer)+1);
                    app.frame_uas_x = app.frame_uas_x(:,startFrame:end);
                    app.frame_uas_y = app.frame_uas_y(:,startFrame:end);
                    app.frame_uas_z = app.frame_uas_z(:,startFrame:end);
                    
                    % Show completion message
                    TextIn = {'Process Completed'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                else
                    app.OrientationDropDown.Value = 'Make a selection:';
                    TextIn = {'No .pos file loaded, try again or choose an alternative method'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                end
                
                % Update the display
                TextIn = {'Select .csv containing UAS onboard IMU data'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                % Load the onboard nav data
                [app.UAS_onboardfile, app.UAS_onboarddirectory] = uigetfile({'*.csv' '.csv Files'},'Select .csv containing UAS onboard flight navation data',app.directory);
                if length(app.UAS_onboardfile) > 1
                    % Update the display
                    TextIn = {'Loading UAS onboard navigation data - Please wait'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                    [data_text2,~] = readtext(strjoin({app.UAS_onboarddirectory app.UAS_onboardfile },''), ',', '','','textual'); % read in the csv file
                    
                    % find the indexes of the key navigation components
                    %[i1 j1] = find(strcmp('datetime(utc)', data_text2) == 1);% AirData UAV
                    %dateIn = data_text2(i1+1:end,j1);% AirData UAV
                    %uas_dateTime = datenum(dateIn,'dd/mm/yyyy HH:MM:SS'); % AirData UAV
                    
                    [i1 j1] = find(strcmp('GPS(0):Date', data_text2) == 1);% Raw data
                    dateIn = data_text2(i1+1:end,j1);% Raw data
                    [i2 j2] = find(strcmp('GPS(0):Time', data_text2) == 1); % Raw data
                    timeIn = data_text2(i2+1:end,j2); % Raw data
                    uas_dateTime = datenum(strcat(dateIn,timeIn),'yyyymmddHHMMSS'); % Raw data
                    
                    [k1 k2] = unique(uas_dateTime);
                    te1 = round(length(k2)./2);
                    uas_dateTime2 = zeros(length(uas_dateTime),1);
                    
                    
                    for a = 1:length(k2)-1
                        sampleRateHz = k2(a+1) - k2(a);
                        dt1 = k1(te1) - k1(te1-1);
                        dt2 = (1/sampleRateHz);
                        dt = dt1*dt2;
                        %datenumfracsec = (k1(te1) - k1(te1-1))./(sampleRateHz-1);
                        for b = 1:sampleRateHz%-1
                            if b == 1
                                uas_dateTime2(k2(a)) = uas_dateTime(k2(a)) + 0;
                                t1(k2(a)+b-1,1) = findnearest(GPST_numeric,uas_dateTime2((k2(a)+b-1)));
                                t1(k2(a)+b-1,1) = findnearest(GPST_numeric,uas_dateTime2((k2(a)+b-1)));
                            else
                                doIt = (k2(a)+b-1) < length(uas_dateTime);
                                if doIt == 1
                                    uas_dateTime2(k2(a)+b-1,1) = uas_dateTime2(k2(a)+b-2,1) + (dt);
                                    t1(k2(a)+b-1,1) = findnearest(uas_dateTime2((k2(a)+b-1)),GPST_numeric); % [time, array]
                                end
                            end
                        end
                    end
                    
                    utcOffset = ( k1(te1) - k1(te1-1)) .*18;
                    uas_dateTime2 = uas_dateTime2 + utcOffset; % add 18-secs to UAS time to convert to GPS time
                    
                    [i3 j3] = find(strcmp('IMU_ATTI(0):roll', data_text2) == 1); % Raw data
                    %[i3 j3] = find(strcmp('roll(degrees)', data_text2) == 1); % AirData UAV
                    rollRaw = str2double(data_text2(i3+1:end,j3));
                    [i4 j4] = find(strcmp('IMU_ATTI(0):pitch', data_text2) == 1); % Raw data
                    %[i4 j4] = find(strcmp('pitch(degrees)', data_text2) == 1); % AirData UAV
                    pitchRaw = str2double(data_text2(i4+1:end,j4));
                    [i5 j5] = find(strcmp('IMU_ATTI(0):yaw', data_text2) == 1); % Raw data
                    %[i5 j5] = find(strcmp('IMU_heading(degrees)', data_text2) == 1); % AirData UAV
                    % options:
                    %(1) 'IMU_ATTI(0):yaw'; (2) IMU_ATTI(0):yaw360; (3) IMU_ATTI(0):magYaw; (4) Mag(0):magYaw; (5) Mag(1):magYaw
                    yawRaw = str2double(data_text2(i5+1:end,j5));
                    [i6 j6] = find(strcmp('GPS(0):heightMSL', data_text2) == 1);
                    uasGPS = str2double(data_text2(i6+1:end,j6));
                    
                    clear idx1
                    for a = 1:length(DN)
                        [cc,~] = findnearest(DN(a),uas_dateTime2);
                        idx1(a) = cc(1);
                    end
                    
                    % Setup the yaw data -- this section is fine
                    inT = yawRaw(idx1);
                    inTidx = find(inT < 0);
                    inT(inTidx) = 360-abs(inT(inTidx));
                    inT = 360 - inT;
                    inT = inT + 90; % adjust for 0 being East
                    inT = smooth(inT,5); % smooth the data over every 5 points
                    app.frameYprMatch = [];
                    app.frameYprMatch(:,1) = deg2rad(inT);
                    %plot(inT); hold on;
                    clear inT inTidx
                    
                    % Setup the pitch data - normally no adjustment is
                    % required when a gimball is being used
                    inT = pitchRaw(idx1);
                    %inT = (0-inT) + 90; % this is incorrect (v2)
                    %inT = (inT) + 90; % this is correct -- current config (v1)
                    inT(1:length(inT)) = 90; % v3 -- no adjustment for pitch
                    app.frameYprMatch(:,2) = deg2rad(inT);
                    clear inT inTidx
                    
                    % Setup the roll data - normally no adjustment is
                    % required when a gimball is being used
                    inT = rollRaw(idx1); % v1
                    %inT = (0-inT); %v2
                    inT(1:length(inT)) = 0; % v3 -- no adjustment for roll
                    app.frameYprMatch(:,3) = deg2rad(inT);
                    clear inT
                    
                    %Display the completion message
                    TextIn = {'UAS flight navigation data processed'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    
                else
                    app.OrientationDropDown.Value = 'Make a selection:';
                    TextIn = {'No .csv file loaded, try again or choose an alternative method'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                end
                
            else
                app.GCPDataDropDown.Visible = 'on';
                TextIn = {'The camera orientation will be optimised using the GCPs'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
            
        end
        
        % Cell selection callback: UITable
        function UITableCellSelection(app, event)
            if strcmp ( app.OrientationDropDown.Value, 'Stationary: GCPs') == 1
                
                % Ensure that all of the required fields are enabled
                app.CameraxyzEditField.Enable = 'on';
                app.CameraxyzEditField_2.Enable = 'on';
                app.CameraxyzEditField_3.Enable = 'on';
                app.yawpitchrollEditField.Enable = 'on';
                app.yawpitchrollEditField_2.Enable = 'on';
                app.yawpitchrollEditField_3.Enable = 'off';
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'on') % disable to buffer field
                app.GCPDataDropDown.Enable = 'on';
                app.BufferaroundGCPsmetersEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Visible = 'on';
                app.UITable.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.UITable.Data = [0 0 0 0 0]; % just one GCP to set orientation
                set(app.BufferaroundGCPsmetersEditField, 'Enable', 'on') % disable the GCP buffer option
                app.CheckGCPsSwitch.Enable = 'off';
                app.UITable.Enable = 'off';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.ResolutionmpxEditField.Enable ='on';
                
                % Create a new figure of first image
                myfig = figure('units','normalized','outerposition',[0 0 1 1]);
                hold on;
                myax = axes;
                A = imshow(app.firstFrame);
                objectRegion = [1, 1, app.imgsz(2), app.imgsz(1)]; %[TopLeftX,TopLeftY,LengthX,LengthY]
                
                % Initialize data cursor object & import data to table
                cursorobj = datacursormode(h.myfig);
                waitfor(gcf,'CurrentCharacter',char(32));
                mypoints = getCursorInfo(cursorobj);
                
                %compute Euclidean distances:
                %distances = sqrt(sum(bsxfun(@minus, PotentialGCPs, double(mypoints.Position)).^2,2));
                %find the smallest distance and use that as an index into B:
                %closest = PotentialGCPs(find(distances==min(distances)),:);
                %inder1 = min(find(app.UITable.Data(:,1) == 0));
                
                % Commented out the above so that the absolute px values
                % are used rather than the nearest to a feature. This is
                % only needed when tracking, and nota stable frame
                app.UITable.Data(inder1,4:5) = double(mypoints.Position); % use the closest GCP
                
                % Manually input the corresponding real-world coordinates
                answer = inputdlg('Enter corresponding real world coordinates [X,Y,Z] e.g. 100,100,200',...
                    'GCP Definition', [1 50]);
                newGCPs = str2double(split(answer,','));
                app.UITable.Data(inder1,1:3) = newGCPs;
                try
                    close(myfig)
                catch
                end
            end
            
        end
        
        % Value changed function: GCPDataDropDown
        function GCPDataDropDownValueChanged(app, event)
            app.GCPData = app.GCPDataDropDown.Value;
            
            checkGcpCsvData(app)
            
            if strcmp (app.GCPData, 'Inputted manually') == 1
                app.CheckGCPsSwitch.Enable = 'on';
                app.UITable.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.UITable.Data = [];
                
                app.UITable.Data = [0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0;...
                    0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0;...
                    0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0;...
                    0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0]; % Maximum of 20 GCPs
                
                % Enable the definition of individual GCP points from the image
            elseif strcmp (app.GCPData, 'Select from image') == 1
                
                app.UITable.Data = [];
                app.CheckGCPsSwitch.Enable = 'on';
                app.UITable.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                
                TextIn = {'Select the GCPs in the image by right clicking on them.';...
                    'Then enter their [x y z] locations'; ...
                    'Once all have been selected click Enter on the keyboard and close the window to continue'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                app.imageGCPs = []; app.GCPimageReal = [];
                [app.imageGCPs, app.GCPimageReal] = readPoints(app.firstFrame,100,0); hold on;
                [~, t1] = size(app.imageGCPs);
                [~ ,t2] = size(app.GCPimageReal);
                if ~isequal(t1,t2)
                    in1 = [0; 0; 0];
                    temp = [app.GCPimageReal];
                    joined = [in1, temp];
                    app.GCPimageReal = joined;
                end
                
                app.UITable = uitable(app.KLTIV_UIFigure);
                app.UITable.Visible = 'On';
                app.UITable.ColumnName = {'X [meters]'; 'Y [meters]'; 'Z [meters]'; 'X [px]'; 'Y [px]'};
                app.UITable.RowName = {};
                app.UITable.ColumnEditable = [true true true false false];
                app.UITable.CellSelectionCallback = createCallbackFcn(app, @UITableCellSelection, true);
                app.UITable.ForegroundColor = [0.149 0.149 0.149];
                app.UITable.FontName = 'Ubuntu';
                app.UITable.Position = [335 153 290 219];
                app.UITable.Data = [ app.GCPimageReal; app.imageGCPs]';
                app.gcpA = app.UITable.Data ;
                pause(0.5)
                try
                    close(f1)
                catch
                end
            end
        end
        
        % Button pushed function: RUNButton
        function RUNButtonPushed(app, event) 
            if isempty(app.reloaded) % only run if the settings haven't been reloaded
                app.GCPDataDropDown.Value =  'Make a selection:';
                app.subSample = [];
                app.videoNumber = [];
                app.s2 = [];
                app.directory_save_multiple = [];
                app.QfileOut = [];
                app.startingVideo = [1];
                set(app.RUNButton,'Text',{['Processing, please wait.']});
                app.starterInd = 1;

                customFOV(app)
            end
            
            for a = 1:length(app.fileNameAnalysis)
                
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true && isnan(app.totalQ(a)) % ensure no q data
                    
                    % Purge the listbox
                    if length(find(~cellfun(@isempty,app.ListBox.Items))) == 1000
                        for x=1:1000 % create an empty listbox again
                            app.ListBox.Items(x) = {['']};
                        end
                    end
                    
                    try
                        if app.videoNumber > 1
                            customFOV(app)
                        end
                        imageAnalysis(app)
                        flightPath(app)
                        trajectoryAdjustments(app)
                        exportVelocity(app)
                        trajectories(app)
                        CALCULATEButtonPushed(app)
                        appendQoutputs(app)
                        set(app.RUNButton,'Text',strjoin({'Processing: ' int2str((app.videoNumber-1)/length(app.fileNameAnalysis)*100) '% Complete'},''));
                        TextIn = {['Discharge computed for video ', int2str(app.videoNumber), ' of ', num2str(length(app.fileNameAnalysis))]};
                        app.ListBox.Items = [app.ListBox.Items, TextIn'];
                        printItems(app)
                        pause(0.01);
                        app.ListBox.scroll('bottom')
                        
                        if app.starterInd == 1
                            startingAppVals = app; % create a copy of the settings
                            startingAppVals.uvHR = [];
                            startingAppVals.visHR = [];
                            startingAppVals.xyzA_final = [];
                            startingAppVals.xyzB_final = [];
                            startingAppVals.vel = [];
                            startingAppVals.refValue = [];
                            startingAppVals.objectFrameStacked = {};
                            startingAppVals.normalVelocity = [];
                            app.starterInd = app.starterInd + 1;
                        else
                            app.starterInd = app.starterInd + 1;
                        end
                        
                    catch
                        TextIn = {['Unable to process video ', char(app.fileNameAnalysis(app.videoNumber)) ' . Skipping this file.']};
                        app.ListBox.Items = [app.ListBox.Items, TextIn'];
                        printItems(app)
                        pause(0.01);
                        app.ListBox.scroll('bottom')
                    end
                    app.videoNumber = app.videoNumber + 1;
                    app.startingVideo = [0];
                    %resetApp(app,startingAppVals);
                    %flushBase(app)
                    %clear functions
                else 
                    app.videoNumber = app.videoNumber + 1;
                end
            end
            
            set(app.RUNButton,'Text','Processing: Complete');
            pause(0.01)
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == true
                imageAnalysis(app)
                flightPath(app)
                trajectoryAdjustments(app)
                exportVelocity(app)
                trajectories(app)
                set(app.RUNButton,'Text','Processing: Complete');
                pause(0.01)
            end
        end
        
        
        % If the ROI button is pushed
        function roiButtonPushed(app, event)
            if length(app.firstFrame) > 1
                [roiPoints] = readPoints(app.firstFrame,100,4,app,[])'; hold on;
                roiPoints = replace_num(roiPoints,0,NaN);
                useVals = ~isnan(roiPoints(:,1));
                app.boundaryLimitsPx = polyshape(roiPoints(useVals,1),roiPoints(useVals,2));
                plot(app.boundaryLimitsPx);
                title ('Close the window and continue');
                app.boundaryLimitsPx = app.boundaryLimitsPx.Vertices;
            else
                %Display an error - need to load video
            end
        end
        
        % Button pushed function: OutputDirectoryButton
        function OutputDirectoryButtonPushed(app, event)
            app.s2 = [];
            set(app.RUNButton,'Text','RUN');
            if length(app.directory) < 1
                % Create list of images inside the considered directory
                app.directory_save = uigetdir;
            else
                [app.directory_save] = uigetdir(app.directory);
            end
            
            if length(app.directory_save) > 1
                app.OutputDirectoryButton.Text = app.directory_save;
                app.OutputDirectoryButton.VerticalAlignment = 'top';
                
                TextIn = strjoin({'Output directory is: ' app.directory_save}, '');
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            else
                TextIn = {'No video selected, please try again'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                app.OutputDirectoryButton.Text = 'Click here';
            end
        end
        
        % Button pushed function: AddVideoButton
        function AddVideoButtonPushed(app, event)
            
            %app.VelocityDropDown.Value = 'Make a selection:';
            app.k1 =  [];
            app.s2 = [];
            set(app.RUNButton,'Text','RUN');
            app.GCPfile = [];
            app.GCPData = [];
            app.masterImage = [];
            app.firstOrthoImage = [];
            app.GCPDataDropDown.Value = 'Make a selection:';
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == true
                if length(app.directory) < 2
                    % Create list of images inside the considered directory
                    [app.file, app.directory] = uigetfile('*');
                else
                    [app.file, app.directory] = uigetfile({'*' 'All Files'},'Select a file',app.directory);
                end
                
                if length(app.file) > 1
                    textOutput = strjoin({app.directory, app.file}, '');
                    TextIn = {'Single video file selected is:'; textOutput; ...
                        'Please wait while it is loaded.'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = textOutput;
                    app.AddVideoButton.VerticalAlignment = 'top';
                    
                    direc = dir([app.directory,filesep]); filenames={};
                    [filenames{1:length(direc),1}] = deal(direc.name);
                    filenames = sortrows(filenames); %sort all image files
                    amount = length(filenames);
                    
                    TextIn = {'Video file succesfully selected.'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = textOutput;
                    app.AddVideoButton.VerticalAlignment = 'top';
                    
                else
                    TextIn = {'No video selected, please try again'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = 'Click here';
                end
                
            elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                if length(app.directory) < 1
                    % Create list of images inside the considered directory
                    %[app.file, app.directory] = uigetfile('*', 'MultiSelect', 'on' );
                    app.directory = uigetdir;
                else
                    app.directory = uigetdir;
                    %[app.directory] = uigetfile({'*' 'All Files'},'Select a file',app.directory, 'MultiSelect', 'on');
                end
                
                if length(app.directory) > 1
                    
                    % Provide alternative templates for the year format +
                    % find the index of this from the user input xxxxxxyyyymmdd_HHMM
                    template = inputdlg('Provide the template of the filename inputs e.g. xxxxxxxxyyyymmdd_HHMM',...
                        'Provide the filename template', [1 60]);
                    if length(cell2mat(strfind(template,'y'))) == 4
                        yearsFormat = 'yyyy';
                        yearInIdx = cell2mat(strfind(template,'y'));
                    elseif length(cell2mat(strfind(template,'y'))) == 2
                        yearsFormat = 'yy';
                        yearInIdx = cell2mat(strfind(template,'y'));
                        preYear = '20';
                    end
                    monthInIdx = cell2mat(strfind(template,'m'));
                    dateInIdx = cell2mat(strfind(template,'d'));
                    hourInIdx = cell2mat(strfind(template,'H'));
                    minuteInIdx = cell2mat(strfind(template,'M'));
                    direc = dir([app.directory,filesep]); app.videoDirFileNames={};
                    [app.videoDirFileNames{1:length(direc),1}] = deal(direc.name);
                    app.videoDirFileNames = sortrows(app.videoDirFileNames); %sort all image files
                    app.videoDirFileNames = app.videoDirFileNames(3:end);
                    for a = 1:length(app.videoDirFileNames)
                        try
                            temp = app.videoDirFileNames{a};
                            if length(cell2mat(strfind(template,'y'))) == 4
                                yearIn = temp(yearInIdx(1):yearInIdx(1)+3);
                            elseif length(cell2mat(strfind(template,'y'))) == 2
                                yearIn = {preYear, temp(yearInIdx(1):yearInIdx(1)+1)};
                            end
                            monthIn = temp(monthInIdx:monthInIdx+1);
                            dateIn = temp(dateInIdx:dateInIdx+1);
                            hourIn = temp(hourInIdx:hourInIdx+1);
                            minuteIn = temp(minuteInIdx:minuteInIdx+1);
                            app.videoDatesFormatted{a,1} = [yearIn monthIn dateIn '_' hourIn minuteIn];
                            if isempty(str2num([yearIn monthIn dateIn])) % esnure it can be converted to a number
                                app.videoDatesFormattedNum(a,1) = 0;
                            else
                                app.videoDatesFormattedNum(a,1) = datenum([yearIn monthIn dateIn hourIn minuteIn], 'yyyymmddHHMM');
                            end
                        catch
                            % Skipping this particular file
                        end
                    end
                    % Simplify the arrays so that only properly formatted
                    % files are used
                    idxKeep = app.videoDatesFormattedNum > 0;
                    app.videoDatesFormattedNum = app.videoDatesFormattedNum(idxKeep);
                    app.videoDirFileNames = app.videoDirFileNames(idxKeep);
                    
                    TextIn = strjoin({num2str(length(app.videoDirFileNames)) ' videos selected for analysis'},'');
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = 'Multiple selected';
                    app.AddVideoButton.VerticalAlignment = 'top';
                else
                    TextIn = {'No directory selected, please try again'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = 'Click here';
                end
                
            end
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == 1
                bringInImage(app); % Bring in the first image of the video
            else
                
                bringInImage(app)
                TextIn = {'Select the video to be used to generate/visualize GCP solutions'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                [app.file,tempDir] = uigetfile({'*' 'All Files'},'Select the video to be used to generate/visualize GCP solutions',app.directory, 'MultiSelect', 'off');
                V=VideoReader([tempDir '\' app.file]);
                I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                app.firstFrame = I;
                app.imgsz = [V.Height V.Width];
                
                TextIn = {'Video successfully loaded'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
        end
        
        
        function bringInImage(app) % Extract the first image from the video
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == 1
                answer = questdlg('Would you like to re-encode the video(s)? (Default: No)', ...
                    'Re-encode Video?', ...
                    {'Yes','No'});
                
                switch answer
                    case 'Yes'
                        ffmpeg_conversion(app)
                        
                    case 'No'
                        % Load in the original file
                            try
                                textOutput = strjoin({app.directory, app.file}, '');
                                V=VideoReader(textOutput);
                                I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                                app.firstFrame = I;
                                app.imgsz = [V.Height V.Width];
                                TextIn = {'Original video succesfully loaded, please continue'};
                                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                                printItems(app)
                                pause(0.01);
                                app.ListBox.scroll('bottom');
                            catch
                                TextIn = {'No video selected. The program will terminate. Check inputs and retry'}; % Update the display
                                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                                TimeIn = strjoin(TimeIn, ' ');
                                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                                printItems(app)
                                pause(0.01);
                                app.ListBox.scroll('bottom');
                                error('Breaking out of function');
                            end
                        
                    case 'Cancel'
                            try
                                % Load in the original file
                                textOutput = strjoin({app.directory, app.file}, '');
                                V=VideoReader(textOutput);
                                I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                                app.firstFrame = I;
                                app.imgsz = [V.Height V.Width];
                                TextIn = {'Original video succesfully loaded, please continue'};
                                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                                printItems(app)
                                pause(0.01);
                                app.ListBox.scroll('bottom');
                            catch
                                TextIn = {'No video selected. The program will terminate. Check inputs and retry'}; % Update the display
                                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                                TimeIn = strjoin(TimeIn, ' ');
                                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                                printItems(app)
                                pause(0.01);
                                app.ListBox.scroll('bottom');
                                error('Breaking out of function');
                            end
                end
            end
        end
        
        
        % Callback function
        function PlatformTypeDropDownValueChanged(app, event)
            value = app.PlatformTypeDropDown.Value;
            app.Platformvalue = app.PlatformTypeDropDown.Value;
            if strcmp (app.Platformvalue, 'UAS') == 1
                TextIn = {'The platform has been defined as UAS.'; 'If GCPs are present they will be tracked between frames'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            elseif strcmp(app.Platformvalue, 'Fixed installation') == 1
                TextIn = {'A fixed (non mobile) camera has been selected.'; 'GCPs are assumed to be static through the video.'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
        end
        
        % Value changed function: VelocityDropDown
        function VelocityDropDownValueChanged(app, event)
            if strcmp (app.VelocityDropDown.Value, 'Normal Component') == 1
                TextIn = {'Normal component selected:'; 'The streamwise velocity will be computed'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                % Define the normal flow direction
                app.pts = readPoints(app.firstFrame,2,1); hold on;
                disp(app.pts)
                try
                    close(f1)
                catch
                end
                
                % insert error catches for the following:
                % No suitable video
                % No start and stop trajectories defined
                
                xIn = app.pts(1,:)';
                yIn = app.pts(2,:)';
                %xIn(1:2,2) = 1;
                %b = xIn\yIn;
                %rangeIn = [0, length(app.firstFrame)];
                %extrap =  b(1).* rangeIn+b(2) ;
                %app.start1 = [rangeIn(1) extrap(1)];
                %app.end1 = [rangeIn(2) extrap(2)];
                app.start1 = [xIn(1), yIn(1)];
                app.end1 = [xIn(2), yIn(2)];
                
                
            elseif strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
                TextIn = {'Velocity magnitude selected:'; 'The velocity of flow will be calculated independent of direction'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
        end
        
        
        % Cell edit callback: UITable2
        function editCel2(app,event)
            
            if strcmp (app.CrossSectionDropDown.Value, 'Relative distances [m]') == 1
                
                if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                    app.startXS = [app.masterImageX(1,round(app.XS_pts(1,1))),app.masterImageY(round(app.XS_pts(2,1)))];
                    app.endXS = [app.masterImageX(1,round(app.XS_pts(1,2))),app.masterImageY(round(app.XS_pts(2,2)))];
                else
                    app.startXS = [app.X(1,round(app.XS_pts(1,1))),app.Y(round(app.XS_pts(2,1)))];
                    app.endXS = [app.X(1,round(app.XS_pts(1,2))),app.Y(round(app.XS_pts(2,2)))];
                end
                
                sumX = (app.endXS(1) - app.startXS(1)); % Total change in x
                sumY = (app.endXS(2) - app.startXS(2)); % Total change in y
                
                fractX = app.UITable2.Data(:,1)./app.transectLength; % Fraction of change in X
                fractY = app.UITable2.Data(:,1)./app.transectLength; % Fraction of change in Y
                
                %originalLength = length(app.xInder);
                app.xInder = app.startXS(1) + (fractX.*sumX);
                app.yInder = app.startXS(2) + (fractY.*sumY);
                app.xInder = transpose(replace_num(app.xInder,NaN,0));
                app.yInder = transpose(replace_num(app.yInder,NaN,0));
                
            elseif strcmp (app.CrossSectionDropDown.Value, 'Referenced survey [m]') == 1
                
                sumX = (app.endXS(1) - app.startXS(1)); % Total change in x
                sumY = (app.endXS(2) - app.startXS(2)); % Total change in y
                
                fractX = app.UITable2.Data(:,1)./app.transectLength; % Fraction of change in X
                fractY = app.UITable2.Data(:,1)./app.transectLength; % Fraction of change in Y
                
                %originalLength = length(app.xInder);
                app.xInder = app.startXS(1) + (fractX.*sumX);
                app.yInder = app.startXS(2) + (fractY.*sumY);
                app.xInder = transpose(replace_num(app.xInder,NaN,0));
                app.yInder = transpose(replace_num(app.yInder,NaN,0));
            end
        end % function
        
        % Button pushed function: CALCULATEButton
        function CALCULATEButtonPushed(app, event)
            clear app.UITable2.Data M2 xsVelocity xsStd
            
            editCel2(app)
            
            % Create the finalised cross-section
            if app.UITable2.Data(1,1) ~= 0
                M1 = app.startXS;
                N1 = [0];
                D1 = [0];
            else
                M1 = [];
                N1 = [];
                D1 = [];
            end
            
            if app.UITable2.Data(end,1) ~= app.transectLength
                M3 = app.endXS;
                N3 = [app.transectLength];
                D3 = [0];
            else
                M3 = [];
                N3 = [];
                D3 = [];
            end
            
            N2 = app.UITable2.Data(~isnan(app.UITable2.Data(:,1)));
            A2 = {N1, N2, N3};
            crossSectionPlot = cat(1,A2{:});
            
            t1 = size(app.xInder);
            M2 =  [app.xInder; app.yInder]';
            A1 = {M1, M2, M3};
            crossSectionIn = cat(1,A1{:});
            
            if strcmp(app.ReferenceHeight.Value, 'Water depth [m]') == 1
                D2 =  app.UITable2.Data(~isnan(app.UITable2.Data(:,1)),2);
                t1 = find(D2<0);
                if ~isempty(t1)
                    D2(t1) = 0;
                end
                A3 = {D1, D2, D3};
                depthIn = cat(1,A3{:});
                continuer = 1;
            elseif strcmp(app.ReferenceHeight.Value, 'True bed elevation [m]') == 1
                D2 =  app.UITable2.Data(~isnan(app.UITable2.Data(:,1)),2);
                D2 = app.WatersurfaceelevationmEditField.Value - D2;
                t1 = find(D2<0);
                if ~isempty(t1)
                    D2(t1) = 0;
                end
                A3 = {D1, D2, D3};
                depthIn = cat(1,A3{:});
                continuer = 1;
            else
                continuer = 0;
            end
            
            
            if continuer == 1
                for s = 1:length(crossSectionIn)
                    [~, dis] = knnsearch(crossSectionIn(s,1:2), app.xyzA_final(:,1:2));
                    use1 = find(dis < app.SearchDistanceEditField.Value); % find within 2.5% of the transect distance as default
                    if ~isempty(use1)
                        numberPoints(s) = length(use1);
                        if strcmp(app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
                            temp1 = app.refValue; % uses the velocity magnitude if normal component hasn't been calculated
                            xsVelocity(s) = nanmedian(temp1(use1));
                        elseif strcmp(app.VelocityDropDown.Value, 'Normal Component') == 1
                            xsVelocity(s) = nanmedian(app.normalVelocity(use1));
                            xsStd(s) = nanstd(app.normalVelocity(use1));
                        end
                    end
                    
                    % Assign the start and stop positions with zero values
                    if s == 1 || s == length(crossSectionIn)
                        numberPoints(s) = 0;
                        xsVelocity(s) = 0;
                        xsStd(s) = 0;
                    end
                end
                
                xsVelocity(2:end-1) = replace_num(xsVelocity(2:end-1),0,NaN);
                xsVelocity = xsVelocity.*app.alphaEditField.Value; % Apply the alpha coefficient
                xsVelocity(~depthIn' > 0) = 0; % Ensure limited to teh water extent
                xsStd(2:end-1) = replace_num(xsStd(2:end-1),0,NaN);
                
                % Ensure x-data is distance along xs
                out=cell2mat(cellfun(@(x) app.startXS-x ,{crossSectionIn},'un',0));
                absDistance = sqrt(out(:,1).^2+out(:,2).^2);
                missingInd = find(isnan(xsVelocity));
                
                if strcmp(app.InterpolationMethod.Value, 'Quadratic Polynomial') == 1
                    QuadraticVelocity = xsVelocity';
                    [xData, yData] = prepareCurveData( absDistance, QuadraticVelocity );
                    ft = fittype( 'poly2' );% Set up fittype and options (3rd order polynomial)
                    [fitresult, ~] = fit( xData, yData, ft );% Fit model to data.
                    
                    QuadraticVelocity(missingInd) = fitresult.p1.*absDistance(missingInd).^2 + fitresult.p2.*absDistance(missingInd) + fitresult.p3;
                    rem1 = find(QuadraticVelocity < 0);
                    QuadraticVelocity(rem1) = 0;
                    plotFcn(app, absDistance, QuadraticVelocity, missingInd);
                    
                    % Discharge calculated using the velocity area mid-section method and cubic extrapolation (Herschy, 1993)
                    for a = 1:length(absDistance)
                        if a == 1
                            q(a) = QuadraticVelocity(a) .* ((absDistance(a+1,1) - absDistance(a,1))./2) .* depthIn(a);
                        elseif a == length(QuadraticVelocity)
                            q(a) = QuadraticVelocity(a) .* ((absDistance(a,1) - absDistance(a-1,1))./2) .* depthIn(a);
                            totalQ_quad = sum(q);
                            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                                message1 = ['Q = ' num2str(round(totalQ_quad,2)) ' m' char(179) '/s'];
                                msgbox(message1,'Value');
                            else
                                app.totalQ(app.videoNumber) = totalQ_quad;
                            end
                        else
                            q(a) = QuadraticVelocity(a) .* ((absDistance(a+1,1) - absDistance(a-1,1))./2) .*depthIn(a);
                        end
                    end
                    
                elseif strcmp(app.InterpolationMethod.Value, 'Cubic Polynomial') == 1
                    CubicVelocity = xsVelocity';
                    [xData, yData] = prepareCurveData( absDistance, CubicVelocity );
                    ft = fittype( 'poly3' );% Set up fittype and options (3rd order polynomial)
                    [fitresult, ~] = fit( xData, yData, ft );% Fit model to data.
                    
                    CubicVelocity(missingInd) = fitresult.p1.*absDistance(missingInd).^3 + fitresult.p2.*absDistance(missingInd).^2 ...
                        + fitresult.p3.*absDistance(missingInd) + fitresult.p4;
                    rem1 = find(CubicVelocity < 0);
                    CubicVelocity(rem1) = 0;
                    plotFcn(app, absDistance, CubicVelocity, missingInd);
                    
                    % Discharge calculated using the velocity area mid-section method and cubic extrapolation (Herschy, 1993)
                    for a = 1:length(absDistance)
                        if a == 1
                            q(a) = CubicVelocity(a).*((absDistance(a+1,1) - absDistance(a,1))./2) .* depthIn(a);
                        elseif a == length(CubicVelocity)
                            q(a) = CubicVelocity(a).*((absDistance(a,1) - absDistance(a-1,1))./2) .* depthIn(a);
                            totalQ_cubic = sum(q);
                            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                                message1 = ['Q = ' num2str(round(totalQ_cubic,2)) ' m' char(179) '/s'];
                                msgbox(message1,'Value');
                            else
                                app.totalQ(app.videoNumber) = totalQ_cubic;
                            end
                        else
                            q(a) = CubicVelocity(a).*((absDistance(a+1,1) - absDistance(a-1,1))./2) .* depthIn(a);
                        end
                    end
                    
                elseif strcmp(app.InterpolationMethod.Value, 'Constant Froude') == 1
                    [xData, yData] = prepareCurveData( depthIn, xsVelocity' );
                    ft = fittype( 'poly1' );% Set up fittype and options.
                    [fitresult, ~] = fit( xData, yData, ft );% Fit model to data.
                    
                    % Discharge calculated using the velocity area mid-section method and constant froude number assumption (Herschy, 1993)
                    for a = 1:length(xsVelocity)
                        if a == 1
                            froudeVelocity = xsVelocity';
                            froudeVelocity(missingInd) = NaN;
                            dlm = fitlm(depthIn,froudeVelocity,'Intercept',false);
                            froudeVelocity(missingInd) = depthIn(missingInd).* table2array(dlm.Coefficients(1,1));
                            plotFcn(app, absDistance, froudeVelocity, missingInd);
                            distance1(a) = absDistance(a+1,1) - absDistance(a,1);
                            qfroude(a) = froudeVelocity(a) .* ((absDistance(a+1,1) - absDistance(a,1))./2) .* depthIn(a);
                        elseif a == length(xsVelocity)
                            distance1(a) = absDistance(a,1) - absDistance(a-1,1);
                            qfroude(a) = froudeVelocity(a) .* ((absDistance(a,1) - absDistance(a,1))./2) .* depthIn(a);
                            totalQ_froude = sum(qfroude);
                            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                                message1 = ['Q = ' num2str(round(totalQ_froude,2)) ' m' char(179) '/s'];
                                msgbox(message1,'Value');
                            else
                                app.totalQ(app.videoNumber) = totalQ_froude;
                            end
                        else
                            distance1(a) = absDistance(a+1,1) - absDistance(a-1,1);
                            qfroude(a) = froudeVelocity(a) .* ((absDistance(a+1,1) - absDistance(a-1,1))./2) .* depthIn(a);
                        end
                    end % for length velocity measurements
                end % interpolation method
            end % continuer
        end % function
        
        function plotFcn(app, absDistance, velocityIn, missingInd)
            f1 = figure(); hold on;
            ax1 = gca;
            grid off
            set(gca,'TickLabelInterpreter','latex')
            h1 = plot( absDistance, velocityIn, 'k' );
            h1_1 = scatter( absDistance, velocityIn,...
                'MarkerEdgeColor', 'k',...
                'MarkerFaceColor', 'k');
            h1_2 = scatter( absDistance(missingInd), velocityIn(missingInd),...
                'MarkerEdgeColor', 'r',...
                'MarkerFaceColor', 'r');
            %legend( [h1_1, h1_2, h1],['Velocity Observation'],...
            %     ['Predicted Velocity'],...
            %     ['Velocity Profile'],...
            %     'Interpreter','LaTex',...
            %     'Location','northwest')
            
            xlabel(['Cross-section location $\mathrm{(m)}$'] , 'Interpreter','LaTex');
            ylabel(['Velocity $\mathrm{(m \ s^{-1})}$ '] , 'Interpreter','LaTex');
            set(ax1,'fontsize',14)
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                try
                    temp1 = [app.directory_save_multiple '\crossSectionVelocity.png'];
                    saveas(f1,temp1,'png')
                    cla (ax1);
                    reset(gcf);
                    reset(gca);
                    close (f1)
                    waitfor(f1)
                catch
                end
            end
            
        end
        
        % Value changed function: CrosssectionInputDropDown
        function CrosssectionInputDropDownValueChanged(app, event)
            app.xsData = app.CrosssectionInputDropDown.Value;
            
            if strcmp (app.xsData, 'From .csv file') == 1
                disp ('Importing bathymetry from pre-defined csv file')
                [app.xsfile, app.xsdirectory] = uigetfile({'*.csv' '.csv Files'},'Select a file',app.directory);
                
                if length(app.xsfile) > 1
                    [data_text,~] = readtext(strjoin({app.xsdirectory app.xsfile },''), ',', '','','textual'); % read in the csv file
                    clear app.xs
                    app.xs = [str2double(data_text(2:end,1)), str2double(data_text(2:end,2))]   ; % Extract the chainage coordinate of the scan
                    [app.xsdims, ~] = size(app.xs);
                    app.xs = app.xs(1:app.xsdims,:);
                    app.UITable2.Data = app.xs;
                end
                
                app.xInder = [];
                app.yInder = [];
                for a = 1:length(app.UITable2.Data)
                    if (a > 0 && ...                  % if first row or higher
                            (~isnan(app.UITable2.Data(a,1)) && ...         % second collumn (height) is numeric
                            ~isnan(app.UITable2.Data(a,2)) ))             % first collumn (chainage) is numeric
                        
                        if app.UITable2.Data(a,1) > app.transectLength
                            message = sprintf('Warning! \nSpecified distance exceeds the transect length.');
                            msgbox(message, 'Error','error');
                        end
                        
                        app.startXS = [app.X(1,round(app.XS_pts(1,1))),app.Y(round(app.XS_pts(2,1)))];
                        app.endXS = [app.X(1,round(app.XS_pts(1,2))),app.Y(round(app.XS_pts(2,2)))];
                        sumX = (app.endXS(1) - app.startXS(1)); % Total change in x
                        sumY = (app.endXS(2) - app.startXS(2)); % Total change in y
                        
                        fractX = app.UITable2.Data(a,1)./app.transectLength; % Fraction of change in X
                        fractY = app.UITable2.Data(a,1)./app.transectLength; % Fraction of change in Y
                        
                        originalLength = length(app.xInder);
                        app.xInder(originalLength+1) = app.startXS(1) + (fractX.*sumX);
                        app.yInder(originalLength+1) = app.startXS(2) + (fractY.*sumY);
                        app.xInder = replace_num(app.xInder,NaN,0);
                        app.yInder = replace_num(app.yInder,NaN,0);
                    end
                end
            elseif strcmp (app.xsData, 'Inputted manually') == 1
                app.UITable2.Data = [NaN NaN; NaN NaN; NaN NaN; NaN NaN; NaN NaN;...
                    NaN NaN; NaN NaN; NaN NaN; NaN NaN; NaN NaN;...
                    NaN NaN; NaN NaN; NaN NaN; NaN NaN; NaN NaN;...
                    NaN NaN; NaN NaN; NaN NaN; NaN NaN; NaN NaN]; % Maximum of 20 bathy points
                app.UITable2.ColumnEditable = true;
                
            end % if input type
        end % function
        
        % Value changed function: CameraTypeDropDown
        function CameraTypeDropDownValueChanged(app, event)
            value = app.CameraTypeDropDown.Value;
            if strcmp(value, 'Not listed') == 1 % Unknown
                app.c = app.imgsz./2;
                app.k = [0, 0];
                app.p = [0, 0];
            end % if not listed
            
            TextIn = strjoin({'Camera model selected is: '; app.CameraTypeDropDown.Value},' ');
            TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
            TimeIn = strjoin(TimeIn, ' ');
            app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
            printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
        end % function
        
        % Value changed function: CheckGCPsSwitch
        function CheckGCPsSwitchValueChanged(app, event)
            
        end
        
        % Value changed function: IgnoreEdgesDropDown
        function IgnoreEdgesDropDownValueChanged(app, event)
            value = app.IgnoreEdgesDropDown.Value;
            if strcmp (app.IgnoreEdgesDropDown.Value, 'Yes') == 1
                TextIn = {'Ignore edges selected:'; 'The outer 10% of the images will not be used in the analysis'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            elseif strcmp (app.IgnoreEdgesDropDown.Value, 'No') == 1
                TextIn = {'Ignore edges not selected:'; 'The entirety of the image will be used in the analysis'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
        end
        
        function ProcessingModeDropDownValueChanged(app, event)
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == 1
                app.OrientationDropDown.Items = {'Make a selection:', 'Stationary: Nadir', 'Stationary: GCPs','Dynamic: GCPs', 'Dynamic: GCPs + Stabilisation', 'Dynamic: Stabilisation',  'Dynamic: GPS + IMU'}; %, 'Planet [beta]'}
                app.OrientationDropDown.Value = 'Make a selection:';
                app.CrossSectionDropDown.Items = {'Make a selection:', 'Referenced survey [m]', 'Relative distances [m]'};
                app.CrossSectionDropDown.Value = 'Make a selection:';
                app.ReferenceHeight.Items = {'Make a selection:', 'True bed elevation [m]', 'Water depth [m]'};
                app.ReferenceHeight.Value = 'Make a selection:';
                
                TextIn = {'Please select a single video for analysis'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                % Ensure the correct input buttons are enabled/disabled
                app.AddLevelButton.Enable = 'off';
                app.AddLevelButton.Visible = 'Off';
                app.WatersurfaceelevationmEditField.Enable = 'on';
                app.WatersurfaceelevationmEditField.Visible = 'On';
                app.roiButton.Enable = 'on';
                app.ExportDefaultValuesButton.Enable = 'on';
                app.LoadDefaultValuesButton.Enable = 'on';
                app.CALCULATEButton.Position = [980 162 290 22];
                app.CALCULATEButton.Enable = 'on';
                app.CALCULATEButton.Visible = 'On';
                app.RUNButton.Position = [655 158 290 22];
                app.RUNButton.Enable = 'on';
                app.RUNButton.Visible = 'On';
                
            elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == 1
                app.OrientationDropDown.Items = {'Make a selection:', 'Stationary: GCPs'};
                app.OrientationDropDown.Value = 'Make a selection:';
                app.CrossSectionDropDown.Items = {'Make a selection:', 'Referenced survey [m]'};
                app.CrossSectionDropDown.Value = 'Make a selection:';
                app.ReferenceHeight.Items = {'Make a selection:', 'True bed elevation [m]'};
                app.ReferenceHeight.Value = 'Make a selection:';
                
                TextIn = {'Multiple video analysis mode selected'; 'Please click Define Video(s) and select the folder containing the videos to be analysed'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                % Ensure the correct input buttons are enabled/disabled
                app.AddLevelButton.Enable = 'on';
                app.AddLevelButton.Visible = 'On';
                app.WatersurfaceelevationmEditField.Enable = 'off';
                app.WatersurfaceelevationmEditField.Visible = 'Off';
                app.roiButton.Enable = 'off';
                app.ExportDefaultValuesButton.Enable = 'off';
                app.LoadDefaultValuesButton.Enable = 'off';
                
                app.CALCULATEButton.Position = [655 158 290 22]; % switched with RUN
                app.CALCULATEButton.Enable = 'off';
                app.CALCULATEButton.Visible = 'off';
                app.RUNButton.Position = [980 162 290 22];
                app.RUNButton.Enable = 'on';
                app.RUNButton.Visible = 'On';
                
            end
        end
        
        
        
        function AddLevelButtonPushed(app, event)
            
            app.totalQ = [];
            
            % Identify the level data
            [levelFile,levelDir] = uigetfile ({'*.csv' 'CSV files'},'Select the file containing river level observations', app.directory);
            
            % Bring in the river level data
            [data_text,~] = readtext(strjoin({levelDir '\' levelFile},''),',', '','','textual'); % read in the csv file
            data_text = strrep(data_text,'"', '');
            for a =1:2
                try
                    if a == 1
                        riverLevelTimesNum = datenum(data_text(2:end,1),'dd/mm/yyyy HH:MM');
                        break
                    elseif a == 2
                        riverLevelTimesNum = datenum(data_text(2:end,1),'dd/mm/yyyy HH:MM:SS');
                    end
                catch
                end
            end
            
            riverLevelTimes = data_text(2:end,1);
            RiverLevelValues = str2double(data_text(2:end,2));
            [~, sizer] = size(data_text);
            if sizer > 2 % Q data exists
                RiverQValues= str2double(data_text(2:end,3));
            else
                RiverQValues(1:length(RiverLevelValues),1) = NaN;
            end
                
            TextIn = {'Matching videos to river level observations. Please wait.'};
            app.ListBox.Items = [app.ListBox.Items, TextIn'];
            printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
            try
                for b = 1:length(riverLevelTimesNum)
                    [Idx,D] = knnsearch(riverLevelTimesNum(b),app.videoDatesFormattedNum);
                    [M, I] = min(D);
                    if M < 0.0418./6 % difference of less than 10 minutes
                        videoIdx(b) = I;
                        lat = 50.479391; % Assign the geographical coordinates for determining the sunrise/sunset
                        lon = -3.762149;
                        [rs,~,~,~,~,~] = suncycle(lat,lon,riverLevelTimesNum(b),2880); % Calculate the timing of the sunrise/sunset (time in GMT)
                        DateVector = datevec(riverLevelTimesNum(b));
                        if DateVector(1,4) < rs(1,1) || DateVector(1,4) > rs(1,2)
                            % Do nada
                        else
                            fna{b} = char(app.videoDirFileNames(videoIdx(b)));
                            rlta{b} = riverLevelTimesNum(b);
                            rla(b) = RiverLevelValues(b);
                            rqa(b) = RiverQValues(b);
                        end
                    end
                end
                
                user = find(~cellfun(@isempty,fna));
                app.fileNameAnalysis = fna(user);
                app.riverLevelTimeAnalysis = rlta(user);
                app.riverLevelAnalysis = rla(user);
                app.totalQ = rqa(user);
                
                TextIn = {[num2str(length(app.fileNameAnalysis)) ' videos were matched to river level observations. Please continue']};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom')
            catch
                TextIn = {'No videos were matched river level observations. Check inputs and retry.'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom')
            end
            
        end
        
        
        function ExportDefaultValuesButtonPushed(app, event)
            saveState(app)
        end
        
        function LoadDefaultValuesButtonPushed(app, event)
            loadState(app)
        end
    end
    
    % App initialization and construction
    methods (Access = private)
        
        % Create UIFigure and components
        function createComponents(app)
            
            % Create KLTIV UIFigure
            app.KLTIV_UIFigure = uifigure;
            app.KLTIV_UIFigure.Color = [ 1 1 1];
            app.KLTIV_UIFigure.Position = [100 100 1287 538]; %width < 1366; hgt < 786
            app.KLTIV_UIFigure.Name = 'KLT-IV (v1.1)';
            app.KLTIV_UIFigure.Resize = 'off';
            
            warning off Matlab:HandleGraphics:ObsoletedProperty:JavaFrame
            warning off Matlab:structOnObject
            while true
                try
                    figProps = struct(app.KLTIV_UIFigure);
                    controller = figProps.Controller;
                    controllerProps = struct(controller);
                    platformHost = controllerProps.PlatformHost;
                    platformHostProps = struct(platformHost);
                    break
                catch
                    pause(0.5); % Give the figure (webpage) some more time to load
                end
            end
            
            % Try to load the correct icon
            try
                if isdeployed % Stand-alone mode.
                    [status, result] = system('path');
                    currentDir = char(regexpi(result, 'Path=(.*?);', 'tokens', 'once'));
                    win =   platformHostProps.CEF;
                    win.Icon = [currentDir '\' 'KLT_icon.ico'];
                else % MATLAB mode.
                    currentDir = pwd;
                    win =   platformHostProps.CEF;
                    win.Icon = [currentDir '\' 'KLT_icon.ico'];
                end
            catch
            end
            
            app.CONTROLDIMS = [app.KLTIV_UIFigure.Position(3),...
                app.KLTIV_UIFigure.Position(4)];
            
            % Create scrollPane
            app.scrollPane = uipanel(app.KLTIV_UIFigure);
            app.scrollPane.AutoResizeChildren = 'off';
            app.scrollPane.BorderType = 'none';
            app.scrollPane.Position(1:4) = [0, ...
                0,...
                app.KLTIV_UIFigure.Position(3),...
                app.KLTIV_UIFigure.Position(4)];
            
            % Inject CSS in head
            app.WEBWINDOW = mlapptools.getWebWindow(app.KLTIV_UIFigure);
            cssText = [...
                '''<style>\n', ...
                '  {@import url("https://fonts.googleapis.com/css?family=Ubuntu&display=swap") \n}'...
                '  .scrollpane {\n', ...
                '    background:  #F0F2F0 !important;\n'...
                '    background: -webkit-linear-gradient(to bottom, #000C40, #F0F2F0) !important;\n'...
                '    background: linear-gradient(to bottom, #000C40, #F0F2F0) !important;\n'...
                '  }\n', ...
                '  .controlbox {\n', ...
                '    background-color:#D8E2DC !important;\n'...
                '    border-radius: 15px 5px 5px 15px !important;\n', ...
                '    background-size:40px 60px !important;\n',...
                '    font-family: Ubuntu !important;\n'...
                '    font-weight: normal !important;\n'...
                '    font-size: 12px !important;\n'...
                '    color: #005284 !important;\n'...
                '  }\n', ...
                '  .controlbox::after {\n',...
                '    opacity: 0.6 !important;\n', ...
                '  }\n',...
                '  .infoBox {\n', ...
                '    background-color: #f0f0f0 !important;\n'...
                '    border-radius: 15px 5px 5px 15px !important;\n', ...
                '    background-size:40px 60px !important;\n',...
                '    font-family: Ubuntu !important;\n'...
                '    font-weight: light !important;\n'...
                '    font-size: 12px !important;\n'...
                '    color: #262626 !important;\n'...
                '    text-align: center !important;\n'...
                '    vertical-align:middle !important;\n'...
                '  }\n', ...
                '  .infoBox2 {\n', ...
                '    background-color: #f0f0f0 !important;\n'...
                '    border-radius: 15px 5px 5px 15px !important;\n', ...
                '    background-size:40px 60px !important;\n',...
                '    font-family: Ubuntu !important;\n'...
                '    font-weight: light !important;\n'...
                '    font-size: 12px !important;\n'...
                '    color: #262626 !important;\n'...
                '    text-align: center !important;\n'...
                '    vertical-align:middle !important;\n'...
                '  }\n', ...
                '</style>\n''' ...
                ];
            
            pause(3) % Insert a pause to ensure the above is executed properly
            app.WEBWINDOW.executeJS(['document.head.innerHTML += ', ...
                cssText]);
            
            % add .scrollpane class to scrollPane div
            [~,scrollID] = mlapptools.getWebElements(app.scrollPane);
            scrollClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                scrollID.ID_attr, scrollID.ID_val, 'scrollpane');
            app.WEBWINDOW.executeJS(scrollClassString);
            
            % Create VideoInputsLabel
            app.VideoInputsLabel = uilabel(app.KLTIV_UIFigure);
            app.VideoInputsLabel.FontName = 'Ubuntu';
            app.VideoInputsLabel.FontSize = 26;
            app.VideoInputsLabel.FontColor = [0.149 0.149 0.149];
            app.VideoInputsLabel.Position = [65 482 190 34];
            app.VideoInputsLabel.Text = '(1) Video Inputs';
            
            % Create the first panel
            i = 1;
            app.ControlHandles = gobjects(i,100); %no. of items in panel and no of panels
            app.ControlHandles(i,1) = uipanel(app.scrollPane);
            app.ControlHandles(i,1).AutoResizeChildren = 'off';
            app.ControlHandles(i,1).Position = [15 215 300 315];
            app.ControlHandles(i,1).BorderType = 'none';
            
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,1));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'controlbox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            
            % Define the processing mode label outline
            app.ProcessingModeDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.ProcessingModeDropDownLabel.Position = [20 446 140 22];
            app.ProcessingModeDropDownLabel.Text = '';
            app.ControlHandles(i,18) = app.ProcessingModeDropDownLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,18));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.ProcessingModeDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.ProcessingModeDropDownLabel.Position = [20 446 140 22];
            app.ProcessingModeDropDownLabel.Text = '    Mode';
            
            % Define the processing mode
            app.ProcessingModeDropDown = uidropdown(app.KLTIV_UIFigure);
            app.ProcessingModeDropDown.Items = {'Make a selection', 'Single Video', 'Multiple Videos'};
            app.ProcessingModeDropDown.ValueChangedFcn = createCallbackFcn(app, @ProcessingModeDropDownValueChanged, true);
            app.ProcessingModeDropDown.Position = [170 446 140 22];
            app.ProcessingModeDropDown.Value = 'Single Video';
            app.ProcessingModeDropDown.FontName = 'Roboto';
            
            app.AddVideoButtonLabel = uilabel(app.KLTIV_UIFigure);
            app.AddVideoButtonLabel.HorizontalAlignment = 'left';
            app.AddVideoButtonLabel.Position = [20 349 140 22];
            app.AddVideoButtonLabel.Text = '';
            app.ControlHandles(i,22) = app.AddVideoButtonLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,22));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.AddVideoButtonLabel = uilabel(app.KLTIV_UIFigure);
            app.AddVideoButtonLabel.HorizontalAlignment = 'left';
            app.AddVideoButtonLabel.Position = [20 349 140 22];
            app.AddVideoButtonLabel.Text = '    Define Video(s)';
            
            %  Create AddVideoButton Label
            app.AddVideoButtonLabel = uilabel(app.KLTIV_UIFigure);
            app.AddVideoButtonLabel.HorizontalAlignment = 'left';
            app.AddVideoButtonLabel.Position = [20 414 140 22];
            app.AddVideoButtonLabel.Text = '';
            app.ControlHandles(i,22) = app.AddVideoButtonLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,22));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.AddVideoButtonLabel = uilabel(app.KLTIV_UIFigure);
            app.AddVideoButtonLabel.HorizontalAlignment = 'left';
            app.AddVideoButtonLabel.Position = [20 414 140 22];
            app.AddVideoButtonLabel.Text = '    Define Video(s)';
            
            %  Create AddVideoButton
            app.AddVideoButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.AddVideoButton.Position = [170 414 140 22];
            app.AddVideoButton.Text = '';
            app.ControlHandles(i,2) = app.AddVideoButton;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,2));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox2');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.AddVideoButton.VerticalAlignment = 'center';
            app.AddVideoButton.HorizontalAlignment = 'center';
            app.AddVideoButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.AddVideoButton.ButtonPushedFcn = createCallbackFcn(app, @AddVideoButtonPushed, true);
            app.AddVideoButton.Position = [170 414 140 22];
            app.AddVideoButton.Text = 'Click here';
            app.AddVideoButton.FontName = 'Roboto';
            app.AddVideoButton.VerticalAlignment = 'center';
            app.AddVideoButton.HorizontalAlignment = 'center';
            
            % Create CameraTypeDropDownLabel
            app.CameraTypeDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.CameraTypeDropDownLabel.HorizontalAlignment = 'left';
            app.CameraTypeDropDownLabel.Position = [20 381 140 22];
            app.CameraTypeDropDownLabel.Text = '';
            app.ControlHandles(i,3) = app.CameraTypeDropDownLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,3));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.CameraTypeDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.CameraTypeDropDownLabel.HorizontalAlignment = 'left';
            app.CameraTypeDropDownLabel.Position = [20 381 140 22];
            app.CameraTypeDropDownLabel.Text = '    Camera Type';
            
            % Create CameraTypeDropDown
            app.CameraTypeDropDown = uidropdown(app.KLTIV_UIFigure);
            app.CameraTypeDropDown.FontName = 'Roboto';
            app.CameraTypeDropDown.Items = {'Make a selection', ...
                'DJI Phantom 2 Vision+',...
                'DJI Inspire 1',...
                'DJI Mavic 2 Pro',...
                'DJI Phantom 4 Pro',...
                'GoPro Hero3',...
                'GoPro Hero4',...
                'Hikvision DS-2CD2T42WD-I8 6mm', ...
                'Hikvision IPC-B140 6mm', ...
                'Nikon D810', 'Sony RX10II', ...
                'Vivotek IB8382-F3', ... %'Feshie',
                'Not listed'};
            app.CameraTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @CameraTypeDropDownValueChanged, true);
            app.CameraTypeDropDown.Position = [170 381 140 22];
            app.CameraTypeDropDown.Value = 'Make a selection';
            
            % Create OrientationDropDownLabel
            app.OrientationDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.OrientationDropDownLabel.HorizontalAlignment = 'left';
            app.OrientationDropDownLabel.Position = [20 349 140 22];
            app.OrientationDropDownLabel.Text = '';
            app.ControlHandles(i,4) = app.OrientationDropDownLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,4));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.OrientationDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.OrientationDropDownLabel.HorizontalAlignment = 'left';
            app.OrientationDropDownLabel.Position = [20 349 140 22];
            app.OrientationDropDownLabel.Text = '    Orientation';
            
            % Create OrientationDropDown
            app.OrientationDropDown = uidropdown(app.KLTIV_UIFigure);
            app.OrientationDropDown.Items = {'Make a selection:', 'Stationary: Nadir', 'Stationary: GCPs','Dynamic: GCPs', 'Dynamic: GCPs + Stabilisation', 'Dynamic: Stabilisation',  'Dynamic: GPS + IMU'}; %, 'Planet [beta]'}
            app.OrientationDropDown.ValueChangedFcn = createCallbackFcn(app, @OrientationDropDownValueChanged, true);
            app.OrientationDropDown.FontName = 'Roboto';
            app.OrientationDropDown.Position = [170 349 140 22];
            app.OrientationDropDown.Value = 'Make a selection:';
            
            % Create CameraxyzLabel
            app.CameraxyzEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.CameraxyzEditFieldLabel.FontName = 'Ubuntu';
            app.CameraxyzEditFieldLabel.Position = [20 317 140 22];
            app.CameraxyzEditFieldLabel.Text = '';
            app.ControlHandles(i,5) = app.CameraxyzEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,5));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.CameraxyzEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.CameraxyzEditFieldLabel.Position = [20 317 140 22];
            app.CameraxyzEditFieldLabel.Text = '    Camera [x]';
            app.CameraxyzEditFieldLabel.FontName = 'Ubuntu';
            
            % Create CameraxyzEditField
            app.CameraxyzEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.CameraxyzEditField.ValueDisplayFormat = '%.2f';
            app.CameraxyzEditField.FontName = 'Roboto';
            app.CameraxyzEditField.FontColor = [0.149 0.149 0.149];
            app.CameraxyzEditField.Position = [170 317 140 22];
            app.CameraxyzEditField.Value = 9;
            
            % Create CameraxyzLabel2
            app.CameraxyzEditField_2Label = uilabel(app.KLTIV_UIFigure);
            app.CameraxyzEditField_2Label.FontName = 'Ubuntu';
            app.CameraxyzEditField_2Label.Position = [20 285 140 22];
            app.CameraxyzEditField_2Label.Text = '';
            app.ControlHandles(i,6) = app.CameraxyzEditField_2Label;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,6));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.CameraxyzEditField_2Label = uilabel(app.KLTIV_UIFigure);
            app.CameraxyzEditField_2Label.FontName = 'Ubuntu';
            app.CameraxyzEditField_2Label.Position = [20 285 140 22];
            app.CameraxyzEditField_2Label.Text = '    Camera [y]';
            app.ControlHandles(i,6) = app.CameraxyzEditField_2Label;
            
            % Create CameraxyzEditField_2
            app.CameraxyzEditField_2 = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.CameraxyzEditField_2.ValueDisplayFormat = '%.2f';
            app.CameraxyzEditField_2.FontName = 'Roboto';
            app.CameraxyzEditField_2.FontColor = [0.149 0.149 0.149];
            app.CameraxyzEditField_2.Position = [170 285 140 22];
            app.CameraxyzEditField_2.Value = 15;
            
            % Create CameraxyzLabel3
            app.CameraxyzEditField_3Label = uilabel(app.KLTIV_UIFigure);
            app.CameraxyzEditField_3Label.FontName = 'Ubuntu';
            app.CameraxyzEditField_3Label.Position = [20 253 140 22];
            app.CameraxyzEditField_3Label.Text = '';
            app.ControlHandles(i,7) = app.CameraxyzEditField_3Label;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,7));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.CameraxyzEditField_3Label = uilabel(app.KLTIV_UIFigure);
            app.CameraxyzEditField_3Label.FontName = 'Ubuntu';
            app.CameraxyzEditField_3Label.Position = [20 253 140 22];
            app.CameraxyzEditField_3Label.Text = '    Camera [z]';
            app.ControlHandles(i,7) = app.CameraxyzEditField_3Label;
            
            % Create CameraxyzEditField_3
            app.CameraxyzEditField_3 = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.CameraxyzEditField_3.ValueDisplayFormat = '%.2f';
            app.CameraxyzEditField_3.FontName = 'Roboto';
            app.CameraxyzEditField_3.FontColor = [0.149 0.149 0.149];
            app.CameraxyzEditField_3.Position = [170 253 140 22];
            app.CameraxyzEditField_3.Value = 36;
            
            % Create tickboxes for adjustment = xbox
            app.Cameraxyz_modifyXbox = uicheckbox(app.KLTIV_UIFigure);
            tempPos = [app.CameraxyzEditFieldLabel.Position];
            tempPos(1) = tempPos(1) + 120;
            app.Cameraxyz_modifyXbox.Position = tempPos;
            app.Cameraxyz_modifyXbox.Text = '';
            app.Cameraxyz_modifyXbox.Value = 1; 
            
            % Create tickboxes for adjustment = ybox
            app.Cameraxyz_modifyYbox = uicheckbox(app.KLTIV_UIFigure);
            tempPos = [app.CameraxyzEditField_2Label.Position];
            tempPos(1) = tempPos(1) + 120;
            app.Cameraxyz_modifyYbox.Position = tempPos;
            app.Cameraxyz_modifyYbox.Text = '';
            app.Cameraxyz_modifyYbox.Value = 1; 

            % Create tickboxes for adjustment = ybox
            app.Cameraxyz_modifyZbox = uicheckbox(app.KLTIV_UIFigure);
            tempPos = [app.CameraxyzEditField_3Label.Position];
            tempPos(1) = tempPos(1) + 120;
            app.Cameraxyz_modifyZbox.Position = tempPos;
            app.Cameraxyz_modifyZbox.Text = '';
            app.Cameraxyz_modifyZbox.Value = 1; 
            
            % Create yawpitchrollEditFieldLabel
            app.yawpitchrollEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.yawpitchrollEditFieldLabel.HorizontalAlignment = 'left';
            app.yawpitchrollEditFieldLabel.FontName = 'Ubuntu';
            app.yawpitchrollEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.yawpitchrollEditFieldLabel.Position = [20 221 140 22];
            app.yawpitchrollEditFieldLabel.Text = '';
            app.ControlHandles(i,8) = app.yawpitchrollEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,8));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.yawpitchrollEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.yawpitchrollEditFieldLabel.HorizontalAlignment = 'left';
            app.yawpitchrollEditFieldLabel.FontName = 'Ubuntu';
            app.yawpitchrollEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.yawpitchrollEditFieldLabel.Position = [20 221 140 22];
            app.yawpitchrollEditFieldLabel.Text = '    [Yaw, Pitch, Roll]';
            
            % Create yawpitchrollEditField
            app.yawpitchrollEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.yawpitchrollEditField.ValueDisplayFormat = '%.2f';
            app.yawpitchrollEditField.FontName = 'Roboto';
            app.yawpitchrollEditField.FontColor = [0.149 0.149 0.149];
            app.yawpitchrollEditField.Position = [170 221 45 22];
            
            % Create yawpitchrollEditField_2
            app.yawpitchrollEditField_2 = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.yawpitchrollEditField_2.ValueDisplayFormat = '%.2f';
            app.yawpitchrollEditField_2.FontName = 'Roboto';
            app.yawpitchrollEditField_2.FontColor = [0.149 0.149 0.149];
            app.yawpitchrollEditField_2.Position = [216.6667 221 45 22];
            app.yawpitchrollEditField_2.Value = 1.5708;
            
            % Create yawpitchrollEditField_3
            app.yawpitchrollEditField_3 = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.yawpitchrollEditField_3.ValueDisplayFormat = '%.2f';
            app.yawpitchrollEditField_3.FontName = 'Roboto';
            app.yawpitchrollEditField_3.FontColor = [0.149 0.149 0.149];
            app.yawpitchrollEditField_3.Position = [262.6667 221 45 22];
            app.yawpitchrollEditField_3.Value = 0;
            
            % Create box no.2
            app.ControlHandles(i,9) = uipanel(app.scrollPane);
            app.ControlHandles(i,9).AutoResizeChildren = 'off';
            app.ControlHandles(i,9).Position = [15 15 300 185];
            app.ControlHandles(i,9).BorderType = 'none';
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,9));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'controlbox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            
            % Create Settings label
            app.VideoInputsLabel = uilabel(app.KLTIV_UIFigure);
            app.VideoInputsLabel.FontName = 'Ubuntu';
            app.VideoInputsLabel.FontSize = 26;
            app.VideoInputsLabel.FontColor = [0.149 0.149 0.149];
            app.VideoInputsLabel.Position = [90 155 190 34];
            app.VideoInputsLabel.Text = '(2) Settings';
            
            % Create ExtractionratesEditFieldLabel
            app.ExtractionratesEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.ExtractionratesEditFieldLabel.HorizontalAlignment = 'left';
            app.ExtractionratesEditFieldLabel.FontName = 'Ubuntu';
            app.ExtractionratesEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.ExtractionratesEditFieldLabel.Position = [20 120 140 22];
            app.ExtractionratesEditFieldLabel.Text = '';
            app.ControlHandles(i,10) = app.ExtractionratesEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,10));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.ExtractionratesEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.ExtractionratesEditFieldLabel.HorizontalAlignment = 'left';
            app.ExtractionratesEditFieldLabel.FontName = 'Ubuntu';
            app.ExtractionratesEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.ExtractionratesEditFieldLabel.Position = [20 120 140 22];
            app.ExtractionratesEditFieldLabel.Text = '    Extract rate (s)';
            
            % Create ExtractionratesEditField
            app.ExtractionratesEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.ExtractionratesEditField.ValueDisplayFormat = '%.2f';
            app.ExtractionratesEditField.FontName = 'Roboto';
            app.ExtractionratesEditField.FontColor = [0.149 0.149 0.149];
            app.ExtractionratesEditField.Position = [170 120 140 22];
            app.ExtractionratesEditField.Value = 1;
            
            % Create BlocksizepxEditFieldLabel
            app.BlocksizepxEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.BlocksizepxEditFieldLabel.HorizontalAlignment = 'left';
            app.BlocksizepxEditFieldLabel.FontName = 'Ubuntu';
            app.BlocksizepxEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.BlocksizepxEditFieldLabel.Position = [20 90 140 22];
            app.BlocksizepxEditFieldLabel.Text = '';
            app.ControlHandles(i,11) = app.BlocksizepxEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,11));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.BlocksizepxEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.BlocksizepxEditFieldLabel.HorizontalAlignment = 'left';
            app.BlocksizepxEditFieldLabel.FontName = 'Ubuntu';
            app.BlocksizepxEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.BlocksizepxEditFieldLabel.Position = [20 90 140 22];
            app.BlocksizepxEditFieldLabel.Text = '    Block size (px)';
            
            % Create BlocksizepxEditField
            app.BlocksizepxEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.BlocksizepxEditField.ValueDisplayFormat = '%.0f';
            app.BlocksizepxEditField.FontName = 'Roboto';
            app.BlocksizepxEditField.FontColor = [0.149 0.149 0.149];
            app.BlocksizepxEditField.Position = [170 90 140 22];
            app.BlocksizepxEditField.Value = 31;
            
            % Create IgnoreEdgesDropDownLabel
            app.IgnoreEdgesDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.IgnoreEdgesDropDownLabel.HorizontalAlignment = 'left';
            app.IgnoreEdgesDropDownLabel.FontName = 'Ubuntu';
            app.IgnoreEdgesDropDownLabel.FontColor = [0.149 0.149 0.149];
            app.IgnoreEdgesDropDownLabel.Position = [20 60 140 22];
            app.IgnoreEdgesDropDownLabel.Text = '';
            app.ControlHandles(i,12) = app.IgnoreEdgesDropDownLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,12));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.IgnoreEdgesDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.IgnoreEdgesDropDownLabel.HorizontalAlignment = 'left';
            app.IgnoreEdgesDropDownLabel.FontName = 'Ubuntu';
            app.IgnoreEdgesDropDownLabel.FontColor = [0.149 0.149 0.149];
            app.IgnoreEdgesDropDownLabel.Position = [20 60 140 22];
            app.IgnoreEdgesDropDownLabel.Text = '    Ignore Edges?';
            
            
            % Create IgnoreEdgesDropDown
            app.IgnoreEdgesDropDown = uidropdown(app.KLTIV_UIFigure);
            app.IgnoreEdgesDropDown.Items = {'Make a selection', 'Yes', 'No'};
            app.IgnoreEdgesDropDown.ValueChangedFcn = createCallbackFcn(app, @IgnoreEdgesDropDownValueChanged, true);
            app.IgnoreEdgesDropDown.FontName = 'Roboto';
            app.IgnoreEdgesDropDown.FontColor = [0.149 0.149 0.149];
            app.IgnoreEdgesDropDown.Position = [170 60 140 22];
            app.IgnoreEdgesDropDown.Value = 'Make a selection';
            
            % Create VelocityDropDownLabel
            app.VelocityDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.VelocityDropDownLabel.HorizontalAlignment = 'left';
            app.VelocityDropDownLabel.FontName = 'Ubuntu';
            app.VelocityDropDownLabel.FontColor = [0.149 0.149 0.149];
            app.VelocityDropDownLabel.Position = [20 30 140 22];
            app.VelocityDropDownLabel.Text = '';
            app.ControlHandles(i,13) = app.VelocityDropDownLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,13));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.VelocityDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.VelocityDropDownLabel.HorizontalAlignment = 'left';
            app.VelocityDropDownLabel.FontName = 'Ubuntu';
            app.VelocityDropDownLabel.FontColor = [0.149 0.149 0.149];
            app.VelocityDropDownLabel.Position = [20 30 140 22];
            app.VelocityDropDownLabel.Text = '    Vel. component';
            
            % Create VelocityDropDown
            app.VelocityDropDown = uidropdown(app.KLTIV_UIFigure);
            app.VelocityDropDown.Items = {'Velocity Magnitude', 'Normal Component'}; %'Make a selection:', 'Normal Component',
            app.VelocityDropDown.ValueChangedFcn = createCallbackFcn(app, @VelocityDropDownValueChanged, true);
            app.VelocityDropDown.FontName = 'Roboto';
            app.VelocityDropDown.FontColor = [0.149 0.149 0.149];
            app.VelocityDropDown.Position = [170 30 140 22];
            app.VelocityDropDown.Value = 'Velocity Magnitude';
            
            % Create GroundControlLabel
            app.GroundControlLabel = uilabel(app.KLTIV_UIFigure);
            app.GroundControlLabel.FontName = 'Ubuntu';
            app.GroundControlLabel.FontSize = 26;
            app.GroundControlLabel.FontColor = [0.149 0.149 0.149];
            app.GroundControlLabel.Position = [365 482 240 34];
            app.GroundControlLabel.Text = '(3) Ground Control';
            
            % Create third panel
            app.ControlHandles(i,14) = uipanel(app.scrollPane);
            app.ControlHandles(i,14).AutoResizeChildren = 'off';
            app.ControlHandles(i,14).Position = [330 15 305 513];
            app.ControlHandles(i,14).BorderType = 'none';
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,14));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'controlbox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            
            % Create GCPDataDropDownLabel
            app.GCPDataDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.GCPDataDropDownLabel.HorizontalAlignment = 'left';
            app.GCPDataDropDownLabel.FontName = 'Ubuntu';
            app.GCPDataDropDownLabel.FontColor = [0.149 0.149 0.149];
            app.GCPDataDropDownLabel.Position = [335 446 140 22];
            app.GCPDataDropDownLabel.Text = '';
            app.ControlHandles(i,15) = app.GCPDataDropDownLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,15));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.GCPDataDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.GCPDataDropDownLabel.HorizontalAlignment = 'left';
            app.GCPDataDropDownLabel.FontName = 'Ubuntu';
            app.GCPDataDropDownLabel.FontColor = [0.149 0.149 0.149];
            app.GCPDataDropDownLabel.Position = [335 446 140 22];
            app.GCPDataDropDownLabel.Text = '    GCP Data';
            
            % Create GCPDataDropDown
            app.GCPDataDropDown = uidropdown(app.KLTIV_UIFigure);
            app.GCPDataDropDown.Items = {'Make a selection:', 'Inputted manually', 'From .csv file', 'Select from image'};
            app.GCPDataDropDown.ValueChangedFcn = createCallbackFcn(app, @GCPDataDropDownValueChanged, true);
            app.GCPDataDropDown.FontName = 'Roboto';
            app.GCPDataDropDown.FontColor = [0.149 0.149 0.149];
            app.GCPDataDropDown.Position = [485 446 140 22];
            app.GCPDataDropDown.Value = 'Make a selection:';
            
            % Create CheckGCPsSwitchLabel
            app.CheckGCPsSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.CheckGCPsSwitchLabel.HorizontalAlignment = 'left';
            app.CheckGCPsSwitchLabel.FontName = 'Ubuntu';
            app.CheckGCPsSwitchLabel.Position = [335 414 140 22];
            app.CheckGCPsSwitchLabel.Text = '';
            app.ControlHandles(i,16) = app.CheckGCPsSwitchLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,16));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.CheckGCPsSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.CheckGCPsSwitchLabel.HorizontalAlignment = 'left';
            app.CheckGCPsSwitchLabel.FontName = 'Ubuntu';
            app.CheckGCPsSwitchLabel.Position = [335 414 140 22];
            app.CheckGCPsSwitchLabel.Text = '    Check GCPs';
            
            % Create CheckGCPsSwitch
            app.CheckGCPsSwitch = uiswitch(app.KLTIV_UIFigure, 'slider');
            app.CheckGCPsSwitch.ValueChangedFcn = createCallbackFcn(app, @CheckGCPsSwitchValueChanged, true);
            app.CheckGCPsSwitch.FontName = 'Roboto';
            app.CheckGCPsSwitch.Position = [535 413 140 22];
            
            % Create ExportGCPdataSwitchLabel
            app.ExportGCPdataSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.ExportGCPdataSwitchLabel.FontName = 'Ubuntu';
            app.ExportGCPdataSwitchLabel.Position = [335 381 140 22];
            app.ExportGCPdataSwitchLabel.Text = '';
            app.ControlHandles(i,25) = app.ExportGCPdataSwitchLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,25));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements';
            app.ExportGCPdataSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.ExportGCPdataSwitchLabel.FontName = 'Ubuntu';
            app.ExportGCPdataSwitchLabel.Position = [335 381 140 22];
            app.ExportGCPdataSwitchLabel.Text = '    Export GCPs?';
            
            % Create ExportGCPdataSwitch
            app.ExportGCPdataSwitch = uiswitch(app.KLTIV_UIFigure, 'slider');
            app.ExportGCPdataSwitch.FontName = 'Roboto';
            app.ExportGCPdataSwitch.Position = [535 381 140 22];
            
            % Create UITable
            app.UITable = uitable(app.KLTIV_UIFigure);
            app.UITable.ColumnName = {'X [meters]'; 'Y [meters]'; 'Z [meters]'; 'X [px]'; 'Y [px]'};
            app.UITable.RowName = {};
            app.UITable.ColumnEditable = [true true true false false];
            app.UITable.CellSelectionCallback = createCallbackFcn(app, @UITableCellSelection, true);
            app.UITable.ForegroundColor = [0.149 0.149 0.149];
            app.UITable.FontName = 'Roboto';
            app.UITable.Position = [335 153 290 219];
            
            % Create BufferaroundGCPsmetersEditFieldLabel
            app.BufferaroundGCPsmetersEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.BufferaroundGCPsmetersEditFieldLabel.HorizontalAlignment = 'left';
            app.BufferaroundGCPsmetersEditFieldLabel.FontName = 'Ubuntu';
            app.BufferaroundGCPsmetersEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.BufferaroundGCPsmetersEditFieldLabel.Position = [335 120 140 22];
            app.BufferaroundGCPsmetersEditFieldLabel.Text = '';
            app.ControlHandles(i,19) = app.BufferaroundGCPsmetersEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,19));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.BufferaroundGCPsmetersEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.BufferaroundGCPsmetersEditFieldLabel.HorizontalAlignment = 'left';
            app.BufferaroundGCPsmetersEditFieldLabel.FontName = 'Ubuntu';
            app.BufferaroundGCPsmetersEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.BufferaroundGCPsmetersEditFieldLabel.Position = [335 120 140 22];
            app.BufferaroundGCPsmetersEditFieldLabel.Text = '    GCP buffer (m)';
            
            % Create BufferaroundGCPsmetersEditField
            app.BufferaroundGCPsmetersEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.BufferaroundGCPsmetersEditField.FontName = 'Roboto';
            app.BufferaroundGCPsmetersEditField.FontColor = [0.149 0.149 0.149];
            app.BufferaroundGCPsmetersEditField.Position = [485 120 140 22];
            app.BufferaroundGCPsmetersEditField.Value = 10;
            
            % Create CustomFOVEditFieldLabel_2
            app.CustomFOVEditFieldLabel_2 = uilabel(app.KLTIV_UIFigure);
            app.CustomFOVEditFieldLabel_2.HorizontalAlignment = 'left';
            app.CustomFOVEditFieldLabel_2.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditFieldLabel_2.Position = [335 77 140 22];
            app.CustomFOVEditFieldLabel_2.Text = '';
            app.ControlHandles(i,20) = app.CustomFOVEditFieldLabel_2;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,20));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.CustomFOVEditFieldLabel_2 = uilabel(app.KLTIV_UIFigure);
            app.CustomFOVEditFieldLabel_2.HorizontalAlignment = 'left';
            app.CustomFOVEditFieldLabel_2.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditFieldLabel_2.Position = [335 77 140 22];
            app.CustomFOVEditFieldLabel_2.Text = '    Custom FOV:';
            
            % Create CustomFOVEditField_2
            app.CustomFOVEditField_2 = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.CustomFOVEditField_2.FontName = 'Roboto';
            app.CustomFOVEditField_2.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditField_2.Position = [526 96 27 22];
            
            % Create CustomFOVEditField_3
            app.CustomFOVEditField_3 = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.CustomFOVEditField_3.FontName = 'Roboto';
            app.CustomFOVEditField_3.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditField_3.Position = [598 96 27 22];
            
            % Create CustomFOVEditField_4
            app.CustomFOVEditField_4 = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.CustomFOVEditField_4.FontName = 'Roboto';
            app.CustomFOVEditField_4.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditField_4.Position = [526 63 27 22];
            
            % Create CustomFOVEditField_5
            app.CustomFOVEditField_5 = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.CustomFOVEditField_5.FontName = 'Roboto';
            app.CustomFOVEditField_5.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditField_5.Position = [598 63 27 22];
            
            % Create CustomFOVEditFieldLabel_3
            app.CustomFOVEditFieldLabel_3 = uilabel(app.KLTIV_UIFigure);
            app.CustomFOVEditFieldLabel_3.HorizontalAlignment = 'left';
            app.CustomFOVEditFieldLabel_3.FontName = 'Roboto';
            app.CustomFOVEditFieldLabel_3.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditFieldLabel_3.Position = [488 96 36 22];
            app.CustomFOVEditFieldLabel_3.Text = 'X min';
            
            % Create CustomFOVEditFieldLabel_4
            app.CustomFOVEditFieldLabel_4 = uilabel(app.KLTIV_UIFigure);
            app.CustomFOVEditFieldLabel_4.HorizontalAlignment = 'left';
            app.CustomFOVEditFieldLabel_4.FontName = 'Roboto';
            app.CustomFOVEditFieldLabel_4.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditFieldLabel_4.Position = [488 63 36 22];
            app.CustomFOVEditFieldLabel_4.Text = 'X max';
            
            % Create CustomFOVEditFieldLabel_6
            app.CustomFOVEditFieldLabel_6 = uilabel(app.KLTIV_UIFigure);
            app.CustomFOVEditFieldLabel_6.HorizontalAlignment = 'left';
            app.CustomFOVEditFieldLabel_6.FontName = 'Roboto';
            app.CustomFOVEditFieldLabel_6.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditFieldLabel_6.Position = [563 96 36 22];
            app.CustomFOVEditFieldLabel_6.Text = 'Y min';
            
            % Create CustomFOVEditFieldLabel_7
            app.CustomFOVEditFieldLabel_7 = uilabel(app.KLTIV_UIFigure);
            app.CustomFOVEditFieldLabel_7.HorizontalAlignment = 'left';
            app.CustomFOVEditFieldLabel_7.FontName = 'Roboto';
            app.CustomFOVEditFieldLabel_7.FontColor = [0.149 0.149 0.149];
            app.CustomFOVEditFieldLabel_7.Position = [563 63 36 22];
            app.CustomFOVEditFieldLabel_7.Text = 'Y max';
            
            % Create WatersurfaceelevationmEditField
            app.WatersurfaceelevationmEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.WatersurfaceelevationmEditField.FontName = 'Roboto';
            app.WatersurfaceelevationmEditField.FontColor = [0.149 0.149 0.149];
            app.WatersurfaceelevationmEditField.Position = [485 30 140 22];
            app.WatersurfaceelevationmEditField.Value = 0;
            
            % Create WatersurfaceelevationmEditFieldLabel
            app.WatersurfaceelevationmEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.WatersurfaceelevationmEditFieldLabel.HorizontalAlignment = 'left';
            app.WatersurfaceelevationmEditFieldLabel.FontName = 'Ubuntu';
            app.WatersurfaceelevationmEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.WatersurfaceelevationmEditFieldLabel.Position = [335 30 140 22];
            app.WatersurfaceelevationmEditFieldLabel.Text = '';
            app.ControlHandles(i,21) = app.WatersurfaceelevationmEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,21));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.WatersurfaceelevationmEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.WatersurfaceelevationmEditFieldLabel.HorizontalAlignment = 'left';
            app.WatersurfaceelevationmEditFieldLabel.FontName = 'Ubuntu';
            app.WatersurfaceelevationmEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.WatersurfaceelevationmEditFieldLabel.Position = [335 30 140 22];
            app.WatersurfaceelevationmEditFieldLabel.Text = '    WSE (m)';
            
            %  Create AddLevel Button -- this is minimised unless multiple
            %  videos are being analysed
            app.AddLevelButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.AddLevelButton.ButtonPushedFcn = createCallbackFcn(app, @AddLevelButtonPushed, true);
            app.AddLevelButton.Position = [485 30 140 22];
            app.AddLevelButton.Text = 'Click here';
            app.AddLevelButton.FontName = 'Ubuntu';
            app.ControlHandles(1,55) = app.AddLevelButton;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(1,55));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox2');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.AddLevelButton.VerticalAlignment = 'center';
            app.AddLevelButton.HorizontalAlignment = 'center';
            app.AddLevelButton.Enable = 'off';
            app.AddLevelButton.Visible = 'Off';
            
            % Create box no.4
            app.ControlHandles(i,23) = uipanel(app.scrollPane);
            app.ControlHandles(i,23).AutoResizeChildren = 'off';
            app.ControlHandles(i,23).Position = [650 152 305 376];
            app.ControlHandles(i,23).BorderType = 'none';
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,23));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'controlbox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            
            % Create AnalysisLabel
            app.AnalysisLabel = uilabel(app.KLTIV_UIFigure);
            app.AnalysisLabel.FontName = 'Ubuntu';
            app.AnalysisLabel.FontSize = 26;
            app.AnalysisLabel.Position = [730 482 240 34];
            app.AnalysisLabel.Text = '(4) Analysis';
            
            % Create output directory text
            app.OutputDirectoryButtonText = uilabel(app.KLTIV_UIFigure);
            app.OutputDirectoryButtonText.Text = '';
            app.OutputDirectoryButtonText.FontName = 'Ubuntu';
            app.OutputDirectoryButtonText.FontColor = [0.149 0.149 0.149];
            app.OutputDirectoryButtonText.Position = [655 446 140 22];
            app.ControlHandles(i,24) = app.OutputDirectoryButtonText;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,24));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements';
            app.OutputDirectoryButtonText = uilabel(app.KLTIV_UIFigure);
            app.OutputDirectoryButtonText.Text = '    Output Location';
            app.OutputDirectoryButtonText.FontName = 'Ubuntu';
            app.OutputDirectoryButtonText.FontColor = [0.149 0.149 0.149];
            app.OutputDirectoryButtonText.Position = [655 446 140 22];
            
            % Create OutputDirectoryButton
            app.OutputDirectoryButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.OutputDirectoryButton.ButtonPushedFcn = createCallbackFcn(app, @OutputDirectoryButtonPushed, true);
            app.OutputDirectoryButton.FontName = 'Roboto';
            app.OutputDirectoryButton.Position = [805 446 140 22];
            app.OutputDirectoryButton.Text = 'Click here';
            
            % Create ROI text
            app.roiButtonText = uilabel(app.KLTIV_UIFigure);
            app.roiButtonText.Text = '';
            app.roiButtonText.FontName = 'Ubuntu';
            app.roiButtonText.FontColor = [0.149 0.149 0.149];
            app.roiButtonText.Position = [655 414 140 22];
            app.ControlHandles(i,37) = app.roiButtonText;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,37));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements';
            app.OutputDirectoryButtonText = uilabel(app.KLTIV_UIFigure);
            app.OutputDirectoryButtonText.Text = '    Define ROI';
            app.OutputDirectoryButtonText.FontName = 'Ubuntu';
            app.OutputDirectoryButtonText.FontColor = [0.149 0.149 0.149];
            app.OutputDirectoryButtonText.Position = [655 414 140 22];
            
            % Create ROI Button
            app.roiButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.roiButton.ButtonPushedFcn = createCallbackFcn(app, @roiButtonPushed, true);
            app.roiButton.FontName = 'Roboto';
            app.roiButton.Position = [805 414 140 22];
            app.roiButton.Text = 'Click here';
            
            % Create ExporttrajectoriesSwitchLabel
            app.ExporttrajectoriesSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.ExporttrajectoriesSwitchLabel.FontName = 'Ubuntu';
            app.ExporttrajectoriesSwitchLabel.Position = [655 382 140 22];
            app.ExporttrajectoriesSwitchLabel.Text = '';
            app.ControlHandles(i,26) = app.ExporttrajectoriesSwitchLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,26));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements';
            app.ExporttrajectoriesSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.ExporttrajectoriesSwitchLabel.FontName = 'Ubuntu';
            app.ExporttrajectoriesSwitchLabel.Position = [655 382 140 22];
            app.ExporttrajectoriesSwitchLabel.Text = '    Export Velocity?';
            
            % Create ExporttrajectoriesSwitch
            app.ExporttrajectoriesSwitch = uiswitch(app.KLTIV_UIFigure, 'slider');
            app.ExporttrajectoriesSwitch.FontName = 'Roboto';
            app.ExporttrajectoriesSwitch.Position = [850 382 140 22];
            
            % Create OrthophotosSwitchLabel
            app.OrthophotosSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.OrthophotosSwitchLabel.FontName = 'Ubuntu';
            app.OrthophotosSwitchLabel.Position = [655 350 140 22];
            app.OrthophotosSwitchLabel.Text = '';
            app.ControlHandles(i,27) = app.OrthophotosSwitchLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,27));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements';
            app.OrthophotosSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.OrthophotosSwitchLabel.FontName = 'Ubuntu';
            app.OrthophotosSwitchLabel.Position = [655 350 140 22];
            app.OrthophotosSwitchLabel.Text = '    Orthophotos?';
            
            % Create OrthophotosSwitch
            app.OrthophotosSwitch = uiswitch(app.KLTIV_UIFigure, 'slider');
            app.OrthophotosSwitch.FontName = 'Roboto';
            app.OrthophotosSwitch.Position = [850 350 140 22];
            
            % Create ResolutionmpxEditFieldLabel
            app.ResolutionmpxEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.ResolutionmpxEditFieldLabel.HorizontalAlignment = 'left';
            app.ResolutionmpxEditFieldLabel.FontName = 'Ubuntu';
            app.ResolutionmpxEditFieldLabel.Position = [655 318 140 22];
            app.ResolutionmpxEditFieldLabel.Text = '';
            app.ControlHandles(i,28) = app.ResolutionmpxEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,28));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements';
            app.ResolutionmpxEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.ResolutionmpxEditFieldLabel.HorizontalAlignment = 'left';
            app.ResolutionmpxEditFieldLabel.FontName = 'Ubuntu';
            app.ResolutionmpxEditFieldLabel.Position = [655 318 140 22];
            app.ResolutionmpxEditFieldLabel.Text = '    Resolution (m/px)';
            
            % Create ResolutionmpxEditField
            app.ResolutionmpxEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.ResolutionmpxEditField.FontName = 'Roboto';
            app.ResolutionmpxEditField.Position = [805 318 140 22];
            app.ResolutionmpxEditField.Value = 0.01;
            
            % Create FlightPathPlotSwitchLabel
            app.FlightPathPlotSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.FlightPathPlotSwitchLabel.HorizontalAlignment = 'left';
            app.FlightPathPlotSwitchLabel.FontName = 'Ubuntu';
            app.FlightPathPlotSwitchLabel.Position = [655 286 140 22];
            app.FlightPathPlotSwitchLabel.Text = '';
            app.ControlHandles(i,29) = app.FlightPathPlotSwitchLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,29));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements';
            app.FlightPathPlotSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.FlightPathPlotSwitchLabel.HorizontalAlignment = 'left';
            app.FlightPathPlotSwitchLabel.FontName = 'Ubuntu';
            app.FlightPathPlotSwitchLabel.Position = [655 286 140 22];
            app.FlightPathPlotSwitchLabel.Text = '    Plot Movement?';
            
            % Create FlightPathPlotSwitch
            app.FlightPathPlotSwitch = uiswitch(app.KLTIV_UIFigure, 'slider');
            app.FlightPathPlotSwitch.FontName = 'Roboto';
            app.FlightPathPlotSwitch.Position = [850 286 140 22];
            
            % Create TrajectoriesPlotSwitchLabel
            app.TrajectoriesPlotSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.TrajectoriesPlotSwitchLabel.HorizontalAlignment = 'left';
            app.TrajectoriesPlotSwitchLabel.FontName = 'Ubuntu';
            app.TrajectoriesPlotSwitchLabel.Position = [655 254 140 22];
            app.TrajectoriesPlotSwitchLabel.Text = '';
            app.ControlHandles(i,30) = app.TrajectoriesPlotSwitchLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,30));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements
            app.TrajectoriesPlotSwitchLabel = uilabel(app.KLTIV_UIFigure);
            app.TrajectoriesPlotSwitchLabel.HorizontalAlignment = 'left';
            app.TrajectoriesPlotSwitchLabel.FontName = 'Ubuntu';
            app.TrajectoriesPlotSwitchLabel.Position = [655 254 140 22];
            app.TrajectoriesPlotSwitchLabel.Text = '    Plot Velocity?';
            
            % Create TrajectoriesPlotSwitch
            app.TrajectoriesPlotSwitch = uiswitch(app.KLTIV_UIFigure, 'slider');
            app.TrajectoriesPlotSwitch.FontName = 'Roboto';
            app.TrajectoriesPlotSwitch.Position = [850 254 140 22];
            
            % Create ExportDefaultValues Label
            app.ExportDefaultValuesLabel = uilabel(app.KLTIV_UIFigure);
            app.ExportDefaultValuesLabel.HorizontalAlignment = 'left';
            app.ExportDefaultValuesLabel.FontName = 'Ubuntu';
            app.ExportDefaultValuesLabel.Position = [655 222 140 22];
            app.ExportDefaultValuesLabel.Text = '';
            app.ControlHandles(i,35) = app.ExportDefaultValuesLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,35));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements
            app.ExportDefaultValuesLabel = uilabel(app.KLTIV_UIFigure);
            app.ExportDefaultValuesLabel.HorizontalAlignment = 'left';
            app.ExportDefaultValuesLabel.FontName = 'Ubuntu';
            app.ExportDefaultValuesLabel.Position = [655 222 140 22];
            app.ExportDefaultValuesLabel.Text = '    Export Settings';
            
            % Create ExportDefaultValuesButton
            app.ExportDefaultValuesButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.ExportDefaultValuesButton.ButtonPushedFcn = createCallbackFcn(app, @ExportDefaultValuesButtonPushed, true);
            app.ExportDefaultValuesButton.FontName = 'Roboto';
            app.ExportDefaultValuesButton.Position = [805 222 140 22];
            app.ExportDefaultValuesButton.Text = 'Click here';
            
            % Create ExportDefaultValues Label
            app.LoadDefaultValuesLabel = uilabel(app.KLTIV_UIFigure);
            app.LoadDefaultValuesLabel.HorizontalAlignment = 'left';
            app.LoadDefaultValuesLabel.FontName = 'Ubuntu';
            app.LoadDefaultValuesLabel.Position = [655 190 140 22];
            app.LoadDefaultValuesLabel.Text = '';
            app.ControlHandles(i,36) = app.LoadDefaultValuesLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,36));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements
            app.LoadDefaultValuesLabel = uilabel(app.KLTIV_UIFigure);
            app.LoadDefaultValuesLabel.HorizontalAlignment = 'left';
            app.LoadDefaultValuesLabel.FontName = 'Ubuntu';
            app.LoadDefaultValuesLabel.Position = [655 190 140 22];
            app.LoadDefaultValuesLabel.Text = '    Load Settings';
            
            % Create ExportDefaultValuesButton
            app.LoadDefaultValuesButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.LoadDefaultValuesButton.ButtonPushedFcn = createCallbackFcn(app, @LoadDefaultValuesButtonPushed, true);
            app.LoadDefaultValuesButton.FontName = 'Roboto';
            app.LoadDefaultValuesButton.Position = [805 190 140 22];
            app.LoadDefaultValuesButton.Text = 'Click here';
            
            % Create RUNButton
            app.RUNButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.RUNButton.ButtonPushedFcn = createCallbackFcn(app, @RUNButtonPushed, true);
            app.RUNButton.FontName = 'Ubuntu';
            app.RUNButton.FontColor = [0.149 0.149 0.149];
            app.RUNButton.Position = [655 158 290 22];
            app.RUNButton.Text = 'RUN';
            
            % Create box no.5
            app.ControlHandles(i,31) = uipanel(app.scrollPane);
            app.ControlHandles(i,31).AutoResizeChildren = 'off';
            app.ControlHandles(i,31).Position = [970 152 305 376];
            app.ControlHandles(i,31).BorderType = 'none';
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,31));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'controlbox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            
            % Create AnalysisLabel
            app.AnalysisLabel = uilabel(app.KLTIV_UIFigure);
            app.AnalysisLabel.FontName = 'Ubuntu';
            app.AnalysisLabel.FontSize = 26;
            app.AnalysisLabel.Position = [1045 482 240 34];
            app.AnalysisLabel.Text = '(5) Discharge';
            
            % Create CrossSectionDropDownLabel
            app.CrossSectionDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.CrossSectionDropDownLabel.HorizontalAlignment = 'left';
            app.CrossSectionDropDownLabel.FontName = 'Ubuntu';
            app.CrossSectionDropDownLabel.FontColor = [0.149 0.149 0.149];
            app.CrossSectionDropDownLabel.Position = [980 446 140 22];
            app.CrossSectionDropDownLabel.Text = '';
            app.ControlHandles(i,50) = app.CrossSectionDropDownLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,50));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.CrossSectionDropDownLabel = uilabel(app.KLTIV_UIFigure);
            app.CrossSectionDropDownLabel.HorizontalAlignment = 'left';
            app.CrossSectionDropDownLabel.FontName = 'Ubuntu';
            app.CrossSectionDropDownLabel.FontColor = [0.149 0.149 0.149];
            app.CrossSectionDropDownLabel.Position = [980 446 140 22];
            app.CrossSectionDropDownLabel.Text = '    Cross-section Input';
            
            % Create CrossSectionDropDown
            app.CrossSectionDropDown = uidropdown(app.KLTIV_UIFigure);
            app.CrossSectionDropDown.Items = {'Make a selection:', 'Referenced survey [m]', 'Relative distances [m]'};
            app.CrossSectionDropDown.ValueChangedFcn = createCallbackFcn(app, @CrossSectionDropDownValueChanged, true);
            app.CrossSectionDropDown.FontName = 'Roboto';
            app.CrossSectionDropDown.FontColor = [0.149 0.149 0.149];
            app.CrossSectionDropDown.Position = [1130 446 140 22];
            app.CrossSectionDropDown.Value = 'Make a selection:';
            
            % Create Reference height label
            app.ReferenceHeightLabel = uilabel(app.KLTIV_UIFigure);
            app.ReferenceHeightLabel.HorizontalAlignment = 'left';
            app.ReferenceHeightLabel.FontName = 'Ubuntu';
            app.ReferenceHeightLabel.FontColor = [0.149 0.149 0.149];
            app.ReferenceHeightLabel.Position = [980 414 140 22];
            app.ReferenceHeightLabel.Text = '';
            app.ControlHandles(i,51) = app.ReferenceHeightLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,51));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM element
            app.ReferenceHeightLabel = uilabel(app.KLTIV_UIFigure);
            app.ReferenceHeightLabel.HorizontalAlignment = 'left';
            app.ReferenceHeightLabel.FontName = 'Ubuntu';
            app.ReferenceHeightLabel.FontColor = [0.149 0.149 0.149];
            app.ReferenceHeightLabel.Position = [980 414 140 22];
            app.ReferenceHeightLabel.Text = '    Reference Height';
            
            % Create Reference height settings
            app.ReferenceHeight = uidropdown(app.KLTIV_UIFigure);
            app.ReferenceHeight.Items = {'Make a selection:', 'True bed elevation [m]', 'Water depth [m]'};
            %app.ReferenceHeight.ValueChangedFcn = createCallbackFcn(app, @ReferenceHeightValueChanged, true);
            app.ReferenceHeight.FontName = 'Roboto';
            app.ReferenceHeight.FontColor = [0.149 0.149 0.149];
            app.ReferenceHeight.Position = [1130 414 140 22];
            app.ReferenceHeight.Value = 'Make a selection:';
            
            % Create UITable2
            app.UITable2 = uitable(app.KLTIV_UIFigure);
            app.UITable2.ColumnName = {'Chainage'; 'Elevation'};
            app.UITable2.RowName = {};
            app.UITable2.CellEditCallback = createCallbackFcn(app, @editCel2, true);
            app.UITable2.FontName = 'Roboto';
            app.UITable2.Position = [980 282 290 123];
            
            % Create SearchDistanceEditFieldLabel
            app.SearchDistanceEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.SearchDistanceEditFieldLabel.HorizontalAlignment = 'left';
            app.SearchDistanceEditFieldLabel.FontName = 'Ubuntu';
            app.SearchDistanceEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.SearchDistanceEditFieldLabel.Position = [980 254 140 22];
            app.SearchDistanceEditFieldLabel.Text = '';
            app.ControlHandles(i,33) = app.SearchDistanceEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,33));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements
            app.SearchDistanceEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.SearchDistanceEditFieldLabel.HorizontalAlignment = 'left';
            app.SearchDistanceEditFieldLabel.FontName = 'Ubuntu';
            app.SearchDistanceEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.SearchDistanceEditFieldLabel.Position = [980 254 140 22];
            app.SearchDistanceEditFieldLabel.Text = '    Search Distance (m)';
            
            % Create SearchDistanceEditField
            app.SearchDistanceEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.SearchDistanceEditField.FontName = 'Roboto';
            app.SearchDistanceEditField.FontColor = [0.149 0.149 0.149];
            app.SearchDistanceEditField.Position = [1130 254 140 22];
            app.SearchDistanceEditField.Value = 0.5;
            
            % Create Interpoation method
            app.InterpolationMethodLabel = uilabel(app.KLTIV_UIFigure);
            app.InterpolationMethodLabel.HorizontalAlignment = 'left';
            app.InterpolationMethodLabel.FontName = 'Ubuntu';
            app.InterpolationMethodLabel.FontColor = [0.149 0.149 0.149];
            app.InterpolationMethodLabel.Position = [980 222 140 22];
            app.InterpolationMethodLabel.Text = '';
            app.ControlHandles(i,52) = app.InterpolationMethodLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,52));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements
            app.InterpolationMethodLabel = uilabel(app.KLTIV_UIFigure);
            app.InterpolationMethodLabel.HorizontalAlignment = 'left';
            app.InterpolationMethodLabel.FontName = 'Ubuntu';
            app.InterpolationMethodLabel.FontColor = [0.149 0.149 0.149];
            app.InterpolationMethodLabel.Position = [980 222 140 22];
            app.InterpolationMethodLabel.Text = '    Interpolation method';
            
            % Create InterpolationMethod field
            app.InterpolationMethod = uidropdown(app.KLTIV_UIFigure);
            app.InterpolationMethod.Items = {'Make a selection:', 'Quadratic Polynomial', 'Cubic Polynomial', 'Constant Froude' };
            app.InterpolationMethod.FontName = 'Roboto';
            app.InterpolationMethod.FontColor = [0.149 0.149 0.149];
            app.InterpolationMethod.Position = [1130 222 140 22];
            app.InterpolationMethod.Value = 'Make a selection:';
            
            % Create alphaEditFieldLabel
            app.alphaEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.alphaEditFieldLabel.HorizontalAlignment = 'left';
            app.alphaEditFieldLabel.FontName = 'Ubuntu';
            app.alphaEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.alphaEditFieldLabel.Position = [980 190 140 22];
            app.alphaEditFieldLabel.Text = '';
            app.ControlHandles(i,34) = app.alphaEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,34));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements
            app.alphaEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.alphaEditFieldLabel.HorizontalAlignment = 'left';
            app.alphaEditFieldLabel.FontName = 'Ubuntu';
            app.alphaEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.alphaEditFieldLabel.Position = [980 190 140 22];
            app.alphaEditFieldLabel.Text = '    Alpha';
            
            % Create alphaEditField
            app.alphaEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.alphaEditField.FontName = 'Roboto';
            app.alphaEditField.FontColor = [0.149 0.149 0.149];
            app.alphaEditField.Position = [1130 190 140 22];
            app.alphaEditField.Value = 0.85;
            
            % Create CALCULATEButton
            app.CALCULATEButton = uibutton(app.KLTIV_UIFigure, 'push');
            app.CALCULATEButton.ButtonPushedFcn = createCallbackFcn(app, @CALCULATEButtonPushed, true);
            app.CALCULATEButton.FontName = 'Ubuntu';
            app.CALCULATEButton.FontColor = [0.149 0.149 0.149];
            app.CALCULATEButton.Position = [980 162 290 22];
            app.CALCULATEButton.Text = 'CALCULATE';
            
            % Create ListBox
            app.ListBox = uilistbox(app.KLTIV_UIFigure);
            %app.ListBox.Items = {''};
            for x=1:1000 % create an empty listbox
                app.ListBox.Items(x) = {['']};
            end
            app.ListBox.Enable = 'on';
            app.ListBox.Position = [650 15 625 132];
            app.ListBox.FontName = 'Roboto';
            app.ListBox.Value = '';
            
        end
    end
    
    methods (Access = public)
        
        % Construct app
        function app = KLT
            
            % Create and configure components
            createComponents(app)
            
            % Register the app with App Designer
            registerApp(app, app.KLTIV_UIFigure)
            
            % Execute the startup function
            runStartupFcn(app, @startupFcn)
            
            if nargout == 0
                clear app
            end
        end
        
        % Code that executes before app deletion
        function delete(app)
            delete(app.KLTIV_UIFigure) % Delete UIFigure when app is deleted
        end
    end
end