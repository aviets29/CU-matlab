function vecdot = RocketFlight(t,vec)
% function xdot = RocketFlight(t,vec)
% This function calculates the change in the bottle rocket's conditions
% Assumptions: N/A
% Inputs:   t = time
%           vec = vector containing velocity, angle, distance traveled,
%                 height, volume of air, and mass of the rocket and air
% Outputs:  vecdot = vector containing new values of velocity, angle,
%                    distance traveled, height, volume of air, and mass of
%                    the rocket and air
% Author: 71ca431fae68
% Date Created: 11/13/15
% Date Modified: 12/3/15

% define the input values to familiar names
v = vec(1);
theta = vec(2);
x = vec(3);
z = vec(4);
V = vec(5);
mR = vec(6);
mAir = vec(7);

global g Cd Vbottle Pamb gamma rhoH2O Dthroat R PAirI VH2Oi TairI mAirI

% Calculate the area of the throat
Athroat = pi*((Dthroat/2)^2); % m^2

% Calculate the volume of air in the bottle
VairI = Vbottle - VH2Oi; % m^3

% Calculate the forces acting on the rocket
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% force gravity of rocket
Fgravity = mR * g * sin(theta);
% calculate the drag of the rocket
Fdrag = calcDrag(v);

% calculate the air pressure inside the bottle
Pair = ((VairI/V)^gamma)*PAirI; % N/(m^2)

% make sure that nothing is plotted when z < 0
if z<=0
    for i =1:7
        vecdot(i) = 0;
    end
    v = 0;
end

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
        % calculate the specific impulse
        Isp = Fthrust/(mdot*g); % s
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
        Tend = TairI*((VairI/Vbottle)^(gamma-1));
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
        % calculate the specific impulse
        Isp = Fthrust/mdotAir; % s
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

% calculate the change in velocity
dvdt = (Fthrust/mR) - (Fgravity/mR) - (Fdrag/mR);
% calculate the change in angle
if v < 1
    dthetadt = 0;
else
    dthetadt = (-g*cos(theta))/v;
end
% calculate the change in x position
dxdt = v*cos(theta);
% calculate the change in height
dzdt = v*sin(theta);

% store the new velocity, angle, x position, z position, volume of air, and
% mass of the rocket into the return vector
vecdot= zeros(7,1);
vecdot(1) = dvdt;
vecdot(2) = dthetadt;
vecdot(3) = dxdt;
vecdot(4) = dzdt;
vecdot(5) = dVdt;
vecdot(6) = dmRdt;
vecdot(7) = dmAdt;


