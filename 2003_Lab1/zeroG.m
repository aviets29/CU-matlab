function cOUT = zeroG(c)
%assumes the cart is only traveling in the xz-plane
global h0 g maxG maxD dStep;

dI = c.d(end);
hF = c.pos(end,3);
% theta = atan(c.pos(end,3)/c.pos(end,1));
x0 = c.pos(end,1);
z0 = c.pos(end,3);
theta = atan((z0-c.pos(end-1,3))/(x0-c.pos(end,1)))
d = 0;
v0 = (2*g*(h0-c.pos(end,3)))^(1/2);
vX0 = v0*cos(theta);
vZ0 = v0*sin(theta);

while c.pos(end,3) >= hF
    checkG(c);
    d = d+dStep;
    c.d = [c.d; dI+d];
    theta = [theta; atan(c.pos(end,3)/c.pos(end,1))];
    v = (2*g*(h0-c.pos(end,3)))^(1/2);
    vZ = v*sin(theta(end));
    dZ = ((vZ^2)-(vZ0^2))/(2*(-1)*g);
    dX = dStep*cos(theta(end));
    c.nVec = [c.nVec;[-sin(theta(end)),0,cos(theta(end))]];
    c.tVec = [c.tVec;[cos(theta(end)),0,sin(theta(end))]];
    c.pos = [c.pos; [c.pos(end,1)+dX,c.pos(end,2),c.pos(end,3)+dZ]];
    c.fN = [c.fN;0];
    c.fT = [c.fT;0];
    c.fL = [c.fL;0];
end

cOUT = c;
end