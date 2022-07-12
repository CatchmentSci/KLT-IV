function KLT_errorCallback(app,err)

    errdir = getenv('USERPROFILE');
    errLogFileName = fullfile(errdir,...
        ['KLT_errorLog.txt']);
    
    TextIn = {['An unexpected error occurred. Error code: ' err.identifier];...
        ['Error details are being written to the following file: '];...
        [errLogFileName];...
        ['KLT Status: Unexpected Error']};
    
    %TimeIn = {'***** ' char(datetime(now,'ConvertFrom','datenum' )) ' *****'};
    %TimeIn = strjoin(TimeIn, ' ');
    %app.ListBox.Items = [app.ListBox.Items, TimeIn, TextIn'];
    %KLT_printItems(app)
    %pause(0.01);
    %app.ListBox.scroll('bottom');
    
    i=1;
    texterr{i} = app.KLTIV_UIFigure.Name;
    i=i+1;
    texterr{i} = ['Date and time of error: ' datestr(now)];
    i=i+1;
    texterr{i} = '';
    i=i+1;
    texterr{i} = 'Error messages:';
    i=i+1;
    texterr{i} = err.getReport('extended','hyperlinks','off');
    
    fid = fopen(errLogFileName,'W');
    fprintf(fid,'%s\r\n',texterr{:});
    fclose(fid);
    
end