%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Group 2
% Vehicle Design Lab 1
% Spring 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [F16_Clean_Avg, F16_Clean_Sigma_Avg, ...
          F16_Dirty_Avg, F16_Dirty_Sigma_Avg, ...
          B787_Avg, B787_Sigma_Avg] = readIn()

format long g;

F16_Clean = zeros(30,8,4);
F16_Clean_Sigma = zeros(30,8,4);
F16_Clean_Zero_Avg = zeros(30,8);
F16_Clean_25_Avg = zeros(30,8);
F16_Clean_Zero_Sigma_Avg = zeros(30,8);
F16_Clean_25_Sigma_Avg = zeros(30,8);

F16_Dirty = zeros(30,8,4);
F16_Dirty_Sigma = zeros(30,8,4);
F16_Dirty_Zero_Avg = zeros(30,8);
F16_Dirty_25_Avg = zeros(30,8);
F16_Dirty_Zero_Sigma_Avg = zeros(30,8);
F16_Dirty_25_Sigma_Avg = zeros(30,8);

B787 = zeros(30,8,4);
B787_Sigma = zeros(30,8,4);
B787_Zero_Avg = zeros(30,8);
B787_25_Avg = zeros(30,8);
B787_Zero_Sigma_Avg = zeros(30,8);
B787_25_Sigma_Avg = zeros(30,8);

for k = 1:4                    %CHANGE THIS
    
    dummy = sprintf('F16_CLEAN_G0%i.csv',k);
    Data = csvread(dummy,1,0);
    
    P_atm = Data(:,1);           %[Pa]
    T_atm = Data(:,2);           %[K]
    rho_atm = Data(:,3);         %[kg/m^3]
    V_air = Data(:,4);           %[m/s]
    alpha = Data(:,23);          %[Degrees]
    F_N = Data(:,24);            %[N]
	F_A = Data(:,25);            %[N]
    Moment = Data(:,26);         %[N*m]
    
    ind = 1;
    for j = 1:20:600
        F16_Clean(ind,1,k) = mean(P_atm(j:j+1));
        F16_Clean(ind,2,k) = mean(T_atm(j:j+1));
        F16_Clean(ind,3,k) = mean(rho_atm(j:j+1));
        F16_Clean(ind,4,k) = mean(V_air(j:j+1));
        F16_Clean(ind,5,k) = mean(alpha(j:j+1));
        F16_Clean(ind,6,k) = mean(F_N(j:j+1));
        F16_Clean(ind,7,k) = mean(F_A(j:j+1));
        F16_Clean(ind,8,k) = mean(Moment(j:j+1));
        
        F16_Clean_Sigma(ind,1,k) = StdDeviation(P_atm(j:j+1));
        F16_Clean_Sigma(ind,2,k) = StdDeviation(T_atm(j:j+1));
        F16_Clean_Sigma(ind,3,k) = StdDeviation(rho_atm(j:j+1));
        F16_Clean_Sigma(ind,4,k) = StdDeviation(V_air(j:j+1));
        F16_Clean_Sigma(ind,5,k) = StdDeviation(alpha(j:j+1));
        F16_Clean_Sigma(ind,6,k) = StdDeviation(F_N(j:j+1));
        F16_Clean_Sigma(ind,7,k) = StdDeviation(F_A(j:j+1));
        F16_Clean_Sigma(ind,8,k) = StdDeviation(Moment(j:j+1));
        
        ind = ind + 1;
    end
end
% v = 0m/s
F16_Clean_Zero_Avg = [.5*(F16_Clean(1:15,:,1)+F16_Clean(1:15,:,3)) ; .5*(F16_Clean(1:15,:,2)+F16_Clean(1:15,:,4))];
% v = 25 m/s
F16_Clean_25_Avg = [.5*(F16_Clean(16:30,:,1)+F16_Clean(16:30,:,3)) ; .5*(F16_Clean(16:30,:,2)+F16_Clean(16:30,:,4))];

F16_Clean_Zero_Sigma_Avg = [.5.*(F16_Clean_Sigma(1:15,:,1)+F16_Clean_Sigma(1:15,:,3)) ; .5*(F16_Clean_Sigma(1:15,:,2)+F16_Clean_Sigma(1:15,:,4))];
F16_Clean_25_Sigma_Avg = [.5*(F16_Clean_Sigma(16:30,:,1)+F16_Clean_Sigma(16:30,:,3)) ; .5*(F16_Clean_Sigma(16:30,:,2)+F16_Clean_Sigma(16:30,:,4))];

