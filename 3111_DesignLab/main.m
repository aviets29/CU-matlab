%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111 Design Lab
% RANS Turbulent Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all; clc;

%% Load in data
filename = 'Data.csv';
delimiter = ',';
endRow = 44;
formatSpec = '%f%f%f%f%f%f%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
data = textscan(fileID, formatSpec, endRow, 'Delimiter', delimiter, 'ReturnOnError', false);

fclose(fileID);

%% Analyze 0012
alpha_0012 = data{1}(1:23);
cl_0012 = data{8}(1:23);
cd_0012 = data{9}(1:23);

max_cl_ind = find(max(cl_0012) == cl_0012,1);
min_cl_ind = find(min(cl_0012) == cl_0012,1);

max_cl_0012 = max(cl_0012);
alpha_stall_0012 = alpha_0012(max_cl_ind);

p_0012 = polyfit(alpha_0012(10:14)*pi/180,cl_0012(10:14),1);
liftslope_0012 = p_0012(1);
alpha_0_0012 = -(180/pi)*p_0012(2)/p_0012(1);

figure()
plot(alpha_0012,cl_0012);
hold on;
scatter(alpha_0012,cl_0012);
title('c_l vs. \alpha plot for NACA 0012 using RANS Turbulent Model')
xlabel('\alpha [deg]');
ylabel('c_l [n/a]');

figure()
plot(alpha_0012,cd_0012);
hold on;
scatter(alpha_0012,cd_0012);
title('c_d vs. \alpha plot for NACA 0012 using RANS Turbulent Model')
xlabel('\alpha [deg]');
ylabel('c_d [n/a]');

figure()
plot(cl_0012(min_cl_ind:max_cl_ind),cd_0012(min_cl_ind:max_cl_ind));
hold on;
scatter(cl_0012(min_cl_ind:max_cl_ind),cd_0012(min_cl_ind:max_cl_ind));
title('c_d vs. c_l plot for NACA 0012 using RANS Turbulent Model');
xlabel('c_l [n/a]');
ylabel('c_d [n/a]');

%% Compare 0012 from ANSYS to Vortex Panel Method

N = 50;
alpha_range = pi/180*(-18:4:18);
for j = 1:length(alpha_range)
    [x(:,j),y(:,j)] = Naca_Airfoil(0,0,12/100,1,N);
    [cp_1_x(:,j),Cp_1(:,j),cl_1(j)] = Vortex_Panel(x(:,j),y(:,j),1,alpha_range(j));
end

poly = polyfit(alpha_range,cl_1,1);
cl_line = poly(1)*alpha_range + poly(2);

liftslope_vortex_0012 = poly(1);
alpha_0_vortex_0012 = -(180/pi)*poly(2)/poly(1);

%% Compare 0012 from ANSYS to PLLT

alpha_range = pi/180*(-18:4:18);
cl_line_pllt = 2*pi*alpha_range;

liftslope_pllt_0012 = 2*pi;
alpha_0_pllt_0012 = 0;

%% Plot Comparison for 0012
figure()
scatter(alpha_range*180/pi,cl_1,('o'));
hold on
plot(alpha_range*180/pi,cl_line);
scatter(alpha_range*180/pi,cl_line_pllt,'s');
plot(alpha_range*180/pi,cl_line_pllt);
scatter(alpha_0012,cl_0012,'d');
plot(alpha_0012,cl_0012);
title('C_l comparison (ANSYS, Vortex Panel Method, and PLLT) for NACA 0012');
xlabel('\alpha [degrees]');
ylabel('C_l [n/a]');
legend('Vortex Data','Vortex Fit','PLLT Data','PLLT Fit','ANSYS Data', ...
       'ANSYS Fit','Location','Southeast');
xlim([min(alpha_0012) max(alpha_0012)]);
grid on
hold off;

%% Analyze 4412
alpha_4412 = data{1}(24:end);
cl_4412 = data{8}(24:end);
cd_4412 = data{9}(24:end);

max_cl_ind_4412 = find(max(cl_4412) == cl_4412,1);
min_cl_ind_4412 = find(min(cl_4412) == cl_4412,1);

max_cl_4412 = max(cl_4412);
alpha_stall_4412 = alpha_4412(max_cl_ind_4412);

figure()
plot(alpha_4412,cl_4412);
hold on;
scatter(alpha_4412,cl_4412);
title('c_l vs. \alpha plot for NACA 4412 using RANS Turbulent Model')
xlabel('\alpha [deg]');
ylabel('c_l [n/a]');

figure()
plot(alpha_4412,cd_4412);
hold on;
scatter(alpha_4412,cd_4412);
title('c_d vs. \alpha plot for NACA 4412 using RANS Turbulent Model')
xlabel('\alpha [deg]');
ylabel('c_d [n/a]');

figure()
plot(cl_4412(min_cl_ind_4412:max_cl_ind_4412),cd_4412(min_cl_ind_4412:max_cl_ind_4412));
hold on;
scatter(cl_4412(min_cl_ind_4412:max_cl_ind_4412),cd_4412(min_cl_ind_4412:max_cl_ind_4412));
title('c_l vs. c_d plot for NACA 0012 using RANS Turbulent Model');
xlabel('c_l [n/a]');
ylabel('c_d [n/a]');

p_4412 = polyfit(alpha_4412(6:10)*pi/180,cl_4412(6:10),1);
liftslope_4412 = p_4412(1);
alpha_0_4412 = -(180/pi)*p_4412(2)/p_4412(1);

%% Compare 4412 from ANSYS to Vortex Panel Method

