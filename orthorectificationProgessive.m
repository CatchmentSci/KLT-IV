function [] = orthorectificationProgessive(app)

if strcmp(app.CheckGCPsSwitch.Value, 'On') == 1
    app.ExportGCPdataSwitch.Enable = 'on';
    app.ExportGCPdataSwitch.Value = 'On';
    
    TextIn = {'GCPs will be checked at the extract rate'; ...
        'Checked GCP positions will automatically be exported to a .csv'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    for a = 1:length(app.gcpA(:,4))
        if ~isnan(app.gcpA(a,4))
            [outTemp1] = KLT_readPoints(app.objectFrame,1,2, app, a); hold on;
            if length(outTemp1) == 2
                app.imageGCPs(a, 1:2) = outTemp1;
            else
                app.imageGCPs(a, 1:2) = [NaN, NaN];
            end
        else
            % dialog box -- is the GCP still visible?
            fig1 = figure('units','normalized','outerposition',[0 0 1 1]);
            hold on;
            im1 = imshow(app.objectFrame);
            answer = questdlg(['Is GCP ' num2str(a) ' still visible?'], ...
                ['GCP ' num2str(a) ' Located at ' num2str(app.gcpA(a,1:3))] , ...
                'Yes, No');
            try
                close (fig1)
            catch
            end
            
            switch answer % Handle response
                case 'Yes'
                    % Initialize data cursor object & import data to table
                    [app.imageGCPs(a, 1:2)] = KLT_readPoints(app.objectFrame,1,[], app, a); hold on;
                    try
                        close (f1)
                    catch
                    end
                case 'No'
                    app.gcpA(a,4:5) = NaN;
            end
        end
        
        % Find the closest point that can be tracked
        PotentialGCPs = detectMinEigenFeatures(app.firstFrame); % Find features
        PotentialGCPs = double(PotentialGCPs.Location);
        distances = sqrt(sum(bsxfun(@minus, PotentialGCPs, app.imageGCPs(a,1:2)).^2,2));
        closest = PotentialGCPs(find(distances==min(distances)),:);
        if length(closest) > 0
            app.gcpA(a,4:5) = closest;
        else
            app.gcpA(a,4:5) = [NaN, NaN];
        end
    end
    
    TextIn = {'Option to load new GCPs if they have become visible'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    % dialog box -- Are new GCPs visible?
    answer = questdlg(['Are any GCPs newly visible?'], ...
        'Yes, No');
    if strcmp(answer,'Yes') == 1
        fig1 = figure('units', 'normalized', 'outerposition',[0 0 1 1]);
        hold on;
        TextIn = {'Select new GCPs in the image by right clicking on them.';...
            'Then enter their [x y z] locations'; ...
            'Once all have been selected click Enter on the keyboard'};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        title ('See dialog box for instructions');
        [newImageGCPs,newGCPimageReal] = readPoints(app.objectFrame,100,0,app,[]); hold on;
        [~, t1] = size(newImageGCPs);
        [~ ,t2] = size(newGCPimageReal);
        if ~isequal(t1,t2)
            % Display the error output
            TextIn = {'Unsuccesful labelling of new GCP. Please try again'};
            TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
            TimeIn = strjoin(TimeIn, ' ');
            app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
            printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
        else
            [~ ,t3] = size(app.gcpA);
            app.gcpA(t3+1:t3+t1,1:5) = [newGCPimageReal; newImageGCPs]'; % add the new GCPs to the file
            TextIn = {'New GCPs loaded succesfully'};
            TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
            TimeIn = strjoin(TimeIn, ' ');
            app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
            printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
        end
        try
            close(f1)
        catch
        end
    end
end

% Continuation
if strcmp(app.ExportGCPdataSwitch.Enable, 'on') == 1 ...
        && strcmp(app.ExportGCPdataSwitch.Value, 'On') == 1 ...
        && strcmp(app.OrientationDropDown.Value, 'Dynamic: GCPs') == true % new addition (this condition only)
    template = '00000';
    inputNum = num2str(app.s2);
    p1 = template(1:end-length(num2str(app.s2)));
    p2 = inputNum;
    fileNameIteration = [p1,p2];
    if size(app.rollingGCPs) < 1 % starting point
        app.rollingGCPs = app.InitialGCP;
        t00 = {app.file, num2str(app.ExtractionratesEditField.Value),'','',''};
        t0 = {'Frame', num2str(1),'','',''};
        t1 = num2cell(app.gcpA);
        t2 = {'', '','', '', ''; ...
            'Frame', fileNameIteration,'','',''};
        t4 = num2cell(app.rollingGCPs);
        app.rollingGCPs = [t00; t0; t1; t2; t4];
        app.TempFileIn = strjoin({app.directory_save, '\', ...
            app.file(1:end-4), '_', char(datetime(now,'ConvertFrom','datenum','format', 'yyyyMMddHHmm' )), ...
            '_GCPOutputs.csv'},'');
        
        TextIn = {['GCP data succesfully exported to ' app.TempFileIn]};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
    else
        t2 = {'', '','', '', ''};
        t3 = {'Frame ', fileNameIteration,'', '', ''};
        t4 = num2cell(app.gcpA);
        app.rollingGCPs  = [app.rollingGCPs; t2; t3; t4];
    end
    writetable( cell2table(app.rollingGCPs), app.TempFileIn , ...
        'writevariablenames', false, 'quotestrings', true)
    TextIn = {['Locations of additional checked GCPs succesfully exported to: ' app.TempFileIn]};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
end

if isa(app.gcpA_checked, 'structure') == 1
    t5 = fieldnames(app.gcpA_checked);
    if ~isempty(t5) % if using pre-checked GCP data
        t6 = cellfun(@(a) strsplit(a, '_'), t5, 'UniformOutput', false);
        t7 = [t6{1:length(t5),1}];
        t8 = str2double (t7(2:2:length(t7)));
        idx = find (app.s2 == t8);
        if idx > 0 % only assign if data is available
            t9 = char(t5(idx));
            eval(['app.gcpA = app.gcpA_checked.' t9]); % assign the data to gcpA
            
            TextIn = {['Previously identified and checked GCPs loaded']};
            TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
            TimeIn = strjoin(TimeIn, ' ');
            app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
            printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
            
        end
    end
end

% Declare availability of GCPs
if ~isempty(app.gcpA)
    available = find(~isnan(app.gcpA(:,4)));
else
    available = []; % empty array
end

if strcmp (app.OrientationDropDown.Value,'Dynamic: GCPs') == 1
    
    % Optimise the camera parameters by defining [x y z] and known parameters constant
    [app.camA,app.rmse]=app.camA.optimizecam(app.gcpA(available,1:3),app.gcpA(available,4:5),'11100111000000000000');
    
    % Save the optimised parameter set and the app.rmse
    inder1 = size(app.cameraModelParameters);
    app.cameraModelParameters(inder1(1)+1,1:length(app.camA.fullmodel)+1) = [app.camA.fullmodel app.rmse];
    
    % Display the updated RMSE of the camera model
    TextIn = {['Updated camera model optimised for frame ' num2str(app.s2)]; ...
        ['RMSE = ' num2str(app.rmse) ' px']};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
end

if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS') == 1
    % Optimise the camera parameters by defining [x y z] and known parameters constant
    
    offset1 = round((app.s2_mod.*app.videoFrameRate));
    app.camA.xyz = [app.frame_uas_x(app.s2-offset1), app.frame_uas_y(app.s2-offset1), app.frame_uas_z(app.s2-offset1)]; % These are the known GPS positions of the camera
    
    % Save the optimised parameter set and the app.rmse
    inder1 = size(app.cameraModelParameters);
    app.cameraModelParameters(inder1(1)+1,1:length(app.camA.fullmodel)+1) = [app.camA.fullmodel NaN];
    
    % Display the updated RMSE of the camera model
    TextIn = {['Updated camera model optimised for frame ' num2str(app.s2)]};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
end

if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + compass') == 1
    % Optimise the camera parameters by defining [x y z] and known parameters constant
    
    offset1 = round((app.s2_mod.*app.videoFrameRate));
    app.camA.xyz = [app.frame_uas_x(app.s2-offset1), app.frame_uas_y(app.s2-offset1), app.frame_uas_z(app.s2-offset1)]; % These are the known GPS positions of the camera
    app.camA.viewdir = [app.frameYprMatch(app.s2-offset1,1),app.frameYprMatch(app.s2-offset1,2),app.frameYprMatch(app.s2-offset1,3)];
    
    % Save the optimised parameter set and the app.rmse
    inder1 = size(app.cameraModelParameters);
    app.cameraModelParameters(inder1(1)+1,1:length(app.camA.fullmodel)+1) = [app.camA.fullmodel NaN];
    
    % Display the updated RMSE of the camera model
    TextIn = {['Updated camera model optimised for frame ' num2str(app.s2)]};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
end

imageExport(app) % Export the image

end