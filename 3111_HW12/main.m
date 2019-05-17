%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111
% HW 12
% main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

%% Analyze flat plate

M = 2.5;
alpha = [5 15 30];
epsilon = 0;

fprintf('==================== Problem #1 ====================\n');
fprintf('c_l (Exp theory)\tc_d (Exp theory)\tc_l (Lin theory)\tc_d (Lin theory)\n');
for i = 1:length(alpha)
    if i < 3
        [c_l_exp(i), c_d_exp(i)] = shockExpansion(M,alpha(i),epsilon);
        [c_l_lin(i), c_d_lin(i)] = linTheory(M,alpha(i),epsilon);
        fprintf('%.3f\t\t\t\t%.3f\t\t\t\t%.3f\t\t\t\t%.3f\n',c_l_exp(i),c_d_exp(i),c_l_lin(i),c_d_lin(i));
    else
        [c_l_lin(i), c_d_lin(i)] = linTheory(M,alpha(i),epsilon);
        fprintf('Nada!\t\t\t\tNada!\t\t\t\t%.3f\t\t\t\t%.3f\n',c_l_lin(i),c_d_lin(i));
    end
end

fprintf('\nError in c_l\tError in c_d\n');
for i = 1:length(alpha)-1
    error_cl(i) = abs((c_l_exp(i) - c_l_lin(i))/c_l_exp(i))*100;
    error_cd(i) = abs((c_d_exp(i) - c_d_lin(i))/c_d_exp(i))*100;
    
    fprintf('%.3f\t\t\t%.3f\n',error_cl(i),error_cd(i));
end

%% Analyze diamond airfoil

M = 2.5;
alpha = [5 15 30];
epsilon = 5;

fprintf('\n==================== Problem #2 ====================\n');
fprintf('c_l (Exp theory)\tc_d (Exp theory)\tc_l (Lin theory)\tc_d (Lin theory)\n');
for i = 1:length(alpha)
    if i < 3
        [c_l_exp(i), c_d_exp(i)] = shockExpansion(M,alpha(i),epsilon);
        [c_l_lin(i), c_d_lin(i)] = linTheory(M,alpha(i),epsilon);
        fprintf('%.3f\t\t\t\t%.3f\t\t\t\t%.3f\t\t\t\t%.3f\n',c_l_exp(i),c_d_exp(i),c_l_lin(i),c_d_lin(i));
    else
        [c_l_lin(i), c_d_lin(i)] = linTheory(M,alpha(i),epsilon);
        fprintf('Nada!\t\t\t\tNada!\t\t\t\t%.3f\t\t\t\t%.3f\n',c_l_lin(i),c_d_lin(i));
    end
end

fprintf('\nError in c_l\tError in c_d\n');
for i = 1:length(alpha)-1
    error_cl(i) = abs((c_l_exp(i) - c_l_lin(i))/c_l_exp(i))*100;
    error_cd(i) = abs((c_d_exp(i) - c_d_lin(i))/c_d_exp(i))*100;
    
    fprintf('%.3f\t\t\t%.3f\n',error_cl(i),error_cd(i));
end
