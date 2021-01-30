function [] = checkBox_optimizeXYZ(app)

% Create a check box:

cbx = uicheckbox(fig,'Position', [app.CameraxyzEditFieldLabel.Position] ,...
    'ValueChangedFcn',@(cbx,event) cBoxChanged(cbx,rb3));
end

% Create the function for the ValueChangedFcn callback:
function cBoxChanged(cbx,rb3)
val = cbx.Value;
if val
    rb3.Enable = 'off';
else
    rb3.Enable = 'on';
end
end