F16_Clean_Avg = [F16_Clean_25_Avg(:,1:5) (F16_Clean_25_Avg(:,6:8)-F16_Clean_Zero_Avg(:,6:8))];
vars = sqrt(F16_Clean_25_Avg(:,6:8).^2.*F16_Clean_25_Sigma_Avg(:,6:8).^2 + F16_Clean_Zero_Avg(:,6:8).^2.*F16_Clean_Zero_Sigma_Avg(:,6:8).^2);
F16_Clean_Sigma_Avg = [F16_Clean_25_Sigma_Avg(:,1:5) vars];

 for k = 5:8                    %Number of sheets
     
    dummy = sprintf('F16_LOADED_G0%i.csv',k);
    Data = csvread(dummy,1,0);
    
    P_atm = Data(:,1);           %[Pa]
    T_atm = Data(:,2);           %[K]
    rho_atm = Data(:,3);         %[kg/m^3]
    V_air = Data(:,4);           %[m/s]
    alpha = Data(:,23);          %[Degrees]
    F_N = Data(:,24);            %[N]
	F_A = Data(:,25);            %[N]
    Moment = Data(:,26);         %[N*m]
    Model = 2.*ones(600,1);      %F-16 Dirty
    
    ind = 1;
    if rem(k,4) > 0
        ind2 = rem(k,4);
    else
        ind2 = 4;
    end
    
    for j = 1:20:600
        F16_Dirty(ind,1,ind2) = mean(P_atm(j:j+1));
        F16_Dirty(ind,2,ind2) = mean(T_atm(j:j+1));
        F16_Dirty(ind,3,ind2) = mean(rho_atm(j:j+1));
        F16_Dirty(ind,4,ind2) = mean(V_air(j:j+1));
        F16_Dirty(ind,5,ind2) = mean(alpha(j:j+1));
        F16_Dirty(ind,6,ind2) = mean(F_N(j:j+1));
        F16_Dirty(ind,7,ind2) = mean(F_A(j:j+1));
        F16_Dirty(ind,8,ind2) = mean(Moment(j:j+1));
        
        F16_Dirty_Sigma(ind,1,ind2) = StdDeviation(P_atm(j:j+1));
        F16_Dirty_Sigma(ind,2,ind2) = StdDeviation(T_atm(j:j+1));
        F16_Dirty_Sigma(ind,3,ind2) = StdDeviation(rho_atm(j:j+1));
        F16_Dirty_Sigma(ind,4,ind2) = StdDeviation(V_air(j:j+1));
        F16_Dirty_Sigma(ind,5,ind2) = StdDeviation(alpha(j:j+1));
        F16_Dirty_Sigma(ind,6,ind2) = StdDeviation(F_N(j:j+1));
        F16_Dirty_Sigma(ind,7,ind2) = StdDeviation(F_A(j:j+1));
        F16_Dirty_Sigma(ind,8,ind2) = StdDeviation(Moment(j:j+1));
        
        ind = ind + 1;
    end
 end
 
F16_Dirty_Zero_Avg = [.5*(F16_Dirty(1:15,:,1)+F16_Dirty(1:15,:,3)) ; .5*(F16_Dirty(1:15,:,2)+F16_Dirty(1:15,:,4))];
F16_Dirty_25_Avg = [.5*(F16_Dirty(16:30,:,1)+F16_Dirty(16:30,:,3)) ; .5*(F16_Dirty(16:30,:,2)+F16_Dirty(16:30,:,4))];

F16_Dirty_Zero_Sigma_Avg = [.5*(F16_Dirty_Sigma(1:15,:,1)+F16_Dirty_Sigma(1:15,:,3)) ; .5*(F16_Dirty_Sigma(1:15,:,2)+F16_Dirty_Sigma(1:15,:,4))];
F16_Dirty_25_Sigma_Avg = [.5*(F16_Dirty_Sigma(16:30,:,1)+F16_Dirty_Sigma(16:30,:,3)) ; .5*(F16_Dirty_Sigma(16:30,:,2)+F16_Dirty_Sigma(16:30,:,4))];

