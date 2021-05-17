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
        if  strcmp (app.OrientationValue, 'Dynamic: Stabilisation') == false && ...
            strcmp (app.OrientationValue, 'Planet [beta]') == false
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

        % Apply the neccesary rotations to extract u and v components
        ideal               = end1_rw - start1_rw;
        phi                 = rad2deg(atan2(ideal(2), ideal(1)));
        v2                  = app.xyzB_final - app.xyzA_final;
        obs_dir             = rad2deg(atan2(v2(:,2), v2(:,1)));
        psi                 = phi - obs_dir;
        u                   = cosd(psi).*vmag;   
        v                   = sind(psi).*vmag;
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
	app.refValue(remover1) = NaN;
end
     

end

