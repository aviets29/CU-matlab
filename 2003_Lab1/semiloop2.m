function cOUT = semiloop2(c,thetaF,r)
global h0 g maxG maxD dStep;

dI = c.d(end);

% %finds the angle, in [rad], between v and [0,0,-1]
% %assumes the cart is only traveling in the xz-plane
% tempVec = c.nVec(end,:)*(-1);
% v0 = [0,0,-1];
% % tAngle = asin(dot(tempVec,v0));
% tAngle = acos(dot(tempVec,v0));
% if(tempVec(1)>=0)%x-coord is pos -> quad 4 or 1
%     theta = tAngle;
% else%x-coord is neg -> quad 2 or 3
%     theta = tAngle*(-1);
% end
theta = pi;
dLoop = 2*pi*r;
d = 0;

while theta(end) < thetaF
    checkG(c);
    d = d+dStep;
    c.d = [c.d; dI+d];
    tempVec = c.nVec(end,:)*(-1);
%     theta = [theta; acos(dot([0,0,-1],tempVec))];%in [radians]
    theta = [theta; theta(end)+(dStep/dLoop)*2*pi];
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
end