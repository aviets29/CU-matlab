function vecdot = RocketFlightISP(t,vec)

global mDry thetaI rhoAirAmb Dbottle CD vWind
g = 9.8; %m/s^2

% define the input values to familiar names
v = vec(1:3);
x = vec(4);
y = vec(5);
z = vec(6);

if norm([x y z]) < 1
   heading = [cos(thetaI); 0; sin(thetaI)];
else
    % define heading
    v = v - vWind';
    heading = v./norm(v);
end

% Calculate the forces acting on the rocket
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% force gravity of rocket
Fgravity = mDry * g;
% calculate the drag of the rocket
vRel = norm(v);
% calculate the area of the bottle
A = pi*(Dbottle/2)^2; % m^2
% calculate the dynamic pressure acting on the rocket
q = (rhoAirAmb*(vRel^2))/2; % Pa = N/(m^2)
% calculate the drag
Fdrag = q*CD*A; % N

% calculate the change in velocity
dvxdt = -(Fdrag/mDry).*heading(1);
dvydt = -(Fdrag/mDry).*heading(2);
dvzdt = -Fgravity/mDry - (Fdrag/mDry).*heading(3);

% calculate the change in x position
dxdt = v(1);
% calc the change in y position
dydt = v(2);
% calculate the change in height
dzdt = v(3);

% store the new velocity, angle, x position, z position, volume of air, and
% mass of the rocket into the return vector
vecdot = zeros(6,1);
vecdot(1) = dvxdt;
vecdot(2) = dvydt;
vecdot(3) = dvzdt;
vecdot(4) = dxdt;
vecdot(5) = dydt;
vecdot(6) = dzdt;

% make sure that nothing is plotted when z < 0
if z<=0
    vecdot = zeros(1,6);
end