% Button pushed function: CALCULATEButton
function KLT_CALCULATEButtonPushed(app, ~)
clear app.UITable2.Data M2 xsVelocity xsStd

KLT_editCel2(app)

% Create the finalised cross-section
if app.UITable2.Data(1,1) ~= 0
    M1 = app.startXS;
    N1 = [0];
    D1 = [0];
else
    M1 = [];
    N1 = [];
    D1 = [];
end

if app.UITable2.Data(end,1) ~= app.transectLength
    M3 = app.endXS;
    N3 = [app.transectLength];
    D3 = [0];
else
    M3 = [];
    N3 = [];
    D3 = [];
end

N2 = app.UITable2.Data(~isnan(app.UITable2.Data(:,1)));
A2 = {N1, N2, N3};
crossSectionPlot = cat(1,A2{:});

t1 = size(app.xInder);
M2 =  [app.xInder; app.yInder]';
A1 = {M1, M2, M3};
crossSectionIn = cat(1,A1{:});

if strcmp(app.ReferenceHeight.Value, 'Water depth [m]') == 1
    D2 =  app.UITable2.Data(~isnan(app.UITable2.Data(:,1)),2);
    t1 = find(D2<0);
    if ~isempty(t1)
        D2(t1) = 0;
    end
    A3 = {D1, D2, D3};
    depthIn = cat(1,A3{:});
    continuer = 1;
elseif strcmp(app.ReferenceHeight.Value, 'True bed elevation [m]') == 1
    D2 =  app.UITable2.Data(~isnan(app.UITable2.Data(:,1)),2);
    D2 = app.WatersurfaceelevationmEditField.Value - D2;
    t1 = find(D2<0);
    if ~isempty(t1)
        D2(t1) = 0;
    end
    A3 = {D1, D2, D3};
    depthIn = cat(1,A3{:});
    continuer = 1;
else
    continuer = 0;
end


