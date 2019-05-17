function outarg = calcDLM(alpha,N,A,P,Model)

% convert alpha from degrees to radians
alpha = alpha * (pi/180);
% calculate the lift
Lift = N.*cos(alpha) - A.*sin(alpha);
% calculate the drag
Drag = N.*sin(alpha) + A.*sin(alpha);
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

% calculate the Moment about the CG
Moment = P - N.*d;

outarg = [Drag, Lift, Moment];
end

