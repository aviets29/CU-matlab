function [ t,Th,w,P,N ] = analyze( dt )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global m l g Th0 t0 w0

t(1) = t0;
Th(1) = Th0;
w(1) = w0;
alpha(1) = ((3/2)*(g/l)*sin(Th(1)));
P(1) = m*((l/2)*(alpha(1)*cos(Th(1)) - w(1)^2*sin(Th(1))));
N(1) = m*g + m*((l/2)*(-alpha(1)*sin(Th(1)) - w(1)^2*cos(Th(1))));

on_wall = true;
n = 1;
while on_wall
    t(n+1) = t(n) + dt;
    
    w(n+1) = w(n) + alpha(n)*dt;
    Th(n+1) = Th(n) + w(n)*dt; 
    alpha(n+1) = ((3/2)*(g/l)*sin(Th(n+1)));
    
    P(n+1) = m*((l/2)*(alpha(n+1)*cos(Th(n+1)) - w(n+1)^2*sin(Th(n+1))));
    N(n+1) = m*g + m*((l/2)*(-alpha(n+1)*sin(Th(n+1)) - w(n+1)^2*cos(Th(n+1)))); 

    if P(n+1) <= 0 || N(n+1) <= 0
        on_wall = false;
    end
    n = n + 1;
end
end