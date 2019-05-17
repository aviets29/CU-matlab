function [L,D] = prob1( )

Th_plot = 0:.01:pi;

V_inf = 25; %m/s
rho_inf = 0.9093; %kg/m^3
p_inf = 7.012*10^4; %Pa
q_inf = .5*rho_inf*V_inf^2;

Cp = 1 - 4*(sin(Th_plot)).^2;
p = q_inf.*Cp + p_inf;

figure(1)
polarplot(Th_plot,Cp,'-r');
title('C_p vs \theta')

pax = gca;
pax.ThetaAxisUnits = 'degrees';


syms Th
p_n = @(Th) sin(Th).*(q_inf*(1 - 4*(sin(Th)).^2) + p_inf);
p_a = @(Th) cos(Th).*(q_inf*(1 - 4*(sin(Th)).^2) + p_inf);

N = 100;
L = simpson(p_n,0,2*pi,N);
D = simpson(p_a,0,2*pi,N);
end

