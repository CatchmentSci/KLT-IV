% Button pushed function: CALCULATEButton
function KLT_CALCULATEButtonPushed(app, ~)
clear app.UITable2.Data M2 xsVelocity xsStd

KLT_editCel2(app)

% Create the finalised cross-section
if app.UITable2.Data(1,1) ~= 0
    M1      = app.startXS;
    N1      = [0];
    D1      = [0];
else
    M1      = [];
    N1      = [];
    D1      = [];
end

if app.UITable2.Data(end,1) < app.transectLength % changed 20210312
    M3      = app.endXS;
    N3      = [app.transectLength];
    D3      = [0];
else
    M3      = [];
    N3      = [];
    D3      = [];
end

N2          = app.UITable2.Data(~isnan(app.UITable2.Data(:,1)));
A2          = {N1, N2, N3};
xsPlot      = cat(1,A2{:});
t1          = size(app.xInder);
M2          = [app.xInder; app.yInder]';
A1          = {M1, M2, M3};
xsIn        = cat(1,A1{:});


if strcmp(app.ReferenceHeight.Value, 'Water depth [m]') == 1
    D2      =  app.UITable2.Data(~isnan(app.UITable2.Data(:,1)),2);
    t1      = find(D2<0);
    
    if ~isempty(t1)
        D2(t1) = 0;
    end
    
    A3      = {D1, D2, D3};
    depthIn = cat(1,A3{:});
    cont    = 1;
    
elseif strcmp(app.ReferenceHeight.Value, 'True bed elevation [m]') == 1
    D2      = app.UITable2.Data(~isnan(app.UITable2.Data(:,1)),2);
    D2      = app.WatersurfaceelevationmEditField.Value - D2;
    t1      = find(D2<0);
    
    if ~isempty(t1)
        D2(t1) = 0;
    end
    
    A3      = {D1, D2, D3};
    depthIn = cat(1,A3{:});
    cont    = 1;
else
    cont    = 0;
end

% interpolate the xs (x,y, and depth) to 0.01m dist increments
xi          = xsIn(:,1);
yi          = xsIn(:,2);


% add noise to x if required
if length(unique(xi)) < length(xi)
    [M, N] = size(xi);
    xi = xi + 0.000001*rand(M,N);
end

% add noise to y if required
if length(unique(yi)) < length(yi)
    [M, N] = size(yi);
    yi = yi + 0.000001*rand(M,N);
end

% add noise to depth if required
te1             = diff(depthIn);
te2             = find(te1 == 0)+1;
[M, N]          = size(te2);
depthIn(te2)    = depthIn(te2) + 0.000001*rand(M,N);


F                       = scatteredInterpolant(xi,yi,depthIn);
F.Method                = 'nearest';
F.ExtrapolationMethod   = 'nearest';
nu                      = abs(xsIn(1,:) - xsIn(end,:));
nu2                     = sqrt(nu(1).^2+ nu(2).^2);
nu3                     = nu2.*100; % num of cms
XQ                      = linspace(xi(1),xi(end),nu3); % modified - check ok
YQ                      = linspace(yi(1),yi(end),nu3); % modified - check ok
% [Xg,Yg]               = meshgrid(XQ,YQ);
% 
xsIn                    = [XQ; YQ]'; % overwrite original input
vq                      = F(xsIn(:,1),xsIn(:,2)); % need to optimise
depthIn                 = vq; % overwrite original input

% ensure the depth data is properly interpolated between points
TF = find(diff(depthIn) ~= 0);
TF = [0;TF]; % length(depthIn)];
Ti = cat(1,A3{:});

for a = 1:length(TF)
    if a == 1
        midPoint(a) = 1;
    elseif a == length(TF)
        midPoint(a) = length(depthIn);
    else
        midPoint(a) = round((TF(a+1) - TF(a)+1)./2) + TF(a);
    end
    
end

vq              = interp1(midPoint,depthIn(midPoint),1:length(depthIn));
vq              = replace_num(vq,NaN,0);
depthIn         = vq;
depthIn(1)      = 0;
depthIn(end)    = 0;
% differences between actual and sim:
% t = 0.01:0.01:length(depthIn)/100;
% plot(t,depthIn); hold on; % Sim
% plot(xsPlot,D2) % Actual


% Added to enable a flexible cell structure 20210310
% Corrections made on 20210803 - needs testing
t1              = find(depthIn < 0.01);
[~,temp1]       = nanmax(diff(t1));
wetCellsStart   = t1(temp1);
wetCellsEnd     = t1(temp1+1);

