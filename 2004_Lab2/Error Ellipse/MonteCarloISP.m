clear all; close all; clc;

g = 9.8; %m/s^2
N = 1000;
mph2ms = 0.44704; %m/s
deg2rad = 0.0174533;

vWind_mean = [-1.4;-1;0]* mph2ms;
thetaI_mean = 43*deg2rad; % deg 45
mDry_mean = 136.9/1000; % kg
mWet_mean = 1136.9/1000;
rhoAirAmb_mean = 1.022; % kg/m^3
Dbottle_mean = .109; % m
CD_mean = 0.27; % drag coefficient

vWind_error = 2* mph2ms;
thetaI_error = 2*deg2rad; % deg 45
mDry_error = 5/1000; % kg
mWet_error = 10/1000;
rhoAirAmb_error = .0011; % kg/m^3
Dbottle_error = .001; % m
CD_error = .2; % drag coefficient

fileName = input('Input Filename: ','s');
% calculate the Isp given the static thrust data
[Isp_mean,thrust,time] = calcISP(fileName);
Isp_error = .12;

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
    CD = CD_mean + CD_error.*abs(randn(1));
    
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
    fname = 'MonteCarloISPFunction';
    
    % call ode45 function
    
    [t,cond] = ode45(fname,tspan,condI);
    plot3(cond(:,4),cond(:,5),cond(:,6))
    hold on;
    
    x(i) = cond(end,4);
    y(i) = cond(end,5);
    z(i) = max(cond(:,6));
end

x = x*3.28084;
y = y*3.28084;
x_mean = mean(x);
y_mean = mean(y);

MAG = sqrt(x_mean^2+y_mean^2);
ANGLE = atand(y_mean/x_mean);

fprintf('The Drift Angle is: %.2f degrees\n',ANGLE);
fprintf('The Total Distance is: %.2f ft\n',MAG);

grid on
axis equal
title('Bottle Rocket Trajectory - Isp Model')
xlabel('Downrange Distance Distance [m]')
ylabel('Crossrange Distance [m]')
zlabel('Height [m]')
figure(2)

%% 1
ErrorEllipseCreator(N,x,y);
hold on;
scatter(x_mean,y_mean,'filled','dr');
scatter(215.21,-22.62,'filled','db');


