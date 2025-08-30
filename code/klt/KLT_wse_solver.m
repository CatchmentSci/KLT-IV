
function [wse_map] = KLT_wse_solver(app,xyzA_wse,xyzB_wse,aa,wse_map)

num_adj(1)  = 1;
idx         = 1;
increment   = 0.01;
grider      = [0.05:0.05:0.5];
b           = 1;

for a = 1:50 % max number of iterations

    while b < length(grider) + 2
        if b < length(grider) + 1 && a == 1
            grid_sz = grider(b);
        elseif b >= length(grider) + 1 && a == 1
            grid_sz = grider(min(find(same_bin./length(xyzA) > 0))); % choose highest resolution - change 0 to a fraction e.g.0.3 to alter
        else 
            grid_sz = grid_sz;
        end

        X                       = transpose(min(app.X(1,:)):grid_sz:max(app.X(1,:)));
        Y                       = transpose(min(app.Y(:,1)):grid_sz:max(app.Y(:,1)));
        [app.TransX,app.TransY] = meshgrid(X,Y);
        sizer                   = size(app.TransX);
        hgt_use                 = app.riverLevelAnalysis(app.videoNumber);
        app.Transdem            = [];
        app.Transdem(1:sizer(1), 1:sizer(2))    = hgt_use;
        wse_map{aa,1}           = app.Transdem;


        xyzA        = app.camA.invproject(xyzA_wse{aa} ,app.TransX,app.TransY,wse_map{aa,idx}); % rectify both the start and end positions together
        xyzB        = app.camA.invproject(xyzB_wse{aa} ,app.TransX,app.TransY,wse_map{aa,idx}); % rectify both the start and end positions together

        % Pull out the start/stop positions (px)
        xIn         = app.pts(1,:)';
        yIn         = app.pts(2,:)';
        app.start1  = [xIn(1), yIn(1)];
        app.end1    = [xIn(2), yIn(2)];
        [t1, t2]    = size(app.firstFrame);


        % Ensure the start stop positions don't exceed the size of the image
        if app.start1(1) < 0;   app.start1(1) = 0;	end     % xa
        if app.start1(1) > t2;  app.start1(1) = t2; end
        if app.start1(2) < 0;   app.start1(2) = 0;  end     % ya
        if app.start1(2) > t1;  app.start1(2) = t1; end
        if app.end1(1) < 0;     app.end1(1) = 0;    end     % xb
        if app.end1(1) > t2;    app.end1(1) = t2;   end
        if app.end1(2) < 0;     app.end1(2) = 0;    end     % yb
        if app.end1(2) > t1;    app.end1(2) = t1;   end

        % Convert start/stop positions to rw positions as required
        if  strcmp (app.OrientationDropDown.Value, 'Dynamic: Stabilisation') == false && ...
                strcmp (app.OrientationDropDown.Value, 'Planet [beta]') == false
            start1_rw   = app.camA_first.invproject(app.start1,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
            end1_rw     = app.camA_first.invproject(app.end1,app.TransX,app.TransY,app.Transdem);
        else
            start1_rw   = app.start1.*app.imageResolution;
            end1_rw     = app.end1.*app.imageResolution;
        end

        % Velocity data for correction
        app.vel             = xyzB - xyzA;% The raw velocity values - not direction specific
        app.adjustedVel     = app.vel./(app.iter*1/app.videoFrameRate); % divided by time period between start and stop i.e. m s
        vmag                = sqrt(app.adjustedVel(:,1).^2 + app.adjustedVel(:,2).^2);

        inX = (xyzA(:,1) - xyzB(:,1)) ./ (app.iter*1/app.videoFrameRate);
        inY = (xyzA(:,2) - xyzB(:,2)) ./ (app.iter*1/app.videoFrameRate);

        % define filter on first iteration
        if a == 1 && b == 1
            limer = vmag > 0.1;
            app.initialVel{1} = app.initialVel{1}(limer,1:2);
            app.initialVel{2} = app.initialVel{2}(limer,1:2);
        end
        xyzA            = xyzA(limer,1:2);
        xyzB            = xyzB(limer,1:2);
        vmag            = vmag(limer);
        app.adjustedVel = app.adjustedVel(limer);
        app.vel         = app.vel(limer,1:3);


        % Calculate the flow directions relative to the ideal
        ideal               = end1_rw - start1_rw;
        phi                 = rad2deg(atan2(ideal(2), ideal(1)));
        v2                  = xyzB - xyzA;
        obs_dir             = rad2deg(atan2(v2(:,2), v2(:,1)));
        psi                 = phi - obs_dir;

        % Filter based on a deviation from the ideal.
        % A soft filter of 45 degrees ensures the downstream component is
        % at least twice the secondary vector
        app.filterAngle         = 180; % changed back 20240326
        idx1                    = obs_dir < 0;
        adjus                   = obs_dir;
        adjus(idx1)             = adjus(idx1) +  360;
        if a == 1 && b == 1% define filter on first iteration
            rem1                = find(abs(adjus - phi) >= app.filterAngle & abs(adjus - phi) <= (360-app.filterAngle));
        end

        % Calculate the raw angle
        phi = mean(adjus); % force the ideal to be the median of directions - trial with the mean as well
        det_ang{a}              = adjus - phi;

        % calculate the angles for each bin
        dx          = median(diff(app.TransX(1,:)));
        dy          = median(diff(app.TransY(:,1)));
        xi          = nanmin(app.TransX(:)-(0.5*dx)):dx:nanmax(app.TransX(:)+(0.5*dx));
        yi          = nanmin(app.TransY(:)-(0.5*dx)):dy:nanmax(app.TransY(:)+(0.5*dx));

        % catch in case there are minor rounding errors
        if length(xi) > length(app.TransX(1,:))
            xi = xi(1:length(app.TransX(1,:)));
            yi = yi(1:length(app.TransY(:,1)));
        end

        x           = mean([xyzA(:,1),xyzB(:,1)],2);
        y           = mean([xyzA(:,2),xyzB(:,2)],2);
        z           = det_ang{a}; % the difference between actual + ideal

        % ensure they start and stop in the same bin
        x1            = xyzA(:,1); % start x
        y1            = xyzA(:,2); % start y
        [n_x1,bn_x1]  = histc(x1,xi) ; % xi=bin edges, n_x is the number of observations in each bin, and bn_x indexes the bin that each datapoint goes into
        [n_y1,bn_y1]  = histc(y1,yi) ; % Same, for y

        x2            = xyzB(:,1); % start x
        y2            = xyzB(:,2); % start y
        [n_x2,bn_x2]  = histc(x2,xi) ; % xi=bin edges, n_x is the number of observations in each bin, and bn_x indexes the bin that each datapoint goes into
        [n_y2,bn_y2]  = histc(y2,yi) ; % Same, for y

        same_bin(b,1) = sum((bn_x1 - bn_x2 == 0) & (bn_y1 - bn_y2 == 0));

        if b == length(grider) + 1 || a > 1
            idx_use = find((bn_x1 - bn_x2 == 0) & (bn_y1 - bn_y2 == 0)==1);
        end

        app.vel(rem1)           = NaN;
        app.adjustedVel(rem1)   = NaN;
        adjus(rem1)             = NaN;
        u                       = cosd(psi).*vmag;
        u(rem1)                 = NaN; % direction filter applied
        v                       = sind(psi).*vmag;
        v(rem1)                 = NaN; % direction filter applied
        app.refValue            = u;
        app.downstreamVelocity  = u;
        app.adjustedVel         = [u, v]; % check that these are the values exported to excel

        if b == Inf % b == length(grider) + 1 || a > 1 % deactivated
            app.vel                 = app.vel(idx_use);
            app.adjustedVel         = app.adjustedVel(idx_use);
            adjus                   = adjus(idx_use);
            u                       = u(idx_use);
            v                       = v(idx_use);
            app.refValue            = u;
            app.downstreamVelocity  = u;
            app.adjustedVel         = [u, v]; % check that these are the values exported to excel
            x                       = x(idx_use);
            y                       = y(idx_use);
            z                       = z(idx_use); % the difference between actual + ideal

        end

        b = b + 1;

        if a > 1
            b = length(grider) + 2;
        end
    end

    b = 1; % reset b

    % Find index to bins
    [n_x,bn_x]  = histc(x,xi) ; % xi=bin edges, n_x is the number of observations in each bin, and bn_x indexes the bin that each datapoint goes into
    [n_y,bn_y]  = histc(y,yi) ; % Same, for y
    ii          = find(bn_x == 0 | bn_y == 0) ; % can't have zero indicies
    bn_x(ii)    = [] ;
    bn_y(ii)    = [] ;
    z(ii)       = [] ;

    ct          = sparse(bn_y,bn_x,1,length(yi),length(xi));    % Count number of obs in each bin
    sm          = sparse(bn_y,bn_x,                         z,length(yi),length(xi));    % Sum values of z in each bin
    zi{a}       = full(sm./ct);    % Average of z = sum/count. It will be NaN if the bin is empty.
    zc          = z - zi{a}(sub2ind(size(zi{a}),bn_y,bn_x));    % Compute centered values

    % generate the indices and copy map
    wse_map{aa,idx+1} =  wse_map{aa,idx};
    idx = sum(cellfun('length',wse_map(aa,:))>0);

    % categorise deviation of the vector
    gtr  = zi{a} > 0;
    lstn = zi{a} < 0;

    if a == 1
        % first trial adding the ones greater and subtracting from smaller
        mean_dir_change{a}              = 0;
        wse_map{aa,idx}(gtr)            = wse_map{aa,idx}(gtr) + increment; %correct
        wse_map{aa,idx}(lstn)           = wse_map{aa,idx}(lstn) - increment;
        idx_map                         = zeros(size(wse_map{aa,1}));
        perm_idx_map                    = ones(size(wse_map{aa,1}));
        num_adj(a)                      = sum(sum([gtr(:),lstn(:)]));
        impr(1:sizer(1), 1:sizer(2))    = 0; % initially set as zero
        num_adj(a)                      = sum(idx_map(:) > 0);

    else

        impr(1:sizer(1), 1:sizer(2))    = 0; % initially set as zero
        dir_change{a}                   = zi{a} - zi{1};
        mean_dir_change{a}              = nanmedian(dir_change{a}(:));

        pos_idx                         = find(zi{a} > 0); % if its a positive offset
        neg_idx                         = find(zi{a} < 0); % if its a negative offset

        % check if there has been an improvement
        temp_idx  =     find(zi{a} < 0 & (zi{a-1} < 0)); % both negative
        temp_idx2 =     find(zi{a}(temp_idx) - zi{a-1}(temp_idx) > 0); % if improvement
        impr(temp_idx(temp_idx2)) = 1; % ok
        %neg(a) = length(temp_idx)

        temp_idx    = find(zi{a} > 0 & (zi{a-1} > 0)); % both positive
        temp_idx2   = find(zi{a}(temp_idx) - zi{a-1}(temp_idx) < 0); % if improvement
        impr(temp_idx(temp_idx2)) = 2; % ok

        temp_idx  =     find(zi{a} < 0 & (zi{a-1} > 0)); % initially positive then negative
        temp_idx2 =     find(zi{a-1}(temp_idx) + zi{a}(temp_idx) > 0); % if improvement
        impr(temp_idx(temp_idx2)) = 3; % ok

        temp_idx  =     find(zi{a} > 0 & (zi{a-1} < 0)); % initially negative then positive
        temp_idx2 =     find(zi{a}(temp_idx) + zi{a-1}(temp_idx) < 0); % if improvement
        impr(temp_idx(temp_idx2)) = 4; % ok
        flip_flop(a) = length(find(impr>2));

        % update logic map
        idx_map (impr & perm_idx_map)   = 1;
        idx_map (~impr)                 = 0;

        % alter the wse accordingly
        idx1                            = impr == 2 | impr == 4;
        wse_map{aa,idx}(idx1)           = wse_map{aa,idx}(idx1) + increment;
        idx2                            = impr == 1 | impr == 3;
        wse_map{aa,idx}(idx2)           = wse_map{aa,idx}(idx2) - increment;
        num_adj(a)                      = sum(idx1(:)>0) + sum(idx2(:)>0);

    end
end

C = zi;
closest_to_zero = C{1};
% Initialize the matrix to store the indices of the closest values to zero
indices = ones(sizer(1), sizer(2));

% Iterate through the remaining cells and update the closest_to_zero matrix and indices
for i = 2:length(C)
    % Find the absolute values of the current matrix and the closest_to_zero matrix
    abs_current = abs(C{i});
    abs_closest = abs(closest_to_zero);

    % Create a logical mask where the absolute values of the current matrix are smaller than those in closest_to_zero
    mask = abs_current < abs_closest;

    % Update the closest_to_zero matrix based on the mask
    closest_to_zero(mask) = C{i}(mask);

    % Update the indices matrix based on the mask
    indices(mask) = i;
end

% closest_to_zero now contains the values closest to zero for each element across all cells
% indices now contains the indices of the cell where these closest values were found

result = zeros(sizer(1), sizer(2));

% Iterate over each element of the indices matrix
for row = 1:sizer(1)
    for col = 1:sizer(2)
        % Get the cell index for the current element
        cell_index = indices(row, col);
        % Extract the corresponding element from the appropriate cell
        result(row, col) = wse_map{cell_index}(row, col);
    end
end

%figure(); imagesc(result);
wse_map{aa,idx} =  result; % overwrite the last map with the optimised

if a > 1 && num_adj(a) == Inf % stop when no more changes

    % set up the figure
    fig=figure(1); hold on;
    fig.Units='pixels';
    set(fig,'DefaultTextFontName','Arial');
    set(fig,'Position',[100, 0, 2480./2, 3508./2]); % A4 aspect ratio
    fig.Units='normalized';

    p0 = imagesc(wse_map{aa,idx}); % plot final resolved output
    exportgraphics(fig,[pwd '\wse_reconstruction_sim_' num2str(aa) '.png'],'Resolution',600)
    pause(5)
    close all;


    ideal               = end1_rw - start1_rw;
    phi                 = rad2deg(atan2(ideal(2), ideal(1)));
    v1                  = app.initialVel{2}  - app.initialVel{1};
    obs_dir_initial     = rad2deg(atan2(v1(:,2), v1(:,1)));
    mag_initial         = sqrt(v1(:,1).^2 + v1(:,2).^2);

    xyzA_final          = xyzA;
    xyzB_final          = xyzB;
    app.finalVel        = {xyzA_final, xyzB_final};
    v2                  = app.finalVel{2} - app.finalVel{1} ;
    obs_dir_final       = rad2deg(atan2(v2(:,2), v2(:,1)));
    mag_final           = sqrt(v2(:,1).^2 + v2(:,2).^2);

    % potential plots to show differences
    %histogram(mag_initial); hold on;
    %histogram(mag_final); hold on;
    %polarhistogram(v1); hold on;
    %polarhistogram(v2); hold on;

    return
end
