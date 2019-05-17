%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111
% HW 12
% obliqueShoch.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [p2_p1,M2] = obliqueShoch(M,theta)

gamma = 1.4;
Beta = beta(M,theta,gamma,0);
Mn_1 = M*sind(Beta);

p2_p1 = 1 + 2*gamma/(gamma+1)*(Mn_1^2 - 1);
Mn_2 = sqrt((1+((gamma-1)/2*Mn_1^2))/(gamma*Mn_1^2 - (gamma-1)/2));
M2 = Mn_2/sind(Beta-theta);

end

