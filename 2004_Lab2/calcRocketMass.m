function [massRocket, mAir] = calcRocketMass(Vair)
% function mass = calcRocketMass(Vair)
% This function calculates the mass of the rocket
% Assumptions: N/A
% Inputs:   Vair = the volume of air in the bottle
% Outputs:  massRocket = the total mass of the rocket
%           massAir = the mass of the air in the rocket
% Author: 71ca431fae68
% Date Created: 11/13/15
% Date Modified: 12/3/15

global Vbottle rhoH2O R mBottle TairI PAirI 

mH2O = rhoH2O*(Vbottle-Vair); % kg
mAir = (PAirI*Vair)/(R*TairI); % kg

% calculate the mass of the rocket
massRocket = mBottle + mAir + mH2O;

end