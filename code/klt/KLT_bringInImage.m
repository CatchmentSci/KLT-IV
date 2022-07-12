function KLT_bringInImage(app) % Extract the first image from the video

if strcmp (app.ProcessingModeDropDown.Value, 'Single Video') == 1
    answer = questdlg('Would you like to re-encode the video(s)? (Default: No)', ...
        'Re-encode Video?', ...
        {'Yes','No'});
    
    switch answer
        case 'Yes'
            ffmpeg_conversion(app)
            
        case 'No'
            % Load in the original file
            try
                textOutput = strjoin({app.directory, app.file}, '');
                V=VideoReader(textOutput);
                I = rgb2gray(readFrame(V)); % new method for large files
                app.firstFrame = I;
                app.imgsz = [V.Height V.Width];
                TextIn = {'Original video succesfully loaded, please continue'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            catch
                TextIn = {'No video selected. The program will terminate. Check inputs and retry'}; % Update the display
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                error('Breaking out of function');
            end
            
        case 'Cancel'
            try
                % Load in the original file
                textOutput = strjoin({app.directory, app.file}, '');
                V=VideoReader(textOutput);
                I = rgb2gray(readFrame(V)); % new method for large files
                app.firstFrame = I;
                app.imgsz = [V.Height V.Width];
                TextIn = {'Original video succesfully loaded, please continue'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            catch
                TextIn = {'No video selected. The program will terminate. Check inputs and retry'}; % Update the display
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                error('Breaking out of function');
            end
    end
end
end