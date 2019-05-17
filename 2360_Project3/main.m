%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analyzing an Epidemic Model
% Author: Alec Viets
% Created: 4/16/2016
% Last edited: 4/21/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all; clc;
global R0
p = 0:.1:1;
s0 = (1-p)*.9;
i0 = .1;
r0 = p.*s0;

for i = 1:2
    if i == 1
        R0 = 1.5;
    else
        R0 = .5;
    end

    initials = [s0(1) i0(1) r0(1)];
    tspan = [0 20];
    [t,y1] = ode45('epidemic',tspan, initials);
    
    figure()
    plot(t,y1)
    title(sprintf('Percentages of Population for R_{0} = %.1f',R0));
    xlabel('time');
    ylabel('Percentages [%]');
    legend('s(t)','i(t)','r(t)','Location','East')
end

figure()
for i = 1:length(p)
    
    R0 = 1.5;
    initials = [s0(i) i0 r0(i)];
    
    tspan = [0 20];
    [t,y2] = ode45('epidemic',tspan, initials);
    
    ymax(i) = max(y2(:,2));
    zero_index = find(diff(y2(:,2)>=0),1);
    % tau(i) = t(zero_index);
    
    plot(t,y2(:,2))
    hold on;
    LegendInfo{i} = ['p = ' num2str(p(i))];
end

title(sprintf('Epidemic surge vs. time',R0));
xlabel('time');
ylabel('percentages [%]');
legend(LegendInfo)

figure()
scatter(p,ymax)
ylim([.1 .15])
title('Epidemic surge vs. time');
xlabel('p values');
ylabel('\sigma [%]');

x = -1:.1:1;
y = -x;
y2 = x*0;
p1 = plot(x,y,'*b');
hold on
plot([0 0 0],[-1 0 1],'LineWidth',2);
title('Eigenspace for equilibrium solutions')
xlabel('x')
ylabel('y')