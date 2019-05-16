function [x, y, i, data] = Penalidades(P)
%Penalidades
    
    limite_iteracoes = 100;
    traceback = [];
    stop_condition = 0;
    
    x = P.x0;
    
    c = ones(size(P.res_fnc(x)))';
    step = 1.5;
    
    for i = 1:limite_iteracoes
        
        Fpp = @(x) (P.fnc(x) + c*(P.res_fnc(x).^2));
        Gpp = @(x) (P.grad(x) + 2*P.res_grad(x)*(P.res_fnc(x).*c'));
        
        traceback.x(i,:) = x;
        traceback.y(i) = P.fnc(x);
        traceback.yp(i) = Fpp(x);
        traceback.k(i) = i;
        traceback.c(i,:) = c;
        traceback.h(i,:) = P.res_fnc(x);
        traceback.P(i) = c*(P.res_fnc(x).^2);
        
        [x, y] = QuaseNewtonMultidimensional(Fpp, Gpp, x);
        
        res = P.res_fnc(x);
        
        if max(abs(res) > 1e-6)
            c = c.*sign(abs(res))'*step;
        else
            stop_condition = 1;
            
            traceback.x(i,:) = x;
            traceback.y(i) = P.fnc(x);
            traceback.yp(i) = Fpp(x);
            traceback.k(i) = i;
            traceback.c(i,:) = c;
            traceback.h(i,:) = P.res_fnc(x);
            traceback.P(i) = P_fnc(P, x, c);
            break 
        end
        
    end
    
    
    data.x = x;
    data.y = y;
    data.k = i;
    data.h = P.res_fnc(x);
    data.P = P_fnc(P, x, c);
    data.traceback = traceback;
    data.stop_condition = stop_condition;
    data.iterations = i;
    data.iteration_limit = limite_iteracoes;
    data.method_name = 'Método das Penalidades';
end

function pen = P_fnc(P, x, c)
    pen = c*(P.res_fnc(x).^2);
end