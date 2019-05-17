%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% Create orbit path for earth
% Generate video
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all; clc;

t = 1:365;
t2 = 1:24;
%r_sun = 695700000; %m
%r_earth = 6371000; %m
%a_orbit = 152.1*10^9; %m
%b_orbit = 147.1*10^9; %m

r_sun = 6; %m
r_earth = 1; %m
r_sat = 2; %m
a_orbit = 40; %m
b_orbit = 36; %m

c = sqrt(a_orbit^2-b_orbit^2);

x1 = linspace(a_orbit,-a_orbit,length(t)/2);
x2 = linspace(-a_orbit,a_orbit,length(t)/2);
x_orbit = [x1 x2];
for i = 1:length(x_orbit)
    if i < length(x_orbit)/2
        y_orbit(i) =  b_orbit*sqrt(1-x_orbit(i).^2/a_orbit^2);
    else
        y_orbit(i) =  -b_orbit*sqrt(1-x_orbit(i).^2/a_orbit^2);
    end
end

x3 = linspace(-r_rat,r_sat,length(t)/2);
x4 = linspace(r_rat,-r_sat,length(t)/2);
x_sat = [x3 x4];
for i = 1:length(x_sat)
    if i < length(x_sat)/2
        y_sat(i) =  sqrt(r_sat^2-x_sat(i).^2);
    else
        y_sat(i) =  -sqrt(r_sat^2-x_sat(i).^2);
    end
end

z_sat = zeros(length(x_sat),1);

for i = 1:length(x_orbit)
    earth_y(i) = y_orbit(i);
    earth_r(i) = sqrt(x_orbit(i)^2 + earth_y(i)^2);
    
    [x,y,z] = sphere;
    surf(x*r_sun-c, y*r_sun, z*r_sun);
    hold on
    surf(x*r_earth+x_orbit(i), y*r_earth+earth_y(i), z*r_earth);
    axis equal;
    plot(x_orbit,y_orbit);
    
    xlabel('x distance [m]')
    ylabel('y distance [m]')

    M(i) = getframe(gcf);
    hold off
end

%fps = length(t)/t(end);
movie2avi(M,'orbit_video.avi');
