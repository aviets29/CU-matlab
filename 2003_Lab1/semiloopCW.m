function cOUT = semiloopCW(c,thetaF,r)
global h0 g maxG maxD dStep;

dI = c.d(end);

if c.pos(end,3) < 0
    theta = 2*pi - atan(c.tVec(end,3)/c.tVec(end,1));
else
    theta = atan(c.tVec(end,3)/c.tVec(end,1));
end

dLoop = 2*pi*r;
d = 0;

while theta(end) > thetaF
    checkG(c);
    d = d+dStep;
    c.d = [c.d; dI+d];
    tempVec = c.nVec(end,:)*(-1);
    theta = [theta; theta(end)-(dStep/dLoop)*2*pi];
    c.nVec = [c.nVec;[-sin(theta(end)),0,cos(theta(end))]];
    c.tVec = [c.tVec;[cos(theta(end)),0,sin(theta(end))]];
    c.pos = [c.pos; [c.pos(end,:)+r.*(theta(end)-theta(end-1)).*c.tVec(end,:)]];
    v = (2*g*(h0-c.pos(end,3)))^(1/2);
%     c.fN = [c.fN;((v^2)/r)+g*abs(cos(theta(end)))];
%     c.fT = [c.fT; g*abs(sin(theta(end)))];
    c.fN = [c.fN;((v^2)/r)+g*cos(theta(end))];
    c.fT = [c.fT; g*sin(theta(end))];
    c.fL = [c.fL;0];
end

cOUT = c;
end