function [] = KLT_checkQoutputs(app)

if app.videoNumber == 1 || app.startingVideo == 1
    
    app.QfileOut = strjoin({app.directory_save, '\', ...
        'stage_discharge.csv'},'');
    if exist(app.QfileOut, 'file')
        answer = questdlg('Existing output already found. Overwrite?', ...
            'Continue?', ...
            {'Yes','No'});
        
        switch answer
            case 'Yes'
                TextIn = {'Overwriting the .csv file with new discharge data.'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                
            case 'No'
                newAppend = datestr(datetime('now'),'ddmmyyyy_HHMM');
                app.QfileOut = strjoin({app.directory_save, '\', ...
                    'stage_disharge_', newAppend, '.csv'},'');
                TextIn = {strjoin({'Creating new file: ', app.QfileOut  },'')};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                pause(0.01)
            case 'Cancel'
                newAppend = datestr(datetime('now'),'ddmmyyyy_HHMM');
                app.QfileOut = strjoin({app.directory_save, '\', ...
                    'stage_disharge_', newAppend, '.csv'},'');
                TextIn = {strjoin({'Creating new file: ', app.QfileOut  },'')};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                pause(0.01)
        end
    end
end

end
