function [] = KLT_appendQoutputs(app)


if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
    
    KLT_checkQoutputs(app)
    
    try
        % Write the data to a csv file
        
        outVars(:,1)    = cellstr(datestr(cell2mat(app.riverLevelTimeAnalysis), 'dd/mm/yyyy HH:MM'));
        outVars(:,2)    = num2cell(app.riverLevelAnalysis)';
        [sizer1,~]      = size(app.totalQ);
        
        if sizer1 == 1 % if only one q output
            tempOut             = round(app.totalQ*100)/100'; % Round to two decimal places
            t1                  = max(find(~isnan(tempOut(1,:))));
            tempOut             = tempOut(1,1:t1);
            [~, sizer2]         = size(tempOut);
            labels              = {'DateTime', 'Stage [m]', 'Mean velocity [m/s]', 'Discharge [m3/s]'};
            
            if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1
                app.compiled_refVal = num2cell(nanmean(app.refValue));
            else
                app.compiled_refVal = [app.compiled_refVal; num2cell(nanmean(app.refValue))];
            end
            
            outVars(1:sizer2,3) = num2cell(app.compiled_refVal);
            outVars(1:sizer2,4) = num2cell(tempOut);
            dataOut             = [labels;outVars];
            writetable (cell2table(dataOut), app.QfileOut, ...
                'writevariablenames', false, 'quotestrings', true);
            
        else % all three q outputs
            tempOut         = round(app.totalQ*100)/100; % Round to two decimal places
            t1              = max(find(~isnan(tempOut(1,:))));
            tempOut         = tempOut(1:3,1:t1);
            [~, sizer2]     = size(tempOut);
            labels          = {'DateTime', 'Stage [m]', 'Mean velocity [m/s]', ...
                'Discharge [m3/s; quadratic]', 'Discharge [m3/s; cubic]', ...
                'Discharge [m3/s; froude]'};
            
            if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1
                app.compiled_refVal = num2cell(nanmean(app.refValue));
            else
                app.compiled_refVal = [app.compiled_refVal; num2cell(nanmean(app.refValue))];
            end
            
            outVars(1:sizer2,3) = app.compiled_refVal;
            outVars(1:sizer2,4:4+sizer1-1) = num2cell(tempOut)';
            dataOut         = [labels;outVars];
            writetable(cell2table(dataOut), app.QfileOut, ...
                'writevariablenames', false, 'quotestrings', true);
        end
        
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
