%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Function
% ASEN 2003 Lab 5
%
% Authors: Alec Viets and Ryan Blay
% Date Published: 3/14/2016
% Date Changed: 3/14/2016
%
% Purpose: A computational excersize to determine the effects of forces on 
%          a barrel rolling down an incline. In this lab, the angular and linear
%          properties were determined using a first order taylor series
%          approximation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clean House
clear all; close all;

%% Declare constants and global variables
global M M0 m R r k Beta g
M = 11.7;           %kg
M0 = .7;            %kg
m = 3.4;            %kg
R = 0.235;          %m
r = 0.178;          %m
Beta = 5.5*pi/180;  %radians
k = 0.203;          %m
g = 9.81;           %m/s^2

%% Analyze for both cases
%First case, w/o weight
balanced = true; 
model_wheel(balanced); 

%Second case, with weight
balanced = false; 
model_wheel(balanced);