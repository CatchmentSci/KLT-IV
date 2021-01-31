function [] = trajectoryAdjustments(app)
if strcmp (app.VelocityDropDown.Value, 'Normal Component') == 1
    
    TextIn = {'Computing the normal component of the flow. Please wait.'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    [t1, t2] = size(app.objectFrame); % Ensure the start stop positions don't exceed the size of the image
    if app.start1(1) < 0; app.start1(1) = 0; end
    if app.start1(1) > t2; app.start1(1) = t2; end
    if app.start1(2) < 0; app.start1(2) = 0; end
    if app.start1(2) > t1; app.start1(2) = t1; end
    if app.end1(1) < 0; app.end1(1) = 0; end
    if app.end1(1) > t2; app.end1(1) = t2; end
    if app.end1(2) < 0; app.end1(2) = 0; end
    if app.end1(2) > t1; app.end1(2) = t1; end
    
    if strcmp (app.OrientationValue, 'Dynamic: Stabilisation') == false && ...
            strcmp (app.OrientationValue, 'Planet [beta]') == false
        start1_rw = app.camA_first.invproject(app.start1,app.TransX,app.TransY,app.Transdem); % rectify both the start and end positions together
        end1_rw =   app.camA_first.invproject(app.end1,app.TransX,app.TransY,app.Transdem);
    else
        start1_rw = app.start1.*app.imageResolution;
        end1_rw = app.end1.*app.imageResolution;
    end
    
    TextIn = {'Estimating the length of time the trajectory corrections will take. Please wait.'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    % Convert velocities to normal direction
    tic;
    if length(app.xyzA_final) > 100
        len1 = 1000;
    else
        len1 = length(app.xyzA_final);
    end
    
    for a = 1:len1
        temper1 = normalVector([app.xyzA_final(a,1:2)', app.xyzB_final(a,1:2)'],start1_rw(1:2),end1_rw(1:2));
    end
    time = toc;
    
    TextIn = {'Would you like to speed up analysis by sub-sampling the data? See dialog box'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    eachIter = time./a; % seconds per sample
    timeS  = (length(app.xyzA_final)).*eachIter./60; %mins
    prompt = ['app.subSample data? You have ' num2str(length(app.xyzB_final)) ' features. This will take '...
        num2str(round(timeS)) ' minutes'];
    dlgtitle = 'Query';
    definput = num2str(length(app.xyzA_final));
    app.subSample = str2num(cell2mat(inputdlg(prompt,dlgtitle,[1 60],{definput})));
    dataPoints = app.subSample;
    ind1 = randperm(length(app.xyzA_final));
    if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
        set(app.RUNButton,'Text','Processing trajectories');
    end
    
    TextIn = {'Adjusting trajectories, please wait'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    for t = 1:dataPoints
        if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
            set(app.RUNButton,'Text',strjoin({'Processing: ' int2str((t)/(dataPoints)*100) '% Complete'},''));
        end
        dataOut(t) = normalVector([app.xyzA_final(ind1(t),1:2)',app.xyzB_final(ind1(t),1:2)'],start1_rw(1:2),end1_rw(1:2));
    end
    
    dataOut = replace_num(dataOut,0,NaN);
    app.xyzA_final = app.xyzA_final(ind1(1:t),1:2);
    app.xyzB_final = app.xyzB_final(ind1(1:t),1:2);
    app.normalVelocity = abs(dataOut./(app.iter*1/app.videoFrameRate))'; % divided by time period between start and stop i.e. m s
    app.vel = app.xyzB_final - app.xyzA_final;% The raw velocity values - not direction specific
    app.adjustedVel = app.vel./(app.iter*1/app.videoFrameRate); % divided by time period between start and stop i.e. m s
    
    % Specify the minimum and maximum velocity for normal
    % component analysis
    if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
        app.refValue = app.normalVelocity(:,1);
        if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1% if the first video
            defaultValue = {'0.1', num2str(Inf)};
            titleBar = 'Define the min and max velocities to be stored across all videos';
            userPrompt = {'Minimum (m/s): ', 'Maximum (m/s): '};
            caUserInput = inputdlg(userPrompt, titleBar, [1, 120], defaultValue);
            app.minVel = str2num(caUserInput{1});
            app.maxVel = str2num(caUserInput{2});
        end
        if ~isempty(app.minVel)
            remover1 = find(app.refValue < app.minVel | app.refValue > app.maxVel);
            app.refValue(remover1) = NaN;
        end
        
    elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
        app.refValue = app.normalVelocity(:,1);
        if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1 % if the first video
            defaultValue = {'0.1', num2str(Inf)};
            titleBar = 'Define the minimum and maximum velocities to be stored';
            userPrompt = {'Minimum (m/s): ', 'Maximum (m/s): '};
            caUserInput = inputdlg(userPrompt, titleBar, [1, 80], defaultValue);
            app.minVel = str2num(caUserInput{1});
            app.maxVel = str2num(caUserInput{2});
        end
        if ~isempty(app.minVel)
            remover1 = find(app.refValue < app.minVel | app.refValue > app.maxVel);
            app.refValue(remover1) = NaN;
        end
    end
    
    TextIn = {'Trajectory adjustments completed, continue'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
elseif strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
    app.xyzA_final = app.xyzA_final(1:end,1:2);
    app.xyzB_final = app.xyzB_final(1:end,1:2);
    app.vel = app.xyzB_final - app.xyzA_final;% The raw velocity values - not direction specific
    app.adjustedVel = app.vel./(app.iter*1/app.videoFrameRate); % divided by time period between start and stop i.e. m s
    app.normalVelocity(1:length(app.xyzA_final),1) = NaN;
    app.refValue = sqrt(app.adjustedVel(:,1).^2 + app.adjustedVel(:,2).^2);
    
    % Specify the minimum and maximum velocity
    if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
        if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1% if the first video
            defaultValue = {'0.1', num2str(Inf)};
            titleBar = 'Define the min and max velocities to be stored across all videos';
            userPrompt = {'Minimum (m/s): ', 'Maximum (m/s): '};
            caUserInput = inputdlg(userPrompt, titleBar, [1, 120], defaultValue);
            app.minVel = str2num(caUserInput{1});
            app.maxVel = str2num(caUserInput{2});
        end
        if ~isempty(app.minVel)
            remover1 = find(app.refValue < app.minVel | app.refValue > app.maxVel);
            app.refValue(remover1) = NaN;
        end
        
    elseif strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
        if isempty(app.videoNumber) || app.videoNumber < 2 || app.startingVideo == 1% if the first video
            defaultValue = {'0.1', num2str(Inf)};
            titleBar = 'Define the minimum and maximum velocities to be stored';
            userPrompt = {'Minimum (m/s): ', 'Maximum (m/s): '};
            caUserInput = inputdlg(userPrompt, titleBar, [1, 80], defaultValue);
            app.minVel = str2num(caUserInput{1});
            app.maxVel = str2num(caUserInput{2});
        end
        if ~isempty(app.minVel)
            remover1 = find(app.refValue < app.minVel | app.refValue > app.maxVel);
            app.refValue(remover1) = NaN;
        end
    end
    
end
end