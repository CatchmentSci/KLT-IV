function  [] = KLT_customFOV(app)

if abs(app.CustomFOVEditField_2.Value) + abs(app.CustomFOVEditField_4.Value) > 0 || ...
        abs(app.CustomFOVEditField_2.Value) + abs(app.CustomFOVEditField_4.Value) > 0 ...
        && strcmp(app.CustomFOVEditField_2.Enable,'on') == true ...
        && strcmp(app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false
    
    % Lower resolution DEM
    TransxIn = app.CustomFOVEditField_2.Value:0.1:app.CustomFOVEditField_4.Value;
    TransyIn = app.CustomFOVEditField_3.Value:0.1:app.CustomFOVEditField_5.Value;
    [app.TransX,app.TransY]=meshgrid(TransxIn,TransyIn);
    [params] = size(app.TransX);
    demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
    app.Transdem = demIn; 
    
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
                KLT_printItems(app)
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
            KLT_printItems(app)
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
    
    TransxIn = nanmin(app.gcpA(:,1))-GCPbuffer:0.1:nanmax(app.gcpA(:,1))+GCPbuffer;
    TransyIn = nanmin(app.gcpA(:,2))-GCPbuffer:0.1:nanmax(app.gcpA(:,2))+GCPbuffer;
    [app.TransX,app.TransY]=meshgrid(TransxIn,TransyIn);
    [params] = size(app.TransX);
    app.Transdem(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value; %20210427
    
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
                    KLT_printItems(app)
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
                KLT_printItems(app)
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
    
    KLT_ffmpeg_conversion_batch(app)
    
    V = VideoReader(strjoin ({app.directory, '\', app.fileNameAnalysis{app.videoNumber}},''));
    
    try
        totNum = V.NumFrames; % sometimes doesn't exist
    catch
        totNum = floor(V.Duration.*V.FrameRate); % estimate frame number
    end
    
    
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
        try
            app.objectFrameStacked{a} = images.internal.rgb2graymex(readFrame(V));
        catch
            app.objectFrameStacked = app.objectFrameStacked(1:a-1); %20210430
            totNum = a - 1;
            break
        end
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
    
    if strcmp(app.OrientationDropDown.Value, 'Dynamic: GPS + IMU') == false
        demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
        [params2] = [size(TransyIn,2), size(TransxIn,2)];
        app.Transdem = zeros(params2);
        app.Transdem = replace_num(app.Transdem,0,app.WatersurfaceelevationmEditField.Value); % app.Transdem = demIn;
    end
    
end


end