function vecdot = epidemic(t,vec)

global R0

% define the input values to familiar names
s = vec(1);
i = vec(2);
r = vec(3);

dsdt = -R0*s*i;
didt = i*R0*s-i;
drdt = i;

vecdot = zeros(3,1);
vecdot(1) = dsdt;
vecdot(2) = didt;
vecdot(3) = drdt;
