% Lab 4

clear all
close all

global m l g Th0 t0 w0
m = 18; % kg
l = 4; % m
g = 9.81; % m/s^2
Th0 = 5*pi/180; % radians
t0 = 0; % s
w0 = 0; % rad/s

dt = [.1 .01 .001];
for i = 1:length(dt)
    [t{i},Th{i},w{i},P{i},N{i}] = analyze(dt(i));
end
w_ana = calc_w_ana(Th{1});

plots_table(t,Th,w,P,N, w_ana,dt);
