% experiments of extracting wse

wsw_exp     = 1;

if wsw_exp == 1

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

end

%colormap(gca, flipud(colormap(gca)))
%colorbar