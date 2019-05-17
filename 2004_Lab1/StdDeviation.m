function sigma = StdDeviation(Data)
    
    n = length(Data);
    x_bar = mean(Data);
    data_sum = 0;
    
    for i = 1:n
        data_sum = data_sum + (Data(i)-x_bar)^2;
    end
    
    sigma = (data_sum/(n-1))^.5;
end