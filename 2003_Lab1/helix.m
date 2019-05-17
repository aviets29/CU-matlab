function cOUT = helix(c,deltah1,r,N)
global h0 g maxG maxD dStep;

dI = c.d(end);
dLoop = 2*pi*r;
v = (2*g*(h0-c.pos(end,3)))^(1/2);
phi = atan((v^2)/(r*g));
theta = acos(dot(c.tVec(end,:),[1,0,0]));
deltah = (deltah1)/(N*2*r*pi);
% deltah = (c.pos(end,3)-hF)/(N*2*r*pi);
rho = atan((deltah1)/(N*2*r*pi));
d = 0;
while theta(end) < (N*2*pi + pi)
    d = d+dStep;
    c.d = [c.d; dI+d];
    theta = [theta; theta(end)+(dStep/dLoop)*2*pi];%in [radians]
    c.nVec = [c.nVec;[cos(theta(end)),sin(theta(end)),sin(phi)]./...
        norm([cos(theta(end)),sin(theta(end)),sin(phi)])];
    c.tVec = [c.tVec;[cos(theta(end)),sin(theta(end)),-deltah]./...
         norm([cos(theta(end)),sin(theta(end)),-deltah])];
    c.pos = [c.pos; [c.pos(end,:)+r.*(theta(end)-theta(end-1)).*c.tVec(end,:)]];

    v = (2*g*(h0-c.pos(end,3)))^(1/2);
    c.fN = [c.fN; ((v^2)/r)];
    c.fT = [c.fT;g*sin(rho)];
    c.fL = [c.fL;g*cos(rho)];
	checkG(c);
end

cOUT = c;
end%of function bankedTurn