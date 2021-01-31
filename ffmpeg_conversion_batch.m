function []  = ffmpeg_conversion_batch(app)

if isempty(app.videoNumber) || app.videoNumber == 1 || app.startingVideo == 1 
app.batchAnswer = questdlg('Would you like to re-encode the video(s)? (Default: No)', ...
    'Re-encode Video?', ...
    {'Yes','No'});
end

switch app.batchAnswer
    
    case 'Yes'
        
        t = 1;
        while t < 3

            fileIn = char(app.fileNameAnalysis(app.videoNumber));
            st1 = strfind(fileIn,'.'); %find the full stops in the filename
            st1 = st1(end); % find the character index of the last one
            try
                st1 = cell2mat(st1);
            catch
            end
            
            % First convert to an mkv file
            commandIn = ['-i "' [app.directory '\' fileIn] '" -c:v libx264 -y ' ...
                '"' [app.directory '\' fileIn(1:st1-1)] '_KLT.mkv"' ];
            
            TextIn = {'Converting the video to an optimal format. Please wait'};
            app.ListBox.Items = [app.ListBox.Items, TextIn'];
            KLT_printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
            
            % Create the duplicate file using ffmpeg
            if exist('ffmpeg.exe','file') > 0  && strcmp(fileIn(st1-3:st1-1),'KLT') == 0
                try
                    ffmpegexec (commandIn); % convert to an mkv format first to ensure the correct frame rate is retained
                    fileIn = [fileIn(1:st1-1) '_KLT.mkv'];
                    textOutput = [app.directory '\' fileIn ];
                    
                    % Then convert back to an mp4 file with the correct metadata
                    commandIn = ['-i "' [app.directory '\' fileIn] '" -c copy -y ' ...
                        '"' [app.directory '\' fileIn(1:st1-1)] '_KLT.mp4"' ];
                    
                    % Create the duplicate file using ffmpeg
                    ffmpegexec (commandIn); % convert back to an mp4 format
                    fileIn = [fileIn(1:st1-1) '_KLT.mp4'];
                    textOutput = [app.directory '\' fileIn ];
                    delete([app.directory '\' fileIn(1:st1-1) '_KLT.mkv"' ]) % Delete the .mkv
                    
                    % Method of loading the video
                    V = VideoReader(textOutput);
                    I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                    app.firstFrame = I;
                    app.imgsz = [V.Height V.Width];
                    
                    TextIn = {'Conversion complete. Please continue'};
                    app.ListBox.Items = [app.ListBox.Items, TextIn'];
                    KLT_printItems(app)
                    pause(0.01);
                    app.ListBox.scroll('bottom');
                    t = 3;
                    
                catch
                    % Perhaps run the ffmpegsetup here in case it exists
                    % Incase of error load in the original file
                    if exist('ffmpegsetup.m','file') > 0 && t == 1
                        try
                            %ffmpegsetup
                        catch
                        end
                    end
                    textOutput = strjoin({app.directory, fileIn}, '');
                    V=VideoReader(textOutput);
                    I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                    app.firstFrame = I;
                    app.imgsz = [V.Height V.Width];
                    t = 3;
                end
            else
                % Incase of error load in the original file
                textOutput = strjoin({app.directory, fileIn}, '');
                V=VideoReader(textOutput);
                I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                app.firstFrame = I;
                app.imgsz = [V.Height V.Width];
                t = 3;
            end
        end
        
        
    case 'No'
        % Load in the original file
        if strcmp (app.ProcessingModeDropDown.Value, 'Single Videos') == 1
            try
                textOutput = strjoin({app.directory, app.file}, '');
                V=VideoReader(textOutput);
                I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
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
        
    case 'Cancel'
        if strcmp (app.ProcessingModeDropDown.Value, 'Single Videos') == 1
            try
                % Load in the original file
                textOutput = strjoin({app.directory, app.file}, '');
                V=VideoReader(textOutput);
                I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
                app.firstFrame = I;
                app.imgsz = [V.Height V.Width];
                TextIn = {'Original video succesfully loaded, please continue'};
                app.ListBox.Items = [app.ListBox.Items, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            catch
                TextIn = {'No video selected. The program will terminate. Check inputs and retry'}; % Update the display
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
                error('Breaking out of function');
            end
        end
end

app.fileNameAnalysis{app.videoNumber} = fileIn; % overwrite if neccessary

end