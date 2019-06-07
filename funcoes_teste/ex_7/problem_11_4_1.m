classdef problem_11_4_1
    
    properties(Constant)
        x0 = [
            2   % [cm] - Diâmetro Interno
            10  % [cm] - Diâmetro Externo
        ];
        
        l = 250;     % [cm] - Comprimento
        rho = 0.0025 % [kgf/cm^3] - Densidade
        E = 0.85e6   % [kgf/cm^2] - Módulo de elasticidade
        sigma = 500  % [kgf/cm^2] - Limite de escoamento
        P = 2500     % [kgf] - Carga de compressão
        
    end
    
    methods(Static)
        function f = fnc(x)
            di = x(1);
            do = x(2);
            
            l = problem_11_4_1.l;
            rho = problem_11_4_1.rho;
            
            d = (di+do)/2;
            W = pi*(do^2-di^2)*l*rho;
            
            f = 5*W + 2*d;
        end
        
        function g = grad(x)
            di = x(1);
            do = x(2);
            
            l = problem_11_4_1.l;
            rho = problem_11_4_1.rho;
            
            g = [
                5*pi*l*rho*(-2*di) + 1
                5*pi*l*rho*(2*do) + 1
            ];
        end
        
        function h = h_fnc(x)
            h = 0;
        end
        function h = h_grad(x)
            h = 0;
        end
        
        function g = g_fnc(x)
            
            g1 = @problem_11_4_1.g1;
            g2 = @problem_11_4_1.g2;
            g3 = @problem_11_4_1.g3;
            g4 = @problem_11_4_1.g4;
            g5 = @problem_11_4_1.g5;
            g6 = @problem_11_4_1.g6;
            g7 = @problem_11_4_1.g7;
            g8 = @problem_11_4_1.g8;
            
            g = [
                g1(x)
                g2(x)
                g3(x)
                g4(x)
                g5(x)
                g6(x)
            ];
        end
        function g = g_grad(x)
            
            g1_grad = @problem_11_4_1.g1_grad;
            g2_grad = @problem_11_4_1.g2_grad;
            g3_grad = @problem_11_4_1.g3_grad;
            g4_grad = @problem_11_4_1.g4_grad;
            g5_grad = @problem_11_4_1.g5_grad;
            g6_grad = @problem_11_4_1.g6_grad;
            g7_grad = @problem_11_4_1.g7_grad;
            g8_grad = @problem_11_4_1.g8_grad;
            
            g = [ g1_grad(x) g2_grad(x) g3_grad(x) g4_grad(x) g5_grad(x) g6_grad(x) ];
        end
        
        % Limite de tensão de escoamento
        function g = g1(x)
            di = x(1);
            do = x(2);
            
            P = problem_11_4_1.P;
            sigma = problem_11_4_1.sigma;
            
            g = 4*P/(pi*(do^2-di^2)) - sigma;
        end
        function g = g1_grad(x)
            di = x(1);
            do = x(2);
            
            P = problem_11_4_1.P;
            
            g = [
                -4*P/(pi*(do^2-di^2)^2)*(-2*di)
                -4*P/(pi*(do^2-di^2)^2)*(2*do)
            ];
        end
        
        % Limite de tensão para flambagem
        function g = g2(x)
            di = x(1);
            do = x(2);
            
            P = problem_11_4_1.P;
            rho = problem_11_4_1.rho;
            l = problem_11_4_1.l;
            E = problem_11_4_1.E;
            
            I = 1/12*pi*rho*l*(3*(do^4-di^4)/16 + l^2*(do^2-di^2)/4);
            
            g = P - pi^2*E*I/l^2;
        end
        function g = g2_grad(x)
            di = x(1);
            do = x(2);
            
            rho = problem_11_4_1.rho;
            l = problem_11_4_1.l;
            E = problem_11_4_1.E;
            
            g = [
                -pi^2*E/l^2 * 1/12*pi*rho*l*(3*(-4*di^3)/16 + l^2*(-2*di)/4)
                -pi^2*E/l^2 * 1/12*pi*rho*l*(3*(4*do^3)/16 + l^2*(2*do)/4)
            ];
        end
        
        % Diâmetro médio de no máximo 14 cm
        function g = g3(x)
            di = x(1);
            do = x(2);
            
            g = (do+di)/2 - 14;
        end
        function g = g3_grad(x)
            g = [
                1/2;
                1/2;
            ];
        end
        
        % Diâmetro médio de no mínimo 2 cm
        function g = g4(x)
            di = x(1);
            do = x(2);
            
            g = 2 - (do+di)/2;
        end
        function g = g4_grad(x)
            g = [
                -1/2;
                -1/2;
            ];
        end
        
        % Parede do tubo de no mínimo 0.4 cm
        function g = g5(x)
            di = x(1);
            do = x(2);
            
            g = 0.4 - (do-di)/2;
        end
        function g = g5_grad(x)
            g = [
                1/2;
                -1/2;
            ];
        end
        
        % Parede do tubo de no máximo 16 cm
        function g = g6(x)
            di = x(1);
            do = x(2);
            
            g = (do-di)/2 - 16;
        end
        function g = g6_grad(x)
            g = [
                -1/2;
                1/2;
            ];
        end
        
        % Parede do tubo de no máximo 16 cm
        function g = g7(x)
            di = x(1);
            
            g = -di;
        end
        function g = g7_grad(x)
            g = [
                -1
                0
            ];
        end
        % Parede do tubo de no máximo 16 cm
        function g = g8(x)
            do = x(2);
            
            g = -do;
        end
        function g = g8_grad(x)
            g = [
                0
                -1
            ];
        end
        
        function h = has_h()
            h=0;
        end
        function g = has_g()
            g=1;
        end
    end
end

