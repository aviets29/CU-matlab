function drag = calcDrag(velocity)
% function drag = calcDrag(velocity)
% This function calculates the drag force acting on a rocket
% Assumptions: N/A
% Inputs:   velocity = the velocity of the rockets
% Outputs:  drag = the drag force acting on the rocket
% Author: 71ca431fae68
% Date Created: 11/14/15
% Date Modified: 11/29/15

global rhoAirAmb Dbottle CD

% calculate the area of the bottle
A = pi*(Dbottle/2)^2; % m^2
% calculate the dynamic pressure acting on the rocket
q = (rhoAirAmb*(velocity^2))/2; % Pa = N/(m^2)
% calculate the drag
drag = q*CD*A; % N

end