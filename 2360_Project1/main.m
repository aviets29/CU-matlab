%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fishing stuff
% Author: Alec Viets
% Created: 2/3/2016
% Last edited: 2/3/2016
%
% Purpose: Create a theoretical model for the amount of fishing allowed in
%          a given season by using growth rates, carrying capacities, and
%          harvest rates.
%
% Algorithm:
% Let p = 1.2 and q = 1
% Let the growth rate, r = 0.65
% Let the carrying capacity for rainbow trout, LRT = 6.1
% Let the carrying capacity for brown trout, LBT = 10.5
% Let the carrying capacity for bass, LB = 20.2
% Define the logistic growth equation
% Plot dy/dt as a function of y
% Use the plot to define equilibrium solutions (dy/dt = 0)
% Find the approximate values of L where the number of equilibria changes
% For the last step, there are 2 bifurcation values
% Use dirfield.m to plot the vector fields for L = 6.1, 10.5, 20.2
% Adjust time interval to view long term behavior

close all;
clc;

p = 1.2;
q = 1;
r = 0.65;

LRT = 6.1;
LBT = 10.5;
LB = 20.2;

y = 0:.0001:25;
ind = 0;
for L = [LRT LBT LB]
    
    dydt = r.*(1-y./L).*y-(p*y.^2)./(q+y.^2);
    
    ind = ind + 1;
    figure(ind)
    plot(y,dydt)
    title(sprintf('dy/dt for L = %f',L));
    xlabel('y')
    ylabel('dy/dt')
end

figure()
fun1 = @(t,x) .65.*(1-x./6.1).*x-(1.2*x.^2)./(1+x.^2);
dirfield(fun1, 0:.5:20,0:.5:20,sprintf('t vs. y for L = %f',LRT));

figure()
fun2 = @(t,x) .65.*(1-x./10.5).*x-(1.2*x.^2)./(1+x.^2);
dirfield(fun2, 0:.5:20,0:.5:20,sprintf('t vs. y for L = %f',LBT));

figure()
fun3 = @(t,x) .65.*(1-x./20.2).*x-(1.2*x.^2)./(1+x.^2);
dirfield(fun3, 0:.5:30,0:.5:20,sprintf('t vs. y for L = %f',LB));

bifurcation = [];
numEQ = 0;
check = 1;

for L = 6.1:.1:20.2
    
    dydt = r.*(1-y./L).*y-(p*y.^2)./(q+y.^2);
    cross = find((abs(diff(sign(dydt)))== 2) | (abs(diff(sign(dydt)))== 1)); 
    
     if length(cross) ~= numEQ
         bifurcation = [bifurcation ; L];
     end
    numEQ = length(cross);
    
    if check
       figure()
    end 
    
    plot(y,dydt)
    title('dy/dt for various L');
    xlabel('y')
    ylabel('dy/dt')
    hold on
    
    check = 0;
end

figure()
h = (p*y.^2)./(q+y.^2);
plot(y,h)
title('Harvest Function Analysis');
xlabel('y')
ylabel('h(y)')