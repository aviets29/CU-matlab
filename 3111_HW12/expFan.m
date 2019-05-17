%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111
% HW 12
% expFan.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [p2_p1,M2] = expFan(M,theta)

[M1,v1,mu1] = flowprandtlmeyer(1.4,M);
v2 = theta + v1;
[M2,v_2,mu2] = flowprandtlmeyer(1.4,v2,'nu');

p2_p1 = ((1+(1.4-1)/2*M1^2)/(1+(1.4-1)/2*M2^2))^(1.4/.4);
end

