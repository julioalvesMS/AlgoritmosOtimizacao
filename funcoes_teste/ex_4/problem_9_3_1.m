classdef problem_9_3_1
    
    properties
        x0 = [0 0]'
        xp = [0.25 0.75]'
    end
    
    methods(Static)
        function f = fnc(x)
            x1 = x(1);
            x2 = x(2);
            f = (1/2)*(x1^2 + (x2^2)/3);
        end
        
        function g = grad(x)
            x1 = x(1);
            x2 = x(2);
            g = [
                x1
                x2/3
            ];
        end
        
        function g = h_fnc(x)
            
            g1 = @problem_9_3_1.g1;
            
            g = [
                g1(x)
            ];
        end
        function g = h_grad(x)
            g1_grad = @problem_9_3_1.g1_grad;
            g = [ g1_grad(x) ];
        end
        
        function g = g1(x)
            x1 = x(1);
            x2 = x(2);
            
            g = x1 + x2 - 1;
        end
        function g = g1_grad(x)
            g = [
                1
                1
            ];
        end
        
        function g = g_fnc(x)
            g = 0;
        end
        function g = g_grad(x)
            g = 0;
        end
        
        function h = has_h()
            h=1;
        end
        function g = has_g()
            g=0;
        end
    end
end

