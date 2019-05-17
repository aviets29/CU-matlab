function [vLandingModel, vLanding] = landSpeed(rho,CL,model)

% define meter to ft conversion
m2ft = 3.28084; % ft
% F16 clean
if model == 1
    scale = 48;
    S = 27.87 * m2ft^2;  % ft
    c = 3.05 * m2ft; % ft
    W = 30000; %lbs
    % http://www.lockheedmartin.com/us/products/f16/F-16Specifications.html
    % scale the F16 wing area & mean chord line
    Ss = S/scale^2;
    cs = c/scale;
    Ws = W/scale^3;
    landingFactor = 1.2;
% F16 Dirty
elseif model == 2
    scale = 48;
    S = 27.87 * m2ft^2;  % ft
    c = 3.05 * m2ft; % ft
    W = 37500 * 0.97; % lbs consider some loss of fuel from original takeoff
    Ss = S/scale^2;
    cs = c/scale;
    Ws = W/scale^3;
    landingFactor = 1.2;
% 787
else
    scale = 225;
    S = 325 * m2ft; %ft^2
    c = 8.05 * m2ft; % ft
    W = 360000; % lb
    Ss = S/scale^2;
    cs = c/scale;
    Ws = W/scale^3;
    landingFactor = 1.3;
end

% find the index of the max lift coeffcient
[CLmax,i] = max(CL);
% calculate the stall speed
vStallModel = sqrt((2*Ws)./(rho(i).*Ss.*CLmax));
vStall = sqrt((2*W)./(rho(i).*S.*CLmax));
% calculate vLanding
vLanding = landingFactor*vStall;
vLandingModel = landingFactor*vStallModel;