function out = PIVlab_preproc (app,in,roirect,clahe, clahesize,highp,highpsize,intenscap,wienerwurst,wienerwurstsize,minintens,maxintens,backremoval)
%preprocessing does not change the image class anymore
%works with uint8, uint16, singe and double RGB and gray images.
%this function preprocesses the images

if size(in,3)>1
	in=rgb2gray(in); % rgb2gray keeps image class
end

if max(in,'omitnan') > 1
    in = in./255;
end

%th      = 10./255;
%a       = in(:,:,1)>th; % find pixel values greater than 10
%a       = bwareaopen(a,50); % find 50 connected pixels
%B       = bwboundaries(a,'noholes');
%B1      = B{1,1};
%k       = boundary(B1); %(:,1),B1(:,2),1); % [x,y]: outline
%filled  = polyshape (B1(k,2),B1(k,1)); % polyshape
%a1      = roipoly(in,filled.Vertices(:,1),filled.Vertices(:,2));
% in_roi = in(a1);

in_roi      = in; %(a1);
in_roi      = replace_num(in_roi,0,NaN);
idx         = ~isnan(in_roi);
in_roi(idx) = imadjust(in_roi(idx));
in_roi      = reshape(in_roi,size(in));

if backremoval == 1 && isempty(app.backgroundImage)
    
    startingFrame   = round(1 + (app.videoStart.*app.videoFrameRate));
    lastFrame       = floor(app.videoClip.*app.videoFrameRate);
    frameRange      = startingFrame:1:lastFrame;
    inputNum        = num2str(app.s2);
    template        = '00000';
    
    for a = 1:length(frameRange)
        inputNum        = num2str(frameRange(a));
        p1              = template(1:end-length(inputNum));
        p2              = inputNum;
        fileName        = [p1,p2];
        
        dirIn           = [app.directory_save '\stabilisedFrames'];
        files           = dir(dirIn);
        dirFlags        = [files.isdir];
        subDirs         = files(dirFlags);
        subDirsNames    = cell(1, numel(subDirs) - 2);
        for i=3:numel(subDirs)
            subDirsNames{i-2} = subDirs(i).name;
        end
        
        subDir          = num2str(numel(strfind(subDirsNames,'pass')));
        tempImage       = double(imread([dirIn '\pass' subDir '\' app.file(1:end-4) '_frame' fileName '.jpg']))./255;
        tempOrtho       = nan(size(app.dem,1),size(app.dem,2),1);
        tempOrtho(:,:,1)= reshape(interp2(tempImage(:,:,1),app.uvHR(:,1),app.uvHR(:,2)),size(app.rgbHR));
        %tempOrtho       = replace_num(tempOrtho,0,NaN);
        idx             = ~isnan(tempOrtho);
        tempOrtho(idx)  = imadjust(tempOrtho(idx));
        %tempOrtho       = replace_num(tempOrtho,0,NaN);
        %tempOrtho       = reshape(tempOrtho,size(in));
        
        if a == 1
            imTemplate      = zeros(numel(tempOrtho),1);
            idx             = find(~isnan(tempOrtho)); % find cells with image data
            imTemplate(idx) = imTemplate(idx) + 1; % increase the counter
            accum_image     = tempOrtho;
        else
            idx             = find(~isnan(tempOrtho));
            imTemplate(idx) = imTemplate(idx) + 1;
            temp_accum_image= accum_image(idx) + tempOrtho(idx);
            accum_image(idx)= temp_accum_image;
        end
    end
    
    imTemplate          = reshape(imTemplate,size(accum_image));
    app.backgroundImage = (accum_image./imTemplate); % create the ave based on cell data occurrence
    in_roi              = in_roi - app.backgroundImage;
    idx                 = ~isnan(in_roi);
    in_roi(idx)         = imadjust(in_roi(idx));
    
elseif backremoval == 1
    
    in_roi              = in_roi - app.backgroundImage;
    idx                 = ~isnan(in_roi);
    in_roi(idx)         = imadjust(in_roi(idx));
    
end


if intenscap == 1
    %Intensity Capping: a simple method to improve cross-correlation PIV results
    %Uri Shavit Æ Ryan J. Lowe Æ Jonah V. Steinbuck
    n = 2; 
    up_lim_im_1 = median(double(in_roi(:))) + n*std2(in_roi); % upper limit for image 1
    brightspots_im_1 = find(in_roi > up_lim_im_1); % bright spots in image 1
    capped_im_1 = in_roi; capped_im_1(brightspots_im_1) = up_lim_im_1; % capped image 1
    in_roi=capped_im_1;
end

if clahe == 1
    numberoftiles1=round(size(in_roi,1)/clahesize);
    numberoftiles2=round(size(in_roi,2)/clahesize);
    if numberoftiles1 < 2
    numberoftiles1=2;
    end
    if numberoftiles2 < 2
    numberoftiles2=2;
    end
    in_roi=adapthisteq(in_roi, 'NumTiles',[numberoftiles1 numberoftiles2], 'ClipLimit', 0.01, 'NBins', 256, 'Range', 'full', 'Distribution', 'uniform');
end

if highp == 1
    h           = fspecial('gaussian',highpsize,highpsize);
    in_roi      = replace_num(in_roi,NaN,0);
    in_roi      = (in_roi-(imfilter(in_roi,h,'replicate')));
end

if wienerwurst == 1
    in_roi      = wiener2(in_roi,[wienerwurstsize wienerwurstsize]);
end

out = in;
out = in_roi;