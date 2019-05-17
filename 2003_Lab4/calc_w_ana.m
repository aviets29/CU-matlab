function w_ana = calc_w_ana( Th )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
global m l g Th0 t0 w0

w_ana = sqrt((3*g/l)*(cos(Th0)-cos(Th)));

end

