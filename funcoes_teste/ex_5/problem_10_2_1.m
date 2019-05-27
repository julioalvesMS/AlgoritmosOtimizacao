classdef problem_10_2_1
    
    properties
        x0 = [0 1]'
    end
    
    methods(Static)
        function f = fnc(x)
            x1 = x(1);
            x2 = x(2);
            
            f = (x1-2)^4 + (x1-2*x2)^2;
        end
        
        function g = grad(x)
            x1 = x(1);
            x2 = x(2);
            g = [
                4*(x1-2)^3 + 2*(x1-2*x2)
                -4*(x1-2*x2)
            ];
        end
        
        function h = h_fnc(x)
            h = 0;
        end
        
        function g = g_fnc(x)
            
            g1 = @problem_10_2_1.g1;
            
            g = [
                g1(x)
            ];
        end
        function g = g_grad(x)
            g1_grad = @problem_10_2_1.g1_grad;
            g = [ g1_grad(x) ];
        end
        
        function g = g1(x)
            x1 = x(1);
            x2 = x(2);
            
            g = x1^2 - x2;
        end
        function g = g1_grad(x)
            x1 = x(1);
            g = [
                2*x1
                -1
            ];
        end
    end
end

