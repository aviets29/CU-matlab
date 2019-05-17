function[] = checkData()
% function[] = checkData(filename)
% This function plots the static test data to make sure the data looks
% correct
% Inputs:   filename = the name of the data file
% Outputs:  N/A
% Author: Edward Zuzula
% Date Created: 3/14/16
% Date Modified: ------
clear all; close all;;
% read in the data file
filename = input('File name: ','s');
data = load(filename);
% look at column 3 of the data which is the summed load
summedLoad = data(:,3);
% define the frequency
frequency = 1.652*1000; %Hz
% define time
time = linspace(0,length(summedLoad)/frequency,length(summedLoad));
% plot thrust vs time
figure
plot(time,summedLoad)
title('Static Test Thrust')
xlabel('Time [s]')
ylabel('Thrust [lb_f]')
end