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

if app.UITable2.Data(end,1) ~= app.transectLength
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


% add noise if required
if length(unique(xi)) < length(xi)
    [M, N] = size(xi);
    xi = xi + 0.000001*rand(M,N);
end

if length(unique(yi)) < length(yi)
    [M, N] = size(yi);
    yi = yi + 0.000001*rand(M,N);
end

F               = scatteredInterpolant(xi,yi,depthIn);
nu              = abs(xsIn(1,:) - xsIn(end,:));
nu2             = sqrt(nu(1).^2+ nu(2).^2);
nu3             = nu2.*100; % num of cms
XQ              = linspace(min(xi),max(xi),nu3);
YQ              = linspace(min(yi),max(yi),nu3);
vq              = F(XQ,YQ);
xsIn            = [XQ; YQ]'; % overwrite original input
xi              = xsIn(:,1);
yi              = xsIn(:,2);
depthIn         = vq;% overwrite original input
depthIn(1)      = 0;
depthIn(end)    = 0;


% Added to enable a flexible cell structure 20210310
t1              = find(depthIn < 0.01);
wetCellsStart   = find(diff(t1)>1)+1;
wetCellsEnd     = t1(end - find(diff(flipud(t1))<-1)+1)-1;
if isempty(wetCellsEnd) wetCellsEnd = length(depthIn); end % test this
wetCellsNum     = abs(wetCellsEnd - wetCellsStart);
wetCellsIdx     = wetCellsStart:round(wetCellsNum./app.CellNumberEditField.Value):wetCellsEnd;
wetCellsIdx     = [wetCellsIdx(1:app.CellNumberEditField.Value), wetCellsEnd];



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
                P       = InterX([x1;y1],[x2;y2]);
                %plot(x1,y1,x2,y2,P(1,:),P(2,:),'ro')
                if ~isempty(P)
                    withinCell(t) = true;
                else
                    withinCell(t) = false;
                end
            end
        end
        
        mi(s,1:2)      = [nanmean(x1), nanmean(y1)] ;
        xsVelocity(s)  = nanmedian(app.refValue(withinCell));  
        clear withinCell
        
    end
    
    % if no data in first or last cells assign as zero
    if isnan(xsVelocity(1,1)) xsVelocity(1,1) = 0; end
    if isnan(xsVelocity(1,end)) xsVelocity(1,end) = 0; end
    
    % Apply the alpha coefficient
    xsVelocity      = xsVelocity.*app.alphaEditField.Value; 
    
    % Ensure x-data is distance along xs
    out             =cell2mat(cellfun(@(x) app.startXS-x ,{mi},'un',0));
    absDistance     = sqrt(out(:,1).^2+out(:,2).^2);
    missingInd      = find(isnan(xsVelocity));
    
    if strcmp(app.InterpolationMethod.Value, 'Quadratic Polynomial') == 1
        QuadraticVelocity   = xsVelocity';
        [xData, yData]      = prepareCurveData( absDistance, QuadraticVelocity );
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
        CubicVelocity   = xsVelocity';
        [xData, yData]  = prepareCurveData( absDistance, CubicVelocity );
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
    end % interpolation method
end % cont
end % function