%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% Project 2
% Differential function 'bottle'
% Date Created: 11/6/2015
% Date Modified: 3/9/2016

% Purpose: Develop proficiency with ode45 and other partial differential
% methods within MatLab.
% Assumptions: Isentropic, incompressible flow, inviscous, 
% gravity = 9.8 m/s^2. 
% Equations: ode45(), F=ma.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dydt = bottle(~,y)

%REMEMBER TO CHANGE IF NECCESSARY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

volume0 = .0015;                                  % Volume of air [m^3]
pressure0 = 682525;                              % Pressure of air [Pa]

R = 287;

p = ((volume0/y(3))^1.4)*pressure0;           %pressure during stage 1 [Pa]
pend = pressure0*(volume0/.002)^1.4;
p2 = pend*(y(7)/((pressure0*volume0) ...      %Pressure during stage 2 [Pa]
/(R*288.15)))^1.4;                   
pa = 82943.93;                                  %Atmpospheric Pressure [Pa]
pstar = p2*(2/2.4)^(1.4/.4);                        %Critical Pressure [Pa]

Me = sqrt(((p2/pa)^(.4/1.4)-1)*(2/.4));           %Mach # for phase 2 [N/A]

rhoWater = 1000;                                 %Density of water [kg/m^3]
rhoAir = .961;                                     %Density of air [kg/m^3]
rho2 = (y(7)/.002)^1.4;                    %Density during phase 2 [kg/m^3]

Temp = p2/(rho2*R);                       %Temp at any point in phase 2 [K]
TempAir = 300;                                        %Atmospheric Temp [K]
TempExitCHOKED = (2/2.4)*Temp;                     %Temp of choked flow [K]
TempExit = Temp*(1+.2*Me^2)^(1.4/.4);          %Temp of non-choked flow [K]

rhoe = pa/(R*TempExit);                   %Density at exit (not choked) [K]
rhoeCHOKED = pstar/(R*TempExitCHOKED);     %Density of choked flow [kg/m^3]

cd = .8;                                        %Discharge Coefficent [N/A]
Areat = pi*(1.05*10^(-2))^2;                          %Area of throat [m^2]
Areab= pi*(5.25*10^(-2))^2;                   %Crosssection of bottle [m^2]
Cd = .5;                                            %Drag coefficient [N/A]
g = 9.81;                                                  %Gravity [m/s^2]

if y(3) < .002        %Volume of air is less than volume of bottle, stage 1
    
    F = 2*cd*(p-pa)*Areat;
    D = rhoAir*.5*y(4)^2*Cd*Areab;
    Fg = y(6)*g*sin(y(5));  
    
    if y(4) < 1
    dydt(1) = y(4)*cos(y(5));
    dydt(2) = y(4)*sin(y(5));
    dydt(3) = cd*Areat*sqrt((2/rhoWater)*(p-pa));
    dydt(4) = (F-D-Fg)/y(6);
    dydt(5) = 0;
    dydt(6) = -cd*Areat*sqrt(2*rhoWater*(p-pa));
    dydt(7) = 0;
    
    else
    dydt(1) = y(4)*cos(y(5));
    dydt(2) = y(4)*sin(y(5));
    dydt(3) = cd*Areat*sqrt((2/rhoWater)*(pressure0*(volume0/y(3))^1.4-pa));
    dydt(4) = (F-D-Fg)/y(6);
    dydt(5) = -g*cos(y(5))/y(4);
    dydt(6) = -cd*Areat*sqrt(2*rhoWater*(p-pa));
    dydt(7) = 0;
    end
    
elseif (p2 > pa)   %volume of air is equal to volume of bottle
    
    VeCHOKED = sqrt(1.4*R*TempExitCHOKED);
    Ve = Me*sqrt(1.4*R*TempExit);
    FCHOKED = cd*rhoeCHOKED*Areat*VeCHOKED^2 + (pstar - pa)*Areat;
    F2 = cd*rhoe*Areat*Ve^2;
    D = rhoAir*.5*y(4)^2*Cd*Areab;
    Fg = y(6)*g*sin(y(5)); 

    if pstar > pa                     %If pstar is greater than atmospheric
         dydt(1) = y(4)*cos(y(5));
         dydt(2) = y(4)*sin(y(5));
         dydt(3) = 0;
         dydt(4) = (FCHOKED-D-Fg)/y(6);
         dydt(5) = -(g*cos(y(5)))/y(4);
         dydt(6) = cd*rhoeCHOKED*Areat*VeCHOKED;
         dydt(7) = -cd*rhoeCHOKED*Areat*VeCHOKED;
     else
         dydt(1) = y(4)*cos(y(5));
         dydt(2) = y(4)*sin(y(5));
         dydt(3) = 0;
         dydt(4) = (F2-D-Fg)/y(6);
         dydt(5) = -g*cos(y(5))/y(4);
         dydt(6) = cd*rhoe*Areat*Ve;
         dydt(7) = -cd*rhoe*Areat*Me*Ve;
     end
 
else                                                      %Ballistic phase
     F = 0;
     D = rhoAir*.5*y(4)^2*Cd*Areab;
     Fg = y(6)*g*sin(y(5));
     
     dydt(1) = y(4)*cos(y(5));
     dydt(2) = y(4)*sin(y(5));
     dydt(3) = 0;
     dydt(4) = (F-D-Fg)/y(6);
     dydt(5) = -g*cos(y(5))/y(4);
     dydt(6) = 0;
     dydt(7) = 0;
end
 
dydt=dydt';
end