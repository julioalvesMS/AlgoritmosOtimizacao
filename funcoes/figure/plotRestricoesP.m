function plotRestricoesP(data, fnc_name)
%PLOT_COMPARE_UNIDIMENSIONAL Summary of this function goes here
%   Detailed explanation goes here
    
    name = ['Adequação das Restrições - ' fnc_name ' - ' data.method_name];

    figure;
    hold all;
    legends = [];
    for i=1:size(data.traceback.h, 2)
        plot(data.traceback.k, data.traceback.h(:,i));
        legends{i} = sprintf('h_%d(x)', i);
    end
    
    plot(data.traceback.k, data.traceback.P, '--');
    legends{i+1} = 'P(x)';
    
    hold off;
    legend(legends);
    title(name)
    
    xlabel('Iterações')
    ylabel('y')
    
    name = removeSpecialCharacters(name);
    saveas(gcf, strcat('imagens/', name, '.png'));
end

