%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% Project 2
% Date Created: 11/12/2015

% Purpose: Develop proficiency with ode45 and other partial differential
% methods within MatLab through the construction of a theoretical bottle
% rocket simulation.
% Assumptions: Isentropic, incompressible flow, inviscous. 
% Equations: ode45(), isentropic relations, F=ma.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

volume0 = .0015;                                  % Volume of air [m^3]
theta0 = pi/3.6;                                      % Angle [Radians]
pressure0 = 682525;                              % Pressure of air [Pa]
x0 = 0;                                               % X-coordinate in [m]
z0 = 0.1;                                             % Z-coordinate in [m]
velocity0 = 0;                                             % Velocity [m\s]
MBottle = .07;                                        % mass of bottle [kg]
MWater = 1000*(.002 - volume0);                        % mass of water [kg]
MAir = (pressure0*volume0)/(286.9*288.15);               % mass of air [kg]
MRocket0 = MBottle + MWater + MAir;                   % mass of rocket [kg]
VWind = [0 0 0];

initials = [x0 y0 z0 volume0 velocity0 theta0 MRocket0 MAir];%Declare initials

xspan = 0:.05:6;
[~,y] = ode45('bottle',xspan, initials);                        %Call ode45


plot(y(:,1),y(:,2));                                 %Plot path of rocket
hold on
set(gca,'XTick',0:5:90);
ylim([0,50]);

title('Path of Rocket')
xlabel('Horizontal Distance [m]')                             %x-axis label
ylabel('Vertical Distance [m]')                               %y-axis label
legend('case 1','case 2','case 3','case 4')

