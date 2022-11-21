function KLT_edit_discharge_report(app,absDistance, depthUse, QuadraticVelocity, CubicVelocity, froudeVelocity, missingInd, cellArea, totalQ_froude, totalQ_quad, totalQ_cubic, wetted_width );

text            = fileread('KLT_discharge_report.html');

[sizer1,~]      = size(app.totalQ);

if sizer1 == 1 % if only one q output
    newChr          = strrep(text,'VarSiteName',app.file); % assign the video name
    newChr          = strrep(newChr,'VarFileName',app.file); % assign the video name
else
    [~,nameIn,~]    = fileparts(app.directory_save_multiple);
    newChr          = strrep(text,'VarSiteName',nameIn); % assign the video name
    newChr          = strrep(newChr,'VarFileName',nameIn); % assign the video name
end

newChr          = strrep(newChr,'VarCameraType',app.CameraTypeDropDown.Value); % assign the camera type
newChr          = strrep(newChr,'VarXYZ',...
    [ num2str(round(app.camA.xyz(1,1),2)), ', ' num2str(round(app.camA.xyz(1,2),2)), ', ' num2str(round(app.camA.xyz(1,3),2))]); % assign the optimised camera location
newChr          = strrep(newChr,'VarYawPitchRoll',...
    [num2str(round(app.camA.viewdir(1),2)) ', '  num2str(round(app.camA.viewdir(2),2)) ', ' num2str(round(app.camA.viewdir(3),2))]);
newChr          = strrep(newChr,'VarVideoDuration',num2str(app.videoDuration)); % assign the video duration
newChr          = strrep(newChr,'VarFrameRate',num2str(app.videoFrameRate)); % assign the video frame rate
newChr          = strrep(newChr,'VarResolution',[num2str(size(app.firstFrame,1)) ' x ' num2str(size(app.firstFrame,2))]); % assign the video resolution
[~,cmdout]      = system('ver'); % get OS version info
newChr          = strrep(newChr,'VarOSName',cmdout); % assign the OS version
[~,cmdout]      = system('hostname'); % get OS version info
newChr          = strrep(newChr,'VarSystemName',cmdout); % assign the system name
[~,cmdout]      = system('echo %PROCESSOR_ARCHITECTURE%'); % get OS version info
newChr          = strrep(newChr,'VarSystemType',cmdout); % assign the system name
newChr          = strrep(newChr, 'VarOrientationMethod',app.OrientationDropDown.Value); % assign the orientation method
newChr          = strrep(newChr, 'VarExtractRate',num2str(app.ExtractionratesEditField.Value)); % assign the extract rate
newChr          = strrep(newChr, 'VarBlockSize',num2str(app.BlocksizepxEditField.Value)); % assign the block size
newChr          = strrep(newChr, 'VarVelComponent',app.VelocityDropDown.Value); % assign the velocity component
newChr          = strrep(newChr, 'VarIgnoreEdges',app.IgnoreEdgesDropDown.Value ); % assign the velocity component

