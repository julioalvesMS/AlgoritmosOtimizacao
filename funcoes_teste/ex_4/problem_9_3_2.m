classdef problem_9_3_2
    
    properties
        x0 = [-2 2 2 -1 -1]'
        xp = [-1.717 1.596 1.827 -0.764 -0.763]'
    end
    
    methods(Static)
        function f = fnc(x)
            x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4); x5 = x(5);
            f = exp(x1*x2*x3*x4*x5);
        end
        
        function g = grad(x)
            x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4); x5 = x(5);
            
            f = @problem_9_3_2.fnc;
            g = [
                x2*x3*x4*x5 * f(x)
                x1*x3*x4*x5 * f(x)
                x1*x2*x4*x5 * f(x)
                x1*x2*x3*x5 * f(x)
                x1*x2*x3*x4 * f(x)
            ];
        end
        
        function g = h_fnc(x)
            g1 = @problem_9_3_2.g1;
            g2 = @problem_9_3_2.g2;
            g3 = @problem_9_3_2.g3;
            
            g = [
                g1(x)
                g2(x)
                g3(x)
            ];
        end
        function g = h_grad(x)
            g1_grad = @problem_9_3_2.g1_grad;
            g2_grad = @problem_9_3_2.g2_grad;
            g3_grad = @problem_9_3_2.g3_grad;
            
            g = [g1_grad(x) g2_grad(x) g3_grad(x)];
        end
        
        function g = g1(x)
            x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4); x5 = x(5);
            
            g = x1^2 + x2^2 + x3^2 + x4^2 + x5^2 - 10;
        end
        function g = g2(x)
            x2 = x(2); x3 = x(3); x4 = x(4); x5 = x(5);
            
            g = x2*x3 - 5*x4*x5;
        end
        function g = g3(x)
            x1 = x(1); x2 = x(2);
            
            g = x1^3 + x2^3 + 1;
        end
        function g = g1_grad(x)
            x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4); x5 = x(5);
            
            g = [
                2*x1
                2*x2
                2*x3
                2*x4
                2*x5
            ];
        end
        function g = g2_grad(x)
            x2 = x(2); x3 = x(3); x4 = x(4); x5 = x(5);
            
            g = [
                0
                x3
                x2
                -5*x5
                -5*x4
            ];
        end
        function g = g3_grad(x)
            x1 = x(1); x2 = x(2);
            g = [
                3*x1^2
                3*x2^2
                0
                0
                0
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

