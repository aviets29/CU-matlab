function cOUT = straight(c,dF,dir)
global h0 g maxG maxD dStep;

dI = c.d(end);
d = 0;

while d <= dF
    checkG(c);
    d = d+dStep;
    c.d = [c.d; dI+d];
    c.nVec = [c.nVec;c.nVec(end,:)];
    c.tVec = [c.tVec;c.tVec(end,:)];
    c.pos = [c.pos; c.pos(end,:)+dStep*dir];
    c.fN = [c.fN; g];
    c.fT = [c.fT; 0];
    c.fL = [c.fL; 0];
end
cOUT = c;
end%of function straight