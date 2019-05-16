function [y,x,k,data] = AjusteQuadratico(fnc, x1, x2, x3, E)
%BuscaDicotomica Summary of this function goes here
%   Detailed explanation goes here

    if nargin < 4
        x3 = (x1+x2)/2;
    end
    
    if nargin < 5
        E = abs(x2-x1)/1000;
    end
    
    condicao_parada = 0;    
    iteration_limit = 300;
    traceback = [];
    
    x = x3;
    
    for k=0:iteration_limit
        
        traceback.k(k+1) = k;
        traceback.x(k+1) = x;
        traceback.y(k+1) = fnc(x);
        
        if abs(x1-x2) < E
            condicao_parada = 1;
            break;
        end
        
        f1 = fnc(x1);
        f2 = fnc(x2);
        f3 = fnc(x3);

        D = (x2-x3)*f1 + (x3-x1)*f2 + (x1-x2)*f3;
        
        if (D==0)
            break;
        end

        dp1 = (x2^2-x3^2)*f1;
        dp2 = (x3^2-x1^2)*f2;
        dp3 = (x1^2-x2^2)*f3;

        x = (1/2)*(dp1 + dp2 + dp3)/D;
        
        fx = fnc(x);
        
        if (x1 < x3)
            if (fx < f3)
                x2 = x3;
                x3 = x;
            else
                x1 = x;
            end
        else
            if (f3 < fx)
                x2 = x;
            else
                x1 = x3;
                x3 = x;
            end
        end
    end
    
    y = fnc(x);
    
    data.traceback = traceback;
    data.stop_condition = condicao_parada;
    data.iterations = k;
    data.iteration_limit = iteration_limit;
    data.method_name = 'Ajuste Quadrático';
end
