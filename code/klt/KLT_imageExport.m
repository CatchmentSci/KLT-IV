function  [] = KLT_imageExport(app)
if strcmp (app.OrthophotosSwitch.Value, 'On') == 1
    A = double(app.objectFrame);
    
    if nanmax(A(:) > 1.01)
        A = A./255;
    end
        
    try
        A = rgb2gray(A);
    catch
        %disp('Already grayscale')
    end
    
    if strcmp(app.OrientationDropDown.Value,'Stationary: GCPs') == 1 ||... % Stable GCPs
            strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation + GCPs') == 1
        uvHR1 = app.uvHR(:,1);
        uvHR2 = app.uvHR(:,2);
        clear app.uvHR
        app.rgbHR=nan(size(app.dem,1),size(app.dem,2),1);
        for jj = 1:1 % only one as it is a grayscale image
            app.rgbHR(:,:,jj) = reshape(interp2(A(:,:,jj),uvHR1,uvHR2),size(app.rgbHR));
        end
    elseif strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation') == 1 % no GCPs
        app.rgbHR = app.objectFrame;
    else % if updated camera model is required
        [app.uvHR,~,app.inframeHR]=app.camA.project([app.X(:),app.Y(:), app.dem(:)]); % High res DEM input
        uvHR1 = app.uvHR(:,1);
        uvHR2 = app.uvHR(:,2);
        app.visHR(1:length(app.X(:,1)),1:length(app.Y(1,:))) = 1; % Same change here
        app.uvHR(~app.inframeHR|~app.visHR(:),:) = nan;
        app.rgbHR=nan(size(app.dem,1),size(app.dem,2),1);
        for jj = 1:1 % only one as it is a grayscale image
            app.rgbHR(:,:,jj) = reshape(interp2(A(:,:,jj),uvHR1,uvHR2),size(app.rgbHR));
        end
    end
    template = '00000';
    inputNum = num2str(app.s2);
    p1 = template(1:end-length(num2str(app.s2)));
    p2 = inputNum;
    fileNameIteration = [p1,p2];
    
    
    % Define the output dir of the orthophoto
        if app.directory_save == 0
            pause(0.1)
            filenameJpg = [ app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
            
        elseif ~isempty(app.directory_save_multiple)
            pause(0.1)
            dirIn = [app.directory_save_multiple '\orthorectified\'];
            mkdir (dirIn);
            filenameJpg = [dirIn '\' app.fileNameAnalysis{app.videoNumber}(1:end-4) '_frame' fileNameIteration '.jpg'];
        else
            pause(0.1)
            dirIn = [app.directory_save '\orthorectified\'];
            mkdir (dirIn);
            filenameJpg = [dirIn '\' app.file(1:end-4) '_frame' fileNameIteration '.jpg'];
        end
        
    if strcmp (app.OrientationDropDown.Value,'Dynamic: GPS + Stabilisation') == 1
        % export the data
        x = app.currentFrame; % input from previous script
    elseif strcmp (app.OrientationDropDown.Value,'Dynamic: Stabilisation') == 1
        x = im2uint8(app.objectFrame);
    elseif app.prepro == 1
        x = im2uint8(app.objectFrame);
    else
        x = app.rgbHR ./ max(app.rgbHR(:));  % Scale to [0,1]
    end
    
    imwrite(x,filenameJpg)
    
    % Orthophoto saved display
    TextIn = {['Orthophoto for frame number ' num2str(app.s2) ' generated']};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
end
end