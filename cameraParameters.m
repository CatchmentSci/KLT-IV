% This function defines the camera internal paramaters
function [] = cameraParameters(app)


if strcmp(app.CameraTypeDropDown.Value,'Feshie') == 1 % Inspire in 4k
    %camA.viewdir = [0 0.43 0]; % starting estimate
    app.c = [1380.97382627503,792.679232759451]; % principal point
    app.f = [2550.35343875040,2556.01273149975]; % focal length
    app.k = [-0.387433168111666,0.196720029641234];
    app.p = [0.000503309879087366,0.00108477837537248];
    %camA.xyz = [284954.612736, 804757.459104, 238.410236]; % These are the known coordinates of the camera
end


if strcmp(app.CameraTypeDropDown.Value,'DJI Inspire 1') == 1 % Inspire in 4k
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [2359.98,2358.74]./[3840, 2160];
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [1887.62,1068.33]./[3840, 2160];
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.154181, 0.191157, -0.127208];
    app.p = [-0.000347475, 0.000901209];
end

if strcmp(app.CameraTypeDropDown.Value,'DJI Mavic 2 Pro') == 1 % Mavic in 4k
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [3.190368300693209e+03,3.201143699224210e+03]./[3840, 2160];
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [1.952351062450719e+03,1.034587378139037e+03]./[3840, 2160];
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [0.0237, -0.0513, 0.0501];
    app.p = [-0.0051, 0.0029];
end

if strcmp(app.CameraTypeDropDown.Value,'DJI Phantom 2 Vision+') == 1 % P2 in HD
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [2085.6531304193268,2097.7914297690591]./[1920, 1080];
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [983.72698564621078,591.10490171362926]./[1920, 1080];
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.39337101163739979, 0.22479403054754418, -0.060388944043505401];
    app.p = [0.00080516007117634213, 0.00033476323336714822];
end

if strcmp(app.CameraTypeDropDown.Value,'DJI Phantom 4 Pro') == 1 % P4P in 4k
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [2827.00857042855,2833.38156555097]./[4096, 2160];
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [2033.08012062467,1106.97452716574]./[4096, 2160];
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.0135157865829167,0.0115170782569725,0.00408501968559129];
    app.p = [0.00100397405901139,0.000192736356482156];
end

if strcmp(app.CameraTypeDropDown.Value,'GoPro Hero3') == 1 % GoPro3 in HD
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [857.48296979, 876.71824265]./[1920, 1080];
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [968.06224829, 556.37145899 ]./[1920, 1080];
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.25761402, 0.0877086999, -0.000256970803];
    app.p = [-0.000593390389, -0.015219409];
end


if strcmp(app.CameraTypeDropDown.Value,'GoPro Hero4') == 1 % GoPro4 in HD
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [1118.64, 1128.18]./[1920, 1080];
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [962.26, 545.433 ]./[1920, 1080];
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.270042, 0.114, -0.0294602];
    app.p = [-0.000356729, -0.000184773];
end

if strcmp(app.CameraTypeDropDown.Value,'Nikon D810') == 1 % Ru's RaBT camera
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [6083, 6061]./[6538, 3988]; %focal_pixel ./ imageWidth
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [3619.4 2446]./[6538, 3988]; % calibrated centre ./ calibrated imgsx
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.0856 0.0322 0.1564];
    app.p = [-0.0021 -0.0024];
end

if strcmp(app.CameraTypeDropDown.Value,['Hikvision IPC-B140 6mm']) == 1 % Small Hikvision camers
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [2124.42047162460, 2128.57975116548]./[1920, 1080]; %focal_pixel ./ imageWidth
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [941.887624920416, 505.126748658918]./[1920, 1080]; % calibrated centre ./ calibrated imgsx
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.402995926717212 -0.235231556745731 3.91194477707879];
    app.p = [0.00162223162654566 -0.000225216488124441];
end

if strcmp(app.CameraTypeDropDown.Value,['Hikvision DS-2CD2T42WD-I8 6mm']) == 1 % Big hikvision (Dart cal)
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [2175.30476649761,2180.36638652039]./[1920, 1080]; %focal_pixel ./ imageWidth
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [941.152559177274,523.591836252122]./[1920, 1080]; % calibrated centre ./ calibrated imgsx - Dart
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.402237894106535,0.282129187583127];
    app.p = [-0.00182249890441745,0.00181517750005350];
end

if strcmp(app.CameraTypeDropDown.Value,['Sony RX10II']) == 1 % Sony - Robert
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [3735.92768193351,3726.42702477657]./[5472, 3080]; %focal_pixel ./ imageWidth
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [2751.34166352007,1526.78770550591]./[5472, 3080]; % calibrated centre ./ calibrated imgsx
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.00200180077279503,-0.000171661928003883];
    app.p = [0.000780837449267255,0.00131777116373489];
end


if strcmp(app.CameraTypeDropDown.Value,['Vivotek IB8382-F3']) == 1 % Vivotek
    % focal_pixel = (focal_mm / sensor_width_mm) * image_width_in_pixels
    % therefore: focal_pixel/imageWidth = unknowns or un
    un = [563.276676795991, 564.045670214258]./[640, 360]; %focal_pixel ./ imageWidth
    app.f = [app.imgsz(2).*un(1),...
        app.imgsz(1).*un(2)];
    c_ratio = [312.179791583164, 186.327244987421]./[640, 360]; % calibrated centre ./ calibrated imgsx
    app.c = [app.imgsz(2).*c_ratio(1),...
        app.imgsz(1).*c_ratio(2)];
    app.k = [-0.411824895052046, 0.160953384394240];
    app.p = [-0.00169324854200364, 0.000575385479186003];
end

if strcmp(app.CameraTypeDropDown.Value,['Not listed']) == 1 % Unknown
    app.c = fliplr(app.imgsz(1:2)./2);
    app.f = [2000 2000]; % initial guess
    app.k = [0, 0];
    app.p = [0, 0];
end

end