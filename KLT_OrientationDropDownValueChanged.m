% Value changed function: OrientationDropDown
function KLT_OrientationDropDownValueChanged(app, ~)
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
    KLT_printItems(app)
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
    KLT_printItems(app)
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