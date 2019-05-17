function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,ct,cr,aero_t,aero_r,geo_t,geo_r,N)

for i = 1:length(N)
    Th(i) = N(i)*pi/(2*N(end));
    if Th(i) <= pi/2 && Th(i) >= 0
        c = cr - (cr - ct)*cos(Th(i));
        alpha_L0 = aero_r - (aero_r - aero_t)*cos(Th(i));
        alpha =  geo_r - (geo_r - geo_t)*cos(Th(i));
        a0 =  a0_r - (a0_r - a0_t)*cos(Th(i));
    else
        c = cr + (cr - ct)*cos(Th(i));
        alpha_L0 = aero_r + (aero_r - aero_t)*cos(Th(i));
        alpha =  geo_r + (geo_r - geo_t)*cos(Th(i));
        a0 =  a0_r + (a0_r - a0_t)*cos(Th(i));
    end
    
    RHS(i) = alpha - alpha_L0;
    
    for j = 1:length(N)
        A(i,j) = sin(N(j)*Th(i))*(4*b/(a0*c)) + sin(N(j)*Th(i))*N(j)/sin(Th(i));
    end
end

A_n = A\RHS';

%% Calculate e
for i=2:length(N)
    delta(i-1)=N(i)*(A_n(i)/A_n(1))^2;
end
e=1/(1+sum(delta));

%% Calculate Cl and Cd
S = b*(cr+ct)/2;
AR = b^2/S;

c_L = A_n(1)*pi*AR;
c_Di = c_L^2/(e*AR*pi);

end