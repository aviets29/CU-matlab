function cOUT = bankedTurn(c,r)
global h0 g maxG maxD dStep;

dI = c.d(end);
dLoop = 2*pi*r;
v = (2*g*(h0-c.pos(end,3)))^(1/2);
% phi = atan((v^2)/(r*g));
theta = 0;
d = 0;

while theta <= pi
    checkG(c);
    d = d+dStep;
    c.d = [c.d; dI+d];
    theta = [theta; (d/dLoop)*2*pi];%in [radians]
    c.nVec = [c.nVec;[cos(theta(end)),sin(theta(end)),0]./...
        norm([cos(theta(end)),sin(theta(end)),0])];
    c.tVec = [c.tVec;[cos(theta(end)),sin(theta(end)),0]];
    c.pos = [c.pos; [c.pos(end,:)+r.*(theta(end)-theta(end-1)).*c.tVec(end,:)]];
%     c.pos = [c.pos; [c.pos(end,:)+r.*(phi(end)-phi(end-1)).*c.tVec(end,:)]];
    v = (2*g*(h0-c.pos(end,3)))^(1/2);
    c.fN = [c.fN;((v^2)/r)];
    c.fT = [c.fT;0];
    c.fL = [c.fL;g];
end

cOUT = c;
end%of function bankedTurn