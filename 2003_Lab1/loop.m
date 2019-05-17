function cOUT = loop(c,hI,r)
global h0 g maxG maxD dStep;

dI = c.d(end);
dLoop = 2*pi*r;
theta = [0];
d = 0;

while d <= dLoop
    checkG(c);
    d = d+dStep;
    c.d = [c.d; dI+d];
    theta = [theta; (d/dLoop)*2*pi];%in [radians]
    c.nVec = [c.nVec;[-sin(theta(end)),0,cos(theta(end))]];
    c.tVec = [c.tVec;[cos(theta(end)),0,sin(theta(end))]];
    c.pos = [c.pos; [c.pos(end,:)+r.*(theta(end)-theta(end-1)).*c.tVec(end,:)]];
    v = (2*g*(h0-c.pos(end,3)))^(1/2);
%     c.fN = [c.fN;((v^2)/r)-g*abs(cos(theta(end)))];
%     c.fT = [c.fT; -g*abs(sin(theta(end)))];
    c.fN = [c.fN;((v^2)/r)+g*cos(theta(end))];
    c.fT = [c.fT; g*sin(theta(end))];
    c.fL = [c.fL;0];
end
cOUT = c;
end%of function loop(c,hI,r)