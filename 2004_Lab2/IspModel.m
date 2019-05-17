% Isp Model
clear all;  clc; close all;

% define global variables
global mProp g mDry mWet thetaI vWind
mProp = 999.8/1000; % kg
g = 9.81; % m/s^2
mDry = 115.9/1000; % kg
mWet = 1120/1000; %mDry + mProp; % kg %1.055


fileName = input('Input Filename: ','s');
% calculate the Isp given the static thrust data
[Isp,thrust,time] = calcISP(fileName);
% Calculate deltaV from Isp and use as initial velocity
dV = Isp*g*log(mWet/mDry);
mph2ms = 0.44704; %m/s

figure
% Define the intital state of the rocket
vI = dV; % m/s
vWind = [-4;0;0]* mph2ms;
deg2rad = 0.0174533;
thetaI = 45*deg2rad; % deg 45
vxI = vI*cos(thetaI);
vyI = 0;
vzI = vI*sin(thetaI);
xI = 0; % m
yI = 0; % m
zI = 0.1; % m


% create a vector of intital conditions
condI = [vxI vyI vzI xI yI zI];

% define time interval
t0 = 0; % s
tf = 100; % s
tspan= [t0 tf];

% define function name
fname = 'RocketFlightISP';

% call ode45 function
[t,cond] = ode45(fname,tspan,condI);

% Plot the rockets trajectory
plot3(cond(:,4),cond(:,5),cond(:,6))
grid on
axis equal
title('Bottle Rocket Trajectory - Isp Model')
xlabel('Downrange Distance Distance [m]')
ylabel('Crossrange Distance [m]')
zlabel('Height [m]')



