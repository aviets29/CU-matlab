function [rho2_rho1,p2_p1,T2_T1,rho01_rho1,p01_p1,p02_p1,T01_T1,Mn1,Mn2] = normalShock(M,beta,gamma)

% Calculating total conditions at static...
p01_p1 = (1 + ((gamma-1)/2)*M^2)^(gamma/(gamma-1));
T01_T1 = (1 + (gamma-1)/2*M^2)^(1/(gamma-1));
rho01_rho1 = 1 + (gamma-1)/2*M^2;

%Calculate the normal mach number
Mn1 = M*sind(beta);

% Calculate static properties across the normal shock
rho2_rho1 = ((gamma+1)*Mn1^2)/(2+(gamma-1)*Mn1^2);
p2_p1 = 1 + (2*gamma/(gamma+1))*(Mn1^2-1);
T2_T1 = p2_p1/rho2_rho1;

% Total pressure across normal shock
p02_p1 = (((gamma+1)^2*Mn1^2)/(4*gamma*Mn1^2-2*(gamma-1)))^(gamma/(gamma-1))*((1-gamma+2*gamma*Mn1^2)/(gamma+1));

%Normal mach number across shock
Mn2 = sqrt((1+((gamma-1)/2)*Mn1^2)/(gamma*Mn1^2-(gamma-1)/2));

end