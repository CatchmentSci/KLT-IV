function KLT_planetscopePairToVideo(app, selectedImages, timeSeparation)
    % KLT_planetscopePairToVideo - Creates a video from a pair of PlanetScope images
    % and their associated XML and JSON metadata files, aligning the second image
    % vertically according to the computed transformation.
    %
    % This function assumes that selectedImages is a structure array (e.g. the
    % ImageGroups produced by load_planetscope_files.m) with fields:
    %   id         - Common identifier for the image group.
    %   tif        - The TIFF image data.
    %   xml        - The XML metadata.
    %   json       - The JSON metadata (containing properties.gsd).
    %   rgb        - The pre-computed RGB composite.
    %   utmCorners - The UTM bounding box (four corners) computed from the XML.
    %
    % The function calculates the vertical translation from the UTM centroids
    % (converted to pixel units via the ground sampling distance, gsd) and applies
    % that translation solely in the vertical (y) direction to the second image.
    % Prior to video creation, the user is prompted to select a region of interest
    % (ROI) to crop the frames. A video is then created with the cropped frames,
    % at a frame rate determined by timeSeparation.
    %
    % Inputs:
    %   app            - The application object.
    %   selectedImages - Structure array containing the grouped images.
    %   timeSeparation - The time separation between image captures (in seconds).
    
    % -------------------------------------------------------------------------
    for i = 1:length(selectedImages)                             % Loop over the two images
        if ~isfield(selectedImages(i),'rgb') || isempty(selectedImages(i).rgb)
            ms = selectedImages(i).tif;                          % Multispectral image cube (DN)
            
            if ~isa(ms,'double'), ms = double(ms); end           % Use double for safe math
            coeffs = ones(1,4);                                  % Default scales if metadata missing
            
            try
                assets     = selectedImages(i).json.assets;      % JSON assets block
                assetNames = fieldnames(assets);                 % Asset keys (strings)
    
                % Pick the correct AnalyticMS asset (avoid metadata-only entries)
                pick = contains(assetNames,'_1B_AnalyticMS_tif') & ~contains(assetNames,'metadata');
                if ~any(pick)
                    pick = contains(assetNames,'AnalyticMS_tif') & ~contains(assetNames,'metadata');
                end
                tifAssetName = assetNames{find(pick,1,'first')}; % Asset name string
    
                % MATLAB converts 'raster:bands' to 'raster_bands'
                if isfield(assets.(tifAssetName),'raster_bands')
                    rb = assets.(tifAssetName).raster_bands;
                else
                    rb = assets.(tifAssetName).(matlab.lang.makeValidName('raster:bands'));
                end
    
                coeffs = arrayfun(@(b) b.scale, rb(1:4));        % Per-band scale factors [B,G,R,NIR]
            catch ME
                warning('Scale factors missing for %s: %s. Using ones.', selectedImages(i).id, ME.message);
            end
    
            nb = min(4, size(ms,3));                             % Number of bands available (≤4)
            radiance = zeros(size(ms));                          % Allocate scaled image cube
            
            for b = 1:nb
                radiance(:,:,b) = ms(:,:,b) * coeffs(b);         % Apply radiometric scale (approx. reflectance)
            end
    
            if size(radiance,3) >= 3
                rgb = radiance(:,:, [3, 2, 1]);                  % Make RGB as [R,G,B] = [band3, band2, band1]
            else
                rgb = mat2gray(ms(:,:,1:min(3,end)));            % Fallback if <3 bands exist
            end
    
            selectedImages(i).rgb = min(max(rgb,0),1);           % Clamp to [0,1] just in case
        end
    end
    
    assignin('base','selectedImages',selectedImages);            % Expose to base workspace (debug convenience)
    
    % -------------------------------------------------------------------------
    % Ensure that each image group has UTM bounding boxes; if not, compute them.
    if ~isfield(selectedImages,'utmCorners') || isempty(selectedImages(1).utmCorners)
        if isempty(selectedImages(1).xml)
            error('First image has no XML; cannot compute UTM bounding box.');
        else
            xmlDoc = selectedImages(1).xml;                      % XML DOM for first image
            try
                % Read corner lat/lon for EPSG inference (use center lat/lon)
                tLat  = str2double(xmlDoc.getElementsByTagName('ps:topLeft').item(0).getElementsByTagName('ps:latitude' ).item(0).getTextContent());
                trLat = str2double(xmlDoc.getElementsByTagName('ps:topRight').item(0).getElementsByTagName('ps:latitude').item(0).getTextContent());
                brLat = str2double(xmlDoc.getElementsByTagName('ps:bottomRight').item(0).getElementsByTagName('ps:latitude').item(0).getTextContent());
                blLat = str2double(xmlDoc.getElementsByTagName('ps:bottomLeft').item(0).getElementsByTagName('ps:latitude').item(0).getTextContent());
                centreLat = mean([tLat,trLat,brLat,blLat]);      % Mean latitude
    
                tLon  = str2double(xmlDoc.getElementsByTagName('ps:topLeft').item(0).getElementsByTagName('ps:longitude' ).item(0).getTextContent());
                trLon = str2double(xmlDoc.getElementsByTagName('ps:topRight').item(0).getElementsByTagName('ps:longitude').item(0).getTextContent());
                brLon = str2double(xmlDoc.getElementsByTagName('ps:bottomRight').item(0).getElementsByTagName('ps:longitude').item(0).getTextContent());
                blLon = str2double(xmlDoc.getElementsByTagName('ps:bottomLeft').item(0).getElementsByTagName('ps:longitude').item(0).getTextContent());
                centreLon = mean([tLon,trLon,brLon,blLon]);      % Mean longitude
    
                zone = floor((centreLon + 180)/6) + 1;           % UTM zone by longitude
                if centreLat >= 0
                    epsg_code = 32600 + zone;                    % Northern hemisphere
                else
                    epsg_code = 32700 + zone;                    % Southern hemisphere
                end
                fprintf('Automatically determined EPSG: %d (UTM Zone %d)\n', epsg_code, zone);
                utmCrs = projcrs(epsg_code);                     % Create projected CRS
            catch ME
                warning('%s', sprintf('Could not determine UTM CRS automatically: %s. Defaulting to EPSG:32619.', ME.message));
                utmCrs = projcrs(32619);                         % Safe fallback
            end
        end
    
        % Compute UTM corner coordinates for each image
        for i = 1:length(selectedImages)
            if isempty(selectedImages(i).xml)
                error('Image %s has no XML; cannot compute UTM bounding box.', selectedImages(i).id);
            end
            xmlDoc = selectedImages(i).xml;                      % DOM for image i
            try
                % Extract lat/lon corners from XML
                topLeftLat     = str2double(xmlDoc.getElementsByTagName('ps:topLeft'    ).item(0).getElementsByTagName('ps:latitude' ).item(0).getTextContent());
                topLeftLon     = str2double(xmlDoc.getElementsByTagName('ps:topLeft'    ).item(0).getElementsByTagName('ps:longitude').item(0).getTextContent());
                topRightLat    = str2double(xmlDoc.getElementsByTagName('ps:topRight'   ).item(0).getElementsByTagName('ps:latitude' ).item(0).getTextContent());
                topRightLon    = str2double(xmlDoc.getElementsByTagName('ps:topRight'   ).item(0).getElementsByTagName('ps:longitude').item(0).getTextContent());
                bottomRightLat = str2double(xmlDoc.getElementsByTagName('ps:bottomRight').item(0).getElementsByTagName('ps:latitude' ).item(0).getTextContent());
                bottomRightLon = str2double(xmlDoc.getElementsByTagName('ps:bottomRight').item(0).getElementsByTagName('ps:longitude').item(0).getTextContent());
                bottomLeftLat  = str2double(xmlDoc.getElementsByTagName('ps:bottomLeft' ).item(0).getElementsByTagName('ps:latitude' ).item(0).getTextContent());
                bottomLeftLon  = str2double(xmlDoc.getElementsByTagName('ps:bottomLeft' ).item(0).getElementsByTagName('ps:longitude').item(0).getTextContent());
    
                % Project lat/lon to UTM x/y (metres)
                [xTL,yTL] = projfwd(utmCrs, topLeftLat,     topLeftLon);
                [xTR,yTR] = projfwd(utmCrs, topRightLat,    topRightLon);
                [xBR,yBR] = projfwd(utmCrs, bottomRightLat, bottomRightLon);
                [xBL,yBL] = projfwd(utmCrs, bottomLeftLat,  bottomLeftLon);
    
                % Store 4x2 matrix of corner coordinates
                selectedImages(i).utmCorners = [xTL,yTL; xTR,yTR; xBR,yBR; xBL,yBL];
            catch ME
                warning('Failed to compute utmCorners for %s: %s', selectedImages(i).id, ME.message);
            end
        end
    end
    
    
    % -------------------------------------------------------------------------
    % Create the output video file name and determine frame rate.
    [~, outputVideoName, ~] = fileparts(selectedImages(1).paths.tif);  % Base name from first TIF path
    outputVideoPath = fullfile(fileparts(selectedImages(1).paths.tif), [outputVideoName, '.avi']); % AVI path
    frameRate = 1 / timeSeparation;                                    % FPS from time separation
    
    outputVideo = VideoWriter(outputVideoPath, 'Motion JPEG AVI');     % MJPEG for compatibility
    outputVideo.FrameRate = frameRate;                                 % Set frame rate
    if isprop(outputVideo,'Quality'), outputVideo.Quality = 100; end   % Highest quality if supported
    open(outputVideo); 

    % -------------------------------------------------------------------------
    % Compute the relative translation using the UTM centroids (vertical only).
    centroid1 = mean(selectedImages(1).utmCorners, 1);                 % UTM centroid image 1
    centroid2 = mean(selectedImages(2).utmCorners, 1);                 % UTM centroid image 2
    translation_m = centroid2 - centroid1;                             % Delta (metres)
    
    gsd1 = selectedImages(1).json.properties.gsd;                      % GSD 1 (m/px)
    gsd2 = selectedImages(2).json.properties.gsd;                      % GSD 2 (m/px)
    gsdFinal = mean([gsd1, gsd2]);                                     % Mean GSD (m/px)
    
    translation_pix = translation_m / gsdFinal;                        % Delta in pixels
    adjustedTranslation = [0, -translation_pix(2)];                    % Keep vertical only (dx=0)
    
    dy_float = adjustedTranslation(2);                                 % Fractional vertical shift
    dy_int   = round(dy_float);                                        % Integer shift to avoid blur
    dy_frac  = dy_float - dy_int;                                      % Residual (left to stabiliser)
    
    % Apply integer vertical shift with nearest-neighbour (no interpolation blur)
    transformedImage2 = imtranslate(selectedImages(2).rgb, [0 dy_int], 'nearest', 'FillValues', NaN);


    % -------------------------------------------------------------------------
    % Integer-only vertical translation (NO interpolation blur).
    dy_float = adjustedTranslation(2);     % fractional vertical shift (px)
    dy_int   = round(dy_float);            % integer shift we will actually apply
    dy_frac  = dy_float - dy_int;          % residual left for stabiliser later
    
    % Apply integer shift using nearest (no smoothing). Pad with NaN to mark no-data.
    transformedImage2 = imtranslate(selectedImages(2).rgb, [0 dy_int], 'nearest', 'FillValues', NaN);

    % -------------------------------------------------------------------------
    % Crop the frames by manually selecting an AOI.
    figure;                                                            % New figure for ROI selection
    imshow(selectedImages(1).rgb);                                     % Show first image for context
    title('Select the ROI, then double-click or press Enter.');        % ROI guidance
    hRect = drawrectangle;                                             % Interactive rectangle
    roi = round(hRect.Position);                                       % [x y w h], rounded to pixels
    close(gcf);                                                        % Close ROI figure
    
    frame1_raw = imcrop(selectedImages(1).rgb, roi);                   % Crop frame 1 RGB
    frame2_raw = imcrop(transformedImage2, roi);                       % Crop frame 2 RGB (already shifted)


    % -------------------------------------------------------------------------
    % Micro-alignment (translation-only, integer-only) to minimise blur.
    doMicroAlign = false;                                              % Toggle ON only if needed
    if doMicroAlign
        I1 = rgb2gray(frame1_raw);                                     % Grayscale for correlation
        I2 = rgb2gray(frame2_raw);                                     % Grayscale for correlation
    
        m1 = ~any(isnan(frame1_raw),3);                                % Valid pixels mask (frame 1)
        m2 = ~any(isnan(frame2_raw),3);                                % Valid pixels mask (frame 2)
        overlap = m1 & m2;                                             % Overlap region
    
        tau = 0.03;                                                    % Intensity change tolerance
        staticMask = overlap & isfinite(I1) & isfinite(I2) & (abs(I2 - I1) < tau); % Static areas
        G = imgradient(I1);                                            % Gradient magnitude (texture)
        if any(staticMask(:))                                         
            gthr = prctile(G(staticMask), 50);                         % Median gradient in static area
            staticMask = staticMask & (G >= gthr);                     % Keep textured static pixels
        end
    
        refA = I1; movA = I2;                                          % Copies for masking
        refA(~staticMask) = 0; movA(~staticMask) = 0;                  % Zero non-static pixels
    
        tform = imregcorr(movA, refA, 'translation');                  % Estimate sub-pixel translation
        dx_f = tform.T(3,1);  dy_f = tform.T(3,2);                     % Extract (dx,dy)
        dx_i = round(dx_f);  dy_i = round(dy_f);                       % Round to integers (avoid blur)
    
        frame2_raw = imtranslate(frame2_raw, [dx_i dy_i], 'nearest', 'FillValues', NaN); % Apply integer shift
    end

    % -------------------------------------------------------------------------
    % Convert to double for processing + build valid masks (post-shift/crop)
    f1 = im2double(frame1_raw);                                        % Frame 1 as double [0,1]
    f2 = im2double(frame2_raw);                                        % Frame 2 as double [0,1]
    mask1 = ~any(isnan(frame1_raw), 3);                                % Valid pixels (frame 1)
    mask2 = ~any(isnan(frame2_raw), 3);                                % Valid pixels (frame 2)


    % -------------------------------------------------------------------------
    % Image Pre-Processing (choose one mode)
    % Options:
    %  'jointStretch' - Joint linear stretch (per channel) using both frames.
    %  'histMatch'    - Match frame-2 histogram to frame-1 (per channel),
    %                   then apply a mild shared stretch (per channel).
    mode = 'histMatch';                                                % Default (recommended)
    
    switch mode
        % -----------------------------
        case 'jointStretch'
            commonLow  = zeros(1,3);                                   % Per-channel lower cut
            commonHigh = ones(1,3);                                    % Per-channel upper cut
            for c = 1:3                                                % For R,G,B
                v1 = f1(:,:,c); v1 = v1(mask1);                        % Valid samples (frame 1)
                v2 = f2(:,:,c); v2 = v2(mask2);                        % Valid samples (frame 2)
                vals = [v1; v2];                                       % Pool both frames
                if ~isempty(vals)
                    p = prctile(vals,[1 98]);                          % Robust percentiles
                    if ~all(isfinite(p)) || p(2) <= p(1), p = [0 1]; end % Safety fallback
                    commonLow(c)  = p(1);                              % Store lower cut
                    commonHigh(c) = p(2);                              % Store upper cut
                else
                    commonLow(c)=0; commonHigh(c)=1;                   % No stats -> full range
                end
            end
    
            frame1 = zeros(size(f1)); frame2 = zeros(size(f2));        % Allocate outputs
            for c = 1:3                                                % Apply same stretch to both
                frame1(:,:,c) = imadjust(f1(:,:,c), [commonLow(c) commonHigh(c)], []);
                frame2(:,:,c) = imadjust(f2(:,:,c), [commonLow(c) commonHigh(c)], []);
            end
    
        % -----------------------------
        case 'histMatch'
            nBins  = 256;                                              % Histogram resolution
            frame1 = zeros(size(f1));                                  % Output frame 1 (reference look)
            frame2 = zeros(size(f2));                                  % Output frame 2 (matched to frame 1)
    
            for c = 1:3                                                % Process R,G,B independently
                ch1 = f1(:,:,c);                                       % Channel from frame 1
                ch2 = f2(:,:,c);                                       % Channel from frame 2
                v1  = ch1(mask1);                                      % Valid overlap samples (frame 1)
                v2  = ch2(mask2);                                      % Valid overlap samples (frame 2)
    
                if isempty(v1) || isempty(v2)                          % If no overlap…
                    frame1(:,:,c) = ch1;                               % …pass through frame 1
                    frame2(:,:,c) = ch2;                               % …pass through frame 2
                    continue                                           % Next channel
                end
    
                p1 = prctile(v1,[1 99]);                               % Trim tails (frame 1)
                p2 = prctile(v2,[1 99]);                               % Trim tails (frame 2)
                L  = min(p1(1), p2(1));                                % Shared low bound
                H  = max(p1(2), p2(2));                                % Shared high bound
                if ~isfinite(L) || ~isfinite(H) || H <= L              % Safety check
                    L = 0; H = 1;                                      % Fallback to full range
                end
    
                v1c = min(max(v1, L), H);                              % Clamp samples (frame 1)
                v2c = min(max(v2, L), H);                              % Clamp samples (frame 2)
    
                edges   = linspace(L, H, nBins+1);                     % Histogram bin edges
                centers = (edges(1:end-1)+edges(2:end))/2;             % Bin centers
    
                h1   = histcounts(v1c, edges);                         % Histogram (frame 1)
                h2   = histcounts(v2c, edges);                         % Histogram (frame 2)
                cdf1 = cumsum(h1);  cdf1 = cdf1 / max(cdf1(end), eps); % CDF (frame 1) in [0,1]
                cdf2 = cumsum(h2);  cdf2 = cdf2 / max(cdf2(end), eps); % CDF (frame 2) in [0,1]
    
                F2 = griddedInterpolant(centers, cdf2, 'linear','nearest'); % value -> CDF (frame 2)
    
                [cdf1u, ia1] = unique(cdf1);                           % Enforce strictly increasing CDF
                centers1u    = centers(ia1);                           % Match unique support
                Finv1 = griddedInterpolant(cdf1u, centers1u, 'linear','nearest'); % CDF -> value (frame 1)
    
                ch2c = min(max(ch2, L), H);                            % Clamp full channel (frame 2)
                u    = F2(ch2c);                                       % CDF position of each pixel (frame 2)
                y    = Finv1(u);                                       % Map to frame-1 intensity with same CDF
    
                frame1(:,:,c) = ch1;                                   % Keep frame 1 unchanged (reference)
                frame2(:,:,c) = y;                                     % Use matched values for frame 2
            end
    
            % Mild shared visibility stretch (applied equally to both frames)
            pctVis = [2 98];                                           % Gentle percentiles
            f1s = zeros(size(frame1)); f2s = zeros(size(frame2));      % Buffers
            for c = 1:3
                o1 = frame1(:,:,c); o2 = frame2(:,:,c);                % Channels after matching
                v1o = o1(mask1);  v2o = o2(mask2);                     % Valid overlap samples
                vals = [v1o; v2o];                                     % Pool stats
    
                if isempty(vals)
                    lims = [0 1];                                      % No stats -> full range
                else
                    lims = prctile(vals, pctVis);                      % Shared low/high
                    if ~all(isfinite(lims)) || lims(2) <= lims(1)
                        lims = [0 1];                                  % Safety fallback
                    end
                end
    
                f1s(:,:,c) = imadjust(o1, [lims(1) lims(2)], []);      % Apply same stretch to frame 1
                f2s(:,:,c) = imadjust(o2, [lims(1) lims(2)], []);      % …and to frame 2
            end
            frame1 = f1s; frame2 = f2s;                                % Replace with stretched versions
    
        % -----------------------------
        otherwise
            error('Unknown pre-processing mode: %s', mode);            % Guard for typos
    end

    % -------------------------------------------------------------------------
    % Safety: replace any NaNs/Infs (shouldn’t appear, but just in case)
    frame1(~isfinite(frame1)) = 0;                                     % Replace any NaN/Inf with 0
    frame2(~isfinite(frame2)) = 0;                                     % Replace any NaN/Inf with 0

    % -------------------------------------------------------------------------
    % Video Construction
    writeVideo(outputVideo, frame1);                                   % Write first frame
    writeVideo(outputVideo, frame2);                                   % Write second frame
    
    close(outputVideo);                                                % Close the AVI
    app.file = outputVideo.Filename;                                   % Store path in app
    fprintf('Video saved as: %s\n', outputVideo.Filename);             % Console message
    
    assignin('base','selectedImages',selectedImages);                  % Update debug variable

end