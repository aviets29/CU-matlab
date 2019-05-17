function vecdot = RocketFlightThermo(t,vec)
% function xdot = RocketFlight(t,vec)
% This function calculates the change in the bottle rocket's conditions
% Assumptions: N/A
% Inputs:   t = time
%           vec = vector containing velocity, angle, distance traveled,
%                 height, volume of air, and mass of the rocket and air
% Outputs:  vecdot = vector containing new values of velocity, angle,
%                    distance traveled, height, volume of air, and mass of
%                    the rocket and air
% Author: Edward Zuzula
% Date Created: 11/13/15
% Date Modefied: 4/4/16
% Modefied for ASEN 2004 Vehicle Design Lab

% define the input values to familiar names
v = vec(1:3);
theta = vec(4);
x = vec(5);
y = vec(6);
z = vec(7);
V = vec(8);
mR = vec(9);
mAir = vec(10);


global g Cd Vbottle Pamb gamma rhoH2O Dthroat R PAirI VH2Oi mAirI vWind

% Calculate the area of the throat
Athroat = pi*((Dthroat/2)^2); % m^2
% Calculate the volume of air in the bottle
VairI = Vbottle - VH2Oi; % m^3

% Calculate the forces acting on the rocket
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% force gravity of rocket
Fgravity = mR * g ;%* sin(theta);
% calculate the drag of the rocket
vRel = v - vWind;
vRelN = norm(vRel);
Fdrag = calcDrag(vRelN);

% calculate the air pressure inside the bottle
Pair = ((VairI/V)^gamma)*PAirI; % N/(m^2)



% Check to get in phase 1 and phase 2
if (Pair > Pamb)
    % Phase 1: Before water is exhausted (mAir = const.)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if V < Vbottle
        % calculate the exit velocity
        ve = sqrt((2*(Pair-Pamb))/rhoH2O); % m/s
        % calculate the mass flow rate
        mdot = Cd*rhoH2O*Athroat*ve; % kg/s
        % calculate the thrust
        Fthrust = mdot*ve; % N
        % calculate the change in volume of air
        dVdt = Cd*Athroat*ve;
        % calculate the change in mass
        dmRdt = -mdot;
        dmAdt = 0;
        
    % Phase 2: After water is exhausted and before air is exhausted
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else
        % calculate the end pressure and temperature of the air in the bottle
        Pend = PAirI*((VairI/Vbottle)^gamma);
        % Calculate the pressure, density, and temperatur of the air
        P = ((mAir/mAirI)^gamma)*Pend; % Pa
        rho = mAir/Vbottle; % kg/(m^3)
        T = P/(rho*R); % K
        % calculate the critical pressure
        Pcr = P*((2/(gamma+1))^(gamma/(gamma-1))); % Pa
        
        % check to see if flow is choked
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % if flow is choked
        if Pcr > Pamb
            % calculate exit temperature, pressure, and density
            Pe = Pcr; % Pa
            Te = (2/(gamma+1))*T; % K
            rhoe = Pe/(R*Te); % kg/(m^3)
            % calculate the exit velocity
            ve = sqrt(gamma*R*Te);
            % if flow is not choked
        elseif Pcr <= Pamb
            % calculate exit temperature, pressure, mach #, and density
            Pe = Pamb; % Pa
            Me = sqrt(((P/Pamb)^((gamma-1)/gamma)-1)*(2/(gamma-1)));
            Te = (1+((gamma-1)/2)*(Me^2))*T; % K
            rhoe = Pamb/(R*Te); % kg/(m^3)
            % calculate the exit velocity
            ve = Me*sqrt(gamma*R*Te); % m/s
        end
        
        % calculate the mass flow of the air
        mdotAir = Cd*rhoe*Athroat*ve; % kg/s
        % calculate the thrust
        Fthrust = (mdotAir*ve)+((Pe-Pamb)*Athroat); % N
        % calculate the change in mass
        dmRdt = -mdotAir;
        dmAdt = -mdotAir;
        % calculate the change in volume of air
        dVdt = Cd*Athroat*ve;
    end
% Phase 3: No thrust
%%%%%%%%%%%%%%%%%%%%
else
    % No thrust and no change in mass and volume
    Fthrust = 0;
    dmRdt = 0;
    dmAdt = 0;
    dVdt = 0;
end

% calculate the change in angle
if norm([x;y;z]) < 1 
    dthetadt = 0;
    heading = [cos(theta);0;sin(theta)];
else
    dthetadt = (-g*cos(theta))/norm(v);
    heading = vRel./vRelN;
end

% calculate the change in velocity
dvxdt = ((Fthrust/mR) - (Fdrag/mR)).*heading(1);
dvydt = ((Fthrust/mR) - (Fdrag/mR)).*heading(2);
dvzdt = ((Fthrust/mR) - (Fdrag/mR)).*heading(3) - (Fgravity/mR);

% calculate the change in x position
dxdt = vRel(1);
% calc the change in y position
dydt = vRel(2);
% calculate the change in height
dzdt = vRel(3);

% store the new velocity, angle, x position, z position, volume of air, and
% mass of the rocket into the return vector
vecdot= zeros(10,1);
vecdot(1) = dvxdt;
vecdot(2) = dvydt;
vecdot(3) = dvzdt;
vecdot(4) = dthetadt;
vecdot(5) = dxdt;
vecdot(6) = dydt;
vecdot(7) = dzdt;
vecdot(8) = dVdt;
vecdot(9) = dmRdt;
vecdot(10) = dmAdt;

% make sure that nothing is plotted when z < 0
if z<=0
    vecdot = zeros(1,10);
end



