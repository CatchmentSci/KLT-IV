
function [wse_map] = KLT_wse_solver(app,xyzA_wse,xyzB_wse,aa,wse_map)

num_adj(1)  = 1;
idx         = 1;

for a = 1:1000 % max number of iterations

    xyzA        = app.camA.invproject(xyzA_wse{aa} ,app.TransX,app.TransY,wse_map{aa,a}); % rectify both the start and end positions together
    xyzB        = app.camA.invproject(xyzB_wse{aa} ,app.TransX,app.TransY,wse_map{aa,a}); % rectify both the start and end positions together

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
    if a == 1
        limer = vmag > 0.1;
    end
    xyzA  = xyzA(limer,1:2);
    xyzB  = xyzB(limer,1:2);

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
    if a == 1 % define filter on first iteration
        rem1                    = find(abs(adjus - phi) >= app.filterAngle & abs(adjus - phi) <= (360-app.filterAngle));
    end
    det_ang{a}              = phi - adjus;

    app.vel(rem1)           = NaN;
    app.adjustedVel(rem1)   = NaN;
    adjus(rem1)             = NaN;


    % calculate the angles for each bin
    dx          = median(diff(app.TransX(1,:)));
    dy          = median(diff(app.TransY(:,1)));
    xi          = nanmin(app.TransX(:)-(0.5*dx)):dx:nanmax(app.TransX(:)+(0.5*dx));
    yi          = nanmin(app.TransY(:)-(0.5*dx)):dy:nanmax(app.TransY(:)+(0.5*dx));
    x           = mean([xyzA(:,1),xyzB(:,1)],2);
    y           = mean([xyzA(:,2),xyzB(:,2)],2);
    z           = adjus;

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
    gtr  = zi{a} > phi;
    lstn = zi{a} < phi;

    if a == 1
        % first trial adding the ones greater and subtracting from smaller
        mean_dir_change{a}              = 0;
        wse_map{aa,idx}(gtr)            = wse_map{aa,idx}(gtr) + 0.01; %correct
        wse_map{aa,idx}(lstn)           = wse_map{aa,idx}(lstn) - 0.01;
        idx_map                         = zeros(size(wse_map{aa,1}));
        perm_idx_map                    = ones(size(wse_map{aa,1}));
        num_adj(a)                      = sum(sum([gtr(:),lstn(:)]));
    else
        dir_change{a}                   = det_ang{a} - det_ang{a-1};
        mean_dir_change{a}              = nanmean(dir_change{a});

        impr                            = zi{a} - zi{a-1} < 0; % if improvement
        idx_map (impr & perm_idx_map)   = 1;
        idx_map (~impr)                 = 0;
        perm_idx_map(~impr)             = 0;
        num_adj(a)                      = sum(idx_map(:));

        idx1                            = impr > 0 & gtr > 0;
        wse_map{aa,idx}(idx1)           = wse_map{aa,idx}(idx1) + 0.01;
        idx2                            = impr > 0 & lstn > 0;
        wse_map{aa,idx}(idx2)           = wse_map{aa,idx}(idx2) - 0.01;         

    end
    if num_adj(a) == 0 % stop when no more changes
       
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
        return
    end
end