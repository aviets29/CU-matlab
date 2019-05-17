% ASEN 2001 - Lab 3: Composite Beam Bending
%
% Purpose: 
% 
% Given: 
% 
% Assumptions: 
% 
% Authors:
%     Jeffrey Jenkins 
%     Zachary Reynolds
%     Alec Viets
%     Kristyn Sample
%     Syamimah Anwar Deen
% 
% Created: 11/03/2015
% Last modified: 11/05/2015
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Housekepping
clear
clc

%% Read in data
[shear,bending,c,tb,tf] = readIn('Data.xlsx');

%% Calculate max bending and shear forces
% Constants
Ef = 3.0; %GPa
Eb = 3.35; %Gpa

sizeS = size(shear);
taoFail = zeros(sizeS(1),1);
for i = 1:sizeS(1)
    taoFail(i) = (0.75 * shear(i,1))/(shear(i,5));
end

sizeB = size(bending);
sigmaFail = zeros(sizeB(1),1);
for i = 1:sizeB(1)
    Mfail = 0.5 * bending(i,1) * bending(i,2);
    sigmaFail(i) = -(Mfail * c)/(bending(i,6) + (Ef/Eb) * bending(i,7));
end

taoF = mean(taoFail); %psi
sigmaF = mean(sigmaFail); %psi

%% Plot shear and moment diagrams
L = 36; %in
p0 = 0.0831; %psi
xRange = [-L/2,L/2];

syms x

q(x) = 4 * p0 * sqrt(1-(2*x/L)^2); %lb/in

V0 = 0.5 * pi * p0 * L;
V(x) = V0 - int(q,[-L/2,x]); %lb

M(x) = int(V,[-L/2,x]); %lb*in

% Plot functions
close all
figure
ezplot(V,xRange);

figure
ezplot(M,xRange);

%% Computing width function
k = 1.6;

const1 = c*k/(sigmaF*(tb^3/6 + (1/16)*(3/8+1/64)));
wM(x) = -const1 * M(x);

const2 = (3*k)/(2*taoF*tf);
wV(x) = abs(const2 * V(x));

figure
hold on
ezplot(wM/2,[-L/2 L/2]);
ezplot(wV/2,[-L/2 L/2]);
axis([-L/2 L/2 0 3])

%% Wiffle Tree
F = zeros(1,4);
for i = 1:4;
    F(i) = int(q,[-L/2 + (i-1)*(L/8),-L/2 + i*L/8]); %lb
end
F_t = int(q,[-L/2,L/2]);

xbar = zeros(1,4);
for i = 1:4
    xbar(i) = int(x*q,[-L/2 + (i-1)*(L/8),-L/2 + i*L/8])*F(i)^-1; %in
end

%%%
% Vector 'w' consits of the weights of the:
% 1 - loop w/ circle
% 2 - Med bar
% 3 - circle w/ hook
% 4 - Short bar
% 5 - Long bar
% 6 - circle
% 7 - rod
%%%
w(1) = 59.71;
w(2) = 220;
w(3) = 23.5;
w(4) = 120;
w(5) = 340;     % grams
w(6) = 16.2;
w(7) = 28.8;

% Conversion
w = w * 0.00220462; %lb

F(5) = F(1) + F(2) - 2*w(1) - 2*w(3) - w(4); %lb
F(6) = F(3) + F(4) - 2*w(1) - 2*w(3) - w(4); %lb

F(7) = F(5) + F(6) - 2*w(6) - 2*w(3) - w(2); %lb
F(8) = 2*F(7) - 2*w(6) - 3*w(3) - w(5); %lb

% Finding l1
L = 6.125; %[in] small bar
l = xbar(2)-xbar(1); %in
a1 = (L-l)/2
l1 = (a1*(F(1)-w(1)-w(3)) + (L-a1)*(F(2)-w(1)-w(3)) - (L/2)*w(4))/F(5)

% Finding l2
l = xbar(4) - xbar(3);
a2 = (L-l)/2
l2 = (a2*(F(3)-w(1)-w(3)) + (L-a2)*(F(4)-w(1)-w(3)) - (L/2)*w(4))/F(6)

% Finding l3
L = 12.25; %[in] Medium bar
F5pos = xbar(1) + (l1-a1);
F6pos = xbar(3) + (l2-a2);

l = F6pos - F5pos;
a3 = (L-l)/2
l3 = (a3*(F(5)-w(6)-w(3)) + (L-a3)*(F(6)-w(6)-w(3)) - (L/2)*w(2))/F(7)

F7pos = F5pos + (l3-a3);
L = 18.25;
l = F7pos * -2;
a4 = (L-l)/2

ActualFail = 26.25;