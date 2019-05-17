function residuals = residuals(w_theo,w_exp,i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% residuals Function
% ASEN 2003 Lab 5
%
% Authors: Alec Viets and Thomas Pestolesi
% Date Published: 3/8/2016
% Date Changed: 3/28/2016
%
% Inputs: Omega Theoretical, w_theo [rad/s] ; i [index]
% Outputs: residuals [rad/s]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

residuals = w_theo(:,i)-w_exp;

end


