function [ Isp, thrust, time ] = calcISP( filename )
% function [ Isp, thrust, time ] = calcISP( filename )
% This function trims the static test data to capture just the thrust
% portion, calculates the Isp, and plots the thrust vs time
% Inputs:   filename = the name of the data file
% Outputs:  Isp = the specific impulse
%           thrust = a vector of the thrust values
%           time = a time vector that corresponds w/ thrst
% Author: Edward Zuzula
% Date Created: -
% Date Modified: 4/6/16

% define constant variables
mProp = 1;
g = 9.81;
lbf2N = 4.44822; % N
% define the frequency
frequency = 1.652*1000; %Hz

% load the static thrust data
data = load(filename);
% put the summed thrust in a vector
thrust = data(:,3)'; % lbf
% trim data before thrust occurs
ind = 1;
while thrust(ind) < 1 && thrust(ind+1) < 1.2
    ind = ind+1;
end
thrust = thrust(ind:end); % lbf
% trim data for after the thrust occurs
% flip the thrust vector
thrustFlip = fliplr(thrust);
ind = 1;
% find the index where the air thrust phase is ending
while abs(thrustFlip(ind+1) - thrustFlip(ind)) < 1.
    ind = ind+1;
end
% define the last index of the thrust values
LastInd = length(thrust)-ind;
thrust = thrust(1:LastInd); % lbf
% convert thrust to N
thrust = thrust*lbf2N; % N
% redefine time
time = linspace(0,length(thrust)/frequency,length(thrust));
% define a y 
% t1 = linspace(0,time(end),10000);
% interpolate 
y = interp1([time(1) time(end)],[thrust(1) thrust(end)],time);

% thrust = thrust - y;

% plot thrust vs time
figure
plot(time,thrust,time,y);
title('Static Test Thrust vs Time')
xlabel('Time [s]')
ylabel('Thrust [N]')

% integrate the thrust
intThrust = trapz(thrust-y)/frequency;
%intThrust = trapz(thrust)/frequency;
% calculate the Isp
Isp = intThrust./(mProp*g);

thrust = thrust-y;
end

% 946 g/l al
