% Value changed function: GCPDataDropDown
function KLT_GCPDataDropDownValueChanged(app, ~)
app.GCPData = app.GCPDataDropDown.Value;

KLT_checkGcpCsvData(app)

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
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    app.imageGCPs = []; app.GCPimageReal = [];
    [app.imageGCPs, app.GCPimageReal] = KLT_readPoints(app.firstFrame,100,0); hold on;
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
    %KLT_UITableCellSelection(app) % disabled on 20220401 - error when used not clear why enabled
    %app.UITable.CellSelectionCallback = createCallbackFcn(app,@KLT_UITableCellSelection,true); - % can't be run outside of app
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
