%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111
% Experimental Lab 2
% main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;
warning('off');

%% Analyze short wing
wing = ReadIn('Short');
fields = fieldnames(wing);
S = 0.01022; %m
%d = 0.1035; %m
d = 0.08954;

c_avg = .06;
b = .18;
S = b*c_avg; %m
AR = b^2/S;

fprintf('=============== Short Wing ================\n');

for i = 2:numel(fields)
    N = wing.(fields{i}).N - wing.(fields{1}).N;
    A = wing.(fields{i}).A - wing.(fields{1}).A;
    M = wing.(fields{i}).M;
    v(:,i-1) = wing.(fields{i}).v;
    [alpha_max(i-1),cl_max(i-1),liftslope(i-1),alpha_0(i-1),cd_i(i-1),e(i-1)] = plotCoeffs(N,A,M,wing.(fields{i}).rho,wing.(fields{i}).alpha, ...
        v(:,i-1),S,AR,d,'Short',i-1);
end


fprintf('Airspeed\tMax Alpha\tMax cl\t\tLift Slope\talpha_0\t\tcd_i\t\tSpan efficiency\n')
fprintf('%.0f\t\t\t%.2f\t\t%.2f\t\t%.2f pi\t\t%.2f\t\t%.2f\t\t%.2f\n',v(1,1),alpha_max(1),cl_max(1),liftslope(1)/pi,alpha_0(1),cd_i(1),e(1));
fprintf('%.0f\t\t\t%.2f\t\t%.2f\t\t%.2f pi\t\t%.2f\t\t%.2f\t\t%.2f\n\n',v(1,2),alpha_max(2),cl_max(2),liftslope(2)/pi,alpha_0(2),cd_i(2),e(2));

%% Analyze long wing
wing = ReadIn('Long');
fields = fieldnames(wing);

AR = 4;
c_avg = .06;
b = c_avg*AR;
S = b^2/AR; %m

fprintf('=============== Long Wing ================\n');

for i = 2:numel(fields)
    N = wing.(fields{i}).N - wing.(fields{1}).N;
    A = wing.(fields{i}).A - wing.(fields{1}).A;
    M = wing.(fields{i}).M;
    v(:,i-1) = wing.(fields{i}).v;
    [alpha_max(i-1),cl_max(i-1),liftslope(i-1),alpha_0(i-1),cd_i(i-1),e(i-1)] = plotCoeffs(N,A,M,wing.(fields{i}).rho,wing.(fields{i}).alpha, ...
        v(:,i-1),S,AR,d,'Long',i-1);
end


fprintf('Airspeed\tMax Alpha\tMax cl\t\tLift Slope\talpha_0\t\tcd_i\t\tSpan efficiency\n')
fprintf('%.0f\t\t\t%.2f\t\t%.2f\t\t%.2f pi\t\t%.2f\t\t%.2f\t\t%.2f\n',v(1,1),alpha_max(1),cl_max(1),liftslope(1)/pi,alpha_0(1),cd_i(1),e(1));
fprintf('%.0f\t\t\t%.2f\t\t%.2f\t\t%.2f pi\t\t%.2f\t\t%.2f\t\t%.2f\n\n',v(1,2),alpha_max(2),cl_max(2),liftslope(2)/pi,alpha_0(2),cd_i(2),e(2));

%% Analyze elliptical wing
wing = ReadIn('Elliptical');
fields = fieldnames(wing);

S = 0.00783; %m
b = 0.18; %m
AR = b^2/S; 
d = 0.1035; %m

fprintf('=============== Elliptical Wing ================\n');

for i = 2:numel(fields)
    N = wing.(fields{i}).N - wing.(fields{1}).N;
    A = wing.(fields{i}).A - wing.(fields{1}).A;
    M = wing.(fields{i}).M;
    v(:,i-1) = wing.(fields{i}).v;
    [alpha_max(i-1),cl_max(i-1),liftslope(i-1),alpha_0(i-1),cd_i(i-1),e(i-1)] = plotCoeffs(N,A,M,wing.(fields{i}).rho,wing.(fields{i}).alpha, ...
        v(:,i-1),S,AR,d,'Elliptical',i-1);
end


fprintf('Airspeed\tMax Alpha\tMax cl\t\tLift Slope\talpha_0\t\tcd_i\t\tSpan efficiency\n')
fprintf('%.0f\t\t\t%.2f\t\t%.2f\t\t%.2f pi\t\t%.2f\t\t%.2f\t\t%.2f\n',v(1,1),alpha_max(1),cl_max(1),liftslope(1)/pi,alpha_0(1),cd_i(1),e(1));
fprintf('%.0f\t\t\t%.2f\t\t%.2f\t\t%.2f pi\t\t%.2f\t\t%.2f\t\t%.2f\n\n',v(1,2),alpha_max(2),cl_max(2),liftslope(2)/pi,alpha_0(2),cd_i(2),e(2));

