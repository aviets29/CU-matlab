% Alec Viets and Ben Hutchinson
% ASEN 3111
% HW 7
% Additional problem

clear all; close all; clc;

b = 40; % all in ft
cr = 6;
ct = 2;

N = 7;
N = 1:2:N;

% Th = [pi/2 pi/3 pi/4];
% for i = 1:length(N)
%     Th(i) = pi/(N(i)+1);
% end
Th = linspace(.01,pi-.05,length(N));

%Th = [pi/2 pi/3];
RHS = ones(length(N),1)*.15708;
for i = 1:length(N)
    for j = 1:length(N)
        if Th(i) < pi/2 && Th(i) >= 0
            c = cr + (cr - ct)*((-b/2*cos(Th(i)))*2/b);
            A(i,j) = sin(N(j)*Th(i))*(80/(pi*c) + N(j)/sin(Th(i)));
        elseif Th(i) >= pi/2 && Th(i) <= pi
            c = cr - (cr - ct)*((-b/2*cos(Th(i)))*2/b);
            A(i,j) = sin(N(j)*Th(i))*(80/(pi*c) + N(j)/sin(Th(i)));
        else
            A(i,j) = NaN;
        end   
    end
end

A_n = A\RHS;
for i=2:length(N)
    delta(i-1)=N(i)*(A_n(i)/A_n(1))^2;
end
e=1/(1+sum(delta));
