function plotMultidimensionalY(data, fnc_name)
%PLOT_COMPARE_UNIDIMENSIONAL Summary of this function goes here
%   Detailed explanation goes here
    
    name = ['Minimização da resposta - ' fnc_name ' - ' data.method_name];

    figure;
    hold all;
    plot(data.traceback.k, data.traceback.y);
    hold off;
    title(name)
    
    xlabel('Iterações')
    ylabel('y')
    
    name = removeSpecialCharacters(name);
    saveas(gcf, strcat('imagens/', name, '.png'));
end

