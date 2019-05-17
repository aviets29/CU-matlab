function [cp_x,Cp,cl] = Vortex_Panel(x,y,c,alpha)

p_atm = 101325;
rho_inf = 1.225;
m = length(x)-1;
mp1 = length(x);

%Define control points
for i = 1:m
    cp_x(i) = (x(i+1)+x(i))/2;
    cp_y(i) = (y(i+1)+y(i))/2;
    S(i) = sqrt((x(i+1)-x(i)).^2 + (y(i+1)-y(i)).^2);
    Th(i) = atan2((y(i+1)-y(i)),(x(i+1)-x(i)));
    
    RHS(i) = sin(Th(i)-alpha);
end

for i = 1:m
    for j = 1:m
        
        if (i == j)
            N1(i,j) = -1;
            N2(i,j) = 1;
            T1(i,j) = pi/2;
            T2(i,j) = pi/2;
        else
            A = -(cp_x(i)-x(j))*cos(Th(j)) - (cp_y(i)-y(j))*sin(Th(j));
            B = (cp_x(i)-x(j)).^2 + (cp_y(i)-y(j)).^2;
            C = sin(Th(i)-Th(j));
            D = cos(Th(i)-Th(j)); 
            E = (cp_x(i)-x(j))*sin(Th(j)) - (cp_y(i)-y(j))*cos(Th(j));
            F = log(1 + S(j)*(S(j)+2.*A)/B);
            G = atan2(E*S(j),B+A*S(j));
            P = (cp_x(i)-x(j))*sin(Th(i)-2.*Th(j)) + (cp_y(i)-y(j))*cos(Th(i)-2.*Th(j));
            Q = (cp_x(i)-x(j))*cos(Th(i)-2.*Th(j)) - (cp_y(i)-y(j))*sin(Th(i)-2.*Th(j));
            
            N2(i,j) = D + .5*Q*F/S(j) - (A*C + D*E)*(G/S(j));
            N1(i,j) = .5*D*F + C*G - N2(i,j);
            T2(i,j) = C + .5*P*F/S(j) + (A*D - C*E)*G/S(j);
            T1(i,j) = .5*C*F - D*G - T2(i,j);
        end    
    end
end

for i = 1:m
    A_n(i,1) = N1(i,1);
    A_n(i,mp1) = N2(i,m);
    A_t(i,1) = T1(i,1);
    A_t(i,mp1) = T2(i,m);
    
    for j = 2:m
        A_n(i,j) = N1(i,j) + N2(i,j-1);
        A_t(i,j) = T1(i,j) + T2(i,j-1);
    end
end

A_n(mp1,1) = 1;
A_n(mp1,mp1) = 1;

for j = 2:m
    A_n(mp1,j) = 0;
end

RHS(mp1) = 0;

gamma = A_n\RHS';

for i = 1:m
    V(i) = cos(Th(i)-alpha);
    for j = 1:mp1
        V(i) = V(i) + A_t(i,j)*gamma(j); 
        Cp(i) = 1 - (V(i)).^2;
    end
end

Gamma = sum(V.*S);
cl = 2*Gamma/c;

end

