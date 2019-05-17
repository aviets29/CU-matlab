function [x,y] = Naca_Airfoil(m,p,t,c,N)

x = linspace(0,c,N/2+1);
y_t = (t*c/0.2)*(0.2969*sqrt(x/c) - 0.1260*(x/c) - 0.3516*(x/c).^2 +...
    0.2843*(x/c).^3 - 0.1036*(x/c).^4);

for i = 1:length(x)
    if x(i) <= p*c && p ~= 0
        y_c(i) = (m*x(i)/p^2)*(2*p-x(i)/c);
    else
        y_c(i) = m*(c-x(i))/((1-p)^2)*(1+x(i)/c-2*p);
    end
end
for i = 1:length(x)-1
    zeta(i) = atan2(y_c(i+1)-y_c(i),x(i+1)-x(i));
end

zeta = [zeta -zeta(1)];

x_u = x - y_t.*sin(zeta);
x_l = x + y_t.*sin(zeta);

y_u = y_c + y_t.*cos(zeta);
y_l = y_c - y_t.*cos(zeta);

x_l = fliplr(x_l);
y_l = fliplr(y_l);

x = [x_l(1:end-1)  x_u];
y = [y_l(1:end-1)  y_u];
end

