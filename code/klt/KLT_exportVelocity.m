function [] = KLT_exportVelocity(app)

if strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
    Ze1 = app.refValue;
    labels = {'X [m]', 'Y [m]', 'X component [m/s]', 'Y component [m/s]', 'Velocity magnitude [m/s]'};
elseif strcmp(app.VelocityDropDown.Value, 'Downstream Component') == 1
    Ze1 = app.downstreamVelocity(:,1);
    labels = {'X [m]', 'Y [m]', 'X component [m/s]', 'Y component [m/s]', 'Downstream Component [m/s]'};
    %Ze2 = app.tangentialVelocity(:,1);
end
outVars = ([app.xyzA_final, app.adjustedVel, Ze1]); % Populate the array
outVars = round(outVars*100)/100; % Round to two decimal places
dataOut = [labels;num2cell(outVars)];

if strcmp(app.ExporttrajectoriesSwitch.Value, 'On') == 1
    
    TextIn = {'Initiating the export of velocity outputs'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    TextIn = {'Export started. Please wait.'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
        writetable( cell2table(dataOut), strjoin({app.directory_save_multiple, '\', ...
            app.file(1:end-4), '_', char(datetime(now,'ConvertFrom','datenum','format', 'yyyyMMddHHmm' )), ...
            '_VelocityOutputs.csv'},''), ...
            'writevariablenames', false, 'quotestrings', true)
        TextIn = strjoin({'Export completed. Saved to ' app.directory_save_multiple},'');
    elseif strcmp (app.ProcessingModeDropDown.Value, 'Numerical Simulation') == true
        temperA1 = app.fileNameAnalysis{app.videoNumber};
        writetable( cell2table(dataOut), strjoin({app.directory_save, '\', ...
            temperA1(1:end-4), ...
            '_VelocityOutputs.csv'},''), ...
            'writevariablenames', false, 'quotestrings', true)
    else
        writetable( cell2table(dataOut), strjoin({app.directory_save, '\', ...
            app.file(1:end-4), '_', char(datetime(now,'ConvertFrom','datenum','format', 'yyyyMMddHHmm' )), ...
            '_VelocityOutputs.csv'},''), ...
            'writevariablenames', false, 'quotestrings', true);
    end
    
    TextIn = strjoin({'Export completed. Saved to ' app.directory_save},'');
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
end %if strcmp
end % function