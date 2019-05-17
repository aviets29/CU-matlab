%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111
% HW 12
% linTheory.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c_l,c_d] = linTheory(M,alpha,epsilon)

alpha = alpha*pi/180;
epsilon = epsilon*pi/180;

c_l = 4*alpha/sqrt(M^2-1);
c_d = 4*(alpha^2 + epsilon^2)/sqrt(M^2-1);

end

