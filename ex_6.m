%% Exercício 6

%% Inicialização
close all; clc; clear;

addpath(genpath('funcoes'))
addpath(genpath('algoritmos'))
addpath(genpath('funcoes_teste'))

[~, ~] = mkdir('imagens');

%% Problemas

P1 = problem_9_3_1;
P2 = problem_9_3_2;

P3 = problem_10_2_1;

%% 

[x1, y1, i1, P1_data] = LagrangianoAumentado(P1);
[x2, y2, i2, P2_data] = LagrangianoAumentado(P2);
[x3, y3, i3, P3_data] = LagrangianoAumentado(P3);

P1_data = remove_useless_data(P1, P1_data);
P2_data = remove_useless_data(P2, P2_data);
P3_data = remove_useless_data(P3, P3_data);

%%
global P
P = P1;
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');

PROBLEM_1.solver = 'fmincon';
PROBLEM_1.options = options;
PROBLEM_1.objective = @P.fnc;
PROBLEM_1.x0 = P.x0;
PROBLEM_1.nonlcon = @nonlcon;

[X,FVAL,EXITFLAG,OUTPUT] = fmincon(PROBLEM_1);

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

P = P2;
PROBLEM_2.solver = 'fmincon';
PROBLEM_2.options = options;
PROBLEM_2.objective = @P.fnc;
PROBLEM_2.x0 = P.x0;
PROBLEM_2.nonlcon = @nonlcon;

[X,FVAL,EXITFLAG,OUTPUT] = fmincon(PROBLEM_2);

data.x = X;
data.y = FVAL;
data.h = P.h_fnc(X);
data.g = P.g_fnc(X);
data.P = 0;
data.k = OUTPUT.iterations;
data.stop_condition = EXITFLAG;
data.iterations = OUTPUT.iterations;
data.method_name = 'fmincon';
P2_fmincon = data;

P = P3;
PROBLEM_3.solver = 'fmincon';
PROBLEM_3.options = options;
PROBLEM_3.objective = @P.fnc;
PROBLEM_3.x0 = P.x0;
PROBLEM_3.nonlcon = @nonlcon;

[X,FVAL,EXITFLAG,OUTPUT] = fmincon(PROBLEM_3);

data.x = X;
data.y = FVAL;
data.h = P.h_fnc(X);
data.g = P.g_fnc(X);
data.P = 0;
data.k = OUTPUT.iterations;
data.stop_condition = EXITFLAG;
data.iterations = OUTPUT.iterations;
data.method_name = 'fmincon';
P3_fmincon = data;


P1_fmincon = remove_useless_data(P1, P1_fmincon);
P2_fmincon = remove_useless_data(P2, P2_fmincon);
P3_fmincon = remove_useless_data(P3, P3_fmincon);


%%

printOtimizationResultTable([P1_data P2_data P3_data])
printRestritionResultTable([P1_data P2_data P3_data])

plotMultidimensionalY(P1_data, 'P1')
plotMultidimensionalY(P2_data, 'P2')
plotMultidimensionalY(P3_data, 'P3')

plotMultidimensionalX(P1_data, 'P1')
plotMultidimensionalX(P2_data, 'P2')
plotMultidimensionalX(P3_data, 'P3')

plotRestricoesP(P1_data, 'P1')
plotRestricoesP(P2_data, 'P2')
plotRestricoesP(P3_data, 'P3')

%%

printOtimizationResultTable([P1_fmincon P2_fmincon P3_fmincon])
printRestritionResultTable([P1_fmincon P2_fmincon P3_fmincon])

function [c,ceq] = nonlcon(x)
    global P
    c = P.h_fnc(x);
    ceq = P.g_fnc(x);
end