N = 50;
alpha_range = pi/180*(-12:4:20);
for j = 1:length(alpha_range)
    [x(:,j),y(:,j)] = Naca_Airfoil(4/100,4/10,12/100,1,N);
    [cp_1_x(:,j),Cp_1(:,j),cl_2(j)] = Vortex_Panel(x(:,j),y(:,j),1,alpha_range(j));
end

poly = polyfit(alpha_range,cl_2,1);
cl_line = poly(1)*alpha_range + poly(2);

liftslope_vortex_4412 = poly(1);
alpha_0_vortex_4412 = -(180/pi)*poly(2)/poly(1);

%% Compare 4412 from ANSYS to PLLT

alpha_range = pi/180*(-12:4:20);

liftslope_pllt_4412 = 2*pi;
alpha_0_pllt_4412 = -4.15;
cl_line_pllt = liftslope_pllt_4412*alpha_range - liftslope_pllt_4412*(pi/180)*alpha_0_pllt_4412;

%% Plot Comparison for 4412
figure()
scatter(alpha_range*180/pi,cl_2,'o');
hold on
plot(alpha_range*180/pi,cl_line);
scatter(alpha_range*180/pi,cl_line_pllt,'s');
plot(alpha_range*180/pi,cl_line_pllt);
scatter(alpha_4412,cl_4412,'d');
plot(alpha_4412,cl_4412);
title('C_l comparison (ANSYS, Vortex Panel Method, and PLLT) for NACA 4412');
xlabel('\alpha [degrees]');
ylabel('C_l [n/a]');
legend('Vortex Data','Vortex Fit','PLLT Data','PLLT Fit','ANSYS Data', ...
       'ANSYS Fit','Location','Southeast');
xlim([min(alpha_4412) max(alpha_4412)]);
grid on
hold off;

%% Print results from ANSYS data
fprintf('===================== ANSYS =====================\n');
fprintf('Airfoil\t\tMax Cl\t\tStall Angle\t\tLift Slope\t\tAlpha, L=0\n');
fprintf('0012\t\t%.2f\t\t%.2f\t\t\t%.2f pi\t\t\t%.2f\n',max_cl_0012,alpha_stall_0012,liftslope_0012/pi,alpha_0_0012);
fprintf('4412\t\t%.2f\t\t%.2f\t\t\t%.2f pi\t\t\t%.2f\n\n',max_cl_4412,alpha_stall_4412,liftslope_4412/pi,alpha_0_4412);

%% Print PLLT
fprintf('================= Thin Airfoil ==================\n');
fprintf('Airfoil\t\tMax Cl\t\tStall Angle\t\tLift Slope\t\tAlpha, L=0\n');
fprintf('0012\t\tn/a\t\t\tn/a\t\t\t\t%.2f pi\t\t\t%.2f\n',liftslope_pllt_0012/pi,alpha_0_pllt_0012);
fprintf('4412\t\tn/a\t\t\tn/a\t\t\t\t%.2f pi\t\t\t%.2f\n',liftslope_pllt_4412/pi,alpha_0_pllt_4412);

%% Print Vortex Panel Data
fprintf('================= Vortex Panel ==================\n');
fprintf('Airfoil\t\tMax Cl\t\tStall Angle\t\tLift Slope\t\tAlpha, L=0\n');
fprintf('0012\t\tn/a\t\t\tn/a\t\t\t\t%.2f pi\t\t\t%.2f\n',liftslope_vortex_0012/pi,alpha_0_vortex_0012);
fprintf('4412\t\tn/a\t\t\tn/a\t\t\t\t%.2f pi\t\t\t%.2f\n\n',liftslope_vortex_4412/pi,alpha_0_vortex_4412);

%% NACA 4412 Experimental
EXP4412_alpha = [-20 -16 -12 -8 -6 -4 -2 0 2 4 8 12 16 18 20 24 30];
EXP4412_Cl = [-0.545 -.742 -.732 -.374 -.211 -.0255 .146 .338 .501 .677 1.024 1.289 1.579 1.671 1.690 1.182 .913];
EXP4412_Cn = [-.592 -.767 -.722 -.372 -.210 -.0256 .146 .338 .501 .677 1.020 1.275 1.548 1.626 1.640 1.212 1.009];
EXP4412_Ca = [0.0318 -.0170 -.1264 -.0445 -.0151 .0043 .0107 .0098 -.0034 -.0258 -.1003 -.2043 -.3357 -.4040 -.4374 -.1838 -.0776];
EXP4412_Cd = [];
EXP4412_Cl2 = [];

for i = 1:length(EXP4412_alpha)
    EXP4412_Cd(i) = (EXP4412_Cn(i)*sind(EXP4412_alpha(i)) + EXP4412_Ca(i)*cosd(EXP4412_alpha(i)));
    EXP4412_Cl2(i) = (EXP4412_Cn(i)*cosd(EXP4412_alpha(i)) - EXP4412_Ca(i)*sind(EXP4412_alpha(i)));
end


%% NACA 0012 Experimental
EXP0012_alpha = [-4.04 -2.14 -.05 2.05 4.04 6.09 8.30 10.12 11.13 12.12 13.08 14.22 15.26 16.30 17.13 18.02 19.08];
EXP0012_Cl = [-.4417 -.2385 -.0126 .2125 .4136 .6546 .8873 1.0707 1.1685 1.2605 1.3455 1.4365 1.5129 1.5739 1.6116 .9967 1.1358];
EXP0012_Cd = [.00871 .00800 .00809 .00816 .00823 .00885 .01050 .01201 .01239 .01332 .01503 .01625 .01900 .02218 .02560 .18785 .27292];
