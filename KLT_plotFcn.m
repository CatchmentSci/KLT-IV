function KLT_plotFcn(app, absDistance, velocityIn, missingInd)

if strcmp(app.InterpolationMethod.Value, 'All') == 0
    
    f1      = figure(); hold on;
    ax1     = gca;
    grid off
    set(gca,'TickLabelInterpreter','latex')
    
    h1      = plot( absDistance, velocityIn, 'k' );
    h1_1    = scatter( absDistance, velocityIn,...
        'MarkerEdgeColor', 'k',...
        'MarkerFaceColor', 'k');
    h1_2    = scatter( absDistance(missingInd), velocityIn(missingInd),...
        'MarkerEdgeColor', 'r',...
        'MarkerFaceColor', 'r');
    
    xlabel(['Cross-section location $\mathrm{(m)}$'] , 'Interpreter','LaTex');
    ylabel(['Velocity $\mathrm{(m \ s^{-1})}$ '] , 'Interpreter','LaTex');
    set(ax1,'fontsize',14)
end


if strcmp (app.ProcessingModeDropDown.Value, 'Multiple Videos') == true
    try
        temp1 = [app.directory_save_multiple '\crossSectionVelocity.png'];
        saveas(f1,temp1,'png')
        cla (ax1);
        reset(gcf);
        reset(gca);
        close (f1)
        waitfor(f1)
    catch
    end
end

end