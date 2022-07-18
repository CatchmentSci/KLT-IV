 % Cell edit callback: UITable2
        function KLT_editCel2(app,~)
            
            if strcmp (app.CrossSectionDropDown.Value, 'Relative distances [m]') == 1
                
                if strcmp(app.OrientationDropDown.Value,'Dynamic: GPS + IMU') == true
                    app.startXS = [app.masterImageX(1,round(app.XS_pts(1,1))),app.masterImageY(round(app.XS_pts(2,1)))];
                    app.endXS = [app.masterImageX(1,round(app.XS_pts(1,2))),app.masterImageY(round(app.XS_pts(2,2)))];
                else
                    app.startXS = [app.X(1,round(app.XS_pts(1,1))),app.Y(round(app.XS_pts(2,1)))];
                    app.endXS = [app.X(1,round(app.XS_pts(1,2))),app.Y(round(app.XS_pts(2,2)))];
                end
                
                sumX = (app.endXS(1) - app.startXS(1)); % Total change in x
                sumY = (app.endXS(2) - app.startXS(2)); % Total change in y
                
                fractX = app.UITable2.Data(:,1)./app.transectLength; % Fraction of change in X
                fractY = app.UITable2.Data(:,1)./app.transectLength; % Fraction of change in Y
                
                %originalLength = length(app.xInder);
                app.xInder = app.startXS(1) + (fractX.*sumX);
                app.yInder = app.startXS(2) + (fractY.*sumY);
                app.xInder = transpose(replace_num(app.xInder,NaN,0));
                app.yInder = transpose(replace_num(app.yInder,NaN,0));
                
            elseif strcmp (app.CrossSectionDropDown.Value, 'Referenced survey [m]') == 1
                
                sumX = (app.endXS(1) - app.startXS(1)); % Total change in x
                sumY = (app.endXS(2) - app.startXS(2)); % Total change in y
                
                fractX = app.UITable2.Data(:,1)./app.transectLength; % Fraction of change in X
                fractY = app.UITable2.Data(:,1)./app.transectLength; % Fraction of change in Y
                
                %originalLength = length(app.xInder);
                app.xInder = app.startXS(1) + (fractX.*sumX);
                app.yInder = app.startXS(2) + (fractY.*sumY);
                app.xInder = transpose(replace_num(app.xInder,NaN,0));
                app.yInder = transpose(replace_num(app.yInder,NaN,0));
            end
        end % function