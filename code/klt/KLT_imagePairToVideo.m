function KLT_imagePairToVideo(app, selectedImages, timeSeparation)
    % KLT_imagePairToVideo - Creates a video from a pair of images with a specified time separation.
    %
    % Requirements:
    %   Image Dimensions - The height and width of the two images selected
    %   must be of equal dimensions.
    %   Time Separation  - The time separation between captures must be
    %   known. This value informs the frame rate of the video constructed.
    % 
    % Inputs:
    %   app              - The main application object.
    %   selectedImages   - A cell array containing the paths of the selected image pair.
    %   timeSeparation   - The time separation between the images in seconds.
    
    % Extract the first image's name (without extension) for output video name
    [~, outputVideoName, ~] = fileparts(selectedImages{1});
    
    % Define output video path, using the same directory as the selected images
    outputVideoPath = fullfile(fileparts(selectedImages{1}), [outputVideoName, '.avi']);

    % Calculate frame rate based on time separation
    frameRate = 1 / timeSeparation;
    
    % Create the VideoWriter object
    outputVideo = VideoWriter(outputVideoPath, 'Motion JPEG AVI');
    outputVideo.FrameRate = frameRate;
    open(outputVideo);
    
    % Notify the user of video creation progress
    TextIn = {['Creating video: ' outputVideoName '.avi at ' num2str(frameRate) ' fps.']};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app);
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    try
        % Read and write the two images as frames in the video
        for i = 1:2
            img = imread(selectedImages{i});
            
            % Check if the image has more than 3 channels (e.g., a multi-layered .tif file)
            if size(img, 3) > 3
                img = img(:, :, 1:3); % Retain only the first three channels (RGB)
            end
            
            % Convert single-channel (grayscale) images to RGB for consistency
            if size(img, 3) == 1
                img = cat(3, img, img, img); % Convert grayscale to RGB by duplicating the channel
            end
            
            % Write the image frame to the video
            writeVideo(outputVideo, img);
        end
        
        % Change app.file to the output video filename
        app.file = outputVideo.Filename;

        % Close the video file
        close(outputVideo);
        
        % Notify the user of successful video creation
        TextIn = {['Video saved as: ' outputVideoName '.avi']};
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app);
        pause(0.01);
        app.ListBox.scroll('bottom');
    catch ME
        % Handle any errors during the video creation process
        close(outputVideo); % Ensure the video is properly closed
        TextIn = {['Error creating video: ' ME.message]};
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app);
        pause(0.01);
        app.ListBox.scroll('bottom');
    end
end