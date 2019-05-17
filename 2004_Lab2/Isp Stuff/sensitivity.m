clear all; close all; clc;

g = 9.8; %m/s^2
N = 100;
mph2ms = 0.44704; %m/s
deg2rad = 0.0174533;

vWind_mean = [0;0;0]* mph2ms;
thetaI_mean = 45*deg2rad; % deg 45
mDry_mean = 115.9/1000; % kg
mWet_mean = 1120/1000;
rhoAirAmb_mean = 0.961; % kg/m^3
Dbottle_mean = 10.5/100; % m
CD_mean = 0.35; % drag coefficient

vWind_error = 10* mph2ms;
thetaI_error = 4*deg2rad; % deg 45
mDry_error = 0/1000; % kg
mWet_error = 0/1000;
rhoAirAmb_error = .000; % kg/m^3
Dbottle_error = 0/100; % m
CD_error = .0; % drag coefficient

fileName = input('Input Filename: ','s');
% calculate the Isp given the static thrust data
[Isp_mean,thrust,time] = calcISP(fileName);
Isp_error = .0;

figure(1)
for i = 1:N
    global mDry mWet Isp thetaI rhoAirAmb Dbottle CD vWind
    % define possible error
    mDry = mDry_mean + mDry_error.*randn(1);
    mWet = mWet_mean + mWet_error.*randn(1);
    Isp = Isp_mean + Isp_error.*randn(1);
    thetaI = thetaI_mean + thetaI_error.*randn(1);
    rhoAirAmb = rhoAirAmb_mean + rhoAirAmb_error.*randn(1);
    Dbottle = Dbottle_mean + Dbottle_error.*randn(1);
    CD = CD_mean + CD_error.*randn(1);
    
    vWind = [vWind_mean(1) + vWind_error.*randn(1), ...
        vWind_mean(2) + vWind_error.*randn(1), ...
        vWind_mean(3) + vWind_error.*randn(1)];
    
    % Calculate deltaV from Isp and use as initial velocity
    dV = g*Isp.*log(mWet./mDry);
    
    
    % Define the intital state of the rocket
    vI = dV; % m/s
    
    vxI = vI.*cos(thetaI);
    vyI = 0;
    vzI = vI.*sin(thetaI);
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
    fname = 'MonteCarloISPFunction2';
    
    % call ode45 function
    
    [t,cond] = ode45(fname,tspan,condI);
    plot3(cond(:,4),cond(:,5),cond(:,6))
    hold on;
    
    x(i) = cond(end,4);
    y(i) = cond(end,5);
    
end

grid on
axis equal
title('Bottle Rocket Trajectory - Isp Model')
xlabel('Downrange Distance Distance [m]')
ylabel('Crossrange Distance [m]')
zlabel('Height [m]')
figure(2)

ErrorEllipseCreator(N,x,y);
hold on;