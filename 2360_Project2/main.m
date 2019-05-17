%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Diffusive Systems
% Author: Alec Viets
% Created: 3/7/2016
% Last edited: 3/7/2016
%
% Purpose: Create a theoretical model for the diffusion of a liquid through
%          a series of permiable membranes through the use of first and
%          second order differential equations and linear algebra.
%
% y1, y2, and y3 are concentrations of chemicals in container
% 
% Algorithm:
% k = ? for now
% dy1dt = k(-y1 + y2)
% dy2dt = k(y1 - 2*y2 + y3)
% dy3dt = k(y2 - y3)
% Define the A, b, and y matrixes
% Solve the matrix for equilibrium solutions (b = 0)
% Calculate determiate of A
% Now, k = 2
% With k value, calculate solutions to system

clear all;
close all;
clc;

y = @(y1,y2,y3) [y1 ; y2 ; y3];
b = @(dy1dt,dy2dt,dy3dt) [dy1dt ; dy2dt ; dy3dt];
A = @(k) k.*[-1 1 0 ; 1 -2 1 ; 0 1 -1];

syms k
equilibrium = linsolve(A(k),b(0,0,0));
determinate = det(A(k));
%RREF(A(k))
B = @(landa) A(2) - landa*eye(3);
syms landa

% eigenvalues = solve(det(B(landa)) == 0,landa);
% v1 = linsolve((A(2)-eigenvalues(1)*eye(3)),b(0,0,0));

[V,eigenvalues] = eig(A(2));
v1_norm = V(1,:)/norm(V(1,:));
v2_norm = V(2,:)/norm(V(2,:));
v3_norm = V(3,:)/norm(V(3,:));

V_mat = [v1_norm' v2_norm' v3_norm'];
V_RREF = rref(V_mat);

constants = linsolve([,[1; 2; 4]);

syms t
Y(t) = constants(1).*V_RREF(1,:).*exp(eigenvalues(1,1).*t) + ...
    constants(2).*V_RREF(2,:).*exp(eigenvalues(2,2).*t) + ...
    constants(3).*V_RREF(3,:).*exp(eigenvalues(3,3).*t);

y1(t) = exp(-6*t)/6*(1-9*exp(4*t)+14*exp(6*t));
y2(t) = exp(-6*t)/3*(7*exp(6*t)-1);
y3(t) = exp(-6*t)/6*(1+9*exp(4*t)+14*exp(6*t));

M(t) = y1(t)+y2(t)+y3(t);     
dMdt(t) = diff(M);

t = 1:5;

plot(t,y1(t));
hold on;
plot(t,y2(t));
plot(t,y3(t));