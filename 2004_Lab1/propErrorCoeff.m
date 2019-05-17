function A = propErrorCoeff(Drag,Lift,Moment,rho_atm,V_air,sigD,sigL,sigM,sigrho,sigV,model)

% define the wing area of a F16 & mean chord line
if model == 1 || model == 2
    S = 27.87; %m^2
    c = 3.05;
else
    S = 325; %m^2
    c = 8.05;%6.46;
end

%Error in lift coefficient.
delta_CL = sqrt((1./(.5.*rho_atm.*V_air.^2.*S)).^2.*(sigL.^2)+(-Lift./(.5.*rho_atm.^2.*V_air.^2.*S)).^2.*sigrho.^2 + (-2.*Lift./(.5.*rho_atm.*V_air.^3.*S)).^2.*sigV.^2);
%Error in drag coefficient.
delta_CD = sqrt((1./(.5.*rho_atm.*V_air.^2.*S)).^2.*(sigD.^2)+(-Drag./(.5.*rho_atm.^2.*V_air.^2.*S)).^2.*sigrho.^2 + (-2.*Drag./(.5.*rho_atm.*V_air.^3.*S)).^2.*sigV.^2);
%Error in moment coefficient.
delta_CM = sqrt((1./(.5.*rho_atm.*V_air.^2.*S*c)).^2.*(sigM.^2)+(-Moment./(.5.*rho_atm.^2.*V_air.^2.*S*c)).^2.*sigrho.^2 + (-2.*Moment./(.5.*rho_atm.*V_air.^3.*S*c)).^2.*sigV.^2);


A = [ delta_CD,delta_CL,delta_CM];
end

