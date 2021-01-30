function checkGcpCsvData(app)
if strcmp (app.GCPData, 'From .csv file') == 1
    
    app.UITable.Data = [];
    TextIn = {'Importing GCPs from pre-defined .csv file'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    if isempty(double(app.s2)) %|| double(app.s2) > 1
        [app.GCPfile, app.GCPdirectory] = uigetfile({'*.csv' '.csv Files'},'Select a file',app.directory);
    end
    
    if length(app.GCPfile) > 1
        [data_text,~] = readtext(strjoin({app.GCPdirectory app.GCPfile },''), ',', '','','textual'); % read in the csv file
        gcp(:,1) = data_text(2:end,1); % Extract the X coordinate of the scan
        gcp(:,2) = data_text(2:end,2); % Extract the Y coordinate of the scan
        gcp(:,3) = data_text(2:end,3); % Extract the Z coordinate of the scan
        gcp(:,4) = data_text(2:end,4); % Extract the X coordinate in the photo
        gcp(:,5) = data_text(2:end,5); % Extract the Y coordinate in the photo
        test = str2double(gcp(1,1)); % Convert to numeric if simple input
        if isnan(test) % then using the checked GCPs
            
            app.CheckGCPsSwitch.Enable = 'off';
            app.UITable.Enable = 'off';
            app.ExportGCPdataSwitch.Enable = 'off';
            
            t1 = find(isnan(str2double(gcp(:,1))));
            t2 = strfind(gcp,'Frame');
            t3 = find(~cellfun(@isempty,t2));
            b = 1;
            for a  = 1:round(length(t1)/2)
                try
                    eval(['app.gcpA_checked.Frame_' strrep( ...
                        char(gcp(t3(a,1),2)), '"', '') ...
                        '= str2double(gcp(t1(b)+1:t1(b+1)-1,1:5))' ])
                    b = b + 2;
                catch
                    eval(['app.gcpA_checked.Frame_' strrep( ...
                        char(gcp(t3(a,1),2)), '"', '') ...
                        '= str2double(gcp(t1(b)+1:end,1:5))' ])
                    b = b + 2;
                end
            end
            app.gcpA = app.gcpA_checked.Frame_1; % assign the first frameas gcpA
            app.UITable.Data = app.gcpA;
            
            for c = 1:length(t3)
                rates(c,1) = str2double({strrep(char(gcp(t3(c,1),2)), '"', '')});
            end
            
            V = VideoReader(strjoin ({app.directory, app.file},''));
            app.videoDuration = V.Duration; % Extract the length of the video
            app.videoFrameRate = V.FrameRate; % Extract the frame rate of the video
            s1 = (1/app.videoFrameRate).*(rates(2)-rates(1));
            if abs(s1 - app.ExtractionratesEditField.Value) > (1/app.videoFrameRate)
                TextIn = {'The Extract rate (s) value does not correspond with the Extract Rate defined when GCPs were ';...
                    'previously tracked and checked.'; ...
                    'You have three options:'; ...
                    '(1) Change the current extract rate to match one previous used,'; ...
                    '(2) Track and check GCPs at the new Extract Rate'; ...
                    '(3) Do nothing: the GCP locations for frame 1 will be used and tracked through the image sequence'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                app.gcpA_checked = [];
                
                app.CheckGCPsSwitch.Enable = 'on';
                app.CheckGCPsSwitch.Value = 'Off';
                app.ExportGCPdataSwitch.Enable = 'on';
                app.ExportGCPdataSwitch.Value = 'Off';
                
            else
                
                TextIn = {'The Extract rate (s) value corresponds with the Extract Rate defined when GCPs were ';...
                    'previously tracked and checked.'; ...
                    'This information will be used in the tracking sequence'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            end
            
        else
            [app.GCPdims, ~] = size(gcp);
            app.gcpA = str2double(gcp(1:app.GCPdims,:));
            app.UITable.Data = app.gcpA;
            
            if strcmp(app.OrientationDropDown.Value,'Stationary: GCPs') == true ||...
                    strcmp (app.OrientationDropDown.Value,'Dynamic: GCPs + Stabilisation') == true
                app.CheckGCPsSwitch.Enable = 'off';
                app.CheckGCPsSwitch.Value = 'Off';
                app.ExportGCPdataSwitch.Enable = 'on';
            else
                app.CheckGCPsSwitch.Enable = 'on';
                app.ExportGCPdataSwitch.Enable = 'on';
            end
        end
        
        if strcmp(app.OrientationDropDown.Value,'Dynamic: GCPs') == true 
            
            % Snap initial GCPs to tracked features
            objectRegion = [1, 1, app.imgsz(2), app.imgsz(1)]; %[TopLeftX,TopLeftY,LengthX,LengthY]
            PotentialGCPs = detectMinEigenFeatures(app.firstFrame, 'ROI', objectRegion); % Find features
            PotentialGCPs = double(PotentialGCPs.Location);
            mypoints = app.gcpA(:,4:5); % Best guesses of GCPs based on data import
            
            for a = 1:length(app.gcpA(:,4))
                %compute Euclidean distances:
                distances = sqrt(sum(bsxfun(@minus, PotentialGCPs, mypoints(a,1:2)).^2,2));
                %find the smallest distance and use that as an index into B:
                closest = PotentialGCPs(find(distances==min(distances)),:);
                app.gcpA(a,4:5) = closest; % use the closest GCP
            end
        end
    end
end
end