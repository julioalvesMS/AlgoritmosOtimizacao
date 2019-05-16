function plotMultidimensionalX(data, fnc_name)
%PLOT_COMPARE_UNIDIMENSIONAL Summary of this function goes here
%   Detailed explanation goes here
    
    name = ['Otimização das variáveis - ' fnc_name ' - ' data.method_name];

    figure;
    hold all;
    legends = [];
    for i=1:size(data.traceback.x, 2)
        plot(data.traceback.k, data.traceback.x(:,i));
        legends{i} = sprintf('x_%d', i);
    end
    hold off;
    legend(legends);
    title(name)
    
    xlabel('Iterações')
    ylabel('x')
    
    name = removeSpecialCharacters(name);
    saveas(gcf, strcat('imagens/', name, '.png'));
end

