function Value = simpson(fun,a,b,N)

h = (b-a)/N;
for i = 1:(N+1)
    Th(i) = a + (i-1)*h;
end

sum = 0;
for i = 1:(N/2)
    sum = sum + fun(Th(2*i-1)) + 4*fun(Th(2*i)) + fun(Th(2*i+1));
end
Value = sum*(h/3);

end

