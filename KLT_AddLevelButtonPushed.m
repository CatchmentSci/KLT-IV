function KLT_AddLevelButtonPushed(app, ~)

app.totalQ = [];

% Identify the level data
[levelFile,levelDir] = uigetfile ({'*.csv' 'CSV files'},'Select the file containing river level observations', app.directory);

% Bring in the river level data
[data_text,~] = readtext(strjoin({levelDir '\' levelFile},''),',', '','','textual'); % read in the csv file
data_text = strrep(data_text,'"', '');

for a =1:2
    try
        if a == 1
            riverLevelTimesNum = datenum(data_text(2:end,1),'dd/mm/yyyy HH:MM');
            break
        elseif a == 2
            riverLevelTimesNum = datenum(data_text(2:end,1),'dd/mm/yyyy HH:MM:SS');
        end
    catch
    end
end

riverLevelTimes     = data_text(2:end,1);
RiverLevelValues    = str2double(data_text(2:end,2));
[~, sizer]          = size(data_text);

if sizer > 2 % Q data exists
    RiverQValues    = str2double(data_text(2:end,3));
else
    RiverQValues(1:length(RiverLevelValues),1) = NaN;
end

TextIn = {'Matching videos to river level observations. Please wait.'};
app.ListBox.Items = [app.ListBox.Items, TextIn'];
KLT_printItems(app)
pause(0.01);
app.ListBox.scroll('bottom');

try
    for b = 1:length(riverLevelTimesNum)
        [Idx,D] = knnsearch(riverLevelTimesNum(b),app.videoDatesFormattedNum);
        [M, I] = min(D);
        if M < 0.0418./6 % difference of less than 10 minutes
            videoIdx(b)     = I;
            lat             = 50.479391; % Assign the geographical coordinates for determining the sunrise/sunset
            lon             = -3.762149;
            [rs,~,~,~,~,~]  = suncycle(lat,lon,riverLevelTimesNum(b),2880); % Calculate the timing of the sunrise/sunset (time in GMT)
            DateVector      = datevec(riverLevelTimesNum(b));
            
            if DateVector(1,4) < rs(1,1) || DateVector(1,4) > rs(1,2)
                % Do nothin
            else
                fna{b}      = char(app.videoDirFileNames(videoIdx(b)));
                rlta{b}     = riverLevelTimesNum(b);
                rla(b)      = RiverLevelValues(b);
                rqa(b)      = RiverQValues(b);
            end
        end
    end
    
    user                        = find(~cellfun(@isempty,fna));
    app.fileNameAnalysis        = fna(user);
    app.riverLevelTimeAnalysis  = rlta(user);
    app.riverLevelAnalysis      = rla(user);
    app.totalQ                  = rqa(user);
    
    TextIn = {[num2str(length(app.fileNameAnalysis)) ' videos were matched to river level observations. Please continue']};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom')
catch
    TextIn = {'No videos were matched river level observations. Check inputs and retry.'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom')
end

end