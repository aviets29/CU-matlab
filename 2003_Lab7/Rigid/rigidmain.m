%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Function
% ASEN 2003 Lab 5
%
% Authors: Alec Viets and Ryan Blay
% Date Published: 3/14/2016
% Date Changed: 3/14/2016
%
% Purpose: Comparing experimental and theoretical models for both rigid and
%          flexible moving arms but utilizing second order differential
%          equations and various solving methods. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clean House
clear all; close all;

%% Declare constants and global variables
global Kg Km Rm J L
Kg = 48.8;     % Gear Ratio [N/A]
Km = 0.008;    % Motor Constant [V/(rad/s)]
Rm = 3.29;     % Motor Resistance [ohms]
J_hub = 0.002;   % I for hub [kg*m^2]
J_load = 0.0015; % I for load [kg*m^2]
J = J_hub + J_load;
L = .45;  

%% Analyze the Rigid Arm
Thd = pi/4;

[Kp, Kd] = optimizeRigid(Thd);
[time05,overshoot,w,zeta] = rigid(Kp,Kd,Thd);
