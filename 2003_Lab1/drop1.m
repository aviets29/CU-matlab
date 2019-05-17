function cOUT = drop1(c,hI,hF)
global h0 g maxG maxD dStep;

m = -1;
dI = c.d(end);
d = 0;

while c.pos(end,3)>= hF
    checkG(c);
    d = d+dStep;
    c.d = [c.d; dI+d];
    theta = atan(m);
    c.pos = [c.pos; c.pos(end,:)+dStep.*[cos(theta),0,sin(theta)]];
    thetaN = atan(-1/m);
    c.nVec = [c.nVec; [cos(thetaN),0,sin(thetaN)]];
    c.tVec = [c.tVec;[cos(theta),0,sin(theta)]];
%     N = [g*cos(theta),0,g*sin(theta)];
%     G = [0,0,-g];
%     c.fN = [c.fN; N+G];
%     c.fT = [c.fT; [0,0,]];
%     c.fL = [c.fL; [0,0,0]];
    c.fN = [c.fN; g*cos(theta)];
    c.fT = [c.fT; g*sin(theta)];
    c.fL = [c.fL; 0];
end
cOUT = c;
end
