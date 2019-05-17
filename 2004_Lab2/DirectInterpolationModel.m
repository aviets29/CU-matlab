% Direct Interpolation Model
clear; close all; clc
% define global variables
global g thetaI vWind thrust time rhoAirAmb Dbottle CD mProp t_h20_to_air rhoH2O
mProp = 999.8; % kg
g = 9.81; % m/s^2
mWet = 1120/1000; % kg
rhoAirAmb = 0.961; % kg/m^3
rhoH2O = 1000; % kg/m^3
Dbottle = 10.5/100; % m
CD = 0.3; % drag coefficient
mph2ms = 0.44704; %m/s
fileName = input('Input Filename: ','s');
% calculate the Isp given the static thrust data
[Isp,thrust,time] = calcISP(fileName);
t_h20_to_air = 0.155; % s

figure
% Define the intital state of the rocket
vI = 0; % m/s
vWind = [-4;0;0]*mph2ms;
deg2rad = 0.0174533;
thetaI = 45*deg2rad; % deg 45
vxI = vI*cos(thetaI);
vyI = 0;
vzI = vI*sin(thetaI);
xI = 0; % m
yI = 0; % m
zI = 0.1; % m
mI = mWet; % kg


% create a vector of intital conditions
condI = [vxI vyI vzI xI yI zI mI];

% define time interval
t0 = 0; % s
tf = 100; % s
tspan= [t0 tf];

% define function name
fname = 'RocketFlightInterpolation';

% call ode45 function
[t,cond] = ode45(fname,tspan,condI);

% Plot the rockets trajectory
plot3(cond(:,4),cond(:,5),cond(:,6))
grid on
axis equal
title('Bottle Rocket Trajectory - Direct Interpolation Model')
xlabel('Downrange Distance Distance [m]')
ylabel('Crossrange Distance [m]')
zlabel('Height [m]')