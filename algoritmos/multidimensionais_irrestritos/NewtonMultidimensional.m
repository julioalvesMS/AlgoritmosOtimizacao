function [x, y, i, data] = NewtonMultidimensional(fnc, grad, hess, x0)
%GRADIENTE Summary of this function goes here
%   Detailed explanation goes here
    
    limite_iteracoes = 3000;
    
    x = x0;
    traceback = [];
    stop_condition = 0;
    
    for i = 1:limite_iteracoes
        
        fi = fnc(x);
        gi = grad(x);
        Hi = hess(x);
        
        traceback.x(i,:) = x;
        traceback.y(i) = fi;
        traceback.k(i) = i;
        
        if min(eig(Hi))<=0
            break;
        end
        
        if norm(gi)==0
            stop_condition = 1;
            break;
        end
        
        d = -Hi\gi;
        
        if d'*gi>0
            d = -gi;
        end
        
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
            stop_condition = 1;
            traceback.x(i,:) = x;
            traceback.y(i) = y;
            traceback.k(i) = i;
            break;
        end
        
    end
    
    y = fnc(x);
    
    data.x = x;
    data.y = y;
    data.k = i;
    data.traceback = traceback;
    data.stop_condition = stop_condition;
    data.iterations = i;
    data.iteration_limit = limite_iteracoes;
    data.method_name = 'Método de Newton';
end

