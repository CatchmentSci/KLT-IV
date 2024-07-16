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
        CellNumberEditFieldLabel        matlab.ui.control.Label
        CellNumberEditField             matlab.ui.control.NumericEditField
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
        adjustedVel
        backgroundImage
        batchAnswer
        Blocksize
        boundaryLimitsM
        boundaryLimitsPx
        c
        camA
        camA_first
        cameraModelParameters
        Cameraxyz_modifyXbox
        Cameraxyz_modifyYbox
        Cameraxyz_modifyZbox
        clipped
        compiled_refVal
        CONTROLDIMS
        ControlHandles
        ControlsPanel
        CrossSectionDropDownValue
        currentFrame
        CustomFOV_modifyBox
        dem
        directory_ortho
        directory_save
        directory_save_multiple
        directory_stab
        directory2
        end1
        endXS
        estimater
        f
        file
        file2
        fileNameAnalysis
        firstFrame
        firstOrthoImage
        flexVars
        flexVarsComp
        frame_uas_x
        frame_uas_y
        frame_uas_z
        frameYprMatch
        gcpA
        gcpA_checked
        GCPbuffer_modifyBox
        GCPData
        GCPdims
        GCPdirectory
        GCPfile
        GCPimageReal
        imageGCPs
        imageResolution
        imgsz
        inframeHR
        InitialGCP
        iter
        k
        k1
        location
        magVelError
        masterImage
        masterImageX
        masterImageY
        maxVel
        minVel
        newPoints
        downstreamVelocity
        objectFrame
        objectFrameStacked
        OrientationValue
        p
        Platformvalue
        prepro
        previousFrame
        previousLoad
        pts
        QfileOut
        refValue
        reloaded
        requiredResolution
        rgbHR
        riverLevelAnalysis
        riverLevelTimeAnalysis
        rmse
        roiButton
        roiButtonText
        rollingGCPs
        s2
        s2_mod
        scrollPane
        start1
        starterInd
        startingAppVals
        startingVideo
        startXS
        subDir
        subSample
        surveyDirectory
        surveyFile
        surveyIn
        tangentialVelocity
        TempFileIn
        testInputX
        testInputY
        thresh
        totalQ
        Transdem
        transectLength
        transferclass
        transformDownstream
        transformTangential
        TransX
        TransY
        UAS_GPSdirectory
        UAS_GPSfile
        UAS_onboarddirectory
        UAS_onboardfile
        uvA_final
        uvB_final
        uvHR
        vel
        velMagnitude
        VelocityOutputs
        videoClip
        videoDatesFormatted
        videoDatesFormattedNum
        videoDirFileNames
        videoDuration
        videoFrameRate
        videoNumber
        videoStart
        visHR
        WEBWINDOW
        X
        xComponent
        xInder
        Xout
        xs
        XS_pts
        xsData
        xsdims
        xsdirectory
        xsfile
        xyzA_final
        xyzB_final
        Y
        yComponent
        yInder
        Yout
        directory
        init_track
        fin_track
        success_track
        init_track_px
        fin_track_px
        GCPdiff
        pre_pro_params
        filterAngle
        initialVel
        finalVel
        wse_map_out
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
                app.startingVideo           = 0; % added 20210315
                set(app.RUNButton,'Text',{'Processing, please wait.'});
                KLT_customFOV(app)
            end

            for a = 1:length(app.fileNameAnalysis)

                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true %&& isnan(app.totalQ(1,a)) % ensure no q data

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

                        z1 = -3; %set as zero to run the wse reconstruction or -3 to avoid
                        KLT_imageAnalysis(app,z1) 

                        if z1 == 0
                            wse_routine = 1;
                            i1 = -2:-1;
                        else
                             wse_routine = 0;
                             i1 = 0;
                        end

                        for z1 = i1
                            if i1 == 0
                                return
                            end
                            KLT_imageAnalysis(app,z1) %set as zero to run the wse reconstruction or -1 to avoid
                            KLT_flightPath(app)
                            KLT_vectorRotation(app,z1)
                            KLT_exportVelocity(app)
                            KLT_trajectories(app)
                            KLT_CALCULATEButtonPushed(app,z1)
                            KLT_appendQoutputs(app)
                            
                            % save the workspace
                            s = 2;
                            props = properties(app);
                            for ii=s:length(props)
                                try
                                    currentProperty = getfield(app, char(props(ii)));
                                    S{ii} = getfield(app,char(props(ii)));
                                    pause 0.1
                                catch
                                end
                            end

                            if z1 == -1
                                appender = '_wse';
                            else
                                appender = '';
                            end

                            % Save the files from the workspace to the hard drive
                           tempIn = char(app.fileNameAnalysis(a));
                           saving_name = (strcat([app.OutputDirectoryButton.Text '\workspace_' tempIn(1:end-4) appender '.mat']));
                           props2 = properties(app);
                           save(saving_name, 'S','props2','-v7.3');

                        end

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
                            app.startingAppVals.downstreamVelocity = [];
                        else
                            app.starterInd                  = app.starterInd + 1;
                        end

                    catch

                        if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1
                            app.compiled_refVal = num2cell(NaN);
                        else
                            app.compiled_refVal = [app.compiled_refVal; num2cell(NaN)];
                        end

                        TextIn = {['Unable to process video ', char(app.fileNameAnalysis(app.videoNumber)) ' . Skipping this file.']};
                        app.ListBox.Items = [app.ListBox.Items, TextIn'];
                        KLT_printItems(app)
                        pause(0.01);
                        app.ListBox.scroll('bottom')
                    end
                    app.videoNumber = app.videoNumber + 1;
                    app.startingVideo = [0];

                elseif strcmp (app.ProcessingModeDropDown.Value, 'Numerical Simulation') == true %&& isnan(app.totalQ(1,a)) % ensure no q data

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

                        if strcmp (app.ProcessingModeDropDown.Value, 'Numerical Simulation') == false
                            TextIn = {['Discharge computed for video ', int2str(app.videoNumber), ' of ', num2str(length(app.fileNameAnalysis))]};
                        else
                            TextIn = {['Numerical analysis completed for video ', int2str(app.videoNumber), ' of ', num2str(length(app.fileNameAnalysis))]};
                        end

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
                            app.startingAppVals.downstreamVelocity = [];
                        else
                            app.starterInd                  = app.starterInd + 1;
                        end

                    catch

                        if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1
                            app.compiled_refVal = num2cell(NaN);
                        else
                            app.compiled_refVal = [app.compiled_refVal; num2cell(NaN)];
                        end

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
                KLT_imageAnalysis(app,-3)
                KLT_flightPath(app)
                KLT_vectorRotation(app,-3)
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


            elseif strcmp (app.ProcessingModeDropDown.Value, 'Numerical Simulation') == true % Create list of images inside the considered directory
                app.directory = uigetdir;

                if length(app.directory) > 1

                    direc               = dir([app.directory,filesep]); app.videoDirFileNames={};
                    [app.videoDirFileNames{1:length(direc),1}] = deal(direc.name);
                    app.videoDirFileNames = sortrows(app.videoDirFileNames); %sort all image files
                    app.videoDirFileNames = app.videoDirFileNames(3:end);
                    app.fileNameAnalysis  = app.videoDirFileNames; % no matching required

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

                % rollback for newer versions of Matlab 20220122
                try
                    I   = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                catch
                    I   = rgb2gray(readFrame(V));
                end

                app.objectFrame = rgb2gray(readFrame(V));
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

        function ProcessingModeDropDownValueChanged(app, ~)
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == 1
                app.OrientationDropDown.Items = {'Make a selection:', 'Stationary: Nadir', 'Stationary: GCPs','Dynamic: GCPs', 'Dynamic: GCPs + Stabilisation', 'Dynamic: Stabilisation',  'Dynamic: GPS + IMU', 'Planet [beta]'}
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
                app.OrientationDropDown.Enable = true;
                app.CrossSectionDropDown.Enable = true;
                app.ReferenceHeight.Enable = true;
                app.yawpitchrollEditField.Enable = 'on';
                app.yawpitchrollEditField_2.Enable = 'on';
                app.yawpitchrollEditField_3.Enable = 'on';
                app.CameraxyzEditField.Enable = 'on';
                app.CameraxyzEditField_2.Enable = 'on';
                app.CameraxyzEditField_3.Enable = 'on';
                app.CameraTypeDropDown.Enable = true;
                app.Cameraxyz_modifyXbox.Enable = 'on';
                app.Cameraxyz_modifyYbox.Enable = 'on';
                app.Cameraxyz_modifyZbox.Enable = 'on';
                app.IgnoreEdgesDropDown.Enable = 'on';
                app.GCPDataDropDown.Enable = 'on';
                app.CheckGCPsSwitch.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.GCPbuffer_modifyBox.Value = 1;
                app.BufferaroundGCPsmetersEditField.Enable = 'on';
                app.ResolutionmpxEditField.Enable = 'on';
                app.CustomFOVEditField_2.Enable = 'on';
                app.CustomFOVEditField_3.Enable = 'on';
                app.CustomFOVEditField_4.Enable = 'on';
                app.CustomFOVEditField_5.Enable = 'on';
                app.CellNumberEditField.Enable = 'off';
                app.InterpolationMethod.Enable = 'on';
                app.alphaEditField.Enable = 'on';
                app.GCPbuffer_modifyBox.Enable = 'on';
                app.CustomFOV_modifyBox.Enable = 'on';
                app.OrthophotosSwitch.Enable = 'on';
                app.ExporttrajectoriesSwitch.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'on';
                app.TrajectoriesPlotSwitch.Enable = 'on';


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
                app.roiButton.Enable = 'on';
                app.ExportDefaultValuesButton.Enable = 'off';
                app.LoadDefaultValuesButton.Enable = 'off';

                app.CALCULATEButton.Position = [655 158 290 22]; % switched with RUN
                app.CALCULATEButton.Enable = 'off';
                app.CALCULATEButton.Visible = 'off';
                app.RUNButton.Position = [980 162 290 22];
                app.RUNButton.Enable = 'on';
                app.RUNButton.Visible = 'On';
                app.OrientationDropDown.Enable = true;
                app.CrossSectionDropDown.Enable = true;
                app.ReferenceHeight.Enable = true;
                app.yawpitchrollEditField.Enable = 'on';
                app.yawpitchrollEditField_2.Enable = 'on';
                app.yawpitchrollEditField_3.Enable = 'on';
                app.CameraxyzEditField.Enable = 'on';
                app.CameraxyzEditField_2.Enable = 'on';
                app.CameraxyzEditField_3.Enable = 'on';
                app.CameraTypeDropDown.Enable = true;
                app.Cameraxyz_modifyXbox.Enable = 'on';
                app.Cameraxyz_modifyYbox.Enable = 'on';
                app.Cameraxyz_modifyZbox.Enable = 'on';
                app.IgnoreEdgesDropDown.Enable = 'on';
                app.GCPDataDropDown.Enable = 'on';
                app.CheckGCPsSwitch.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.GCPbuffer_modifyBox.Value = 1;
                app.BufferaroundGCPsmetersEditField.Enable = 'on';
                app.ResolutionmpxEditField.Enable = 'on';
                app.CustomFOVEditField_2.Enable = 'on';
                app.CustomFOVEditField_3.Enable = 'on';
                app.CustomFOVEditField_4.Enable = 'on';
                app.CustomFOVEditField_5.Enable = 'on';
                app.CellNumberEditField.Enable = 'on';
                app.InterpolationMethod.Enable = 'on';
                app.alphaEditField.Enable = 'on';
                app.GCPbuffer_modifyBox.Enable = 'on';
                app.CustomFOV_modifyBox.Enable = 'on';
                app.OrthophotosSwitch.Enable = 'on';
                app.ExporttrajectoriesSwitch.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.TrajectoriesPlotSwitch.Enable = 'on';


            elseif strcmp (app.ProcessingModeDropDown.Value, 'Numerical Simulation') == 1
                app.OrientationDropDown.Items = {'Make a selection:', 'Dynamic: Stabilisation'};
                app.OrientationDropDown.Value = 'Dynamic: Stabilisation'; % needs to be defined
                app.CameraTypeDropDown.Enable = false;
                app.OrientationDropDown.Enable = false;
                app.CameraxyzEditField.Enable = 'off';
                app.CameraxyzEditField_2.Enable = 'off';
                app.CameraxyzEditField_3.Enable = 'off';
                app.Cameraxyz_modifyXbox.Enable = 'off';
                app.Cameraxyz_modifyYbox.Enable = 'off';
                app.Cameraxyz_modifyZbox.Enable = 'off';
                app.yawpitchrollEditField.Enable = 'off';
                app.yawpitchrollEditField_2.Enable = 'off';
                app.yawpitchrollEditField_3.Enable = 'off';
                app.IgnoreEdgesDropDown.Enable = 'off';
                app.GCPDataDropDown.Enable = 'off';
                app.CheckGCPsSwitch.Enable = 'off';
                app.ExportGCPdataSwitch.Enable = 'off';
                app.GCPbuffer_modifyBox.Value = 0;
                app.BufferaroundGCPsmetersEditField.Enable = 'off';
                app.ResolutionmpxEditField.Enable = 'off';
                app.CustomFOVEditField_2.Enable = 'off';
                app.CustomFOVEditField_3.Enable = 'off';
                app.CustomFOVEditField_4.Enable = 'off';
                app.CustomFOVEditField_5.Enable = 'off';
                app.WatersurfaceelevationmEditField.Enable = 'off';
                app.WatersurfaceelevationmEditField.Visible = 'Off';
                app.CrossSectionDropDown.Enable = false;
                app.ReferenceHeight.Enable = false;
                app.CellNumberEditField.Enable = 'off';
                app.InterpolationMethod.Enable = 'off';
                app.alphaEditField.Enable = 'off';
                app.CALCULATEButton.Enable = 'off';
                app.CALCULATEButton.Visible = 'Off';
                app.GCPbuffer_modifyBox.Enable = 'off';
                app.CustomFOV_modifyBox.Enable = 'off';
                app.OrthophotosSwitch.Enable = 'off';
                app.ExporttrajectoriesSwitch.Enable = 'on';
                app.FlightPathPlotSwitch.Enable = 'off';
                app.TrajectoriesPlotSwitch.Enable = 'off';


                TextIn = {'Multiple video analysis mode selected'; 'Please click Define Video(s) and select the folder containing the videos to be analysed'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');

                app.CALCULATEButton.Position = [655 158 290 22]; % switched with RUN
                app.CALCULATEButton.Enable = 'off';
                app.CALCULATEButton.Visible = 'off';
                app.RUNButton.Position = [980 162 290 22];
                app.RUNButton.Enable = 'on';
                app.RUNButton.Visible = 'On';


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

        % Create UIFigure and components
        function createComponents(app)

            % Create KLTIV UIFigure
            app.KLTIV_UIFigure = uifigure;
            app.KLTIV_UIFigure.Color = [ 1 1 1];
            app.KLTIV_UIFigure.Position = [100 100 1287 538]; %width < 1366; hgt < 786
            app.KLTIV_UIFigure.Name = 'KLT-IV (v1.02)';
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
                    [~, result] = system('path');
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
                '    background:  #3F7CAC !important;\n'...
                '    background: -webkit-linear-gradient(to right, #3F7CAC, #95AFBA) !important;\n'...
                '    background: linear-gradient(to right, #3F7CAC, #95AFBA) !important;\n'...
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

            % increase the pause time if error is encountered here
            pause(10) % Alllow enough time to ensure the above is executed properly
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
            app.ProcessingModeDropDown.Items = {'Make a selection', 'Single Video', 'Multiple Videos', 'Numerical Simulation'};
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
            app.OrientationDropDown.Items = {'Make a selection:', 'Stationary: Nadir', 'Stationary: GCPs','Dynamic: GCPs', 'Dynamic: GCPs + Stabilisation', 'Dynamic: Stabilisation',  'Dynamic: GPS + IMU', 'Planet [beta]'}
            app.OrientationDropDown.ValueChangedFcn = createCallbackFcn(app, @KLT_OrientationDropDownValueChanged, true);
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
            app.VelocityDropDown.Items = {'Velocity Magnitude', 'Downstream Component'}; %'Make a selection:', 'Downstream Component',
            app.VelocityDropDown.ValueChangedFcn = createCallbackFcn(app, @KLT_VelocityDropDownValueChanged, true);
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
            app.GCPDataDropDown.ValueChangedFcn = createCallbackFcn(app, @KLT_GCPDataDropDownValueChanged, true);
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
            app.UITable.CellSelectionCallback = createCallbackFcn(app, @KLT_UITableCellSelection, true);
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

            % Create tickboxes for adjustment = GCP buffer
            app.GCPbuffer_modifyBox = uicheckbox(app.KLTIV_UIFigure);
            tempPos = [app.BufferaroundGCPsmetersEditFieldLabel.Position];
            tempPos(1) = tempPos(1) + 120;
            app.GCPbuffer_modifyBox.Position = tempPos;
            app.GCPbuffer_modifyBox.Text = '';
            app.GCPbuffer_modifyBox.Value = 1;

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

            % Create tickboxes for adjustment = custom FOV buffer
            app.CustomFOV_modifyBox = uicheckbox(app.KLTIV_UIFigure);
            tempPos = [app.CustomFOVEditFieldLabel_2.Position];
            tempPos(1) = tempPos(1) + 120;
            app.CustomFOV_modifyBox.Position = tempPos;
            app.CustomFOV_modifyBox.Text = '';
            app.CustomFOV_modifyBox.Value = 0;

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
            app.AddLevelButton.ButtonPushedFcn = createCallbackFcn(app, @KLT_AddLevelButtonPushed, true);
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
            app.CrossSectionDropDown.ValueChangedFcn = createCallbackFcn(app, @KLT_CrossSectionDropDownValueChanged, true);
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
            app.UITable2.CellEditCallback = createCallbackFcn(app, @KLT_editCel2, true);
            app.UITable2.FontName = 'Roboto';
            app.UITable2.Position = [980 282 290 123];

            % Create CellNumberEditFieldLabel
            app.CellNumberEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.CellNumberEditFieldLabel.HorizontalAlignment = 'left';
            app.CellNumberEditFieldLabel.FontName = 'Ubuntu';
            app.CellNumberEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.CellNumberEditFieldLabel.Position = [980 254 140 22];
            app.CellNumberEditFieldLabel.Text = '';
            app.ControlHandles(i,33) = app.CellNumberEditFieldLabel;
            [~,panelID] = mlapptools.getWebElements(app.ControlHandles(i,33));
            setClassString = sprintf(...
                'dojo.addClass(dojo.query("[%s = ''%s'']")[0], "%s")',...
                panelID.ID_attr, panelID.ID_val, 'infoBox');
            app.WEBWINDOW.executeJS(setClassString); % add class to DOM elements
            app.CellNumberEditFieldLabel = uilabel(app.KLTIV_UIFigure);
            app.CellNumberEditFieldLabel.HorizontalAlignment = 'left';
            app.CellNumberEditFieldLabel.FontName = 'Ubuntu';
            app.CellNumberEditFieldLabel.FontColor = [0.149 0.149 0.149];
            app.CellNumberEditFieldLabel.Position = [980 254 140 22];
            app.CellNumberEditFieldLabel.Text = '    Number of cells';

            % Create CellNumberEditField
            app.CellNumberEditField = uieditfield(app.KLTIV_UIFigure, 'numeric');
            app.CellNumberEditField.FontName = 'Roboto';
            app.CellNumberEditField.FontColor = [0.149 0.149 0.149];
            app.CellNumberEditField.Position = [1130 254 140 22];
            app.CellNumberEditField.Value = 20;

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
            app.InterpolationMethod.Items = {'Make a selection:', 'All', 'Quadratic Polynomial', 'Cubic Polynomial', 'Constant Froude' };
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
            app.CALCULATEButton.ButtonPushedFcn = createCallbackFcn(app, @KLT_CALCULATEButtonPushed, true);
            app.CALCULATEButton.FontName = 'Ubuntu';
            app.CALCULATEButton.FontColor = [0.149 0.149 0.149];
            app.CALCULATEButton.Position = [980 162 290 22];
            app.CALCULATEButton.Text = 'CALCULATE';

            % Create ListBox
            app.ListBox = uilistbox(app.KLTIV_UIFigure);
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