function plotCompareUnidimensionalX(methods, plot_title)
%PLOT_COMPARE_UNIDIMENSIONAL Summary of this function goes here
%   Detailed explanation goes here
    
    name = ['Comparação dos métodos - x mínimo - ' plot_title];

    figure;
    hold all;
    legends = [];
    for i=1:length(methods)
        plot(methods(i).traceback.k, methods(i).traceback.x);
        legends{i} = methods(i).method_name;
    end
    hold off;
    legend(legends);
    title(name)
    
    xlabel('Iterações')
    ylabel('x')
    
    name = removeSpecialCharacters(name);
    saveas(gcf, strcat('imagens/', name, '.png'));
end

