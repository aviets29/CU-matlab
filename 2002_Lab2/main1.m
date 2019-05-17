%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Group 8
% Aero lab 2
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

x = [0 .175 .35 .7 1.05 1.4 1.75 2.1 2.8 3.5 2.8 2.1 1.4 1.05 .7 .35 0.175 0];
y = [.14665 .33075 .4018 .476 .49 .4774 .4403 .38325 .21875 0 0 0 0 0 .0014 .0175 .03885 .14665];
c = 3.6;

count4 = 0;
count5 = 0;
count6 = 0;
for k = 1:9                      %Number of sheets
    dummy = sprintf('AirfoilPressure_S012_G0%i.csv',k);
    Data = csvread(dummy,1,0);

    P_atm = Data(:,1);           %[Pa]
    T_atm = Data(:,2);           %[K]
    rho_atm = Data(:,3);         %[kg/m^3]
    V_air = Data(:,4);           %[m/s]
    P_dynamic = Data(:,5);       %[Pa]
    P_dynamicAUX = Data(:,6);    %[Pa]
    Pressure = Data(:,7:22);     %[Pa]
    alpha = Data(:,23);          %[Degrees]
    
    
    for j = 1:9                  %Number of sperate tests
        Cp = zeros(1,18);
        for h = 1:9
            Pressure_new = Pressure((j*20-19):(j*20),h);
            Pressure_mean = mean(Pressure_new);
            P_atm_mean = mean(P_atm((j*20-19):(j*20)));
            P_dynamic_mean = mean(P_dynamic((j*20-19):(j*20)));
            
            Cp(h) = (Pressure_mean)/(P_dynamic_mean);
        end
        
        count3 = 10;
        for h = 11:17
            Pressure_new = Pressure((j*20-19):(j*20),count3);
            Pressure_mean = mean(Pressure_new);
            P_atm_mean = mean(P_atm((j*20-19):(j*20)));
            rho_atm_mean = mean(rho_atm((j*20-19):(j*20)));
            V_air_mean = mean(V_air((j*20-19):(j*20)));
            Cp(h) = mean(2*(Pressure_mean)/(rho_atm_mean*V_air_mean^2));
            count3 = count3 + 1;
        end
        
        Cppred1 = ((Cp(9)-Cp(8))/(x(9)-x(8)))*(x(10)-x(9))+y(9);
        Cppred2 = ((Cp(11)-Cp(12))/(x(11)-x(12)))*(x(10)-x(11))+y(11);
        Cp(10) = (Cppred1+Cppred2)/2;
        Cp(18) = Cp(1);    
        
        Cn_sum = -trapz(x,Cp);
        Ca_sum = trapz(y,Cp);

        if j == 1 || j == 2 || j == 3
            alpha2 = alpha(1);
            if rem(j,3) == 1
                figure;
                a = 'r';
            end
            if rem(j,3) == 2
                a = 'b';
            end
            if rem(j,3) == 0
                a = 'g';
            end
            
            plot(x/c,Cp,sprintf('-o%c',a));
            set(gca,'YDir','reverse');
            hold on
            if rem(j,3) == 0
                title(sprintf('Coefficient of Pressure vs. x/c for alpha = %i', alpha(1)));
                xlabel('x/c [N/A]');
                ylabel('Cp [N/A]');
                legend('10 m/s','20 m/s','30 m/s');
            end
            
        elseif j == 4 || j == 5 || j == 6
            alpha2 = alpha(61);
            if rem(j,3) == 1
                figure;
                a = 'r';
            end
            if rem(j,3) == 2
                a = 'b';
            end
            if rem(j,3) == 0
                a = 'g';
            end
            plot(x/c,Cp,sprintf('-o%c',a));
            set(gca,'YDir','reverse');
            hold on
            if rem(j,3) == 0
                title(sprintf('Coefficient of Pressure vs. x/c for alpha = %i', alpha(61)));
                xlabel('x/c [N/A]');
                ylabel('Cp [N/A]');
                legend('10 m/s','20 m/s','30 m/s');
            end
        else 
            alpha2 = alpha(121);
            if rem(j,3) == 1
                figure;
                a = 'r';
            end
            if rem(j,3) == 2
                a = 'b';
            end
            if rem(j,3) == 0
                a = 'g';
            end
            
            plot(x/c,Cp,sprintf('-o%c',a));
            set(gca,'YDir','reverse');
            hold on
            if rem(j,3) == 0
                title(sprintf('Coefficient of Pressure vs. x/c for alpha = %i', alpha(121)));
                xlabel('x/c [N/A]');
                ylabel('Cp [N/A]');
                legend('10 m/s','20 m/s','30 m/s');
            end
        end
        
        Cl = Cn_sum*cosd(alpha2) - Ca_sum*sind(alpha2);
        Cd = Cn_sum*sind(alpha2) + Ca_sum*cosd(alpha2); 



        if rem(j,3) == 1
            count4 = count4 + 1;
            alpha_10(count4) = alpha2;
            Cl_10(count4) = Cl;
            Cd_10(count4) = Cd;
        elseif rem(j,3) == 2
            count5 = count5 + 1;
            alpha_20(count5) = alpha2;
            Cl_20(count5) = Cl;
            Cd_20(count5) = Cd;
        else
            count6 = count6 + 1;
            alpha_30(count6) = alpha2;
            Cl_30(count6) = Cl;
            Cd_30(count6) = Cd;
        end
    end
end

A(:,1) = alpha_20;
A(:,2) = Cl_20;
A(:,3) = Cd_20;

B = sortrows(A);
%% 
figure;
plot(B(:,1),B(:,2),'-mo','LineWidth',2,...
                'MarkerFaceColor','y');
hold on;
plot(B(:,1),B(:,3),'-mo','LineWidth',2,...
                'MarkerFaceColor','b');

title('Coefficient of Lift and Drag at 20 m/s');
xlabel('alpha [Degrees]');
ylabel('Cl & Cd [N/A]');
legend('Cl','Cd','location','NorthWest');
hold off;

