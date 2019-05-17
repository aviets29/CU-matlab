function A = calcCoeff(rho,v,D,L,M,model)

% define the wing area of a F16 & mean chord line
if model == 1 || model == 2
    S = 27.87; %m^2
    c = 3.05;
    % http://www.lockheedmartin.com/us/products/f16/F-16Specifications.html
    % scale the F16 wing area & mean chord line
    Ss = S/(48^2);
    cs = c/48;
else
    S = 325; %m^2
    c = 8.05;%6.46;
    Ss = S/225^2;
    cs = c/225;
end

% calculate the lift coeff
cL = L./(.5.*rho.*(v.^2).*Ss);
% calculate the drag coeff
cD = D./(.5.*rho.*(v.^2).*Ss);
% calculate the moement coefficient
cM = M./(.5.*rho.*(v.^2).*Ss.*cs);

A = [cD,cL,cM];
end