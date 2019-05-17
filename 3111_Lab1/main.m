%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111: Aerodynamics
% Lab 1
%
% Purpose: Develop Matlab skills with numerical integration and get a
% handle on how pressure distibution problems should be solved.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clean house
clc; close all;
format long;

%% Problem 1
[L,D] = prob1();

%% Problem 2
[L2,D2,sigma_L2,sigma_D2] = prob2();
