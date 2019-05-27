function [x, y, i, data] = Barreira(P)
%Barreira
    
    limite_iteracoes = 2000;
    traceback = [];
    stop_condition = 0;
    
    
    tolerance = 1e-6;
    E = 1e-8;
    
    x = P.x0;
    
    c = ones(size(P.g_fnc(x)))';
    
    step = 10;
    
    for i = 1:limite_iteracoes
        
        Fpp = @(x) (P.fnc(x) - c*(1./P.g_fnc(x)));
        Gpp = @(x) (P.grad(x) + P.g_grad(x)* ((1./P.g_fnc(x)^2).*c'));
        Res = @(x) ( min(P.g_fnc(x) <= 0) & min(abs(P.h_fnc(x)) <= tolerance) );
        
        traceback.x(i,:) = x;
        traceback.y(i) = P.fnc(x);
        traceback.yp(i) = Fpp(x);
        traceback.k(i) = i;
        traceback.c(i,:) = c;
        traceback.h(i,:) = P.h_fnc(x);
        traceback.g(i,:) = P.g_fnc(x);
        traceback.P(i) =  - c*(1./P.g_fnc(x));
        
        [x, y] = QuaseNewtonMultidimensional(Fpp, Gpp, x, Res);
        
        if  max(abs(traceback.x(end,:)'-x)) > E && c>0
            c = c/step;
        else
            stop_condition = 1;
            
            traceback.x(i,:) = x;
            traceback.y(i) = P.fnc(x);
            traceback.yp(i) = Fpp(x);
            traceback.k(i) = i;
            traceback.c(i,:) = c;
            traceback.h(i,:) = P.h_fnc(x);
            traceback.g(i,:) = P.g_fnc(x);
            traceback.P(i) =  - c*(1./P.g_fnc(x));
            break 
        end
        
    end
    
    
    data.x = x;
    data.y = y;
    data.k = i;
    data.h = P.h_fnc(x);
    data.g = P.g_fnc(x);
    data.P = P_fnc(P, x, c);
    data.traceback = traceback;
    data.stop_condition = stop_condition;
    data.iterations = i;
    data.iteration_limit = limite_iteracoes;
    data.method_name = 'Método das Penalidades';
end

function pen = P_fnc(P, x, c)
    pen = c*(P.g_fnc(x).^2);
end