F16_Dirty_Avg = [F16_Dirty_25_Avg(:,1:5) (F16_Dirty_25_Avg(:,6:8)-F16_Dirty_Zero_Avg(:,6:8))];
vars = sqrt(F16_Dirty_25_Avg(:,6:8).^2.*F16_Dirty_25_Sigma_Avg(:,6:8).^2 + F16_Dirty_Zero_Avg(:,6:8).^2.*F16_Dirty_Zero_Sigma_Avg(:,6:8).^2);
F16_Dirty_Sigma_Avg = [F16_Dirty_25_Sigma_Avg(:,1:5) vars];

 for k = 9:12                    %Number of sheets
    if k < 10
        dummy = sprintf('787_G0%i.csv',k);
    else
        dummy = sprintf('787_G%i.csv',k);
    end
    
    Data = csvread(dummy,1,0);
    
    P_atm = Data(:,1);           %[Pa]
    T_atm = Data(:,2);           %[K]
    rho_atm = Data(:,3);         %[kg/m^3]
    V_air = Data(:,4);           %[m/s]
    alpha = Data(:,23);          %[Degrees]
    F_N = Data(:,24);            %[N]
	F_A = Data(:,25);            %[N]
    Moment = Data(:,26);         %[N*m]
    Model = 3.*ones(600,1);      %787
    
    ind = 1;
    if rem(k,4) > 0
        ind2 = rem(k,4);
    else
        ind2 = 4;
    end
    
    for j = 1:20:600
        B787(ind,1,ind2) = mean(P_atm(j:j+1));
        B787(ind,2,ind2) = mean(T_atm(j:j+1));
        B787(ind,3,ind2) = mean(rho_atm(j:j+1));
        B787(ind,4,ind2) = mean(V_air(j:j+1));
        B787(ind,5,ind2) = mean(alpha(j:j+1));
        B787(ind,6,ind2) = mean(F_N(j:j+1));
        B787(ind,7,ind2) = mean(F_A(j:j+1));
        B787(ind,8,ind2) = mean(Moment(j:j+1));
        
        B787_Sigma(ind,1,ind2) = StdDeviation(P_atm(j:j+1));
        B787_Sigma(ind,2,ind2) = StdDeviation(T_atm(j:j+1));
        B787_Sigma(ind,3,ind2) = StdDeviation(rho_atm(j:j+1));
        B787_Sigma(ind,4,ind2) = StdDeviation(V_air(j:j+1));
        B787_Sigma(ind,5,ind2) = StdDeviation(alpha(j:j+1));
        B787_Sigma(ind,6,ind2) = StdDeviation(F_N(j:j+1));
        B787_Sigma(ind,7,ind2) = StdDeviation(F_A(j:j+1));
        B787_Sigma(ind,8,ind2) = StdDeviation(Moment(j:j+1));
        
        ind = ind + 1;
    end

B787_Zero_Avg = [.5*(B787(1:15,:,1)+B787(1:15,:,3)) ; .5*(B787(1:15,:,2)+B787(1:15,:,4))];
B787_25_Avg = [.5*(B787(16:30,:,1)+B787(16:30,:,3)) ; .5*(B787(16:30,:,2)+B787(16:30,:,4))];

B787_Zero_Sigma_Avg = [.5*(B787_Sigma(1:15,:,1)+B787_Sigma(1:15,:,3)) ; .5*(B787_Sigma(1:15,:,2)+B787_Sigma(1:15,:,4))];
B787_25_Sigma_Avg = [.5*(B787_Sigma(16:30,:,1)+B787_Sigma(16:30,:,3)) ; .5*(B787_Sigma(16:30,:,2)+B787_Sigma(16:30,:,4))];

B787_Avg = [B787_25_Avg(:,1:5) (B787_25_Avg(:,6:8)-B787_Zero_Avg(:,6:8))];
vars = sqrt(B787_25_Avg(:,6:8).^2.*B787_25_Sigma_Avg(:,6:8).^2 + B787_Zero_Avg(:,6:8).^2.*B787_Zero_Sigma_Avg(:,6:8).^2);
B787_Sigma_Avg = [B787_25_Sigma_Avg(:,1:5) vars];
end