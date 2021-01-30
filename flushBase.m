function flushBase(app)

flushBase = ['clearvars -except app'];
eval('base',flushBase);
evalin('base','clear')

end