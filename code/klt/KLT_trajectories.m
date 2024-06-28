function [] = KLT_trajectories(app)
if strcmp (app.TrajectoriesPlotSwitch.Value, 'On') == 1
    try
        TextIn = {'Initiating the particle trajectories plot. Please wait.'};
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
        xyzA_final2 = app.xyzA_final(:,1:2);
        xyzB_final2 = app.xyzB_final(:,1:2);
        %xyzA_final2 = app.finalVel{1};
        %xyzB_final2 = app.finalVel{2};

        limits = [min(app.refValue,[],'omitnan'); max(app.refValue,[],'omitnan')];
        normalised = app.refValue./max(app.refValue,[],'omitnan');
        f1 = figure ('units','pixels'); %,'outerposition',[0 0 1 1]);
        init = get(0, 'MonitorPositions');
        if size(init, 1) <= 1% v1.01 addition to account for dual monitors
            set(f1,'Position',[2, 42, init(1,3)/2-2, init(1,4)-126]) % square filling half the screen height
        else
            set(f1,'Position',[2, 42, init(1,3)/2-2, init(1,4)-126]) % square filling half the screen height
        end
        a1 = axes;
        hold on;
        axis equal
        axis tight
        
        % Plot the basemap image
        % Merge the images into one complete image of the reach
        if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
            app.masterImage = [];
            app.masterImageX = [];
            app.masterImageY = [];
            listing = dir([app.directory_stab]);
            for a = 1:app.iter: length(listing) % Show at the same rate as the extract rate
                temp1 = cellstr(listing(a).name);
                if ~isempty(temp1(contains(temp1,'.jpg')))
                    imageIn = imread(strjoin([app.directory_stab '\' temp1],''));
                    if isempty(app.masterImage)
                        app.masterImage = imageIn;
                    end
                    missingVal = find(app.masterImage == 0); % missing from master image
                    valExists = find(imageIn > 10); % Exists in new image
                    [val,~]=intersect(missingVal,valExists); % meets both
                    if ~isempty(val)
                        app.masterImage(val) = imageIn(val);
                    end
                end
            end
            [axis1, axis2] = size(app.masterImage);
            app.masterImageX = (1:axis2).*app.ResolutionmpxEditField.Value;
            %app.masterImageY = fliplr((1:axis1).*app.ResolutionmpxEditField.Value);
            app.masterImageY = (1:axis1).*app.ResolutionmpxEditField.Value;
            h1 = image(app.masterImageX,app.masterImageY,...
                app.masterImage,'CDataMapping','scaled');
            
        elseif app.prepro == 1
            h1 = image(app.X(1,:),app.Y(:,1),app.objectFrame.*255);        
        else
            h1 = image(app.X(1,:),app.Y(:,1),app.rgbHR,'CDataMapping','scaled');
        end
        
        colormap(gray);
        
        % Define axes based on minimum of inputs (image or trajectories)
        limOptTrajX = [min([xyzA_final2(:,1),; xyzB_final2(:,1)],[],'omitnan'), max([xyzA_final2(:,1); xyzB_final2(:,1)],[],'omitnan')];
        limOptTrajY = [min([xyzA_final2(:,2); xyzB_final2(:,2)],[],'omitnan'), max([xyzA_final2(:,2); xyzB_final2(:,2)],[],'omitnan')];
        if ~isempty(app.X)
            limOptImageX = [min(app.X(1,:),[],'omitnan'),max(app.X(1,:),[],'omitnan')];
            limOptImageY = [min(app.Y(:,1),[],'omitnan'),max(app.Y(:,1),[],'omitnan')];
            set(a1,'xlim', [max(limOptTrajX(1),limOptImageX(1)),...
                min(limOptTrajX(2),limOptImageX(2))]);
            set(a1,'ylim', [max(limOptTrajY(1),limOptImageY(1)),...
                min(limOptTrajY(2),limOptImageY(2))]);
        else
            set(a1,'xlim', [min([xyzA_final2(:,1); xyzB_final2(:,1)],[],'omitnan'), max([xyzA_final2(:,1); xyzB_final2(:,1)],[],'omitnan')])
            set(a1,'ylim', [min([xyzA_final2(:,2); xyzB_final2(:,2)],[],'omitnan'), max([xyzA_final2(:,2); xyzB_final2(:,2)],[],'omitnan')])
        end
        
        xLims = get(a1,'xlim');
        yLims = get(a1,'ylim');
        set(a1,'xtick',[],'ytick',[]); %remove its ticks
        set(a1,'TickLabelInterpreter','latex')
        set(a1,'fontsize',14)
        
        a2 = axes;
        hold on;
        axis equal;
        axis tight
        set(a2,'xlim',xLims)
        set(a2,'ylim',yLims)
        set(a2,'color','none')
        set(a2,'TickLabelInterpreter','latex')
        set(a2,'fontsize',14)
        linkaxes([a1,a2],'xy'); % link the x and y-axis
        
        %Create the colobar and set appropriate position
        if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
            caxis([min(app.refValue,[],'omitnan'),prctile(app.refValue,99.99)])
        else
            caxis([min(app.refValue,[],'omitnan'),prctile(app.refValue,99)])
        end
        
        restoredSize1 = get(a1, 'Position');
        restoredSize2 = get(a2, 'Position');
        d = colorbar;
        set(a1, 'Position', restoredSize1 );
        set(a2, 'Position', restoredSize2 );
        
        if strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
            ylabel(d, 'Velocity Magnitude $\mathrm{(m \ s^{-1})}$' , 'Interpreter','LaTex');
        elseif strcmp(app.VelocityDropDown.Value, 'Normal Component') == 1
            ylabel(d, 'Normal Velocity $\mathrm{(m \ s^{-1})}$' , 'Interpreter','LaTex');
        end
        
        d.FontSize = 14;
        d.Location = 'eastoutside';
        set(d,'TickLabelInterpreter','latex')
        cd = colormap(a2, parula); % take your pick (doc colormap)
        
        if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
            try
                cd = interp1(linspace(min(app.refValue,[],'omitnan'),prctile(app.refValue,99.99),length(cd)),cd,app.refValue); % map color to velocity values
            catch
                TextIn = {'No valid trajectories available to plot. Exiting'};
                TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
                TimeIn = strjoin(TimeIn, ' ');
                app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
                KLT_printItems(app)
                pause(0.01);
                app.ListBox.scroll('bottom');
            end
        else
            cd = interp1(linspace(min(app.refValue,[],'omitnan'),prctile(app.refValue,99),length(cd)),cd,app.refValue); % map color to velocity values
        end
        cd = uint8(cd'*255); % need a 4xN uint8 array
        xlabel('X-axis coordinates (m)', 'Interpreter','LaTex')
        ylabel('Y-axis coordinates (m)', 'Interpreter','LaTex')
        
        if strcmp (app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
            zlabel(['Velocity Magnitude $\mathrm{(m \ s^{-1})}$'] , 'Interpreter','LaTex');
        elseif strcmp(app.VelocityDropDown.Value, 'Normal Component') == 1
            zlabel(['Normal Velocity $\mathrm{(m \ s^{-1})}$'] , 'Interpreter','LaTex');
        end
        
        % Query how many trajectories to plot
        if isempty(app.subSample)
            prompt = ['How many vectors would you like to display? ' num2str(length(app.refValue)) ' were extracted '];
            dlgtitle = 'Query';
            definput = num2str(10000); % default value
            if str2num(definput) > length(app.refValue)
                definput = num2str(length(app.refValue)); % limited by array size
            end
            app.subSample = str2num(cell2mat(inputdlg(prompt,dlgtitle,[1 60],{definput})));
        end
        
        dataPoints = app.subSample;
        ind1 = randperm(length(app.refValue));
     
        % Catch to ensure too many are not attempted (20210325)
        if dataPoints > length(app.refValue)
            ind1 = ind1(1:length(app.refValue));
        end

        % Optimised: line rather than plot (20210310)
        h2 = gobjects(1,dataPoints); % preallocate object
        for aa = 1:dataPoints 
            h2(aa) = line([xyzA_final2(ind1(1,aa)), xyzB_final2(ind1(1,aa))],...
                [xyzA_final2(ind1(1,aa),2), xyzB_final2(ind1(1,aa),2)], ...
                'color', cd(:,ind1(aa)));

            %quiver(xyzA_final2(:,1), xyzA_final2(:,2), app.adjustedVel(:,1), app.adjustedVel(:,2))

        end
        
        TextIn = {'Exporting the plot of particle trajectories'};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
        % Specify the save file options
        if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
            try
                temp1 = [app.directory_save_multiple '\trajectories.png'];
                saveas(f1,temp1,'png')
                cla(a1);
                cla(a2);
                reset(gcf);
                reset(gca);
                close (f1)
                waitfor(f1)
            catch
            end
        else
            temp1 = [app.directory_save '\' app.file(1:end-4) '_trajectories.png'];
            saveas(f1,temp1,'png')
        end
        
        TextIn = {'Completed export of particle trajectories plot'};
        app.ListBox.Items = [app.ListBox.Items, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
        
    catch
        TextIn = {'Unable to generate and export the plot'};
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TimeIn = strjoin(TimeIn, ' ');
        app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
    end %try
end %strmcmp switch
end % function