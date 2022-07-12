
function [] = KLT_loadState(app)
TextIn = {'Select the settings to load.'};
app.ListBox.Items = [app.ListBox.Items, TextIn'];
KLT_printItems(app)
pause(0.01);
app.ListBox.scroll('bottom');

if length(app.directory) < 1
    % Create list of images inside the considered directory
    [settingsFileIn, settingsDirIn] = uigetfile('*.mat');
else
    [settingsFileIn, settingsDirIn] = uigetfile({'*.mat' 'All Files'},'Select a file',app.directory);
end
if length(settingsFileIn) > 1
    direc = dir([settingsDirIn,filesep]); filenames={};
    [filenames{1:length(direc),1}] = deal(direc.name);
    filenames = sortrows(filenames); %sort all image files
    amount = length(filenames);
    textOutput = strjoin({settingsDirIn, settingsFileIn}, '');
    
    TextIn = strjoin({'Loading settings from: ' textOutput},'');
    TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    TimeIn = strjoin(TimeIn, ' ');
    app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
    
    load(textOutput,'appEx');
    
    if exist('appEx','var')
        fields = fieldnames(app);
        for a = 1:length(fields)
            [i1] =  strcmp(app.flexVarsComp, fields(a));
            if max(i1) > 0
                i1_idx = find (i1 == 1);
                if strcmp(char(app.flexVars(1,i1)), 'UITable.Data') == 1
                    app.UITable = uitable(app.KLTIV_UIFigure);
                    app.UITable.Visible = 'on';
                    app.UITable.ColumnName = {'X [meters]'; 'Y [meters]'; 'Z [meters]'; 'X [px]'; 'Y [px]'};
                    app.UITable.RowName = {};
                    app.UITable.ColumnEditable = [true true true false false];
                    app.UITable.CellSelectionCallback = createCallbackFcn(app, @KLT_UITableCellSelection, true);
                    app.UITable.ForegroundColor = [0.149 0.149 0.149];
                    app.UITable.FontName = 'Ubuntu';
                    app.UITable.Position = [335 153 290 219];
                    eval(['app.' char(app.flexVars(1,i1))  '=' char(strjoin({'appEx.', char(app.flexVarsComp(1,i1_idx))},'')) ';'])
                    %CheckTable1 = get(app.UITable,'Data')
                    %set( app.UITable, 'Data', CheckTable1 )
                    pause(0.5)
                else
                    eval(['app.' char(app.flexVars(1,i1))  '=' char(strjoin({'appEx.', char(app.flexVarsComp(1,i1_idx))},'')) ';'])
                    pause(0.5)
                    try % only certain vars have this
                        eval(['app.' char(fields(a,1)) '.Visible = "Off";']);
                        pause(0.5)
                        eval(['app.' char(fields(a,1)) '.Visible = "On";']);
                        pause(0.5)
                    catch
                        pause(0.5)
                    end
                end
            end
        end
        KLT_OrientationDropDownValueChanged(app)
        KLT_VelocityDropDownValueChanged(app)
        KLT_bringInImage(app)
        %TextIn = strjoin({'Output directory is: ', char(app.directory_save)}, '');
        TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
        TextIn = 'Settings succesfully loaded.';
        app.ListBox.Items = [TimeIn, TextIn'];
        KLT_printItems(app)
        pause(0.01);
        app.ListBox.scroll('bottom');
    end
    
else
    TextIn = {'No settings file selected, please try again'};
    app.ListBox.Items = [app.ListBox.Items, TextIn'];
    KLT_printItems(app)
    pause(0.01);
    app.ListBox.scroll('bottom');
end
end