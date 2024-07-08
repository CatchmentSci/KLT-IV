function [pts, GCPimageReal] = KLT_readPoints(image, n, liner, app, a)
%readPoints   Read manually-defined points from image
%   POINTS = READPOINTS(IMAGE) displays the image in the current figure,
%   then records the position of each click of button 1 of the mouse in the
%   figure, and stops when another button is clicked. The track of points
%   is drawn as it goes along. The result is a 2 x NPOINTS matrix; each
%   column is [X; Y] for one point.
%
%   POINTS = READPOINTS(IMAGE, N) reads up to N points only.
if nargin < 2
    n = Inf;
    pts = zeros(2, 0);
else
    pts = zeros(2, n);
end

test1 = length(size(image));
if test1 == 3
    try
        f1 = figure('units', 'normalized', 'outerposition',[0 0 1 1]);
        image = rgb2gray(image);
    catch
        disp('Grayscale image being shown');
    end
end

if liner == 0 % Provide the input dialogue box for the manual coordaintes entry
    f1 = figure('units', 'normalized', 'outerposition',[0 0 1 1]);
    hold on;
    imshow(image); hold on;     % display image
    title  ('See dialog box for instructions');
    zoom on
end

if liner == 1 % downstream component
    f1 = figure('units', 'normalized', 'outerposition',[0 0 1 1]);
    hold on;
    imshow(image); hold on;     % display image
    title ('Register the streamwise direction of flow: using the right mouse button select the start and stop of a flow-line');
    zoom off
elseif liner == 2 % check GCPs
    imshow(image); hold on;     % display image
    title(['Check the location of each GCP marker. Use the left mouse button to zoom in and the right to assign a new GCP position. If no longer visible press "Esc"']);
    text(gca,app.gcpA(a,4)+10,app.gcpA(a,5)+10,['GCP ' num2str(a)], ...
        'backgroundColor', [1 1 1]);
    h = scatter(gca,app.gcpA(a,4),app.gcpA(a,5), 'b', 'o', 'filled');
    zoom on
elseif liner == 3 % Provide the input dialogue box for the manual coordaintes entry
    f1 = figure('units', 'normalized', 'outerposition',[0 0 1 1]);
    hold on;
    imshow(image); hold on;     % display image
    title  ('See dialog box for instructions');
    zoom off
elseif liner == 4 % Polygon for definition of ROI
    f1 = figure('units', 'normalized', 'outerposition',[0 0 1 1]);
    hold on;
    imshow(image); hold on;     % display image
    title ('Define the region of interest using the right mouse button. Press enter when complete');
    zoom off
elseif liner == 5 % Polygon for definition of stabilisation ROI
    if isempty(app.boundaryLimitsPx) == true
        f1 = figure('units', 'normalized', 'outerposition',[0 0 1 1]);
        hold on;
        imshow(image); hold on;     % display image
        title ('Define the region(s) to be used for stabilisation. Press enter when complete and close the window');
        zoom off
    elseif isempty(app.boundaryLimitsPx) == false
        for z = 1:length(app.boundaryLimitsPx)
            plot(app.boundaryLimitsPx{z,1});
        end
    end
end


defs = 0;
xold = 0;
yold = 0;
k = 0;
GCPimageReal = NaN; % Set the default value as NaN

while 1
    [xi, yi, but] = ginputWhite(1);      % get a point
    if ~isequal(but, 3)             % stop if not button 3 <MP>
        break
    end
    k = k + 1;
    pts(1,k) = xi;
    pts(2,k) = yi;
    
    if liner == 4 % polygon plot
        
        if defs  && liner
            delete(h1);
            h1 = plot([xold xi xold(1)], [yold yi yold(1)], 'go-');  % draw as we go
        else
            h1 = plot(xi, yi, 'ro');         % first point on its own
            xold = [];
            yold = [];
        end
        
        if isequal(k, n)
            break
        end
        xold = [xold, xi];
        yold = [yold, yi];
        defs = 1;
        
    elseif liner == 5 % polygon stabiliation ROI plot
        if defs  && liner
            delete(h1);
            h1 = plot([xold xi xold(1)], [yold yi yold(1)], 'go-');  % draw as we go
        else
            h1 = plot(xi, yi, 'ro');         % first point on its own
            xold = [];
            yold = [];
        end
        
        if isequal(k, n)
            break
        end
        xold = [xold, xi];
        yold = [yold, yi];
        defs = 1;
        
    else % liner not equal to 4
        
        if xold  && liner
            plot([xold xi], [yold yi], 'go-');  % draw as we go
        else
            plot(xi, yi, 'ro');         % first point on its own
        end
        
        if isequal(k, n)
            break
        end
        xold = xi;
        yold = yi;
        
        if liner == 0
            prompt = {'Enter the x co-ordinates [m]', 'Enter the y co-ordinates [m]', ...
                'Enter the z co-ordinates [m]'};
            dlgtitle = 'GCP data input';
            dims = [1 35];
            definput = {'0', '0', '0'};
            GCPimageRealTemp = inputdlg(prompt,dlgtitle,dims,definput);
            GCPimageRealTemp = str2double(GCPimageRealTemp);
            if ~isempty(GCPimageRealTemp) % if data has been selected
                if isnan(GCPimageReal)
                    GCPimageReal = GCPimageRealTemp;
                else
                    [~, dims2] = size(GCPimageReal);
                    GCPimageReal(1:3,dims2+1) = GCPimageRealTemp;
                end
            end
            
            %hold off;
            if k < size(pts,2)
                pts = pts(:, 1:k);
            end
        end
        
    end
end

if liner == 3 % Provide the input dialogue box for the manual coordiantes entry
    plot(pts(1,:),pts(2,:), 'g-')
    zoom out
end

end
