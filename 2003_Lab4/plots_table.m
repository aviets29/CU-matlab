function [ ] = plots_table( t,Th,w,P,N, w_ana, dt )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global m l g Th0 t0 w0

figure(1)
subplot(2,2,1)
for i = 1:length(dt)
    plot(t{i},(180*Th{i})/pi)
    hold on;
    
    if i == length(dt)
        hold off;
    end
end
title('Theta vs. time for various step sizes');
xlabel('time [s]');
ylabel('theta [degrees]');
legend('dt = .1','dt = .01','dt = .001','Location','NorthWest');

subplot(2,2,2)
for i = 1:length(dt)
    plot(t{i},w{i})
    hold on;
    
    if i == length(dt)
        hold off;
    end
end
title('Omega vs. time for various step sizes');
xlabel('time [s]');
ylabel('Omega [rad/s]');
legend('dt = .1','dt = .01','dt = .001','Location','NorthWest');

subplot(2,2,3)

plot(t{3},P{3})
hold on;
plot(t{3},N{3})
hold off;

title('Normal Forces vs. time for various step sizes');
xlabel('time [s]');
ylabel('Normal Force [N]');
legend('P','N','Location','NorthWest');

subplot(2,2,4)

plot(Th{1}*(180/pi),w{1},'*b')
hold on;
plot(Th{1}*(180/pi),w_ana,'-r')
hold off;

title('Omega vs. time for t = .1');
xlabel('theta [degrees]');
ylabel('Omega [rad/s]');
legend('Computational','Analytic','Location','NorthWest');

% Results = figure(1);
% print(Results,'-dpng')

fprintf('\ntrial [s]\t\tTime Seperate [s]\t\tTheta Seperate [degrees]\n')

for i = 1:length(dt)
    fprintf('%.2f\t\t\t%.2f\t\t\t%.2f\t\t\t\t\n',dt(i),t{i}(end),Th{i}(end))
end
end

