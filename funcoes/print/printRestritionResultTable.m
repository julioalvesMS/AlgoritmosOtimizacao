function printRestritionResultTable(data_list)
%PRINTOTIMIZATIONRESULT Summary of this function goes here
%   Detailed explanation goes here
    

    n = length(data_list);
    NConv = 'Não convergiu';
    
    restricoes = 0;
    for i=1:length(data_list)
        restricoes = max([restricoes length(data_list(i).h)]);
    end

    tabela = '';
    lnbrk = '\n';
    
    tabela = [tabela '\\begin{tabular}{| c | c | c | c | c |}' lnbrk];
    tabela = [tabela '\\hline' lnbrk];
    
    tabela = [tabela ' & '];
    for i=1:n
        tabela = [tabela '\\' sprintf('textbf{$ f_%d $}', i) dataGlue(i, n)];
    end
    
    tabela = [tabela '\\hline' lnbrk];
        
    for j=1:restricoes
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
    
    tabela = [tabela '$ P(\\textbf{x}, \\textbf{c}) $ & '];
    for i=1:n
        value = sprintf('%.8f', data_list(i).P);
        tabela = [tabela value dataGlue(i, n)];
    end
    
    tabela = [tabela '\\hline' lnbrk];
    tabela = [tabela '\\end{tabular}' lnbrk];
    
    fprintf(tabela)
end

function glue = dataGlue(i, n)
    if i==n
        glue = ' \\\\ \n';
    else
        glue = ' & ';
    end
end
