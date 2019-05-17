function [Kpt_final, Kpd_final, Kdt_final, Kdd_final] = optimizeFlex(Thd)
global Kg Km Rm

N = 1000;
for i = 1:N
    
    K1 = 4 + 11*rand(1);
    K2 = -4 - 11*rand(1);
    K3 = 1.5*rand(1);
    K4 = 1.5*rand(1);
    
    L = 0.45;        % [m]
    M_arm = 0.06;    % [kg]
    M_tip = 0.05;     % [kg]
    fc = 1.8;         % [Hz]

    J_arm = M_arm*L^2*(1/3);     % [kg*m^2]
    J_hub = 0.002;              % [kg*m^2]
    J_M = M_tip*L^2;            % [kg*m^2]
    J_L = J_arm + J_M;          % [kg*m^2]
    
    K_arm = (2*pi*fc)^2*(J_L);  % [kg*m^2]
    
    p1 = -Kg^2*Km^2/(J_hub*Rm);
    p2 = Kg^2*Km^2*L/(J_hub*Rm);
    q1 = K_arm/(L*J_hub);
    q2 = -K_arm*(J_hub+J_L)/(J_L*J_hub);
    r1 = Kg*Km/(J_hub*Rm);
    r2 = -Kg*Km*L/(J_hub*Rm);
    
    l3 = -p1 + K3*r1 + K4*r2;
    l2 = -q2 + K1*r1 + K2 + K4*(p2*r1 - r2*p1);
    l1 = p1*q2 - q1*p2 + K3*(q1*r2 - r1*q2) + K2*(p2*r1 - r2*p1);
    l0 = K1*(q1*r2-r1*q2);
    
    num_Th = Thd*K1*[r1 0 (r2*q1-r1*q2)];
    den_Th = [1 l3 l2 l1 l0];
    num_D =  K1*[r2 (p2*r1-r2*p1) 0];
    den_D =  [1 l3 l2 l1 l0];
    
    H_Th = tf(num_Th,den_Th);
    [Th,t] = step(H_Th);
    H_D = tf(num_D,den_D);
    [D,t2] = step(H_D);
    
    Th = linspace(Th(1),Th(end),4000);
    t = linspace(t(1),t(end),4000);
    D = linspace(D(1),D(end),4000);
    t2 = linspace(t2(1),t2(end),4000);
    
    ind = 0;
    for k = 1:length(Th)
        if Th(k) < (Thd - Thd*.05)
            ind = ind +1;
        end
    end
    
    Vin = 0;
    for j = 2:length(Th)
        Vin(j) = (Thd - Th(j))*K1 - K3*((Th(j) - Th(j-1))/(t(j)-t(j-1))) ...
                  - K2*D(j) - K3*((D(j)-D(j-1))/(t2(j)-t2(j-1)));
    end
    max1(i) = max(Vin);
    overcheck = find(Th > Thd);
    
    if i == 1
        timeOP = t(end);
        Kpt_final = K1;
        Kpd_final = K2;
        Kdt_final = K3;
        Kdd_final = K4;
    end
    
    %&& max(Vin) < 5
    if t(end) <= timeOP && max(Vin) < 5 && isempty(overcheck)
        timeOP = t(end);
        Kpt_final = K1;
        Kpd_final = K2;
        Kdt_final = K3;
        Kdd_final = K4;
    end
end
end