%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% readIn Function
% ASEN 2003 Lab 6
%
% Authors: Alec Viets and Ryan Blay
% Date Published: 3/30/2016
% Date Changed: 3/30/2016
%
% Inputs: Nada
% Outputs: Nada
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function readIn()

% Define globals
global R Li

figure();
count = 1;
% Define string lengths
strlengths = [0 8 10 11 12 13 13.5 13.6 13.75];
for i = strlengths
    % Store data from file
    Data{count} = load(['100_RPM_',num2str(i),'_INCH.txt']);
    % Plot the data
    plot(Data{count}(:,1),(pi/30)*Data{count}(:,2))
    hold on;
    % Store info in legend cell
    legendInfo{count} = [num2str(i) ' in'];
    count = count + 1;
end

% Create plot titles and axes
title('Yoyo Spin Down Analysis (Experimental)')
xlabel('time [s]')
ylabel('\omega [rad/s]')
% Create legend
legend(legendInfo)

% Calculate C with the ideal string length Li
t = linspace(0,.4003,200);
C = (Li/R+1)^2;
w0 = 10*pi/3;

% Calculate the theoretical omega
w = w0*(C-w0^2.*t.^2)./(C+w0^2.*t.^2);
phi = w0.*t;

% Calculate the string length over time
L = R.*phi-R;

figure()
plot(t,w)
xlim([0,.4003]);
ylim([0 Li]);
title(sprintf('Yoyo Spin Down Analysis for String Length = %.1f in', Li));
xlabel('time [s]')
ylabel('\omega [rad/s]')

figure()
plot(t,L);
xlim([0,.4003]);
ylim([0 Li]);
title('Length of String Over Time');
xlabel('time [s]')
ylabel('String Length [in]')

end