if isempty(wetCellsEnd) wetCellsEnd = length(depthIn); end % test this
wetCellsNum     = abs(wetCellsEnd - wetCellsStart);
wetCellsIdx     = wetCellsStart:round(wetCellsNum./app.CellNumberEditField.Value):wetCellsEnd;
wetCellsIdx     = [wetCellsIdx(1:app.CellNumberEditField.Value), wetCellsEnd];

compCell = zeros(length(app.refValue),1); %new
if cont == 1
    for s = 1:app.CellNumberEditField.Value

        cellSectionIn = xsIn(wetCellsIdx(s):wetCellsIdx(s+1)-1,1:2);

        % find trajectories that intersect the xs within each cell
        for t = 1:length(app.xyzA_final)
            if app.refValue(t)>0
                x1      = [cellSectionIn(1,1), cellSectionIn(end,1)];
                y1      = [cellSectionIn(1,2), cellSectionIn(end,2)];
                x2      = [app.xyzA_final(t,1), app.xyzB_final(t,1)];
                y2      = [app.xyzA_final(t,2), app.xyzB_final(t,2)];
                section_saved{s} = [x1; y1]; %new
                P       = InterX([x1;y1],[x2;y2]);
                %plot(x1,y1,x2,y2,P(1,:),P(2,:),'ro')
                if ~isempty(P)
                    withinCell(t) = true; 
                    idx = find(withinCell==true); %new 
                    compCell(idx) = 1; %new
                else
                    withinCell(t) = false;
                end
            end
        end
        
        mi(s,1:2)      = [nanmean(x1), nanmean(y1)] ;
        xsVelocity(s)  = nanmedian(app.refValue(withinCell));  
        clear withinCell
    end
    
    graphics = 0;
    if graphics == 1 %all new
        run('C:\Users\Matt\OneDrive - Newcastle University\Archive_Dart\Scripts\finalised\Figure1_schematic_b.m');
        constantZ = [4998.681];
        compCell = find(compCell > 0);
        cd = colormap (parula); % take your pick (doc colormap)
        cd = interp1(linspace(nanmin(app.refValue(compCell)),prctile(app.refValue(compCell),100),...
            length(cd)),cd,app.refValue(compCell)); % map color to velocity values
        cd = replace_num(cd,NaN,0);
        
        % new loop
        for aa = 1:length(compCell)
            h2(aa) = plot3([app.xyzA_final(compCell(aa),1), app.xyzB_final(compCell(aa),1)],...
                [app.xyzA_final(compCell(aa),2), app.xyzB_final(compCell(aa),2)], ...
                [constantZ , constantZ],...
                'color', cd(aa,:)); hold on;
        end
        
        for bb = 1:length(section_saved)
            plot3([section_saved{bb}(1,:)],[4980,5007],[constantZ, constantZ],'k--');
            hold on;
        end
    end

    % if no data in first or last cells assign as zero
    % This is not required now due to the cells always incorporating some
    % active channel
    %if isnan(xsVelocity(1,1)) xsVelocity(1,1) = 0; end
    %if isnan(xsVelocity(1,end)) xsVelocity(1,end) = 0; end
    
    % Apply the alpha coefficient
    xsVelocity      = xsVelocity.*app.alphaEditField.Value; 
    
    % Ensure x-data is distance along xs
    out             = cell2mat(cellfun(@(x) app.startXS-x ,{mi},'un',0));
    absDistance     = sqrt(out(:,1).^2+out(:,2).^2);
    missingInd      = find(isnan(xsVelocity));
    
    if strcmp(app.InterpolationMethod.Value, 'Quadratic Polynomial') == 1
        
        QuadraticVelocity   = xsVelocity';
        paddingIn           = [absDistance(1) - nanmean(diff(absDistance))./2,...
            absDistance(end) + nanmean(diff(absDistance))./2];
        combinedIn = [[paddingIn(1);0]'; ...
            absDistance, QuadraticVelocity; ...
            [paddingIn(2);0]'];
        [xData, yData]      = prepareCurveData( combinedIn(:,1), combinedIn(:,2));
        ft                  = fittype( 'poly2' );% Set up fittype and options (3rd order polynomial)
        [fitresult, ~]      = fit( xData, yData, ft );% Fit model to data.
        
        QuadraticVelocity(missingInd) = fitresult.p1.*absDistance(missingInd).^2 + fitresult.p2.*absDistance(missingInd) + fitresult.p3;
        rem1 = find(QuadraticVelocity < 0);
        QuadraticVelocity(rem1) = 0;
        KLT_plotFcn(app, absDistance, QuadraticVelocity, missingInd);
        
        % Discharge calculated using the velocity area mid-section method and cubic extrapolation (Herschy, 1993)
        for a = 1:length(xsVelocity)
            idx         = wetCellsIdx(a) : wetCellsIdx(a+1)-1;
            cellArea(a) = nanmean(depthIn(idx)).*length(idx)./100;
            q(a)        = QuadraticVelocity(a) .* cellArea(a);
            
            if a == length(QuadraticVelocity)
                totalQ_quad = sum(q);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message1 = ['Q = ' num2str(round(totalQ_quad,2)) ' m' char(179) '/s'];
                    msgbox(message1,'Value');
                else
                    app.totalQ(app.videoNumber) = totalQ_quad;
                end
            end
        end
        
    elseif strcmp(app.InterpolationMethod.Value, 'Cubic Polynomial') == 1
        
        CubicVelocity       = xsVelocity';
        paddingIn           = [absDistance(1) - nanmean(diff(absDistance))./2,...
            absDistance(end) + nanmean(diff(absDistance))./2];
        combinedIn = [[paddingIn(1);0]'; ...
            absDistance, CubicVelocity; ...
            [paddingIn(2);0]'];
        [xData, yData]      = prepareCurveData( combinedIn(:,1), combinedIn(:,2));
        ft = fittype( 'poly3' );% Set up fittype and options (3rd order polynomial)
        [fitresult, ~]  = fit( xData, yData, ft );% Fit model to data.
        
        CubicVelocity(missingInd) = fitresult.p1.*absDistance(missingInd).^3 + fitresult.p2.*absDistance(missingInd).^2 ...
            + fitresult.p3.*absDistance(missingInd) + fitresult.p4;
        rem1 = find(CubicVelocity < 0);
        CubicVelocity(rem1) = 0;
        KLT_plotFcn(app, absDistance, CubicVelocity, missingInd);
        
        % Discharge calculated using the velocity area mid-section method and cubic extrapolation (Herschy, 1993)
        for a = 1:length(xsVelocity)
            idx = wetCellsIdx(a) : wetCellsIdx(a+1)-1;
            cellArea(a) = nanmean(depthIn(idx)).*length(idx)./100;
            q(a) = CubicVelocity(a) .* cellArea(a);
            
            if a == length(CubicVelocity)
                totalQ_quad = sum(q);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message1 = ['Q = ' num2str(round(totalQ_quad,2)) ' m' char(179) '/s'];
                    msgbox(message1,'Value');
                else
                    app.totalQ(app.videoNumber) = totalQ_quad;
                end
            end
        end
        
    elseif strcmp(app.InterpolationMethod.Value, 'Constant Froude') == 1
        
        for a = 1:length(xsVelocity)
            idx = wetCellsIdx(a) : wetCellsIdx(a+1)-1;
            depthUse(a) = nanmean(depthIn(idx));
        end
            
        [xData, yData] = prepareCurveData( depthUse, xsVelocity );
        ft = fittype( 'poly1' );% Set up fittype and options.
        [fitresult, ~] = fit( xData, yData, ft );% Fit model to data.
        
        % Discharge calculated using the velocity area mid-section method and constant froude number assumption (Herschy, 1993)
        froudeVelocity = xsVelocity';
        froudeVelocity(missingInd) = NaN;
        dlm = fitlm(depthUse,froudeVelocity,'Intercept',false);
        froudeVelocity(missingInd) = depthUse(missingInd).* table2array(dlm.Coefficients(1,1));
        KLT_plotFcn(app, absDistance, froudeVelocity, missingInd);
        
        
        for a = 1:length(xsVelocity)
            idx = wetCellsIdx(a) : wetCellsIdx(a+1)-1;
            cellArea(a) = nanmean(depthIn(idx)).*length(idx)./100;
            q(a) = froudeVelocity(a) .* cellArea(a);
            
            if a == length(froudeVelocity)
                totalQ_froude = sum(q);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message1 = ['Q = ' num2str(round(totalQ_froude,2)) ' m' char(179) '/s'];
                    msgbox(message1,'Value');
                else
                    app.totalQ(app.videoNumber) = totalQ_froude;
                end
            end
        end % for length velocity measurements
    
    
    elseif strcmp(app.InterpolationMethod.Value, 'All') == 1
    
        base_velocity       = xsVelocity';
        idx_q               = 1;
        QuadraticVelocity   = base_velocity;
        paddingIn           = [absDistance(1) - nanmean(diff(absDistance))./2,...
            absDistance(end) + nanmean(diff(absDistance))./2];
        combinedIn = [[paddingIn(1);0]'; ...
            absDistance, QuadraticVelocity; ...
            [paddingIn(2);0]'];
        
        [xData, yData]      = prepareCurveData( combinedIn(:,1), combinedIn(:,2));
        ft                  = fittype( 'poly2' );% Set up fittype and options (3rd order polynomial)
        [fitresult, ~]      = fit( xData, yData, ft );% Fit model to data.
        
        QuadraticVelocity(missingInd) = fitresult.p1.*absDistance(missingInd).^2 + fitresult.p2.*absDistance(missingInd) + fitresult.p3;
        rem1 = find(QuadraticVelocity < 0);
        QuadraticVelocity(rem1) = 0;
        
        % Discharge calculated using the velocity area mid-section method and cubic extrapolation (Herschy, 1993)
        for a = 1:length(xsVelocity)
            idx         = wetCellsIdx(a) : wetCellsIdx(a+1)-1;
            cellArea(a) = nanmean(depthIn(idx)).*length(idx)./100;
            q(a)        = QuadraticVelocity(a) .* cellArea(a);
            
            if a == length(QuadraticVelocity)
                totalQ_quad = sum(q);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message1 = ['Q quadratic = ' num2str(round(totalQ_quad,2)) ' m' char(179) '/s'];
                else
                    app.totalQ(idx_q,app.videoNumber) = totalQ_quad;
                end
            end
        end
        
        idx_q           = idx_q + 1;
        CubicVelocity   = base_velocity;
        paddingIn       = [absDistance(1) - nanmean(diff(absDistance))./2,...
            absDistance(end) + nanmean(diff(absDistance))./2];
        combinedIn = [[paddingIn(1);0]'; ...
            absDistance, CubicVelocity; ...
            [paddingIn(2);0]'];
        
        [xData, yData]  = prepareCurveData( combinedIn(:,1), combinedIn(:,2));
        ft              = fittype( 'poly3' );% Set up fittype and options (3rd order polynomial)
        [fitresult, ~]  = fit( xData, yData, ft );% Fit model to data.
        
        CubicVelocity(missingInd) = fitresult.p1.*absDistance(missingInd).^3 + fitresult.p2.*absDistance(missingInd).^2 ...
            + fitresult.p3.*absDistance(missingInd) + fitresult.p4;
        rem1 = find(CubicVelocity < 0);
        CubicVelocity(rem1) = 0;
        
        % Discharge calculated using the velocity area mid-section method and cubic extrapolation (Herschy, 1993)
        for a = 1:length(xsVelocity)
            
            idx         = wetCellsIdx(a) : wetCellsIdx(a+1)-1;
            cellArea(a) = nanmean(depthIn(idx)).*length(idx)./100;
            q(a)        = CubicVelocity(a) .* cellArea(a);
            
            if a == length(CubicVelocity)
                totalQ_cubic = sum(q);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message2 = ['Q cubic = ' num2str(round(totalQ_cubic,2)) ' m' char(179) '/s'];
                else
                    app.totalQ(idx_q, app.videoNumber) = totalQ_cubic;
                end
            end
        end
        
        % Froude section
        idx_q           = idx_q + 1;
        for a = 1:length(xsVelocity)
            idx = wetCellsIdx(a) : wetCellsIdx(a+1)-1;
            depthUse(a) = nanmean(depthIn(idx));
        end
            
        % Discharge calculated using the constant froude number assumption (Herschy, 1993)
        [xData, yData] = prepareCurveData( depthUse, xsVelocity );
        froudeVelocity = xsVelocity';
        froudeVelocity(missingInd) = NaN;
        dlm = fitlm(depthUse,froudeVelocity,'Intercept',false);
        froudeVelocity(missingInd) = depthUse(missingInd).* table2array(dlm.Coefficients(1,1));
                
        KLT_plotFcn_All(app, absDistance, QuadraticVelocity, CubicVelocity, froudeVelocity, missingInd)

        for a = 1:length(xsVelocity)
            idx = wetCellsIdx(a) : wetCellsIdx(a+1)-1;
            cellArea(a) = nanmean(depthIn(idx)).*length(idx)./100;
            q(a) = froudeVelocity(a) .* cellArea(a);
            
            if a == length(froudeVelocity)
                totalQ_froude = sum(q);
                if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == false
                    message3 = ['Q Froude = ' num2str(round(totalQ_froude,2)) ' m' char(179) '/s'];
                    message = sprintf([message1, '\n', message2, '\n', message3, '\n' ]);
                    msgbox(message,'Value');
                else
                    app.totalQ(idx_q,app.videoNumber) = totalQ_froude;
                end
            end
        end % for length velocity measurements
        app.totalQ = replace_num(app.totalQ,0,NaN);
    end % interpolation method
end % cont
end % function