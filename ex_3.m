%% Exercício 3

%% Inicialização
close all; clc; clear;

addpath(genpath('funcoes'))
addpath(genpath('algoritmos'))
addpath(genpath('funcoes_teste'))

%% Condições iniciais

x0_1 = [
    -1.2
    1
];

x0_2 = zeros(4,1);

%% Quase Newton

[x, y, k, qua_1] = QuaseNewtonMultidimensional(@function_4_1_1, @gradient_4_1_1, x0_1);
[x, y, k, qua_2] = QuaseNewtonMultidimensional(@function_4_1_2, @gradient_4_1_2, x0_1);
[x, y, k, qua_3] = QuaseNewtonMultidimensional(@function_4_1_3, @gradient_4_1_3, x0_2);
[x, y, k, qua_4] = QuaseNewtonMultidimensional(@function_4_1_4, @gradient_4_1_4, x0_2);

fprintf('\n\n=== Quase-Newton ===\n')
printOtimizationResultTable([qua_1 qua_2 qua_3 qua_4])

plotMultidimensionalX(qua_1, 'f_1(x)')
plotMultidimensionalX(qua_2, 'f_2(x)')
plotMultidimensionalX(qua_3, 'f_3(x)')
plotMultidimensionalX(qua_4, 'f_4(x)')

%% fminsearch
options = optimset('Display','off');

[x, y, stop, fs] = fminsearch(@function_4_1_1, x0_1, options);
fms_1.x = x;
fms_1.y = y;
fms_1.k = fs.iterations;
fms_1.stop_condition = stop;

[x, y, stop, fs] = fminsearch(@function_4_1_2, x0_1, options);
fms_2.x = x;
fms_2.y = y;
fms_2.k = fs.iterations;
fms_2.stop_condition = stop;

[x, y, stop, fs] = fminsearch(@function_4_1_3, x0_2, options);
fms_3.x = x;
fms_3.y = y;
fms_3.k = fs.iterations;
fms_3.stop_condition = stop;

[x, y, stop, fs] = fminsearch(@function_4_1_4, x0_2, options);
fms_4.x = x;
fms_4.y = y;
fms_4.k = fs.iterations;
fms_4.stop_condition = stop;

fprintf('\n\n\\subsubsection*{fminsearch}\n')
printOtimizationResultTable([fms_1 fms_2 fms_3 fms_4])

%% fminunc
options = optimset('Display','off');

[x, y, stop, fs] = fminunc(@function_4_1_1, x0_1, options);
fmu_1.x = x;
fmu_1.y = y;
fmu_1.k = fs.iterations;
fmu_1.stop_condition = stop;

[x, y, stop, fs] = fminunc(@function_4_1_2, x0_1, options);
fmu_2.x = x;
fmu_2.y = y;
fmu_2.k = fs.iterations;
fmu_2.stop_condition = stop;

[x, y, stop, fs] = fminunc(@function_4_1_3, x0_2, options);
fmu_3.x = x;
fmu_3.y = y;
fmu_3.k = fs.iterations;
fmu_3.stop_condition = stop;

[x, y, stop, fs] = fminunc(@function_4_1_4, x0_2, options);
fmu_4.x = x;
fmu_4.y = y;
fmu_4.k = fs.iterations;
fmu_4.stop_condition = stop;

fprintf('\n\n\\subsubsection*{fminunc}\n')
printOtimizationResultTable([fmu_1 fmu_2 fmu_3 fmu_4])