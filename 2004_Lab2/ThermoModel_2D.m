% Project 2
% This project calculates the flight path of a bottle rocket over time
% Assumptions: Isentropic Flow, Incompressible Flow
% Inputs:   N/A
% Outputs:  N/A
% Author: 71ca431fae68
% Date Created: 11/13/15
% Date Modefied: 12/6/15

% start clean
clear all; clc; close all;

% define all global variables
global g Cd psi2in rhoAirAmb Vbottle Pamb gamma rhoH2O Dthroat Dbottle R ...
    mBottle CD PAirI VH2Oi TairI ROCKETmI mAirI

% constant values for bottle rocket flight
g = 9.81; % m/(s^2)
Cd = 0.8;
psi2in = 6894.76; % Pa
rhoAirAmb = 0.961; % kg/m^3
Pamb = 12.03*psi2in; % Pa
gamma = 1.4;
rhoH2O = 1000; % kh/m^3
R = 287; % J/kgK

% constant bottle values
Vbottle = 0.002; % m^3
Dthroat = 2.1/100; % m
Dbottle = 10.5/100; % m
mBottle = 0.07; % kg

%%%%%%%%%%%%%%%%%%%%
figure
% Bottle Rocket parameters
CD = 0.3; % drag coefficient
PAirI = (60*psi2in)+Pamb; % Pa
VH2Oi = Vbottle/2; % m^3
TairI = 300; % K

% Define the intital state of the rocket
vI = 0; % m/s
deg2rad = 0.0174533;
thetaI = 35*deg2rad; % deg 35
xI = 0; % m
zI = 0.1; % m

% calculate the initial volume of air
VairI = Vbottle - VH2Oi;
% calulate the initial mass of the rocket
[ROCKETmI,mAirI] = calcRocketMass(VairI);

% create a vector of intital conditions
condI = [vI thetaI xI zI VairI ROCKETmI mAirI];

% define time interval
t0 = 0; % s
tf = 100; % s
tspan= [t0 tf];

% define function name
fname = 'RocketFlight_2D';

% call ode45 function
[t,cond] = ode45(fname,tspan,condI);

% Plot the rockets trajectory
plot(cond(:,3),cond(:,4))
grid on
axis equal
title('Bottle Rocket Trajectory')
xlabel('Downrange Distance [m]')
ylabel('Height [m]')