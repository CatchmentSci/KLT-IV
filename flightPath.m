function flightPath(app)
if strcmp (app.FlightPathPlotSwitch.Value, 'On') == 1 && strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == 0
    f1 = figure(); % this plots the UAS flight path based on optimisation using GCPs
    h1_1 = scatter3(app.cameraModelParameters(:,1),app.cameraModelParameters(:,2),app.cameraModelParameters(:,3));
    hold on;
    h1_2 = plot3(app.cameraModelParameters(:,1),app.cameraModelParameters(:,2),app.cameraModelParameters(:,3));
    set(gca,'TickLabelInterpreter','latex');
    title ('Camera location throughout the video')
    zlabel('z coordinates [m]' , 'Interpreter','LaTex');
    xlabel('x coordinates [m]', 'Interpreter','LaTex');
    ylabel('y coordinates [m]', 'Interpreter','LaTex');
end
end
