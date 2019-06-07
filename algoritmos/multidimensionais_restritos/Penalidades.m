function [x, y, i, data] = Penalidades(P)
%Penalidades
    
    limite_iteracoes = 100;
    traceback = [];
    stop_condition = 0;
    
    x = P.x0;
    
    c_h = ones(size(P.h_fnc(x)))';
    c_g = ones(size(P.g_fnc(x)))';
    step = 1.5;
    
    for i = 1:limite_iteracoes
        
        Fpp = @(x) (P.fnc(x) + c_h*(P.h_fnc(x).^2) + c_g*(max(0, P.g_fnc(x)).^2));
        Gpp = @(x) (P.grad(x) + 2*P.h_grad(x)*(P.h_fnc(x).*c_h') + 2*P.g_grad(x)*(max(0, P.g_fnc(x)).*c_g'));
        
        traceback.x(i,:) = x;
        traceback.y(i) = P.fnc(x);
        traceback.yp(i) = Fpp(x);
        traceback.k(i) = i;
        traceback.c_h(i,:) = c_h;
        traceback.h(i,:) = P.h_fnc(x);
        traceback.g(i,:) = P.g_fnc(x);
        traceback.P(i) = P_fnc(P, x, c_h, c_g);
        
        [x, y] = QuaseNewtonMultidimensional(Fpp, Gpp, x);
        
        res = P.h_fnc(x);
        res_g = P.g_fnc(x);
        
        if max(abs(res) > 1e-6) || max(res_g) > 0
            c_h = c_h.*(abs(res) > 1e-6)'*step;
            c_g = c_g.*(res_g > 0)'*step;
        else
            stop_condition = 1;
            
            traceback.x(i,:) = x;
            traceback.y(i) = P.fnc(x);
            traceback.yp(i) = Fpp(x);
            traceback.k(i) = i;
            traceback.c_h(i,:) = c_h;
            traceback.h(i,:) = P.h_fnc(x);
            traceback.g(i,:) = P.g_fnc(x);
            traceback.P(i) = P_fnc(P, x, c_h, c_g);
            break 
        end
        
    end
    
    
    data.x = x;
    data.y = y;
    data.k = i;
    data.h = P.h_fnc(x);
    data.g = P.g_fnc(x);
    data.P = P_fnc(P, x, c_h, c_g);
    data.traceback = traceback;
    data.stop_condition = stop_condition;
    data.iterations = i;
    data.iteration_limit = limite_iteracoes;
    data.method_name = 'Método das Penalidades';
end

function pen = P_fnc(P, x, c_h, c_g)
    pen = c_h*(P.h_fnc(x).^2) + c_g*(max(0, P.g_fnc(x)).^2);
end