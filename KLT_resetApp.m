function KLT_resetApp(app)

props = properties(app);
startingAppVals = app.startingAppVals;

for ii=1:length(props)
    currentProperty = getfield(app, char(props(ii)));
    s1 = whos('currentProperty');
    if (s1.bytes./1e+6) > 10 && strcmp(props(ii),'app.totalQ') == 0 && strcmp(props(ii),'app.videoNumber') == 0
        var1 = strjoin(['app.' char(props(ii)) '= startingAppVals.' props(ii)],'');
        eval('caller',var1);
        pause(0.5)
    end
end

%if mod(app.starterInd,5) == 0 % after every 100 videos restart the App
%    saveState(app)
%end

end

