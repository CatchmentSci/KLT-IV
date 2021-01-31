function []  = creatingVideosFromImages_KLT(app, pass, answer)

if strcmp(answer,'Yes') == 1 % only run if new frames have been written
    if pass > 2
        pass = 2;
    end
    
    % insert a check incase the existing stabilised files are used. This
    % checks whether outputs for one or two passes are available and
    % chooses the highest output.
    inputLocation = [app.directory_save '\stabilisedFrames\pass' num2str(pass)];
    if exist(inputLocation,'dir') > 0
        inputLocation = inputLocation;
    else
        pass = pass - 1;
        inputLocation = [app.directory_save '\stabilisedFrames\pass' num2str(pass)];
    end
    
    listing = dir(inputLocation);
    for a = 1:length(listing)
        listingName(a,1) = cellstr(listing(a).name);
    end
    
    listingName = listingName(contains(listingName,'.jpg'));
    writerObj = VideoWriter([inputLocation '\stabilisedFramesOut.avi']);
    writerObj.FrameRate =  app.videoFrameRate; %app.videoFrameRate./app.iter;
    open(writerObj);
    
    h = figure('Visible', 'off');
    cmap = colormap(gray(256));
    clear h
    
    TextIn = {'Generating a video using the stabilised frames. Please wait.'};
    app.ListBox.Items = [app.ListBox.Items, TextIn];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    for u=1:length(listingName)
        fullNameIn = strjoin([inputLocation '\' listingName(u,1)],'');
        I = imread(fullNameIn);
        frame = im2frame(I,cmap);
        writeVideo(writerObj, frame);
    end
    
    close(writerObj);
    line1 = {['Video of image sequence saved to:' ]};
    line2 = {[inputLocation '\stabilisedFramesOut.avi']};
    app.ListBox.Items = [app.ListBox.Items, line1, line2];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
end

end