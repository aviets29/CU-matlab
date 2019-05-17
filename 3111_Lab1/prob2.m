function [L,D,sigma_L,sigma_D] = prob2( )

c = 0.5; %m
alpha = 9; %degrees
V_inf = 20; %m/s
rho_inf = 1.225; %kg/m^3
p_inf = 10.13*10^4; %Pa
q_inf = .5*rho_inf*V_inf^2;
t =12/100;

syms x

load Cp;
Cp_u = @(x) fnval(Cp_upper,x/c); 
Cp_l = @(x) fnval(Cp_lower,x/c); 

p_u = @(x) (q_inf*(Cp_u(x)) + p_inf); 
p_l = @(x) (q_inf*(Cp_l(x)) + p_inf);

N = 10000;

N_u = trapazoidal_upper(p_u,0,c,N,false);
N_l = trapazoidal_lower(p_l,0,c,N,false);

A_u = trapazoidal_upper(p_u,0,c,N,true);
A_l = trapazoidal_lower(p_l,0,c,N,true);

N = N_l - N_u;
A = A_u - A_l;

L = N*cosd(alpha)-A*sind(alpha);
D = N*sind(alpha)+A*cosd(alpha);

sigma_L = 100*abs(132.3085 - L)/132.3085;
sigma_D = 100*abs(-1.7198 - D)/1.7198;

% figure(5)
% plot(0:.01:c,y_t(0:.01:c));
end