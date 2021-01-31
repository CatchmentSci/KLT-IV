function [] = saveState(app)
TextIn = {'Saving the current settings. Please wait.'};
app.ListBox.Items = [app.ListBox.Items, TextIn'];
KLT_printItems(app)
pause(0.01);
app.ListBox.scroll('bottom');
if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == true
    s1 = 1;
    app.flexVars = {'ResolutionmpxEditField.Value', 'SearchDistanceEditField.Value', 'alphaEditField.Value',...
        'CameraxyzEditField.Value', 'CameraxyzEditField_2.Value', 'CameraxyzEditField_3.Value',...
        'yawpitchrollEditField.Value', 'yawpitchrollEditField_2.Value', 'yawpitchrollEditField_3.Value',...
        'ExtractionratesEditField.Value', 'BlocksizepxEditField.Value', ...
        'BufferaroundGCPsmetersEditField', 'WatersurfaceelevationmEditField.Value',...
        'AddVideoButton.Text','file', 'directory',...
        'f', 'c', 'k', 'p', 'rmse', 'CameraTypeDropDown.Value', ...
        'OrientationDropDown.Value', 'CustomFOVEditField_2', ...
        'CustomFOVEditField_3', 'CustomFOVEditField_4', 'TransX', 'TransY', ...
        'Transdem', 'X', 'Y', 'dem', 'rgbHR', ...
        'camA', 'UITable.Data', 'frame_uas_x', 'frame_uas_y', ...
        'frame_uas_z', 'previousFrame', 'firstOrthoImage',...
        'IgnoreEdgesDropDown.Value', 'VelocityDropDownLabel.Text', ...
        'GCPDataDropDown.Value', 'CheckGCPsSwitch.Value', 'imgsz', ...
        'VelocityDropDown.Value', 'gcpA_checked'};
elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
    s = 2;
    props = properties(app);
    for ii=s:length(props)
        try
            currentProperty = getfield(app, char(props(ii)));
            if sum(double(strcmp(char(props(ii)),{'WEBWINDOW';'scrollPane';'ControlsPanel';'CONTROLDIMS';'ControlHandles'}) > 0))
                continue
            end
            s1 = whos('currentProperty');
            S{ii} = getfield(app,char(props(ii)));
            pause 0.1
        catch
        end
    end
    
    % Save the files from the workspace to the hard drive and
    % start a new instance of the app
    save('KLTworkspace.mat', 'S');
    close(app.KLTIVbetav1_0_UIFigure) % close the original instance
    app = app1_1; % Create a new instance of the app
    S=load('KLTworkspace.mat');
    S = S.S;
    
    % Assign the correct values to the variables
    for ii=s:length(props)
        try
            currentProperty = S{ii};
            s1 = whos('currentProperty');
            if sum(double(strcmp(char(props(ii)),{'WEBWINDOW';'scrollPane';'ControlsPanel';'CONTROLDIMS';'ControlHandles'}) > 0))
                continue
            end
            app = setfield(app,char(props(ii)),currentProperty)
            
            try % only certain vars have this
                eval(['app.' char(props(ii)) '.Visible = "Off";']);
                pause(0.5)
                eval(['app.' char(props(ii)) '.Visible = "On";']);
                pause(0.5)
            catch
                pause(0.5)
            end

        catch
        end
    end
    app.reloaded = 1;
end

end