% Add the GCP data
GCPtext         = fileread('KLT_discharge_report_GCP_template.txt');
for a = 1:size(app.gcpA,1)

    GCPtext_mod     = strrep(GCPtext,'GCP x1', num2str(app.gcpA(a,1))); 
    GCPtext_mod     = strrep(GCPtext_mod,'GCP y1', num2str(app.gcpA(a,2))); 
    GCPtext_mod     = strrep(GCPtext_mod,'GCP z1', num2str(app.gcpA(a,3))); 
    GCPtext_mod     = strrep(GCPtext_mod,'GCP x2', num2str(app.gcpA(a,4))); 
    GCPtext_mod     = strrep(GCPtext_mod,'GCP y2', num2str(app.gcpA(a,5))); 
    GCPtext_mod     = strrep(GCPtext_mod,'x error', num2str(round(app.GCPdiff(a,1),2))); 
    GCPtext_mod     = strrep(GCPtext_mod,'y error', num2str(round(app.GCPdiff(a,2),2))); 
    GCPtext_mod     = strrep(GCPtext_mod,'total error', num2str(abs(round(sqrt(app.GCPdiff(a,1).^2+app.GCPdiff(a,2)),2))));

    if a == 1
        fid = fopen([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_GCP_data.txt'],'w');
        fprintf(fid,'%s',GCPtext_mod);
        fclose(fid);
    else
        fid = fopen([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_GCP_data.txt'],'a');
        fprintf(fid,'%s',[GCPtext_mod]);
        fclose(fid);
    end
end

GCPtext_mod     = fileread([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_GCP_data.txt']);
newChr          = strrep(newChr, '<!--    GCP text placeholder    -->',GCPtext_mod ); % assign the velocity component


% Add the PP information
if app.prepro == 0
    newChr = strrep(newChr, 'VarPrePro', 'None'); % specify no pre-processing
else
    newChr = strrep(newChr, 'VarPrePro', 'Active'); % specify pre-processing active
end

PPtext         = fileread('KLT_discharge_report_preprocessing_template.txt');

if ~isempty(app.pre_pro_params) && app.pre_pro_params(2) == 1 % CLAHE settings
    PPtext_mod     = strrep(PPtext,'VarCLAHESize', num2str(app.pre_pro_params(3)));
    PPtext_mod     = strrep(PPtext_mod,'VarCLAHE', 'Enabled');
else
    PPtext_mod     = strrep(PPtext,'VarCLAHESize', 'Null');
    PPtext_mod     = strrep(PPtext_mod,'VarCLAHE', 'Disabled');
end

if ~isempty(app.pre_pro_params) && app.pre_pro_params(4) == 1 % High pass settings
    PPtext_mod     = strrep(PPtext_mod,'VarHighPassSize', num2str(app.pre_pro_params(5)));
    PPtext_mod     = strrep(PPtext_mod,'VarHighPass', 'Enabled');
else
    PPtext_mod     = strrep(PPtext_mod,'VarHighPassSize', 'Null');
    PPtext_mod     = strrep(PPtext_mod,'VarHighPass', 'Disabled');
end

if ~isempty(app.pre_pro_params) && app.pre_pro_params(7) == 1 % WIENER lowpass settings
    PPtext_mod     = strrep(PPtext_mod,'VarWIENERfilter', 'Enabled');
    PPtext_mod     = strrep(PPtext_mod,'VarWIENERsize', num2str(app.pre_pro_params(8)));
else
    PPtext_mod     = strrep(PPtext_mod,'VarWIENERfilter', 'Disabled');
    PPtext_mod     = strrep(PPtext_mod,'VarWIENERsize', 'Null');
end

if ~isempty(app.pre_pro_params) && app.pre_pro_params(6) == 1 % Intensity cap settings
    PPtext_mod     = strrep(PPtext_mod,'VarIntensityCap', 'Enabled');
else
    PPtext_mod     = strrep(PPtext_mod,'VarIntensityCap', 'Disabled');
end

if ~isempty(app.pre_pro_params) && app.pre_pro_params(11) == 1 % Intensity cap settings
    PPtext_mod     = strrep(PPtext_mod,'VarBackgroundRemoval', 'Enabled');
else
    PPtext_mod     = strrep(PPtext_mod,'VarBackgroundRemoval', 'Disabled');
end

newChr          = strrep(newChr, '<!--    PP text placeholder    -->', PPtext_mod); % assign the velocity component
newChr          = strrep(newChr,'VarCheckGCPs',app.CheckGCPsSwitch.Value); % specify whether GCPs were checked or not
newChr          = strrep(newChr,'VarExportGCPs',app.ExportGCPdataSwitch.Value); % specify whether GCPs were exported or not

if app.CustomFOVEditField_2.Value  > 0 && app.CustomFOVEditField_4.Value  > 0 ...
        && app.CustomFOV_modifyBox.Value == 1
    newChr          = strrep(newChr,'VarBufferNumber','Disabled'); % specify whether GCPs were exported or not
    newChr          = strrep(newChr,'VarFOV_X',[ '[' num2str(round(app.CustomFOVEditField_2.Value,2)), ', ' num2str(round(app.CustomFOVEditField_4.Value,2)) ']']); % input custom FOV for x
    newChr          = strrep(newChr,'VarFOV_Y',[ '[' num2str(round(app.CustomFOVEditField_3.Value,2)), ', ' num2str(round(app.CustomFOVEditField_5.Value,2)) ']']); % input custom FOV for y
elseif app.BufferaroundGCPsmetersEditField.Value > 0 ...
        && app.GCPbuffer_modifyBox.Value == 1
    newChr          = strrep(newChr,'VarBufferNumber',num2str(app.BufferaroundGCPsmetersEditField.Value)); % specify whether GCPs were exported or not
    newChr          = strrep(newChr,'VarFOV_X','Null'); % input custom FOV for x
    newChr          = strrep(newChr,'VarFOV_Y','Null'); % input custom FOV for y
end

newChr          = strrep(newChr,'VarWSE',num2str(app.WatersurfaceelevationmEditField.Value)); % define the WSE
newChr          = strrep(newChr,'VarSubsampleLength',num2str(round(app.videoClip - app.videoStart,2))); % define the analysed video length
newChr          = strrep(newChr,'VarFrames', [num2str(round(app.videoFrameRate  .* app.videoStart)) ' - ' num2str(round(app.videoFrameRate  .* app.videoClip))]);
newChr          = strrep(newChr,'VarAngleFilter',num2str(app.filterAngle)); % define the filter angle
newChr          = strrep(newChr,'VarThresholdFilter',['[' num2str(app.minVel) ' - ' num2str(app.maxVel) ']']); % define the threshold filter

newChr          = strrep(newChr,'VarXSMethod',app.CrossSectionDropDown.Value); % define the xs method
newChr          = strrep(newChr,'VarRefHgt',app.ReferenceHeight.Value); % define the bed reference height
newChr          = strrep(newChr,'VarCellNum',num2str(app.CellNumberEditField.Value)); % define the number of cells for Q measurement
newChr          = strrep(newChr,'VarInterpolationMethod',app.InterpolationMethod.Value); % define the number of cells for Q measurement
newChr          = strrep(newChr,'VarAlpha',num2str(app.alphaEditField.Value)); % define the alpha coefficient


% Add the Q data
Qtext         = fileread('KLT_discharge_report_discharge_template.txt');

for a = 1:app.CellNumberEditField.Value

    Qtext_mod     = strrep(Qtext,'VarQnum', num2str(a)); % sample number
    Qtext_mod     = strrep(Qtext_mod,'VarLocation', num2str(round(absDistance(a),2))); % distance
    Qtext_mod     = strrep(Qtext_mod,'VarDepth', num2str(round(depthUse(a),2))); % depth
    Qtext_mod     = strrep(Qtext_mod,'VarArea', num2str(round(cellArea(a),2))); % area
    
    if ismember(a,missingInd) % assign measurement mode
        Qtext_mod     = strrep(Qtext_mod,'VarMode', 'Estimated');
    else
        Qtext_mod     = strrep(Qtext_mod,'VarMode', 'Measured');
    end
   
    if strcmp(app.InterpolationMethod.Value, 'Quadratic Polynomial')
        q_quad_cell   = QuadraticVelocity .* cellArea';
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelQuad', num2str(round(QuadraticVelocity(a),2))); % quad velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQQuad', num2str(round(q_quad_cell(a),2))); % quad velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalQuad', num2str(round((q_quad_cell(a)./totalQ_quad).*100,2))); % quad percent
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelCubic', '&nbsp;'); % cubic velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQCubic', '&nbsp;'); % cubic velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalCubic', '&nbsp;'); % cubic percent
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelFroude', '&nbsp;'); % froude velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQFroude', '&nbsp;'); % froude velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalFroude', '&nbsp;'); % froude percent
        newChr        = strrep(newChr, 'VarMeanVelocity', num2str(mean(round(QuadraticVelocity,2)))); % assign mean velocities
        newChr        = strrep(newChr, 'VarMaxV', num2str(max(round(QuadraticVelocity,2)))); % assign mean velocities
        newChr        = strrep(newChr, 'VarQ', num2str(round(totalQ_quad,2))); % assign Q

    elseif strcmp(app.InterpolationMethod.Value, 'Cubic Polynomial')
        q_cubic_cell  = CubicVelocity .* cellArea';
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelCubic', num2str(round(CubicVelocity(a),2))); % cubic velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQCubic', num2str(round(q_cubic_cell(a),2))); % cubic velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalCubic', num2str(round((q_cubic_cell(a)./totalQ_cubic).*100,2))); % cubic percent
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelFroude', '&nbsp;'); % cubic velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQFroude', '&nbsp;'); % froude velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalFroude', '&nbsp;'); % froude percent
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelQuad', '&nbsp;'); % quad velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQQuad', '&nbsp;'); % quad velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalQuad', '&nbsp;'); % quad percent
        newChr        = strrep(newChr, 'VarMeanVelocity', num2str(mean(round(CubicVelocity,2)))); % assign mean velocities
        newChr        = strrep(newChr, 'VarMaxV', num2str(max(round(CubicVelocity,2)))); % assign mean velocities
        newChr        = strrep(newChr, 'VarQ', num2str(round(totalQ_cubic,2))); % assign Q

    elseif strcmp(app.InterpolationMethod.Value, 'Constant Froude')
        q_froude_cell = froudeVelocity .* cellArea';
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelQuad', '&nbsp;'); % quad velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQQuad', '&nbsp;'); % quad velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalQuad', '&nbsp;'); % quad percent
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelCubic', '&nbsp;'); % cubic velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQCubic', '&nbsp;'); % cubic velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalCubic', '&nbsp;'); % cubic percent
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelFroude', num2str(round(froudeVelocity(a),2))); % froude velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQFroude', num2str(round(q_froude_cell(a),2))); % froude velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalFroude', num2str(round((q_froude_cell(a)./totalQ_froude).*100,2))); % froude percent
        newChr        = strrep(newChr, 'VarMeanVelocity', num2str(mean(round(froudeVelocity,2)))); % assign mean velocities
        newChr        = strrep(newChr, 'VarMaxV', num2str(max(round(froudeVelocity,2)))); % assign mean velocities
        newChr        = strrep(newChr, 'VarQ', num2str(round(totalQ_froude,2))); % assign Q

    elseif strcmp(app.InterpolationMethod.Value, 'All')
        q_cubic_cell  = CubicVelocity .* cellArea';
        q_quad_cell   = QuadraticVelocity .* cellArea';
        q_froude_cell = froudeVelocity .* cellArea';
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelQuad', num2str(round(QuadraticVelocity(a),2))); % quad velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQQuad', num2str(round(q_quad_cell(a),2))); % quad velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalQuad', num2str(round((q_quad_cell(a)./totalQ_quad).*100,2))); % quad percent
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelCubic', num2str(round(CubicVelocity(a),2))); % cubic velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQCubic', num2str(round(q_cubic_cell(a),2))); % cubic velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalCubic', num2str(round((q_cubic_cell(a)./totalQ_cubic).*100,2))); % cubic percent
        Qtext_mod     = strrep(Qtext_mod,'VarMeanVelFroude', num2str(round(froudeVelocity(a),2))); % froude velocity
        Qtext_mod     = strrep(Qtext_mod,'VarMeanUnitQFroude', num2str(round(q_froude_cell(a),2))); % froude velocity    
        Qtext_mod     = strrep(Qtext_mod,'VarPerTotalFroude',num2str(round((q_froude_cell(a)./totalQ_froude).*100,2))); % froude percent
                
        temp            = [ sprintf('%.2f, ' , round([totalQ_quad, totalQ_cubic, totalQ_froude],2)) ];
        temp2           = [ '[' temp(1:end-2) ']' ];
        newChr        = strrep(newChr, 'VarQ', temp2); % assign Q values

        temp            = [ sprintf('%.2f, ' , round(mean([QuadraticVelocity, CubicVelocity, froudeVelocity]),2))];
        temp2           = [ '[' temp(1:end-2) ']' ];
        newChr        = strrep(newChr, 'VarMeanVelocity', temp2); % assign mean vel values

        temp            = [ sprintf('%.2f, ' , round(max([QuadraticVelocity, CubicVelocity, froudeVelocity]),2))];
        temp2           = [ '[' temp(1:end-2) ']' ];
        newChr        = strrep(newChr, 'VarMaxV', temp2); % assign max vel values

    end

    if a == 1
        fid = fopen([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_Q_data.txt'],'w');
        fprintf(fid,'%s',Qtext_mod);
        fclose(fid);
    else
        fid = fopen([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_Q_data.txt'],'a');
        fprintf(fid,'%s',[Qtext_mod]);
        fclose(fid);
    end
end

Qtext_mod     = fileread([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_Q_data.txt']);
newChr          = strrep(newChr, '<!--    Q text placeholder    -->',Qtext_mod ); % assign the velocity component

% add the plot data to the html file
temp = sprintf('%.2f,' , depthUse);
temp2 = [ '[' temp(1:end-1) ']' ];
newChr          = strrep(newChr,'VarPlotDepth',temp2); % define depth for the plot

temp = sprintf('%.2f,' , QuadraticVelocity);
temp2 = [ '[' temp(1:end-1) ']' ];
newChr          = strrep(newChr,'VarPlotQuadraticVelocity',temp2); % define quad vel for the plot

temp = sprintf('%.2f,' , CubicVelocity);
temp2 = [ '[' temp(1:end-1) ']' ];
newChr          = strrep(newChr,'VarPlotCubicVelocity',temp2); % define cubic vel for the plot

temp = sprintf('%.2f,' , froudeVelocity);
temp2 = [ '[' temp(1:end-1) ']' ];
newChr          = strrep(newChr,'VarPlotFroudeVelocity',temp2); % define froude vel for the plot

temp = sprintf('%.2f'',''', absDistance);
temp2 = [ '[''' temp(1:end-2) ']' ];
newChr          = strrep(newChr,'VarPlotDistance',temp2); % define depth for the plot
newChr          = strrep(newChr, 'VarWaterLevel',num2str(app.WatersurfaceelevationmEditField.Value)); % assign the water level
newChr          = strrep(newChr, 'VarArea',num2str(round(sum(cellArea),2))); % assign the water area
newChr          = strrep(newChr, 'VarWidth',num2str(round(wetted_width,2))); % assign the water area
newChr          = strrep(newChr, 'VarMaxD',num2str(round(max(depthUse),2))); % assign the water area
newChr          = strrep(newChr, 'VarFlowAngle', 'Disabled'); % assign the water area

% Write the modified data to the html file

if sizer1 == 1 % if only one q output
    fid = fopen([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_discharge_summary_report.html'],'w');
else
    fid = fopen([app.OutputDirectoryButton.Text '\' nameIn '_discharge_summary_report.html'],'w');
end

fprintf(fid,'%s',newChr);
fclose(fid);

% tidy up
try
    delete([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_Q_data.txt']);
    delete([app.OutputDirectoryButton.Text '\' app.file(1:end-4) '_GCP_data.txt']);
catch
end

end % function



