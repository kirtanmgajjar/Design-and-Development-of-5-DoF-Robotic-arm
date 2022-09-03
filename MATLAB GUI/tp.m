function [a]=tp(b,c,d,e)
    hold on
    for i=1:length(b)
        plot(d,c(i,:),'Linewidth',3);
    end
    hold off
    ax=gca;
    set(gca,'Fontsize',18,'Fontname','Times New Roman')
    xlabel('Time (sec)','Fontsize',26,'Fontname','Times New Roman')
    ylabel(e,'Fontsize',26,'Fontname','Times New Roman')
    legend(b,'Location','Northeastoutside','Fontsize',26,'Fontname','Times New Roman')    
    grid on
    grid minor
    ax.GridLineStyle='-';
    ax.GridAlpha=0.65;
    ax.MinorGridLineStyle='--';
    ax.MinorGridAlpha=0.35;
end