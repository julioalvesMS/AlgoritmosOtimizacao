function [x, y, i, data] = QuaseNewtonMultidimensional(fnc, grad, x0, res_chk)
%GRADIENTE Summary of this function goes here
%   Detailed explanation goes here
    
    limite_iteracoes = 3000;
    
    x = x0;
    traceback = [];
    stop_condition = 0;
    
    check_restrition = 0;
    if nargin >= 4
        check_restrition = 1;
    end
    
    D = eye(length(x0));
    
    Dbfgs = D;
    
    for i = 1:limite_iteracoes
        
        fi = fnc(x);
        gi = grad(x);
        
        traceback.x(i,:) = x;
        traceback.y(i) = fi;
        traceback.k(i) = i;
        
        
        if norm(gi)==0
            break;
        end
        
        d = -D*gi;
        
        if d'*gi>0
            d = -gi;
            D = eye(length(x0));
            Dbfgs = D;
        end
        
        inferior = 0;
        superior = 1e6;
        while 1
            [fd, alpha] = BuscaDicotomica(fnc, inferior, superior, d, x);
            
            retry = fd>fi;
            if check_restrition
                retry = retry || ~res_chk(x + alpha*d);
            end
            
            if retry
                superior = superior/10;
            else
                break;
            end
        end
        
        x_old = x;
        x = x + alpha*d;
        
        if fi-fd < 1e-8
            stop_condition = 1;
            traceback.x(i,:) = x;
            traceback.y(i) = fd;
            traceback.k(i) = i;
            break;
        end
        
        s = x - x_old;
        y = grad(x) - gi;
        
        Ddfp = DirecaoDFP(D, y, s);
        Dbfgs = DirecaoBFGS(D, Dbfgs, y, s);
        
        if y'*s > y'*D*y
            D = Dbfgs;
        else
            D = Ddfp;
        end
        D = Ddfp;
    end
    
    y = fnc(x);
    
    data.x = x;
    data.y = y;
    data.k = i;
    data.traceback = traceback;
    data.stop_condition = stop_condition;
    data.iterations = i;
    data.iteration_limit = limite_iteracoes;
    data.method_name = 'Método de Quase-Newton';
end


function Di = DirecaoDFP(D, y, s)
    Di = D + s*s'/(s'*y) - D*y*y'*D/(y'*D*y);
end

function Di = DirecaoBFGS(D, Dbfgs, y, s)
    
    r = s/(s'*y) - Dbfgs*y/(y'*Dbfgs*y);

    Di = DirecaoDFP(D, y, s) + r*r'*(y'*D*y);
end

