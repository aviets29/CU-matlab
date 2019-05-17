function vecdot = RocketFlightInterpolation(t,vec)

global g thetaI vWind thrust time t_h20_to_air rhoH2O rhoAirAmb 

% define other constants
Dthroat = 2.1/100; % m

% define the input values to familiar names
v = vec(1:3);
x = vec(4);
y = vec(5);
z = vec(6);
m = vec(7);


% check to see if still on the launch rail
if norm([x y z]) < 1
   heading = [cos(thetaI); 0; sin(thetaI)];
   % gravity doesnt act on the rocket
   Fgravity = 0;   
% if not on the rail
else
    % define heading
    v = v - vWind;
    heading = v./norm(v);
    % force gravity of rocket
    Fgravity = m * g;   
end
% calculate the norm of the velocity
vRel = norm(v);
% calculate the thrust
if t < time(end);
    Fthrust = interp1(time,thrust,t);
    % if thrusting with water
    if t < t_h20_to_air
        rho = rhoH2O;
    else
        rho = rhoAirAmb;
    end 
else
    Fthrust = 0;
    rho = 0.01;
end

% calculate the drag
Fdrag = calcDrag(vRel);

% calculate the change in velocity
dvxdt = ((Fthrust/m)-(Fdrag/m)).*heading(1);
dvydt = ((Fthrust/m)-(Fdrag/m)).*heading(2);
dvzdt = -Fgravity/m + (((Fthrust/m)-(Fdrag/m)).*heading(3));

% calculate the change in x position
dxdt = v(1);
% calc the change in y position
dydt = v(2);
% calculate the change in height
dzdt = v(3);

% calculate area
area = pi*(Dthroat/2)^2;
% calculate the exit velocity
ve = sqrt(abs(Fthrust)/(rho*area));
% calculate mdot
mdot = -rho*area*ve;

% store the new velocity, angle, x position, z position, volume of air, and
% mass of the rocket into the return vector
vecdot = zeros(7,1);
vecdot(1) = dvxdt;
vecdot(2) = dvydt;
vecdot(3) = dvzdt;
vecdot(4) = dxdt;
vecdot(5) = dydt;
vecdot(6) = dzdt;
vecdot(7) = mdot;

% make sure that nothing is plotted when z < 0
if z<=0
    for i =1:7
        vecdot(i) = 0;       
    end
end