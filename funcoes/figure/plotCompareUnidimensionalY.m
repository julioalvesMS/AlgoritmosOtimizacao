function plotCompareUnidimensionalY(methods, plot_title)
%PLOT_COMPARE_UNIDIMENSIONAL Summary of this function goes here
%   Detailed explanation goes here
    
    name = ['Comparação dos métodos - y mínimo - ' plot_title];

    figure;
    hold all;
    legends = [];
    for i=1:length(methods)
        plot(methods(i).traceback.k, methods(i).traceback.y);
        legends{i} = methods(i).method_name;
    end
    hold off;
    legend(legends);
    title(name)
    
    xlabel('Iterações')
    ylabel('y')
    
    name = removeSpecialCharacters(name);
    saveas(gcf, strcat('imagens/', name, '.png'));
end

