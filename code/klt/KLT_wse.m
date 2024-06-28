% experiments of extracting wse

function [wse_map] = KLT_wse(app,xyzA_wse,xyzB_wse,ei,xyzA_conv,xyzB_conv)


wsw_exp     = 1;

if wsw_exp == 1 && app.prepro == 0
    TransxIn                = app.CustomFOVEditField_2.Value:0.1:app.CustomFOVEditField_4.Value;
    TransyIn                = app.CustomFOVEditField_3.Value:0.1:app.CustomFOVEditField_5.Value;
    [app.TransX,app.TransY] = meshgrid(TransxIn,TransyIn);
    [params]                = size(app.TransX); clear app.Transdem
    app.Transdem(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;

    for aa = ei
        if aa == 1
            wse_map = {};
        end
        
        wse_map{aa,1} = app.Transdem;
        [wse_map] = KLT_wse_solver(app,xyzA_wse,xyzB_wse,aa,wse_map);

    end


elseif  wsw_exp == 1 && app.prepro == 1

    xyzA        = xyzA_conv;
    xyzB        = xyzB_conv;
    clear xyzA_conv xyzB_conv

    % convert xyzA
    lowerbound  = floor(xyzA);
    upperbound  = lowerbound + 1;
    justdecimal = xyzA-lowerbound;
    xyzA_conv = [app.X(1,lowerbound(:,1))' + (app.ResolutionmpxEditField.Value .* justdecimal(:,1)),...
        app.Y(lowerbound(:,2),1) + (app.ResolutionmpxEditField.Value .* justdecimal(:,2))];

    % convert xyzB
    lowerbound  = floor(xyzB);
    upperbound  = lowerbound + 1;
    justdecimal = xyzB-lowerbound;
    xyzB_conv = [app.X(1,lowerbound(:,1))' + (app.ResolutionmpxEditField.Value .* justdecimal(:,1)),...
        app.Y(lowerbound(:,2),1) + (app.ResolutionmpxEditField.Value .* justdecimal(:,2))];

    xyzA        = xyzA_conv;
    xyzB        = xyzB_conv;
    clear xyzA_conv xyzB_conv

    % these are the outputs based on analysis on the ortho imagery in
    % real-world units
    xyzA_ortho_orig = xyzA;
    xyzB_ortho_orig = xyzB;
    app.initialVel = {xyzA_ortho_orig, xyzB_ortho_orig};

    % convert the real world units back to pixel units for wse analysis
    t1(1:length(xyzA_ortho_orig),1) = nanmean(app.Transdem(:));
    xyzA        = app.camA.project([xyzA_ortho_orig, t1 ]); % rectify both the start and end positions together
    xyzB        = app.camA.project([xyzB_ortho_orig, t1 ]); % rectify both the start and end positions together

    [params]                = size(app.TransX); clear app.Transdem
    app.Transdem(1:params(1),1:params(2)) = app.WatersurfaceelevationmEditField.Value;
            
    xyzA_wse{ei}    = xyzA(:,1:2);
    xyzB_wse{ei}    = xyzB(:,1:2);

    for aa = ei
        if aa == 1
            wse_map = {};
        end
        
        wse_map{aa,1} = app.Transdem;
        [wse_map] = KLT_wse_solver(app,xyzA_wse,xyzB_wse,aa,wse_map);

        if aa == ei(end)
            app.wse_map_out = wse_map; % save the final solution
        end
       
    end

end

%colormap(gca, flipud(colormap(gca)))
%colorbar