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
global Kg Km Rm
Kg = 48.8;     % Gear Ratio [N/A]
Km = 0.008;    % Motor Constant [V/(rad/s)]
Rm = 3.29;     % Motor Resistance [ohms]

%% Alalyze the Flexible Arm
Thd = pi/4;

%[Kpt_final,Kpd_final,Kdt_final,Kdd_final] = optimizeFlex(Thd);
Kpt_final = 5.5;
Kpd_final = -5;
Kdt_final = 1.2;
Kdd_final = 0.8;
flex(Kpt_final,Kpd_final,Kdt_final,Kdd_final,Thd)