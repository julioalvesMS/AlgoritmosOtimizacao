close all; clc; clear;

addpath(genpath('funcoes'))
addpath(genpath('algoritmos'))
addpath(genpath('funcoes_teste'))

[~,~] = mkdir('imagens');

%% Função 1
[x,y,~,pro]= fminsearch(@testFunction_31, 1);
printOtimizationResult(x, y, pro.iterations, 'fminsearch')

[y, x,k, dic_1] = BuscaDicotomica(@testFunction_31, -3, 5);
printOtimizationResult(x, y, k, 'Busca Dicotômica')

[y, x,k, fib_1] = FibonacciUnidimensional(@testFunction_31, -3, 5, 1e-10);
printOtimizationResult(x, y, k, 'Busca Fibonacci')

[y, x,k, new_1] = NewtonUnidimensional(@testFunction_31, @testFunction_31_d, @testFunction_31_dd, 1, 1e-10);
printOtimizationResult(x, y, k, 'Método de Newton')

[y, x,k, qua_1] = AjusteQuadratico(@testFunction_31, -3, 5, 1, 1e-10);
printOtimizationResult(x, y, k, 'Ajuste Quadrático')


plotCompareUnidimensionalX([dic_1 fib_1 new_1 qua_1], 'f(x)');
plotCompareUnidimensionalY([dic_1 fib_1 new_1 qua_1], 'f(x)');

%% Função 2

[x,y,~,pro]= fminsearch(@testFunction_32, 1);
printOtimizationResult(x, y, pro.iterations, 'fminsearch')

[y, x,k, dic_2] = BuscaDicotomica(@testFunction_32, -3, 5);
printOtimizationResult(x, y, k, 'Busca Dicotômica')

[y, x,k, fib_2] = FibonacciUnidimensional(@testFunction_32, -3, 5, 1e-10);
printOtimizationResult(x, y, k, 'Busca Fibonacci')

[y, x,k, new_2] = NewtonUnidimensional(@testFunction_32, @testFunction_32_d, @testFunction_32_dd, 1, 1e-10);
printOtimizationResult(x, y, k, 'Método de Newton')

[y, x,k, qua_2] = AjusteQuadratico(@testFunction_32, -3, 5, 1, 1e-10);
printOtimizationResult(x, y, k, 'Ajuste Quadrático')


plotCompareUnidimensionalX([dic_2 fib_2 new_2 qua_2], 'g(x)');
plotCompareUnidimensionalY([dic_2 fib_2 new_2 qua_2], 'g(x)');