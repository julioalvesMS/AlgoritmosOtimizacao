function plotRestricoesP(data, fnc_name)
%PLOT_COMPARE_UNIDIMENSIONAL Summary of this function goes here
%   Detailed explanation goes here
    
    name = ['Adequação das Restrições - ' fnc_name ' - ' data.method_name];

    figure;
    hold all;
    legends = [];
    l = size(data.traceback.h, 2);
    m = size(data.traceback.g, 2);
    for i=1:l
        plot(data.traceback.k, data.traceback.h(:,i));
        legends{i} = sprintf('h_%d(x)', i);
    end
    for i=1:m
        plot(data.traceback.k, data.traceback.g(:,i));
        legends{i+l} = sprintf('g_%d(x)', i);
    end
    
%     plot(data.traceback.k, data.traceback.P, '--');
%     legends{l+m+1} = 'P(x)';https://odyssey.fem.unicamp.br/AlunoEsp
    
    hold off;
    legend(legends);
    title(name)
    
    xlabel('Iterações')
    ylabel('y')
    
    name = removeSpecialCharacters(name);
    saveas(gcf, strcat('imagens/', name, '.png'));
end