if continuer == 1
    for s = 1:length(crossSectionIn)
        [~, dis] = knnsearch(crossSectionIn(s,1:2), app.xyzA_final(:,1:2));
        use1 = find(dis < app.SearchDistanceEditField.Value); % find within 2.5% of the transect distance as default
        if ~isempty(use1)
            numberPoints(s) = length(use1);
            if strcmp(app.VelocityDropDown.Value, 'Velocity Magnitude') == 1
                temp1 = app.refValue; % uses the velocity magnitude if normal component hasn't been calculated
                xsVelocity(s) = nanmedian(temp1(use1));
            elseif strcmp(app.VelocityDropDown.Value, 'Normal Component') == 1
                xsVelocity(s) = nanmedian(app.normalVelocity(use1));
                xsStd(s) = nanstd(app.normalVelocity(use1));
            end
        end
        
        % Assign the start and stop positions with zero values
        if s == 1 || s == length(crossSectionIn)
            numberPoints(s) = 0;
            xsVelocity(s) = 0;
            xsStd(s) = 0;
        end
    end
    
    xsVelocity(2:end-1) = replace_num(xsVelocity(2:end-1),0,NaN);
    xsVelocity = xsVelocity.*app.alphaEditField.Value; % Apply the alpha coefficient
    xsVelocity(~depthIn' > 0) = 0; % Ensure limited to teh water extent
    xsStd(2:end-1) = replace_num(xsStd(2:end-1),0,NaN);
    
    % Ensure x-data is distance along xs
    out=cell2mat(cellfun(@(x) app.startXS-x ,{crossSectionIn},'un',0));
    absDistance = sqrt(out(:,1).^2+out(:,2).^2);
    missingInd = find(isnan(xsVelocity));
    
    if strcmp(app.InterpolationMethod.Value, 'Quadratic Polynomial') == 1
        QuadraticVelocity = xsVelocity';
        [xData, yData] = prepareCurveData( absDistance, QuadraticVelocity );
        ft = fittype( 'poly2' );% Set up fittype and options (3rd order polynomial)
        [fitresult, ~] = fit( xData, yData, ft );% Fit model to data.
        
        QuadraticVelocity(missingInd) = fitresult.p1.*absDistance(missingInd).^2 + fitresult.p2.*absDistance(missingInd) + fitresult.p3;
        rem1 = find(QuadraticVelocity < 0);
        QuadraticVelocity(rem1) = 0;
        plotFcn(app, absDistance, QuadraticVelocity, missingInd);
        
        % Discharge calculated using the velocity area mid-section method and cubic extrapolation (Herschy, 1993)
        for a = 1:length(absDistance)
            if a == 1
                q(a) = QuadraticVelocity(a) .* ((absDistance(a+1,1) - absDistance(a,1))./2) .* depthIn(a);
            elseif a == length(QuadraticVelocity)
                q(a) = QuadraticVelocity(a) .* ((absDistance(a,1) - absDistance(a-1,1))./2) .* depthIn(a);
                totalQ_quad = sum(q);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message1 = ['Q = ' num2str(round(totalQ_quad,2)) ' m' char(179) '/s'];
                    msgbox(message1,'Value');
                else
                    app.totalQ(app.videoNumber) = totalQ_quad;
                end
            else
                q(a) = QuadraticVelocity(a) .* ((absDistance(a+1,1) - absDistance(a-1,1))./2) .*depthIn(a);
            end
        end
        
    elseif strcmp(app.InterpolationMethod.Value, 'Cubic Polynomial') == 1
        CubicVelocity = xsVelocity';
        [xData, yData] = prepareCurveData( absDistance, CubicVelocity );
        ft = fittype( 'poly3' );% Set up fittype and options (3rd order polynomial)
        [fitresult, ~] = fit( xData, yData, ft );% Fit model to data.
        
        CubicVelocity(missingInd) = fitresult.p1.*absDistance(missingInd).^3 + fitresult.p2.*absDistance(missingInd).^2 ...
            + fitresult.p3.*absDistance(missingInd) + fitresult.p4;
        rem1 = find(CubicVelocity < 0);
        CubicVelocity(rem1) = 0;
        plotFcn(app, absDistance, CubicVelocity, missingInd);
        
        % Discharge calculated using the velocity area mid-section method and cubic extrapolation (Herschy, 1993)
        for a = 1:length(absDistance)
            if a == 1
                q(a) = CubicVelocity(a).*((absDistance(a+1,1) - absDistance(a,1))./2) .* depthIn(a);
            elseif a == length(CubicVelocity)
                q(a) = CubicVelocity(a).*((absDistance(a,1) - absDistance(a-1,1))./2) .* depthIn(a);
                totalQ_cubic = sum(q);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message1 = ['Q = ' num2str(round(totalQ_cubic,2)) ' m' char(179) '/s'];
                    msgbox(message1,'Value');
                else
                    app.totalQ(app.videoNumber) = totalQ_cubic;
                end
            else
                q(a) = CubicVelocity(a).*((absDistance(a+1,1) - absDistance(a-1,1))./2) .* depthIn(a);
            end
        end
        
    elseif strcmp(app.InterpolationMethod.Value, 'Constant Froude') == 1
        [xData, yData] = prepareCurveData( depthIn, xsVelocity' );
        ft = fittype( 'poly1' );% Set up fittype and options.
        [fitresult, ~] = fit( xData, yData, ft );% Fit model to data.
        
        % Discharge calculated using the velocity area mid-section method and constant froude number assumption (Herschy, 1993)
        for a = 1:length(xsVelocity)
            if a == 1
                froudeVelocity = xsVelocity';
                froudeVelocity(missingInd) = NaN;
                dlm = fitlm(depthIn,froudeVelocity,'Intercept',false);
                froudeVelocity(missingInd) = depthIn(missingInd).* table2array(dlm.Coefficients(1,1));
                plotFcn(app, absDistance, froudeVelocity, missingInd);
                distance1(a) = absDistance(a+1,1) - absDistance(a,1);
                qfroude(a) = froudeVelocity(a) .* ((absDistance(a+1,1) - absDistance(a,1))./2) .* depthIn(a);
            elseif a == length(xsVelocity)
                distance1(a) = absDistance(a,1) - absDistance(a-1,1);
                qfroude(a) = froudeVelocity(a) .* ((absDistance(a,1) - absDistance(a,1))./2) .* depthIn(a);
                totalQ_froude = sum(qfroude);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message1 = ['Q = ' num2str(round(totalQ_froude,2)) ' m' char(179) '/s'];
                    msgbox(message1,'Value');
                else
                    app.totalQ(app.videoNumber) = totalQ_froude;
                end
            else
                distance1(a) = absDistance(a+1,1) - absDistance(a-1,1);
                qfroude(a) = froudeVelocity(a) .* ((absDistance(a+1,1) - absDistance(a-1,1))./2) .* depthIn(a);
            end
        end % for length velocity measurements
    end % interpolation method
end % continuer
end % function