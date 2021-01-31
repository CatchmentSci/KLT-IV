% Value changed function: VelocityDropDown
function KLT_VelocityDropDownValueChanged(app, ~)
if strcmp (app.VelocityDropDown.Value, 'Normal Component') == 1
    TextIn = {'Normal component selected:'; 'The streamwise velocity will be computed'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    % Define the normal flow direction
    app.pts = KLT_readPoints(app.firstFrame,2,1); hold on;
    disp(app.pts)
    try
        close(f1)
    catch
    end
    
    % insert error catches for the following:
    % No suitable video
    % No start and stop trajectories defined
    
    xIn = app.pts(1,:)';
    yIn = app.pts(2,:)';
    %xIn(1:2,2) = 1;
    %b = xIn\yIn;
    %rangeIn = [0, length(app.firstFrame)];
    %extrap =  b(1).* rangeIn+b(2) ;
    %app.start1 = [rangeIn(1) extrap(1)];
    %app.end1 = [rangeIn(2) extrap(2)];
    app.start1 = [xIn(1), yIn(1)];
    app.end1 = [xIn(2), yIn(2)];
    
    
elseif strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
    TextIn = {'Velocity magnitude selected:'; 'The velocity of flow will be calculated independent of direction'};
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
end
end