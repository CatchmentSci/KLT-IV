% Cell selection callback: UITable
function KLT_UITableCellSelection(app, ~)
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