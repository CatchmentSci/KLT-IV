function []  = ffmpeg_conversion(app)

t = 1;
while t < 3
    st1 = strfind(app.file,'.'); %find the full stops in the filename
    st1 = st1(end); % find the character index of the last one
    
    % First convert to an mkv file
    commandIn = ['-i "' strjoin({app.directory, app.file}, '') '" -c:v libx264 -y ' ...
        '"' strjoin({app.directory,app.file(1:st1-1)}, '') '_KLT.mkv"' ];
    
    TextIn = {'Converting the video to an optimal format. Please wait'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    % Create the duplicate file using ffmpeg
    if exist('ffmpeg.exe','file') > 0  && strcmp(app.file(st1-3:st1-1),'KLT') == 0
        try
            ffmpegexec (commandIn); % convert to an mkv format first to ensure the correct frame rate is retained
            app.file = [app.file(1:st1-1) '_KLT.mkv'];
            textOutput = strjoin({app.directory, app.file } , '');
            
            % Then convert back to an mp4 file with the correct metadata
            commandIn = ['-i "' strjoin({app.directory, app.file}, '') '" -c copy -y ' ...
                '"' strjoin({app.directory,app.file(1:st1-1)}, '') '_KLT.mp4"' ];
            
            % Create the duplicate file using ffmpeg
            ffmpegexec (commandIn); % convert back to an mp4 format
            app.file = [app.file(1:st1-1) '_KLT.mp4'];
            textOutput = strjoin({app.directory, app.file } , '');
            delete([strjoin({app.directory,app.file(1:st1-1)}, '') '_KLT.mkv"' ]) % Delete the .mkv
            
            % Method of loading the video
            V = VideoReader(textOutput);
            I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
            app.firstFrame = I;
            app.imgsz = [V.Height V.Width];
            
            TextIn = {'Conversion complete. Please continue'};
            app.ListBox.Items = [app.ListBox.Items, TextIn'];
            printItems(app)
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
            textOutput = strjoin({app.directory, app.file}, '');
            V=VideoReader(textOutput);
            I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
            app.firstFrame = I;
            app.imgsz = [V.Height V.Width];
            t = 3;
        end
    else
        % Incase of error load in the original file
        textOutput = strjoin({app.directory, app.file}, '');
        V=VideoReader(textOutput);
        I = images.internal.rgb2graymex(readFrame(V)); % new method for large files
        app.firstFrame = I;
        app.imgsz = [V.Height V.Width];
        t = 3;
    end
end