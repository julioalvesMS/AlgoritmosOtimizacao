function [x, y, i, data] = LagrangianoAumentado(P)
%LagrangianoAumentado
    
    limite_iteracoes = 2000;
    traceback = [];
    stop_condition = 0;
    
    
    tolerance = 1e-6;
    
    E = 1e-8;
    
    x = P.x0;
    
    l = length(P.h_fnc(x));
    m = length(P.g_fnc(x));
    
    v = zeros([1 l]);
    lambda = zeros([1 m]);
    r_h = ones([1 l]);
    r_g = ones([1 m]);
    
    step = 0;
    
    Res = @(x) ( min(P.g_fnc(x) <= 0) & min(abs(P.h_fnc(x)) <= tolerance) );
    
    for i = 1:limite_iteracoes
        
        
        Fpp = @(x) (P.fnc(x) + v*P.h_fnc(x) + lambda*P.g_fnc(x) + 1/2*r_h*(P.h_fnc(x).^2) + 1/2*r_g*(max(0, P.g_fnc(x)).^2));
        Gpp = @(x) (P.grad(x) + P.h_grad(x)*v' + P.g_grad(x)*lambda' + P.h_grad(x)*(P.h_fnc(x).*r_h') + P.g_grad(x)*(max(0, P.g_fnc(x)).*r_g'));
        
        traceback.x(i,:) = x;
        traceback.y(i) = P.fnc(x);
        traceback.yp(i) = Fpp(x);
        traceback.k(i) = i;
        traceback.h(i,:) = P.h_fnc(x);
        traceback.g(i,:) = P.g_fnc(x);
        traceback.P(i) = P_fnc(P, x, v, lambda, r_h, r_g);
        
        [x, y] = QuaseNewtonMultidimensional(Fpp, Gpp, x);
        
        if  ~Res(x) || max(abs(traceback.x(end,:)'-x)) > E
            h_break = abs(P.h_fnc(x)) > tolerance;
            g_break = P.g_fnc(x) > 0;
            
            [r_h, r_g] = increase_penalty(r_h, r_g, h_break, g_break, step);
            
            v = v + r_h.*P.h_fnc(x)';
            lambda = lambda + r_g.*max(0, P.g_fnc(x))';
            
        else
            stop_condition = 1;
            traceback.x(i,:) = x;
            traceback.y(i) = P.fnc(x);
            traceback.yp(i) = Fpp(x);
            traceback.k(i) = i;
            traceback.h(i,:) = P.h_fnc(x);
            traceback.g(i,:) = P.g_fnc(x);
            traceback.P(i) = P_fnc(P, x, v, lambda, r_h, r_g);
            break 
        end
        
    end
    
    
    data.x = x;
    data.y = y;
    data.k = i;
    data.h = P.h_fnc(x);
    data.g = P.g_fnc(x);
    data.P = P_fnc(P, x, v, lambda, r_h, r_g);
    data.traceback = traceback;
    data.stop_condition = stop_condition;
    data.iterations = i;
    data.iteration_limit = limite_iteracoes;
    data.method_name = 'Lagrangiano Aumentado';
    
end

function pen = P_fnc(P, x, v, lambda, r_h, r_g)
    pen = v*P.h_fnc(x) + lambda*P.g_fnc(x) + 1/2*r_h*(P.h_fnc(x).^2) + 1/2*r_g*(max(0, P.g_fnc(x)).^2);
end

function [r_h, r_g] = increase_penalty(r_h, r_g, h_break, g_break, step)

    r_h = r_h + step*h_break'.*r_h;
        
    r_g = r_g + step*g_break'.*r_g;
    
end
