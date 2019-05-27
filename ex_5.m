%% Exercício 5

%% Inicialização
close all; clc; clear;

addpath(genpath('funcoes'))
addpath(genpath('algoritmos'))
addpath(genpath('funcoes_teste'))

%% Problemas

global P
P = problem_10_2_1;

%% 

[x1, y1, i1, P1_data] = Barreira(P);

%%
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');

PROBLEM.solver = 'fmincon';
PROBLEM.options = options;
PROBLEM.objective = @P.fnc;
PROBLEM.x0 = P.x0;
PROBLEM.nonlcon = @nonlcon;

[X,FVAL,EXITFLAG,OUTPUT] = fmincon(PROBLEM);

data.x = X;
data.y = FVAL;
data.h = P.h_fnc(X);
data.g = P.g_fnc(X);
data.P = 0;
data.k = OUTPUT.iterations;
data.stop_condition = EXITFLAG;
data.iterations = OUTPUT.iterations;
data.method_name = 'fmincon';
P1_fmincon = data;

%%
table_data{1} = P1_data;
printOtimizationResultTable(table_data)
printRestritionResultTable(table_data)

table_data{1} = P1_fmincon;
printOtimizationResultTable(table_data)
printRestritionResultTable(table_data)

plotMultidimensionalY(P1_data, 'P')

plotMultidimensionalX(P1_data, 'P')

plotRestricoesP(P1_data, 'P')

function [c,ceq] = nonlcon(x)
    global P
    c = P.h_fnc(x);
    ceq = P.g_fnc(x);
end