function [Kp_final, Kd_final] = optimizeRigid(Thd)
global Kg Km Rm J
N = 10;
Kp = linspace(4,15,N);
Kd = (sqrt(Kp*(4*Kg*Km*J*Rm))-Kg^2*Km^2)/(Kg*Km);

for i = 1:N
    num = Thd*Kp(i)*Kg*Km/(J*Rm);
    den = [1 , (Kg^2*Km^2/(J*Rm) + Kd(i)*Kg*Km/(J*Rm)) , Kp(i)*Kg*Km/(J*Rm)];
    H = tf(num,den);
    [Th,t] = step(H);
    
    Vin = (Thd - Th)*Kp(i);
    
    ind = 0;
    for j = 1:length(Th)
        if Th(j) < (Thd - Thd*.05)
            ind = ind +1;
        end
    end
    
    overcheck = find(Th > Thd);
    if i == 1
        timeOP = t(ind);
        Kp_final = Kp(i);
        Kd_final = Kd(i);
    end
    if t(ind) <= timeOP && isempty(overcheck) && max(Vin) < 5
        timeOP = t(ind);
        Kp_final = Kp(i);
        Kd_final = Kd(i);
    end   
end

N = 1000;
Kp = linspace(Kp_final-1,Kp_final,N);
Kd = (sqrt(Kp*(4*Kg*Km*J*Rm))-Kg^2*Km^2)/(Kg*Km);

for i = 1:N
    num = Thd*Kp(i)*Kg*Km/(J*Rm);
    den = [1 , (Kg^2*Km^2/(J*Rm) + Kd(i)*Kg*Km/(J*Rm)) , Kp(i)*Kg*Km/(J*Rm)];
    H = tf(num,den);
    [Th,t] = step(H);
    
    Vin = (Thd - Th)*Kp(i);
    
    ind = 1;
    for j = 1:length(Th)
        if Th(j) < (Thd - Thd*.05)
            ind = ind +1;
        end
    end
    
    overcheck = find(Th > Thd);
    if i == 1
        timeOP = t(ind);
        Kp_final = Kp(i);
        Kd_final = Kd(i);
    end
    if t(ind) <= timeOP && max(Vin) < 5 && isempty(overcheck)
        timeOP = t(ind);
        Kp_final = Kp(i);
        Kd_final = Kd(i);
    end   
end

