function Value = trapazoidal_lower(fun,a,b,N,Axial)

t =12/100;
c = 0.5; %m

y_t = @(x) -(t*c/0.2)*(0.2969*sqrt(x/c) - 0.1260*(x/c) - 0.3516*(x/c).^2 +...
    0.2843*(x/c).^3 - 0.1036*(x/c).^4);

delta_xk = (a+b)/N; 
x = a: delta_xk :b;

sum = 0;
for i = 1:N
    
    delta_yk = y_t(x(i+1))-y_t(x(i));
    
    if Axial
        sum = sum + delta_yk*(fun(x(i+1))+ fun(x(i)))/2;
    else
        sum = sum + delta_xk*(fun(x(i+1))+ fun(x(i)))/2;
    end
end

Value = sum;

end