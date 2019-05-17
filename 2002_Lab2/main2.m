% Set the Coordinates and plot the geometry of the Clark Y14 Airfoil
% profile with the pressure port locations

clear all, close all, clc

%% Set the Clark Y14 Profile
% The Airfoil coordinates in % Chord
x = [100, 95, 90, 80, 70, 60, 50, 40, 30, 20, 15, 10, 7.5, 5, 2.5, 1.25, 0 1.25, 2.5, 5, 7.5 10, 15, 20, 30, 40, 50, 60, 70, 80, 90, 95, 100];
y = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0.04, 0.18, 0.5, 0.75, 1.11, 1.76, 2.31, 4.19, 6.52, 7.78, 9.45, 10.59, 11.48, 12.79, 13.6, 14, 13.64, 12.59, 10.95, 8.8, 6.25, 3.35, 1.78, 0.14];

c = 3.5; %Chord in Inches

% Scale the Profile for the chord length given
x_scaled = c*x/100;
y_scaled = c*y/100;

%% Set the Pressure Port Locations
% The Pressure Ports coordinates in % Chord
xpp = [0, 5, 10, 20, 30, 40, 50, 60, 70, 80, 80, 70, 60, 50, 40, 30, 20, 10, 5];
ypp = [4.19, 9.45, 11.48, 13.6, 14, 13.64, 12.58, 10.95, 8.8, 6.25, 0, 0, 0, 0, 0, 0, 0.04, 0.5, 1.11];

% Outline the pressure ports that are being skipped
xpp_skip = [70, 70, 50];
ypp_skip = [8.8, 0, 0];

% Scale the port locations for the chord length given
xpp_scaled = c*xpp/100;
ypp_scaled = c*ypp/100;
xpp_skipscaled = c*xpp_skip/100;
ypp_skipscaled = c*ypp_skip/100;

%% Plot the Airfoil Geometry

figure('Name','Clark Y-14 Airfoil Geometry','Position',[100, 100, 1000, 500])
plot(x_scaled, y_scaled, '-k')
hold all
plot(xpp_scaled, ypp_scaled, 'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
plot(xpp_skipscaled,ypp_skipscaled,'x','MarkerEdgeColor','k','MarkerSize',20);
plot([3.5], [0], 'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',10);
axis equal
xlim([0 3.5]);
ylim([-0.5 1]);
grid on
xlabel('x [in]');
ylabel('y [in]');
title('Clark Y-14 Airfoil');

%% Plot Cp and Cl/Cd
dummy = 'AirfoilPressure_S012_G01.csv';
Data = csvread(dummy,1,0);

P_atm = Data(:,1);           %[Pa]
T_atm = Data(:,2);           %[K]
rho_atm = Data(:,3);         %[kg/m^3]
V_air = Data(:,4);           %[m/s]
P_dynamic = Data(:,5);       %[Pa]
P_dynamicAUX = Data(:,6);    %[Pa]
Pressure = Data(:,7:22);     %[Pa]
alpha = Data(:,23);          %[Degrees]

x = [0 .175 .35 .7 1.05 1.4 1.75 2.1 2.8 3.5 2.8 2.1 1.4 1.05 .7 .35 0.175];
y = [.14665 .33075 .4018 .476 .49 .4774 .4403 .38325 .21875 0 0 0 0 0 .0014 .0175 .03885];
c = 3.6;

for i = 1:16
    Xdelta(i) = x(i+1)-x(i);
    Ydelta(i) = y(i+1)-y(i);
end

for j = 1:9
for h = 1:9
    Pressure_new = Pressure((j*20-19):(j*20),h);
    Pressure_mean = mean(Pressure_new);
    P_atm_mean = mean(P_atm((j*20-19):(j*20)));
    rho_atm_mean = mean(rho_atm((j*20-19):(j*20)));
    V_air_mean = mean(V_air((j*20-19):(j*20)));
    Cp(h) = mean(2*(Pressure_mean)/(rho_atm_mean*V_air_mean));
end

count3 = 10;
for h = 11:17
    Pressure_new = Pressure((j*20-19):(j*20),count3);
    Pressure_mean = mean(Pressure_new);
    P_atm_mean = mean(P_atm((j*20-19):(j*20)));
    rho_atm_mean = mean(rho_atm((j*20-19):(j*20)));
    V_air_mean = mean(V_air((j*20-19):(j*20)));
    Cp(h) = mean(2*(Pressure_mean)/(rho_atm_mean*V_air_mean));
    count3 = count3 + 1;
end

Cppred1 = ((Cp(9)-Cp(8))/(x(9)-x(8)))*(x(10)-x(9))+y(9);
Cppred2 = ((Cp(11)-Cp(12))/(x(11)-x(12)))*(x(10)-x(11))+y(11);
Cp(10) = (Cppred1+Cppred2)/2;
end

figure;
plot(x,Cp);
hold all
plot(x_scaled, y_scaled, '-k')


plot(xpp_scaled, ypp_scaled, 'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
plot(xpp_skipscaled,ypp_skipscaled,'x','MarkerEdgeColor','k','MarkerSize',20);
plot([3.5], [0], 'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',10);
