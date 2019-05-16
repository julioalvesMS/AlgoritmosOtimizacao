function [x, y, i, data] = DescidaGradiente(fnc, grad, x0)
%GRADIENTE Summary of this function goes here
%   Detailed explanation goes here
    
    limite_iteracoes = 3000;
    
    x = x0;
    traceback = [];
    
    for i = 1:limite_iteracoes
        
        fi = fnc(x);
        gi = grad(x);
        
        traceback.x(i,:) = x;
        traceback.y(i) = fi;
        traceback.k(i) = i;
        
        if norm(gi)==0
            break;
        end
        
        d = -gi;
        
        inferior = 0;
        superior = 1e9;
        while 1
            [y, alpha] = BuscaDicotomica(fnc, inferior, superior, d, x);
            
            if y>fi
                superior = superior/10;
            else
                break;
            end
        end
        
        x = x + alpha*d;
        
        if fi-y < 1e-10
            traceback.x(i,:) = x;
            traceback.y(i) = y;
            traceback.k(i) = i;
            break;
        end
        
    end
    
    data.x = x;
    data.y = y;
    data.k = i;
    data.traceback = traceback;
    data.stop_condition = i<limite_iteracoes;
    data.iterations = i;
    data.iteration_limit = limite_iteracoes;
    data.method_name = 'Decida Gradiente';
end

