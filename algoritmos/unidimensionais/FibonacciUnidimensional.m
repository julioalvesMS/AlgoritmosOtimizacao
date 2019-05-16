function [y,x,k,data] = FibonacciUnidimensional(fnc, inferior, superior, l, n)
%FibonacciUnidimensional Summary of this function goes here
%   Detailed explanation goes here

    if nargin < 4
        l = (superior-inferior)/1e10;
    end
    if nargin < 5
        n = 300;
    end
    
    condicao_parada = 0;
    traceback = [];
    
    for k=1:n-2
        
        x = (inferior+superior)/2;
        
        traceback.k(k) = k-1;
        traceback.x(k) = x;
        traceback.y(k) = fnc(x);
        
        if superior - inferior < l
            condicao_parada = 1;
            break;
        end
        
        dif = (superior-inferior);
        
        lambda = inferior + fibonacci(n-k-1)*dif/fibonacci(n-k+1);
        mi = inferior + fibonacci(n-k)*dif/fibonacci(n-k+1);
        
        fl = fnc(lambda);
        fm = fnc(mi);
        if fl < fm
            superior = mi;
        elseif fl > fm
            inferior = lambda;
        else
            x = (mi+lambda)/2;
            superior = x;
            inferior = x;
        end
    end
    
    k = k-1;
    
    x = (inferior+superior)/2;
    y = fnc(x);
    
    data.traceback = traceback;
    data.stop_condition = condicao_parada;
    data.iterations = k;
    data.iteration_limit = n-2;
    data.method_name = 'Busca Fibonacci';
end

