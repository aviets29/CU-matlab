function O = propErrorDLM(N,A,P,alpha,sigN,sigA,sigP,sigAlpha,Model)

% convert alpha to radians
alpha = alpha .* (pi/180);
% propagate the error in the drag
sigD = sqrt((sin(alpha).^2) .*(sigN.^2)+(cos(alpha).^2).*(sigA.^2)+((N.*cos(alpha)-A.*sin(alpha)).^2).*(sigAlpha.^2));
% propagate the error in the lift
sigL = sqrt((cos(alpha).^2).*(sigN.^2)+((-1.*sin(alpha)).^2).*(sigA.^2)+((-1.*N.*sin(alpha)- A.*cos(alpha)).^2).*(sigAlpha.^2));
% determine which model is tested
%if clean then A = 28.3 mm
if Model == 1
    d = 28.3/1000;
% if dirty then A = 26.5 mm
elseif Model == 2
    d = 26.5/1000;
% if 787 then A = 52 mm
elseif Model == 3
    d = 52/1000;
end
% propagate the error in moment calculations
sigM = sqrt((sigP.^2)+((-1.*d).^2).*(sigN.^2));

O = [sigD,sigL,sigM];

end