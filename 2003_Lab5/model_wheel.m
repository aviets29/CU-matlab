%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model_wheel Function
% ASEN 2003 Lab 5
%
% Authors: Alec Viets and Ryan Blay
% Date Published: 2/27/2016
% Date Changed: 3/2/2016
%
% Inputs: Nada
% Outputs: time, t [s] ; Theta, Th [rads] ; Omega, w [rad/s]
%          Normal force from wall, P [N] ; Normal force from floor, P [N] 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ] = model_wheel(balanced)
global M M0 m R r k Beta g

[t,Th,w_exp] = readIn(balanced);
Moment = [0,0.5,0.8,1.0,1.2,1.4,1.6];
r_prime = (r.^2+R.^2-2.*r.*R.*cos(pi-Th)).^(.5);

PE_wheel = (M+M0).*g.*Th.*R.*sin(Beta);
PE_weight = m.*g.*r.*cos(Beta)- m.*g.*r.*cos(Th+Beta) + m.*g.*Th.*R.*sin(Beta);

for i = 1:length(Moment)
    if balanced
        KE = PE_wheel- Moment(i).*Th;
        w_theo(:,i) = sqrt(2.*KE./(M.*k.^2+(M+M0).*R^2));
    else
        KE = PE_wheel+PE_weight- Moment(i).*Th;
        w_theo(:,i) = sqrt(2.*KE./(M.*k.^2+(M+M0).*R.^2+m.*r_prime.^2));
    end
    residual{i} = residuals(w_theo,w_exp,i);
end

Plotstuffs(Th,w_theo,w_exp,residual,balanced,Moment);
end

