function [] = KLT_vectorRotation(app)

switch app.VelocityDropDown.Value

    case 'Normal Component'
        
        % Update the dialog box
        TextIn             = {'Adjusting trajectories relative to the idealised flow line. Please wait.'};
        TimeIn             = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn             = strjoin(TimeIn, ' ');
        app.ListBox.Items  = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
    
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
        app.xyzA_final      = app.xyzA_final(1:end,1:2);
        app.xyzB_final      = app.xyzB_final(1:end,1:2);
        app.vel             = app.xyzB_final - app.xyzA_final;% The raw velocity values - not direction specific
        app.adjustedVel     = app.vel./(app.iter*1/app.videoFrameRate); % divided by time period between start and stop i.e. m s
        vmag                = sqrt(app.adjustedVel(:,1).^2 + app.adjustedVel(:,2).^2);

        % Calculate the flow directions relative to the ideal
        ideal               = end1_rw - start1_rw;
        phi                 = rad2deg(atan2(ideal(2), ideal(1)));
        v2                  = app.xyzB_final - app.xyzA_final;
        obs_dir             = rad2deg(atan2(v2(:,2), v2(:,1)));
        psi                 = phi - obs_dir;
        
        % Filter based on a deviation from the ideal.
        % A soft filter of 45 degrees ensures the downstream component is
        % at least twice the secondary vector
        app.filterAngle         = 20;
        idx1                    = obs_dir < 0; 
        adjus                   = obs_dir;
        adjus(idx1)             = adjus(idx1) +  360;
        rem1                    = find(abs(adjus - phi) >= app.filterAngle & abs(adjus - phi) <= (360-app.filterAngle));
        app.vel(rem1)           = NaN;
        app.adjustedVel(rem1)   = NaN;
        
        % Apply the neccesary rotations to extract u and v components
        u                   = cosd(psi).*vmag;   
        u(rem1)             = NaN; % direction filter applied
        v                   = sind(psi).*vmag;
        v(rem1)             = NaN; % direction filter applied
        
        app.refValue        = u;
        app.normalVelocity  = u;
        app.adjustedVel     = [u, v]; % check that these are the values exported to excel
   
        % Update the dialog box
        TextIn             = {'Trajectory adjustments completed.'};
        app.ListBox.Items  = [app.ListBox.Items, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
    case 'Velocity Magnitude'
    	app.xyzA_final      = app.xyzA_final(1:end,1:2);
    	app.xyzB_final      = app.xyzB_final(1:end,1:2);
        app.vel             = app.xyzB_final - app.xyzA_final;% The raw velocity values - not direction specific
        app.adjustedVel     = app.vel./(app.iter*1/app.videoFrameRate); % divided by time period between start and stop i.e. m s
        app.refValue        = sqrt(app.adjustedVel(:,1).^2 + app.adjustedVel(:,2).^2);
     	app.normalVelocity(1:length(app.xyzA_final),1) = NaN;

end
    

% Define the minimum and maximum allowable velocity values
switch app.ProcessingModeDropDown.Value
    case 'Multiple Videos'
        titleBar = 'Define the min and max velocities to be stored across all videos';
    case 'Single Video'
        titleBar = 'Define the minimum and maximum velocities to be used in analysis';
    case 'Numerical Simulation'
        titleBar = 'Define the min and max velocities to be stored across all videos';

end

if app.starterInd == 1 || isempty(app.starterInd)
    defaultValue    = {'0.1', num2str(Inf)};
    userPrompt      = {'Minimum (m/s): ', 'Maximum (m/s): '};
    caUserInput     = inputdlg(userPrompt, titleBar, [1, 120], defaultValue);
    app.minVel      = str2num(caUserInput{1});
    app.maxVel      = str2num(caUserInput{2});
end

if ~isempty(app.minVel)
    remover1    = app.refValue < app.minVel | app.refValue > app.maxVel;
	app.refValue(remover1)      = NaN;
    app.adjustedVel(remover1)   = NaN;
end
     

end

