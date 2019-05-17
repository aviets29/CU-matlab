function cOUT = zeroG2(c)
%assumes the cart is only traveling in the xz-plane
global h0 g maxG maxD dStep;

x0 = c.pos(end,1);
z0 = c.pos(end,3);
% theta = atan((-z0+c.pos(end-1,3))/(-x0+c.pos(end-1,1)));
theta = atan((z0-c.pos(end-1,3))/(x0-c.pos(end-1,1)));

v0 = (2*g*(h0-z0))^(1/2);
vX0 = v0*cos(theta);
vZ0 = v0*sin(theta);

t1 = vZ0/g;
t = 0:0.1:2*t1;

% x1 = (x0+vX0*t);
% y1 = c.pos(end,2)*ones(size(x1,2),1);
% z1 = (z0+vZ0.*t-.5.*g.*t.^2);
% c.pos = [c.pos;x1',y1,z1'];
d0 = c.d(end);
for i = 1:size(t,2)
    x1 = (x0+vX0*t(i));
    y1 = c.pos(end,2);
    z1 = (z0+vZ0.*t(i)-.5.*g.*t(i).^2);
    c.pos = [c.pos;x1,y1,z1];
    c.fN = [c.fN; 0];
    c.fT = [c.fT; 0];
    c.fL = [c.fL; 0];
    c.tVec = [c.tVec; [c.pos(end,1)-c.pos(end-1,1),0,c.pos(end,3)-c.pos(end-1,3)]./...
        sqrt( (c.pos(end,3)-c.pos(end-1,3))^2 + (c.pos(end,1)-c.pos(end-1,1))^2 )];
    c.nVec = [c.nVec; [0,0,0]];
    c.d = [c.d; d0+sqrt( (c.pos(end,1)-c.pos(end-1,1))^2 + (c.pos(end,3)-c.pos(end-1,3))^2 )];
end
cOUT = c;
end