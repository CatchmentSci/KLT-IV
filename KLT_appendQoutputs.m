function [] = KLT_appendQoutputs(app)


if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
    
    KLT_checkQoutputs(app)
    
    try
        % Write the data to a csv file
        labels = {'DateTime', 'Stage [m]', 'Discharge [m3/s]'};
        outVars(:,1) = cellstr(datestr(cell2mat(app.riverLevelTimeAnalysis), 'dd/mm/yyyy HH:MM'));
        outVars(:,2) = num2cell(app.riverLevelAnalysis)';
        tempOut = replace_num((round(app.totalQ*100)/100),NaN,[])'; % Round to two decimal places
        tempOut = num2cell(tempOut);
        outVars(1:length(tempOut),3) = tempOut;
        dataOut = [labels;outVars];
        writetable( cell2table(dataOut), app.QfileOut, ...
            'writevariablenames', false, 'quotestrings', true);
        
        TextIn = strjoin({'Export of discharge reading completed. Saved to ' app.directory_save_multiple},'');
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        pause(0.01)
        
    catch
        TextIn = strjoin({'Unable to write to the discharge .csv file, ensure it is not open elsewhere'});
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        pause(0.01)
        
    end
end

end
