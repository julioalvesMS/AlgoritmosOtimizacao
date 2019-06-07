function printOtimizationResultTable(data_list)
%PRINTOTIMIZATIONRESULT Summary of this function goes here
%   Detailed explanation goes here
    

    n = length(data_list);
    NConv = 'Não convergiu';
    
    variaveis = 0;
    for i=1:length(data_list)
        variaveis = max([variaveis length(data_list(i).x)]);
    end

    tabela = '';
    lnbrk = '\n';
    
    tabela = [tabela '\\begin{tabular}{|' repmat(' c |', 1, n+1) '}' lnbrk];
    tabela = [tabela '\\hline' lnbrk];
    
    tabela = [tabela ' & '];
    for i=1:n
        tabela = [tabela '\\' sprintf('textbf{$ f_%d $}', i) dataGlue(i, n)];
    end
    
    tabela = [tabela '\\hline' lnbrk];
        
    for j=1:variaveis
        tabela = [tabela sprintf('$ x_%d $ & ', j)];
        for i=1:n
            
            if j>length(data_list(i).x)
                value = ' - ';
            elseif data_list(i).stop_condition > 0
                value = sprintf('%.8f', data_list(i).x(j));
            else
                value = NConv;
            end
            tabela = [tabela value dataGlue(i, n)];
        end
    end
    
    tabela = [tabela '$ f(\\textbf{x}) $ & '];
    for i=1:n
        value = sprintf('%.8f', data_list(i).y);
        tabela = [tabela value dataGlue(i, n)];
    end
    
    tabela = [tabela 'Iterações & '];
    for i=1:n
        tabela = [tabela sprintf('%d', data_list(i).k) dataGlue(i, n)];
    end
    
    tabela = [tabela '\\hline' lnbrk];
    tabela = [tabela '\\end{tabular}' lnbrk];
    
    fprintf('\n\n\n======= printOtimizationResultTable =======\n\n')
    fprintf(tabela)
end

function glue = dataGlue(i, n)
    if i==n
        glue = ' \\\\ \n';
    else
        glue = ' & ';
    end
end
