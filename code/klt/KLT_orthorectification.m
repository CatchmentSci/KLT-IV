function [] = KLT_orthorectification(app)

app.rollingGCPs = [];
KLT_checkGcpCsvData(app)

A = (app.firstFrame);
app.InitialGCP = app.gcpA;
if strcmp(app.ExportGCPdataSwitch.Enable, 'on') == 1
    
    % Ensure GCP data is only exported for the first video when multiple
    % videos are being analysed
    if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
        app.ExportGCPdataSwitch.Value = 'Off';
        app.ExportGCPdataSwitch.Enable = 'off';
    end
    
    TextIn = {'Initiating the export of GCP Data'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    outVars = app.gcpA; % Populate the array
    dataOut = [app.UITable.ColumnName';num2cell(outVars)];
    TextIn = {'Export started. Please wait.'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    % Write the GCP file
    if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1 % but only if the first video
        writetable( cell2table(dataOut), strjoin({app.directory_save, '\', ...
            app.file(1:end-4), '_', char(datetime(now,'ConvertFrom','datenum','format', 'yyyyMMddHHmm' )), ...
            '_GCPOutputs.csv'},''), ...
            'writevariablenames', false, 'quotestrings', true)
        
        TextIn = strjoin({'Export completed. Saved to ' app.directory_save '\GCP_data.csv'},'');
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
    end
end % function

if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1 % if the first video
    app.camA = camera();
    app.camA.imgsz = app.imgsz(1:2);
    app.camA.viewdir = [app.yawpitchrollEditField.Value app.yawpitchrollEditField_2.Value app.yawpitchrollEditField_3.Value];
    app.camA.c = app.c; % principal point
    app.camA.f = app.f; % focal length
    app.camA.k(1:length(app.k)) = app.k;
    app.camA.p(1:length(app.p)) = app.p;
    app.camA.xyz = [app.CameraxyzEditField.Value, app.CameraxyzEditField_2.Value, app.CameraxyzEditField_3.Value]; % These are the rough starting coordinates of the camera
end

if strcmp(app.OrientationDropDown.Value,['Stationary: Nadir']) == 1
    % Disable some input options
    set(app.BufferaroundGCPsmetersEditField, 'Enable', 'Off') % Disable buffer options
    % Lower resolution DEM
    TransxIn = app.CustomFOVEditField_2.Value:0.1:app.CustomFOVEditField_4.Value;
    TransyIn = app.CustomFOVEditField_3.Value:0.1:app.CustomFOVEditField_5.Value;
    [app.TransX,app.TransY]=meshgrid(TransxIn,TransyIn);
    [params] = size(app.TransX); clear demIn;
    demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
    app.Transdem = demIn;
    
    % Higher res DEM
    xIn = app.CustomFOVEditField_2.Value:app.ResolutionmpxEditField.Value:app.CustomFOVEditField_4.Value;
    yIn = app.CustomFOVEditField_3.Value:app.ResolutionmpxEditField.Value:app.CustomFOVEditField_5.Value;
    [app.X,app.Y]=meshgrid(xIn,yIn);
    [params] = size(app.X); clear demIn
    demIn(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
    app.dem = demIn;
    
    [app.uvHR,~,app.inframeHR]=app.camA.project([app.X(:),app.Y(:), app.dem(:)]); % High res DEM
    app.visHR(1:length(app.X(:,1)),1:length(app.Y(1,:))) = 1; % Same change here
    app.uvHR(~app.inframeHR|~app.visHR(:),:) = nan;
    uvHR1 = app.uvHR(:,1);
    uvHR2 = app.uvHR(:,2);
    clear app.uvHR
    app.rgbHR=nan(size(app.dem,1),size(app.dem,2),1);
    app.cameraModelParameters = [app.camA.fullmodel app.rmse];
    
    template = '00000';
    inputNum = num2str(app.s2);
    p1 = template(1:end-length(1));
    p2 = inputNum;
    fileNameIteration = [p1,p2];
    
    if app.directory_save == 0
        filenameJpg = [ app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
    else
        dirIn = [app.directory_save '\orthorectified\'];
        mkdir (dirIn);
        filenameJpg = [dirIn '\' app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
    end
    
    for jj = 1:1 % Assumption that the input is a grayscale image
        app.rgbHR(:,:,jj) = reshape(interp2(double(A(:,:,jj)),uvHR1,uvHR2),size(app.rgbHR));
    end
    x = app.rgbHR ./ max(app.rgbHR(:));  % Scale to [0,1]
    %x = app.rgbHR;  % No scaling
    A = ones(size(x));
    A(x == 0) = 1;      % 100% transparent for NaN
    %imwrite(x,filenameTiff); % Save the orthophotos
    imwrite(x,filenameJpg);
    %if app.s2 ==1
    app.firstOrthoImage = x;
    %end
    
elseif strcmp(app.OrientationDropDown.Value,'Stationary: GCPs') == 1 || ...
        strcmp(app.OrientationDropDown.Value,'Dynamic: GCPs') == 1 || ...
        strcmp (app.OrientationDropDown.Value,'Dynamic: GCPs + Stabilisation') == 1
      
    % only optimise the camera model for the first video of the analysis
    if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1
        
        TextIn = {'Optimising the camera model'}; % Update the display
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
        % Cycle through the range of possible yaw values until the
        % optimum solution is found. This assumes that the user has
        % inputted the pitch the correct way i.e. not upside-down
        ii = 0;
        looper = 1;
        tempRMSE= [];
        yawRange = 0:0.5:4;
        
        % Define the flexibility of the camera model
        if strcmp(app.CameraTypeDropDown.Value,['Not listed']) == 1 % If not listed
            adjustmentString = '11100111110000000000';
            adjustmentString(1) = num2str(app.Cameraxyz_modifyXbox.Value); % bring in tick box values
            adjustmentString(2) = num2str(app.Cameraxyz_modifyYbox.Value);
            adjustmentString(3) = num2str(app.Cameraxyz_modifyZbox.Value);
        else
            adjustmentString = '11100111000000000000';
            adjustmentString(1) = num2str(app.Cameraxyz_modifyXbox.Value); % bring in tick box values
            adjustmentString(2) = num2str(app.Cameraxyz_modifyYbox.Value);
            adjustmentString(3) = num2str(app.Cameraxyz_modifyZbox.Value);
        end
        
        x = app.camA.xyz(1); 
        if str2double(adjustmentString(1)) == 1 % check to see if flex in x is enabled
            xRange = x-5:1:x+5;
        else
            xRange(1:11) = x;
        end
        
        y = app.camA.xyz(2);
        if str2double(adjustmentString(2)) == 1 % check to see if flex in y is enabled
            yRange = y-5:1:y+5;
        else
            yRange(1:11) = y;
        end
        
        z = app.camA.xyz(3);
        if str2double(adjustmentString(3)) == 1 % check to see if flex in z is enabled
            zRange = z-5:1:z+5;
        else
            zRange(1:11) = z;
        end 
        
        accptable_rmse = 15;
                
        while ii < 2
            for cycle4 = 1:length(zRange)
                for cycle3 = 1:length(yRange)
                    for cycle2 = 1:length(xRange)
                        for cycle1 = 1:length(yawRange)
                            try
                                app.camA.xyz(1) = xRange(cycle2);
                                app.camA.xyz(2) = yRange(cycle3);
                                app.camA.xyz(3) = zRange(cycle4);
                                app.camA.viewdir(1) = yawRange(cycle1);
                                if strcmp(app.CameraTypeDropDown.Value,['Not listed']) == 1 % If not listed
                                    [tempCam(looper,:),tempRMSE(looper,:),~] = app.camA.optimizecam(app.gcpA(:,1:3),app.gcpA(:,4:5),adjustmentString); %enable focal length to be optimised %'11100111110000000000'); %enable focal length to be optimised
                                    app.camA = tempCam(looper,:);
                                    [tempCam(looper,:),tempRMSE(looper,:),~] = app.camA.optimizecam(app.gcpA(:,1:3),app.gcpA(:,4:5),adjustmentString); %enable focal length to be optimised
                                else
                                    [tempCam(looper,:),tempRMSE(looper,:),~] = app.camA.optimizecam(app.gcpA(:,1:3),app.gcpA(:,4:5),adjustmentString);
                                    % [camx,camy,camz,imgszy,imgszx,viewdiryaw,viewdirpitch,viewdirroll,fx,fy,cx,cy,app.k1-6,p1-2]
                                end
                            catch
                                tempRMSE(looper,:) = NaN;
                            end
                            if tempRMSE(looper,:) == 0
                                tempRMSE(looper,:) = NaN;
                            end
                            if ~isnan(min(tempRMSE)) && min(tempRMSE) < accptable_rmse
                                break
                            end
                            looper = looper + 1;
                        end
                        if ~isnan(min(tempRMSE)) && min(tempRMSE) < accptable_rmse
                            break
                        end
                    end
                    if ~isnan(min(tempRMSE)) && min(tempRMSE) < accptable_rmse
                        break
                    end
                end
                if ~isnan(min(tempRMSE)) && min(tempRMSE) < accptable_rmse
                    break
                end
            end
            % Select the best performing camera model from the range
            % with variable yaw inputs from 0:4
            bestMatch = find(tempRMSE == min(tempRMSE,[],'omitnan'));
            if ~isempty(bestMatch)
                bestMatch = bestMatch(1); % select the first incase the of identical RMSE values
                app.camA = tempCam(bestMatch,:);
                app.rmse = tempRMSE(bestMatch,:);
            elseif isempty(bestMatch) && ii == 1
                % Error so print the message
                TextIn = {'No camera solution. The program will terminate. Check inputs and retry'}; % Update the display
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                error('Breaking out of function');
            end
            
            % This performs a catch if the z-axis values are
            % negative, or no camera solution found.
            if app.camA.xyz(3) < 0 || isempty(bestMatch)
                app.gcpA(:,1) = -app.gcpA(:,1); % invert the x-axis GCPs if needed
                tempCam = []; tempRMSE = [];
                looper = 1; % overwrite the initial solutions
            else
                looper = 1; % Just rerun
            end
            ii = ii + 1;
        end
        
        % Update the display to show the camera model output
        TextIn = {['Camera model optimised. RMSE = ' num2str(app.rmse) 'px']};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
        % Plot the results of the optimal camera model
        TextIn = {'Results of the initial camera model optimisation displayed'};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
        h_fig = figure('units','normalized','outerposition',[0 0 1 1]);
        hold on;
        h_ax = gca;
        imshow(A);
        hold on;
        uvGCP=app.camA(end,1).project(app.gcpA(:,1:3));
        scatter(app.gcpA(:,4),app.gcpA(:,5),'b', 'o','filled');
        pause(0.1)
        scatter(uvGCP(:,1),uvGCP(:,2),'r+');
        legend('Visible GCPs','Projection of GCPs','location','northwest');
        title('Results of initial orthorectification: Click on the image to close')
        set(h_ax,'xtick',[]);
        set(h_ax,'ytick',[])
        try % if exited manually, this prevents error
            waitforbuttonpress
            close (h_fig)
        catch
        end
        TextIn = {'Results of the initial camera model optimisation closed'};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
        answer = questdlg('Are you happy with the orthorectification results?', ...
            'Continue?', ...
            {'Yes','No'});
        
        switch answer
            case 'Yes'
                TextIn = {'Continuing analysis.'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            case 'No'
                TextIn = {'Exiting the analysis'; 'Check the GCP inputs are correct.' ; 'Check the camera location and view direction'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                set(app.RUNButton,'Text','RUN');
                pause(0.01)
                error('Breaking out of function');
            case 'Cancel'
                TextIn = {'Exiting the analysis'; 'Check the GCP inputs are correct.' ; 'Check the camera location and view direction'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                set(app.RUNButton,'Text','RUN');
                pause(0.01)
                error('Breaking out of function');
                
        end
        
    end
    
    if strcmp (app.OrthophotosSwitch.Value, 'On') == 1 || app.s2 > 0 % always called
        
        if ~isempty(app.directory_save_multiple) % Bring in the proper file
            A = app.objectFrameStacked{app.s2};
        end
        
        % Interpolate the image so that it fits the DEM
        [app.uvHR,~,app.inframeHR]=app.camA.project([app.X(:),app.Y(:), app.dem(:)]); % High res DEM input
        app.visHR(1:length(app.X(:,1)),1:length(app.Y(1,:))) = 1; % Same change here
        app.uvHR(~app.inframeHR|~app.visHR(:),:) = nan;
        uvHR1 = app.uvHR(:,1);
        uvHR2 = app.uvHR(:,2);
        clear app.uvHR
        app.rgbHR=nan(size(app.dem,1),size(app.dem,2),1);
        
        template = '00000';
        inputNum = num2str(app.s2);
        p1 = template(1:end-length(num2str(app.s2)));
        p2 = inputNum;
        fileNameIteration = [p1,p2];
        
        app.cameraModelParameters = [app.camA.fullmodel app.rmse];
        
        if strcmp (app.OrthophotosSwitch.Value, 'On') == 1
            
            % Define the output dir of the orthophoto
            if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == true
                if app.directory_save == 0
                    filenameJpg = [ app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
                elseif ~isempty(app.directory_save_multiple)
                    dirIn = [app.directory_save_multiple '\orthorectified\'];
                    mkdir (dirIn);
                    filenameJpg = [dirIn '\' app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
                else
                    dirIn = [app.directory_save '\orthorectified\'];
                    mkdir (dirIn);
                    filenameJpg = [dirIn '\' app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
                end
                
            elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
                
                if app.directory_save == 0
                    filenameJpg = [ app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
                elseif ~isempty(app.directory_save_multiple)
                    dirIn = [app.directory_save_multiple '\orthorectified\'];
                    mkdir (dirIn);
                    filenameJpg = [dirIn '\' app.fileNameAnalysis{app.videoNumber}(1:end-4) '_frame' fileNameIteration '.jpg'];
                else
                    dirIn = [app.directory_save '\orthorectified\'];
                    mkdir (dirIn);
                    filenameJpg = [dirIn '\' app.fileNameAnalysis{app.videoNumber}(1:end-4) '_frame' fileNameIteration '.jpg'];
                end
                
            end
        end
        
        for jj = 1:1 % only one as it is a grayscale image
            app.rgbHR(:,:,jj) = reshape(interp2(double(A(:,:,jj)),uvHR1,uvHR2),size(app.rgbHR));
        end
        
        x = app.rgbHR ./ 255;  % provide in decimal
        app.firstOrthoImage = x;
        
        if strcmp (app.OrthophotosSwitch.Value, 'On') == 1
            imwrite(app.firstOrthoImage,filenameJpg)
        end
        
        % Orthophoto saved display
        TextIn = {['Orthophoto for frame number ' num2str(app.s2) ' generated']};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
    end
    
elseif strcmp(app.OrientationDropDown.Value,'Dynamic: Stabilisation') == 1
    
    % Translate px coordinates to metric coordinates
    [imageSize(1), imageSize(2)] = size(app.firstFrame);
    TransxIn = (1:1:imageSize(2)).*app.ResolutionmpxEditField.Value;
    TransyIn = (1:1:imageSize(1)).*app.ResolutionmpxEditField.Value;
    [app.TransX,app.TransY]=meshgrid(TransxIn,TransyIn);
    app.X = app.TransX;
    app.Y = app.TransY;
    [params] = size(app.TransX);
    demIn(1:params(1),1:params(2)) = 0; % zero because z is relative to water level
    app.Transdem = demIn;
    
    if app.directory_save == 0
        filenameJpg = [ app.file(1:end-4) '_frame00001.jpg'];
    else
        dirIn = [app.directory_save '\orthorectified\'];
        mkdir (dirIn);
        filenameJpg = [dirIn '\' app.file(1:end-4) '_frame00001.jpg'];
    end
    
    app.rgbHR=nan(size(app.Transdem,1),size(app.Transdem,2),1);
    for jj = 1:1 % Assumption that the input is a grayscale image
        app.rgbHR(:,:,jj) = reshape(app.firstFrame,size(app.Transdem));
    end
    x = app.rgbHR ./ max(app.rgbHR(:));  % Scale to [0,1]
    app.previousFrame = x;
    app.previousFrame = replace_num(app.previousFrame,NaN,0); % switch NaNs for zeros to enable tracking
    
    % Save the orthophotos
    imwrite(x,filenameJpg)
    
    %if app.s2 ==1
    app.firstOrthoImage = x;
    %end
    
elseif strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + compass') == 1
    
    % Disable some input options
    set(app.BufferaroundGCPsmetersEditField, 'Enable', 'off') % Disable buffer options
    offset1 = round((app.s2_mod.*app.videoFrameRate));
    totNum = round((app.videoClip.*app.videoFrameRate) + app.s2);
    allX = app.frame_uas_x(app.s2-offset1:totNum-offset1);
    allY = app.frame_uas_y(app.s2-offset1:totNum-offset1);
    
    % Lower resolution DEM
    TransxIn = [min(allX,[],'omitnan')-app.frame_uas_z]:0.1:[max(allX,[],'omitnan')+app.frame_uas_z];
    TransyIn = [min(allY,[],'omitnan')-app.frame_uas_z]:0.1:[max(allY,[],'omitnan')+app.frame_uas_z];
    [app.TransX,app.TransY]=meshgrid(TransxIn,TransyIn);
    [params] = size(app.TransX); clear demIn;
    demIn(1:params(1),1:params(2)) = 0; % zero because z is relative to water level
    app.Transdem = demIn;
    
    % Higher res DEM
    xIn = [min(allX,[],'omitnan')-app.frame_uas_z]:app.ResolutionmpxEditField.Value:[max(allX,[],'omitnan')+app.frame_uas_z];
    yIn = [min(allY,[],'omitnan')-app.frame_uas_z]:app.ResolutionmpxEditField.Value:[max(allY,[],'omitnan')+app.frame_uas_z];
    app.imageResolution = app.ResolutionmpxEditField.Value;
    [app.X,app.Y]=meshgrid(xIn,yIn);
    [params] = size(app.X); clear demIn;
    demIn(1:params(1),1:params(2)) = 0; % zero because z is relative to water level
    app.dem = demIn;
    
    app.camA.xyz = [app.frame_uas_x(1), app.frame_uas_y(1), app.frame_uas_z(1)]; % These are the known GPS positions of the camera
    app.camA.viewdir = [app.frameYprMatch(1,1),app.frameYprMatch(1,2),app.frameYprMatch(1,3)];
    
    [app.uvHR,~,app.inframeHR]=app.camA.project([app.X(:),app.Y(:), app.dem(:)]); % High res DEM
    app.visHR(1:length(app.X(:,1)),1:length(app.Y(1,:))) = 1; % Same change here
    app.uvHR(~app.inframeHR|~app.visHR(:),:) = nan;
    uvHR1 = app.uvHR(:,1);
    uvHR2 = app.uvHR(:,2);
    clear app.uvHR
    app.rgbHR=nan(size(app.dem,1),size(app.dem,2),1);
    app.cameraModelParameters = [app.camA.fullmodel app.rmse];
    
    template = '00000';
    inputNum = num2str(app.s2);
    if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + compass') == 1
        p1 = template(1:end-length(num2str(app.s2)));
    else
        p1 = template(1:end-length(1));
    end
    p2 = inputNum;
    fileNameIteration = [p1,p2];
    
    if isempty(app.directory_ortho)
        if isempty(app.directory_save)
            filenameJpg = [ app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
        else
            dirIn = [app.directory_save '\orthorectified\'];
            mkdir (dirIn);
            filenameJpg = [dirIn '\' app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
        end
        
        for jj = 1:1 % Assumption that the input is a grayscale image
            app.rgbHR(:,:,jj) = uint8(reshape(interp2(double(app.objectFrame(:,:,jj)),uvHR1,uvHR2),size(app.rgbHR)));
        end
        x = app.rgbHR ./ max(app.rgbHR(:));  % Scale to [0,1]
        %x = app.rgbHR;  % No scaling
        A = ones(size(x));
        A(x == 0) = 1;      % 100% transparent for NaN
        app.previousFrame = x;
        app.previousFrame = replace_num(app.previousFrame,NaN,0); % switch NaNs for zeros to enable tracking
        
        % Save the orthophotos
        imwrite(x,filenameJpg)
        
        % write the first file as an ascii in the UTM co-ordinate
        % system
        %arcgridwrite('C:\Users\Matt\Dropbox\Software\Source Code\version_012\bathyGrid2.asc', ...
        %    app.X(1,:),app.Y(:,1),x)
        
        %if (app.s2-offset1) ==1
        app.firstOrthoImage = x;
        %end
    end
end

% calculate the projection error for each GCP if possible
try
    if size(app.gcpA,1)>1
        [GCPpixelTrans,~,~]=app.camA.project([app.gcpA(:,1),app.gcpA(:,2), app.gcpA(:,3)]); % High res DEM
        app.GCPdiff = app.gcpA(:,4:5) - GCPpixelTrans;
    end
    catch
end


end