function KLT_CrossSectionDropDownValueChanged(app, ~)
if strcmp (app.CrossSectionDropDown.Value, 'Referenced survey [m]') == 1
    app.UITable2.Data = [];
    app.xInder = [];
    app.yInder = [];
    [app.surveyFile, app.surveyDirectory] = uigetfile({'*.csv' '.csv Files'},'Select .csv containing cross-section survey data',app.directory);
    if length(app.surveyFile) > 1
        % Update the display
        TextIn = {'Loading Cross-section survey data - please wait'};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app);
        pause(0.01);
        app.ListBox.scroll('bottom');
        
        [data_text,~] = readtext(strjoin({app.surveyDirectory app.surveyFile },''), ',', '','','textual'); % read in the csv file
        app.surveyIn = [];
        app.surveyIn(:,1) = str2double(data_text(2:end,1)); % Extract the X coordinate of the scan
        app.surveyIn(:,2) = str2double(data_text(2:end,2)); % Extract the Y coordinate of the scan
        app.surveyIn(:,3) = str2double(data_text(2:end,3)); % Extract the Z coordinate of the scan
        app.startXS = [ app.surveyIn(1,1),app.surveyIn(1,2) ];
        app.endXS = [ app.surveyIn(end,1),app.surveyIn(end,2) ];
        dist = abs(app.startXS - app.endXS); % [x y distances]
        app.transectLength = sqrt(dist(1,1).^2 + dist(1,2).^2);
        
        % Convert from real-world to relative distances
        out=cell2mat(cellfun(@(x) app.startXS-x ,{app.surveyIn(:,1:2)},'un',0));
        surveyTemp = [sqrt(out(:,1).^2 + out(:,2).^2),app.surveyIn(:,3)] ;
        app.UITable2.Data = surveyTemp;
        
        % Update the display
        TextIn = {'Cross-section survey data succesfully loaded'};
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
        TextIn = {['Selected cross-section length is ' num2str(app.transectLength) 'm']; ...
            ['Please continue']};
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
    end
    
elseif strcmp (app.CrossSectionDropDown.Value, 'Relative distances [m]') == 1
    app.UITable2.Data = [];
    app.xInder = [];
    app.yInder = [];
    
    % Update the display
    TextIn = {'Using the mouse first right click on the start location of the cross-section, then the end point of the cross-section'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    % Plot the basemap image
    % Merge the images into one complete image of the reach
    if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
        app.XS_pts = KLT_readPoints(app.masterImage, 2, 3, app); hold on;
        app.startXS = [app.masterImageX(1,round(app.XS_pts(1,1))),app.masterImageY(round(app.XS_pts(2,1)))];
        app.endXS = [app.masterImageX(1,round(app.XS_pts(1,2))),app.masterImageY(round(app.XS_pts(2,2)))];
    else
        app.XS_pts = KLT_readPoints(app.firstOrthoImage, 2, 3, app); hold on;
        app.startXS = [app.X(1,round(app.XS_pts(1,1))),app.Y(round(app.XS_pts(2,1)))];
        app.endXS = [app.X(1,round(app.XS_pts(1,2))),app.Y(round(app.XS_pts(2,2)))];
    end
    
    dist = abs(app.startXS - app.endXS); % [x y distances]
    app.transectLength = sqrt(dist(1,1).^2 + dist(1,2).^2);
    %msgbox(['Transect length is ' num2str(app.transectLength) 'm'],'Value');
    TextIn = {['Selected cross-section length is ' num2str(app.transectLength) 'm']; ...
        ['Close the Figure window when ready to continue']};
    KLT_printItems(app)
    
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    TextIn = {'Loading Cross-section survey data - please wait'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    [app.surveyFile, app.surveyDirectory] = uigetfile({'*.csv' '.csv Files'},'Select .csv containing cross-section survey data',app.directory);
    
    [data_text,~] = readtext(strjoin({app.surveyDirectory app.surveyFile },''), ',', '','','textual'); % read in the csv file
    surveyTemp(:,1) = data_text(2:end,1); % Extract the distance coordinate of the scan
    surveyTemp(:,2) = data_text(2:end,2); % Extract the Z coordinate of the scan
    surveyTemp = str2double(surveyTemp); % Convert to numeric if simple input
    
    in1 = (0:0.01:app.transectLength)'*(dist./app.transectLength);
    out=cell2mat(cellfun(@(x) app.startXS-x ,{in1},'un',0));
    out(:,3) = 0.01:0.01:(length(out)./100)';
    
    intermediateLength = surveyTemp (:,1); %sqrt(surveyIn(:,1).^2 + surveyIn(:,2).^2);
    
    for a = 1:length(intermediateLength)
        t1(a,1) = findnearest(intermediateLength(a,1),out(:,3));
    end
    app.surveyIn = out(t1,1:2);
    app.UITable2.Data = surveyTemp;
    
end

end