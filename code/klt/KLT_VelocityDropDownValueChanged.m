% Value changed function: VelocityDropDown
function KLT_VelocityDropDownValueChanged(app, ~)

switch app.VelocityDropDown.Value

    case 'Normal Component'
        TextIn = {'Normal component selected:'; 'The streamwise velocity will be computed'};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');

        try
            % Define the normal flow direction
            app.pts = KLT_readPoints(app.firstFrame,2,1); hold on;
            disp(app.pts)
            try
                close(f1)
            catch
            end
        catch
            TextIn = {'An error occurred when selecting the streamwise direction'; ...
                'Ensure a suitable video is selected and the start and end of flow line is defined.'};
            TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
            TimeIn = strjoin(TimeIn, ' ');
            app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
            KLT_printItems(app)
            pause(0.01);
            app.ListBox.scroll('bottom');
        end
    
    case 'Velocity Magnitude'
      
        TextIn = {'Velocity magnitude selected:'; 'The velocity of flow will be calculated independent of direction'};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
end
end