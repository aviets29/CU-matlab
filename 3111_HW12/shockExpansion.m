%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111
% HW 12
% shockExpansion.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c_l,c_d] = shockExpansion(M,alpha,epsilon)

gamma = 1.4;

if alpha >= 0 && alpha < epsilon
    theta1 = epsilon - alpha; % Oblique shock realtion
    [p1_pinf,M1] = obliqueShoch(M,theta1);
    
    theta2 = 2*epsilon; % Expansion fan method
    [p2_p1,M2] = expFan(M1,theta2);
    p2_pinf = p2_p1*p1_pinf;
    
    theta3 = epsilon + alpha; % Oblique shock realtion
    [p3_pinf,M3] = obliqueShoch(M,theta3);
    
    theta4 = 2*epsilon; % Expansion fan method
    [p4_p3,M4] = expFan(M3,theta4);
    p4_pinf = p4_p3*p3_pinf;
    
elseif alpha == epsilon
    theta1 = 0;
    p1_pinf = 1; M1 = M;
    
    theta2 = 2*epsilon; % Expansion fan method
    [p2_p1,M2] = expFan(M1,theta2);
    p2_pinf = p2_p1*p1_pinf;
    
    theta3 = 2*epsilon; % Oblique shock realtion
    [p3_pinf,M3] = obliqueShoch(M,theta3);
    
    theta4 = 2*epsilon; % Expansion fan method
    [p4_p3,M4] = expFan(M3,theta4);
    p4_pinf = p4_p3*p3_pinf;
    
elseif alpha > epsilon
    theta1 = alpha - epsilon; % Expansion fan method
    [p1_pinf,M1] = expFan(M,theta1);
    
    theta2 = 2*epsilon; % Expansion fan method
    [p2_p1,M2] = expFan(M1,theta2);
    p2_pinf = p2_p1*p1_pinf;
    
    theta3 = alpha + epsilon; % Oblique shock realtion
    [p3_pinf,M3] = obliqueShoch(M,theta3);
    
    theta4 = 2*epsilon; % Expansion fan method
    [p4_p3,M4] = expFan(M3,theta4);
    p4_pinf = p4_p3*p3_pinf;
end

c_n = 1/(gamma*M^2)*( - p2_pinf + p3_pinf + p4_pinf - p1_pinf);
c_a =  1/(gamma*M^2)*(p1_pinf - p2_pinf + p3_pinf - p4_pinf)*tand(epsilon);

c_l = c_n*cosd(alpha) - c_a*sind(alpha);
c_d = c_n*sind(alpha) + c_a*cosd(alpha);
end

