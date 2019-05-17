%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Function
% ASEN 2003 Lab 6
%
% Authors: Alec Viets and Ryan Blay
% Date Published: 3/30/2016
% Date Changed: 3/30/2016
%
% Purpose: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clean House
clear all; close all;

%% Declare constants

global Iapp R m Li
Iapp = 165;          %lbm-in^2
R = 4.25;            %in
m = 0.275;           %lbm
Li = 13.58;          %in

%Call the readIn function to analyze data and plot it
readIn()