% Project 2
% This project calculates the flight path of a bottle rocket over time
% Assumptions: Isentropic Flow, Incompressible Flow
% Inputs:   N/A
% Outputs:  N/A
% Author: Edward Zuzula
% Date Created: 11/13/15
% Date Modefied: 4/4/16
% Modefied for ASEN 2004 Vehicle Design Lab

% start clean
clear all; clc; close all;

% define all global variables
global g Cd psi2pa rhoAirAmb Vbottle Pamb gamma rhoH2O Dthroat Dbottle R ...
    mBottle CD PAirI VH2Oi TairI ROCKETmI mAirI vWind

% constant values for bottle rocket flight
g = 9.81; % m/(s^2)
Cd = 0.8;
psi2pa = 6894.76; % Pa
rhoAirAmb = 0.961; % kg/m^3
Pamb = 12.03*psi2pa; % Pa
gamma = 1.4;
rhoH2O = 1000; % kg/m^3
R = 287; % J/kgK
mph2ms = 0.44704; %m/s

% constant bottle values
Vbottle = 0.002; % m^3
Dthroat = 2.1/100; % m
Dbottle = 10.5/100; % m
mBottle = 115.9/1000; % kg

% Trajectory to 80 m
%%%%%%%%%%%%%%%%%%%%
figure
% Bottle Rocket parameters
CD = 0.3; % drag coefficient
PAirI = (39*psi2pa)+Pamb; % Pa
VH2Oi = Vbottle/2; % m^3
TairI = 15.5556+273; % K

% Define the intital state of the rocket
vxI = 0; % m/s
vyI = 0; % m/s
vzI = 0; % m/s
deg2rad = 0.0174533;
thetaI = 45*deg2rad; % deg 35
xI = 0; % m
yI = 0; % m
zI = 0.1; % m
vWind = [-4.03;0;0]*mph2ms; % m/s

% calculate the initial volume of air
VairI = Vbottle - VH2Oi;
% calulate the initial mass of the rocket
[ROCKETmI,mAirI] = calcRocketMass(VairI);

% create a vector of intital conditions
condI = [vxI vyI vzI thetaI xI yI zI VairI ROCKETmI mAirI];

% define time interval
t0 = 0; % s
tf = 100; % s
tspan= [t0 tf];

% define function name
fname = 'RocketFlightThermo';

% call ode45 function
[t,cond] = ode45(fname,tspan,condI);

% Plot the rockets trajectory
plot3(cond(:,5),cond(:,6),cond(:,7))
grid on
title('Bottle Rocket Trajectory')
xlabel('Downrange Distance Distance [m]')
ylabel('Crossrange Distance [m]')
zlabel('Height [m]')

% subplot(2,2,1)
% plot(cond(:,5),cond(:,7))
% xlabel('Downrange Distance Distance [m]')
% ylabel('Height [m]')
% subplot(2,2,2)
% plot(t,cond(:,1))
% xlabel('Time [s]')
% ylabel('Downrange Velocity [m/s]')
% subplot(2,2,3.5)
% plot(t,cond(:,3))
% xlabel('Time [s]')
% ylabel('Z Velocity [m/s]')
