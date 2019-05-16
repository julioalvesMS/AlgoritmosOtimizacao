function [y,x,k,data] = NewtonUnidimensional(fnc, dfnc, ddfnc, inicial, erro)
%NewtonUnidimensional Summary of this function goes here
%   Detailed explanation goes here

    condicao_parada = 0;
    iteration_limit = 300;
    
    x = inicial;
    x_ant = x;
    traceback = [];
    
    for k=0:iteration_limit
        
        traceback.k(k+1) = k;
        traceback.x(k+1) = x;
        traceback.y(k+1) = fnc(x);
        
        if abs(x-x_ant) < erro && k>0
            condicao_parada = 1;
            break;
        end
        
        x_ant = x;
        x = x - dfnc(x)/ddfnc(x);
    end
    
    y = fnc(x);
    
    data.traceback = traceback;
    data.stop_condition = condicao_parada;
    data.iterations = k;
    data.iteration_limit = iteration_limit;
    data.method_name = 'Método de Newton';
end

