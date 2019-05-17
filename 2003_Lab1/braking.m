function [cOUT] = braking(c,h0,length)
global g dStep;

dI = c.d(end);
d = 0;

while d <= length
    checkG(c);
    d = d+dStep;
    c.d = [c.d; dI+d];
    c.nVec = [c.nVec;c.nVec(end,:)];
    c.tVec = [c.tVec;c.tVec(end,:)];
    c.pos = [c.pos; c.pos(end,:)+dStep*c.tVec(end,:)];
    c.fN = [c.fN; g];
    c.fT = [c.fT; -38.259];
    c.fL = [c.fL; 0];
end
cOUT = c;
end%of function straight