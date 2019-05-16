%% Exercício 4

%% Inicialização
close all; clc; clear;

addpath(genpath('funcoes'))
addpath(genpath('algoritmos'))
addpath(genpath('funcoes_teste'))

%% Problemas

P1 = problem_9_3_1;
P2 = problem_9_3_2;

%% 

[x1, y1, i1, P1_data] = Penalidades(P1);
[x2, y2, i2, P2_data] = Penalidades(P2);

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
data.h = P.res_fnc(X);
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
data.h = P.res_fnc(X);
data.P = 0;
data.k = OUTPUT.iterations;
data.stop_condition = EXITFLAG;
data.iterations = OUTPUT.iterations;
data.method_name = 'fmincon';
P2_fmincon = data;

%%

printOtimizationResultTable([P1_data P2_data])
printRestritionResultTable([P1_data P2_data])

plotMultidimensionalY(P1_data, 'P1')
plotMultidimensionalY(P2_data, 'P2')

plotMultidimensionalX(P1_data, 'P1')
plotMultidimensionalX(P2_data, 'P2')

plotRestricoesP(P1_data, 'P1')
plotRestricoesP(P2_data, 'P2')

%%

printOtimizationResultTable([P1_fmincon P2_fmincon])
printRestritionResultTable([P1_fmincon P2_fmincon])

function [c,ceq] = nonlcon(x)
    global P
    c = [];
    ceq = P.res_fnc(x);
end