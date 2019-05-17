function runTrack()
% function [outs] = runTrack()
clear all; close all; clc;
global h0 g maxG maxD dStep;

h0 = 125;%initial height, in [m]
g = 9.81;%acceleration due to gravity, in [m/s^2]
maxG = struct('fore',5,'back',4,'up',6,'down',1,'lat',3);%maximum G-Forces allowed in each direction
maxD = 1250;%maximum track distance, in [m]
dStep = .05;%incremental distance steps, in [m]

cart = struct('d',[0],'nVec',[0,0,1],'tVec',[1,0,0],...
    'pos',[0,0,h0],'fN',-g,'fT',0,'fL',0);

cart = drop1(cart,h0,85);
cart = semiloop(cart,0,25);
r = 25;
cart = loop(cart,cart.pos(end,3),r);
cart = straight(cart,r,[1,0,0]);
r2 = 20;

cart = bankedTurn(cart,r2);
cart = straight(cart,r2,[-1,0,0]);
r3 = 25;
rho = pi+0.0636;%hardcoded from helix func.
cart.tVec(end,:) = [-1,0,0];
cart = semiloop2(cart,rho,100);
cart = helix(cart,25,r3,2.5);
cart = semiloop(cart,0,100);
cart = straight(cart,r3,[1,0,0]);
r4 = 35;
cart = semiloop(cart,pi/4,r4);
cart = zeroG2(cart);
r5 = 60;
cart = drop1(cart,cart.pos(end,3),(r5-r5/sqrt(2)));
cart = semiloop(cart,0,r5);
cart = braking(cart,cart.pos(end,3),20.919);

figure(1)
plot3(cart.pos(:,1),cart.pos(:,2),cart.pos(:,3));
axis('equal');
title('The Completed Roller Coaster');
xlabel('X-Coordinates');
ylabel('Y-Coordinates');
zlabel('Z-Coordinates');


figure(2)
hold on;
plot(cart.d,(cart.fN/g));
title('G''s in Normal Direction');
xlabel('Distance');
ylabel('G''s');
hold off;

figure(3)
hold on;
plot(cart.d,cart.fT/g);
title('G''s in Tangent Direction');
xlabel('Distance');
ylabel('G''s');
hold off;

figure(4)
hold on;
plot(cart.d,cart.fL/g);
title('G''s in Lateral Direction');
xlabel('Distance');
ylabel('G''s');

hold off;

velocity = (2*g.*(h0-cart.pos(:,3))).^(1/2);
% surf(cart.pos(:,1),cart.pos(:,2),cart.pos(:,3),velocity);


end%function runTrack()