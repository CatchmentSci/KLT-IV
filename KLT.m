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
        CellNumberEditFieldLabel    matlab.ui.control.Label
        CellNumberEditField         matlab.ui.control.NumericEditField
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
        GCPbuffer_modifyBox
        CustomFOV_modifyBox
        startingAppVals
    end
    
    
    methods (Access = private)
        
        % Code that executes after component creation
        function startupFcn(app)
            %saveState(app)
        end
        
        
        % Button pushed function: RUNButton
        function RUNButtonPushed(app, ~)
            
            switch app.OrientationDropDown.Value
                case 'Make a selection:'
                    
                    % Update the dialog box
                    TextIn             = {'No Orientation was selected. Please select a value and retry.'};
                    TimeIn             = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn             = strjoin(TimeIn, ' ');
                    app.ListBox.Items  = [app.ListBox.Items, TimeIn, TextIn'];
                    msg                = 'Error occurred.';
                    KLT_printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    error(msg)
                
            end
            
            
            % only run if the settings haven't been reloaded
            if isempty(app.reloaded)
                app.GCPDataDropDown.Value   =  'Make a selection:';
                app.subSample               = [];
                app.videoNumber             = [];
                app.s2                      = [];
                app.directory_save_multiple = [];
                app.QfileOut                = [];
                app.startingVideo           = 1;
                app.starterInd              = 1;
                set(app.RUNButton,'Text',{['Processing, please wait.']});
                KLT_customFOV(app)
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
                            KLT_customFOV(app)
                        end
                        KLT_imageAnalysis(app)
                        KLT_flightPath(app)
                        KLT_vectorRotation(app)
                        KLT_exportVelocity(app)
                        KLT_trajectories(app)
                        KLT_CALCULATEButtonPushed(app)
                        KLT_appendQoutputs(app)
                        set(app.RUNButton,'Text',strjoin({'Processing: ' int2str((app.videoNumber-1)/length(app.fileNameAnalysis)*100) '% Complete'},''));
                        TextIn = {['Discharge computed for video ', int2str(app.videoNumber), ' of ', num2str(length(app.fileNameAnalysis))]};
                        app.ListBox.Items = [app.ListBox.Items, TextIn'];
                        KLT_printItems(app)
                        pause(0.01);
                        app.ListBox.scroll('bottom')
                        
                        if app.starterInd == 1
                            app.startingAppVals             = app; % create a copy of the settings
                            app.startingAppVals.uvHR        = [];
                            app.startingAppVals.visHR       = [];
                            app.startingAppVals.xyzA_final  = [];
                            app.startingAppVals.xyzB_final  = [];
                            app.startingAppVals.vel         = [];
                            app.startingAppVals.refValue    = [];
                            app.starterInd                  = app.starterInd + 1;
                            app.startingAppVals.objectFrameStacked = {};
                            app.startingAppVals.normalVelocity = [];
                        else
                            app.starterInd                  = app.starterInd + 1;
                        end
                        
                    catch
                        TextIn = {['Unable to process video ', char(app.fileNameAnalysis(app.videoNumber)) ' . Skipping this file.']};
                        app.ListBox.Items = [app.ListBox.Items, TextIn'];
                        KLT_printItems(app)
                        pause(0.01);
                        app.ListBox.scroll('bottom')
                    end
                    app.videoNumber = app.videoNumber + 1;
                    app.startingVideo = [0];
                else
                    app.videoNumber = app.videoNumber + 1;
                end
            end
            
            set(app.RUNButton,'Text','Processing: Complete');
            pause(0.01)
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == true
                KLT_imageAnalysis(app)
                KLT_flightPath(app)
                KLT_vectorRotation(app)
                KLT_exportVelocity(app)
                KLT_trajectories(app)
                set(app.RUNButton,'Text','Processing: Complete');
                pause(0.01)
            end
        end
        
        
        % If the ROI button is pushed
        function roiButtonPushed(app, event)
            if length(app.firstFrame) > 1
                [roiPoints] = KLT_readPoints(app.firstFrame,100,4,app,[])'; hold on;
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
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            else
                TextIn = {'No video selected, please try again'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                app.OutputDirectoryButton.Text = 'Click here';
            end
        end
        
        % Button pushed function: AddVideoButton
        function AddVideoButtonPushed(app, event)
            
            %app.VelocityDropDown.Value = 'Make a selection:';
            app.k1                    = [];
            app.s2                    = [];
            app.GCPfile               = [];
            app.GCPData               = [];
            app.masterImage           = [];
            app.firstOrthoImage       = [];
            app.GCPDataDropDown.Value = 'Make a selection:';
            set(app.RUNButton,'Text','RUN');
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == true
                if length(app.directory) < 2
                    % Create list of images inside the considered directory
                    [app.file, app.directory] = uigetfile('*');
                else
                    [app.file, app.directory] = uigetfile({'*' 'All Files'},'Select a file',app.directory);
                end
                
                if length(app.file) > 1
                    textOutput          = strjoin({app.directory, app.file}, '');
                    TextIn              = {'Single video file selected is:'; textOutput; ...
                                        'Please wait while it is loaded.'};
                    TimeIn              = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn              = strjoin(TimeIn, ' ');
                    app.ListBox.Items   = [app.ListBox.Items, TimeIn, TextIn'];
                    
                    KLT_printItems(app)
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
                    KLT_printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = textOutput;
                    app.AddVideoButton.VerticalAlignment = 'top';
                    
                else
                    TextIn = {'No video selected, please try again'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    KLT_printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = 'Click here';
                end
                
            elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                % Create list of images inside the considered directory
                app.directory = uigetdir;
                    
                if length(app.directory) > 1
                    
                    % Provide alternative templates for the year format +
                    % find the index of this from the user input xxxxxxyyyymmdd_HHMM
                    template = inputdlg('Provide the template of the filename inputs e.g. xxxxxxxxyyyymmdd_HHMM',...
                        'Provide the filename template', [1 60]);
                    
                    if length(cell2mat(strfind(template,'y'))) == 4
                        yearsFormat     = 'yyyy';
                        yearInIdx       = cell2mat(strfind(template,'y'));
                        
                    elseif length(cell2mat(strfind(template,'y'))) == 2
                        yearsFormat     = 'yy';
                        yearInIdx       = cell2mat(strfind(template,'y'));
                        preYear         = '20';
                    end
                    
                    monthInIdx          = cell2mat(strfind(template,'m'));
                    dateInIdx           = cell2mat(strfind(template,'d'));
                    hourInIdx           = cell2mat(strfind(template,'H'));
                    minuteInIdx         = cell2mat(strfind(template,'M'));
                    direc               = dir([app.directory,filesep]); app.videoDirFileNames={};
                    [app.videoDirFileNames{1:length(direc),1}] = deal(direc.name);
                    app.videoDirFileNames = sortrows(app.videoDirFileNames); %sort all image files
                    app.videoDirFileNames = app.videoDirFileNames(3:end);
                    
                    for a = 1:length(app.videoDirFileNames)
                        try
                            temp        = app.videoDirFileNames{a};
                            
                            if length(cell2mat(strfind(template,'y'))) == 4
                                yearIn  = temp(yearInIdx(1):yearInIdx(1)+3);
                                
                            elseif length(cell2mat(strfind(template,'y'))) == 2
                                yearIn  = {preYear, temp(yearInIdx(1):yearInIdx(1)+1)};
                            end
                            
                            monthIn     = temp(monthInIdx:monthInIdx+1);
                            dateIn      = temp(dateInIdx:dateInIdx+1);
                            hourIn      = temp(hourInIdx:hourInIdx+1);
                            minuteIn    = temp(minuteInIdx:minuteInIdx+1);
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
                    idxKeep                     = app.videoDatesFormattedNum > 0;
                    app.videoDatesFormattedNum  = app.videoDatesFormattedNum(idxKeep);
                    app.videoDirFileNames       = app.videoDirFileNames(idxKeep);
                    
                    TextIn = strjoin({num2str(length(app.videoDirFileNames)) ' videos selected for analysis'},'');
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    KLT_printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = 'Multiple selected';
                    app.AddVideoButton.VerticalAlignment = 'top';
                else
                    TextIn = {'No directory selected, please try again'};
                    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                    TimeIn = strjoin(TimeIn, ' ');
                    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                    KLT_printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    app.AddVideoButton.Text = 'Click here';
                end
                
            end
            
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == 1
                KLT_bringInImage(app); % Bring in the first image of the video
            else
                
                KLT_bringInImage(app)
                TextIn = {'Select the video to be used to generate/visualize GCP solutions'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
                [app.file,tempDir] = uigetfile({'*' 'All Files'},'Select the video to be used to generate/visualize GCP solutions',app.directory, 'MultiSelect', 'off');
                V=VideoReader([tempDir '\' app.file]);
                I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                app.firstFrame = I;
                app.imgsz = [V.Height V.Width];
                
                TextIn = {'Video successfully loaded'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
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
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            elseif strcmp(app.Platformvalue, 'Fixed installation') == 1
                TextIn = {'A fixed (non mobile) camera has been selected.'; 'GCPs are assumed to be static through the video.'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
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
                            (~isnan(app.UITable2.Data(a,1)) && ...         % second column (height) is numeric
                            ~isnan(app.UITable2.Data(a,2)) ))             % first column (chainage) is numeric
                        
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
            KLT_printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
        end % function
        
        % Value changed function: CheckGCPsSwitch
        function CheckGCPsSwitchValueChanged(app, event)
            % empty function
        end
        
        % Value changed function: IgnoreEdgesDropDown
        function IgnoreEdgesDropDownValueChanged(app, event)
            value = app.IgnoreEdgesDropDown.Value;
            if strcmp (app.IgnoreEdgesDropDown.Value, 'Yes') == 1
                TextIn = {'Ignore edges selected:'; 'The outer 10% of the images will not be used in the analysis'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            elseif strcmp (app.IgnoreEdgesDropDown.Value, 'No') == 1
                TextIn = {'Ignore edges not selected:'; 'The entirety of the image will be used in the analysis'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                KLT_printItems(app)
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
                KLT_printItems(app)
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
                KLT_printItems(app)
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
            KLT_printItems(app)
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
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom')
            catch
                TextIn = {'No videos were matched river level observations. Check inputs and retry.'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom')
            end
            
        end
        
       
        function ExportDefaultValuesButtonPushed(app, event)
            KLT_saveState(app)
        end
        
        function LoadDefaultValuesButtonPushed(app, event)
            KLT_loadState(app)
        end
    end
    
    % App initialization and construction
    methods (Access = private)
        
        KLT_createComponents(app);        
        
    end
    
    methods (Access = public)
        
        % Construct app
        function app = KLT
            
            try
                
                % Create and configure components
                createComponents(app)
                
                % Register the app with App Designer
                registerApp(app, app.KLTIV_UIFigure)
                
                % Execute the startup function
                runStartupFcn(app, @startupFcn)
                
            catch err
                
                KLT_errorCallback(app,err)
                
            end
            
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