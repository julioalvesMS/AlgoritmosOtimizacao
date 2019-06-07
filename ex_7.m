%% Exercício 7 - Coluna Tubular

%% Inicialização
close all; clc; clear;

addpath(genpath('funcoes'))
addpath(genpath('algoritmos'))
addpath(genpath('funcoes_teste'))

[~, ~] = mkdir('imagens');

%% Problemas

global P
P = problem_11_4_1;

%% 

% [x, y, i, P_data] = LagrangianoAumentado(P);

[x, y, i, P_data] = Barreira(P);

P_data = remove_useless_data(P, P_data);

%%

options = optimoptions('fmincon','Display','iter','Algorithm','sqp', 'MaxFunctionEvaluations', 20000);

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
P_fmincon = data;

P_fmincon = remove_useless_data(P, P_fmincon);


%%
plotMultidimensionalY(P_data, 'Coluna Tubular')

plotMultidimensionalX(P_data, 'Coluna Tubular')

plotRestricoesP(P_data, 'Coluna Tubular')

%%

function [c,ceq] = nonlcon(x)
    global P
    c = P.g_fnc(x);
    ceq = P.h_fnc(x);
end