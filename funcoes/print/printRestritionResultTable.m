function printRestritionResultTable(data_list)
%PRINTOTIMIZATIONRESULT Summary of this function goes here
%   Detailed explanation goes here
    

    n = length(data_list);
    NConv = 'Não convergiu';
    
    restricoes_h = 0;
    for i=1:length(data_list)
        restricoes_h = max([restricoes_h length(data_list(i).h)]);
    end
    restricoes_g = 0;
    for i=1:length(data_list)
        restricoes_g = max([restricoes_g length(data_list(i).g)]);
    end

    tabela = '';
    lnbrk = '\n';
    
    tabela = [tabela '\\begin{tabular}{|' repmat(' c |', 1, n+1) '}' lnbrk];
    tabela = [tabela '\\hline' lnbrk];
    
    tabela = [tabela ' & '];
    for i=1:n
        tabela = [tabela '\\' sprintf('textbf{$ P%d $}', i) dataGlue(i, n)];
    end
    
    tabela = [tabela '\\hline' lnbrk];
        
    for j=1:restricoes_h
        tabela = [tabela sprintf('$ h_%d(', j) '\\textbf{x}) $ & '];
        for i=1:n
            
            if j>length(data_list(i).h)
                value = ' - ';
            elseif data_list(i).stop_condition > 0
                value = sprintf('%.8f', data_list(i).h(j));
            else
                value = NConv;
            end
            tabela = [tabela value dataGlue(i, n)];
        end
    end
    
    for j=1:restricoes_g
        tabela = [tabela sprintf('$ g_%d(', j) '\\textbf{x}) $ & '];
        for i=1:n
            
            if j>length(data_list(i).g)
                value = ' - ';
            elseif data_list(i).stop_condition > 0
                value = sprintf('%.8f', data_list(i).g(j));
            else
                value = NConv;
            end
            tabela = [tabela value dataGlue(i, n)];
        end
    end

%     tabela = [tabela '$ P(\\textbf{x}, \\textbf{c}) $ & '];
%     for i=1:n
%         value = sprintf('%.8f', data_list(i).P);
%         tabela = [tabela value dataGlue(i, n)];
%     end
    
    tabela = [tabela '\\hline' lnbrk];
    tabela = [tabela '\\end{tabular}' lnbrk];
    
    fprintf('\n\n\n======= printRestritionResultTable =======\n\n')
    fprintf(tabela)
end

function glue = dataGlue(i, n)
    if i==n
        glue = ' \\\\ \n';
    else
        glue = ' & ';
    end
end
