clear all;
close all;
clc;

% define constant variables
mProp = 999.8/1000;
g = 9.81;
lbf2N = 4.44822; % N
% define the frequency
frequency = 1.652*1000; %Hz

% load the static thrust data
files = dir('*.txt');

fprintf('File Name\tISP [s]\t\tPeak T [N]\t\tTotal Time [s]\n');
fprintf('=========\t=======\t\t==========\t\t==============\n');
for i=1:length(files)
    
    data = load(files(i).name);
    thrust = data(:,3);
    
    % put the summed thrust in a vector
    % lbf
    
    % trim data before thrust occurs
    ind = 1;
    while thrust(ind) < 1 && thrust(ind+1) < 1.2
        ind = ind+1;
    end
    thrust = thrust(ind:end); % lbf
    % trim data for after the thrust occurs
    % flip the thrust vector
    thrustFlip = flip(thrust);
    ind = 1;
    % find the index where the air thrust phase is ending
    while abs(thrustFlip(ind+1) - thrustFlip(ind)) < 1.
        
        ind = ind+1;
    end
    % define the last index of the thrust values
    LastInd = length(thrust)-ind;
    thrust = thrust(1:LastInd); % lbf
    % convert thrust to N
    thrust = (thrust*lbf2N)'; % N
    % redefine time
    time = linspace(0,length(thrust)/frequency,length(thrust));
    % define a y
    % t1 = linspace(0,time(end),10000);
    % interpolate
    y = interp1([time(1) time(end)],[thrust(1) thrust(end)],time);
    
    % thrust = thrust - y;
    
    % plot thrust vs time
    if i == 1
        figure
    end
    
    %plot(time,thrust,time,y);
    plot(time,thrust);
    hold on;
    title('Static Test Thrust vs Time')
    xlabel('Time [s]')
    ylabel('Thrust [N]')
    
    
    % integrate the thrust
    intThrust = trapz(thrust-y)/frequency;

    % calculate the Isp
    Isp = intThrust/(mProp*g);
    
    thrust = thrust-y;
    
    thrustMax(i) = max(thrust);
    thrustMean(i) = mean(thrust);
    thrustSTD(i) = std(thrust);
    timeTotal(i) = time(end);
    Isp1(i) = Isp;
    thrust1{i} = thrust;
    time1(i) = time(end);
    
    fprintf('%s\t\t%.3f\t\t%.3f\t\t\t%.3f\n',files(i).name(1:7),Isp1(i),thrustMax(i),time1(i))
end

for i = 1:100
    IspSEM(i) = std(Isp1)/sqrt(i);
end
z = [1.96 2.24 2.58];
N1 = (z*std(Isp1)/.1).^2;
N2 = (z*std(Isp1)/.01).^2;

figure()
plot(IspSEM);
title('SEM vs. Number of Trials')
xlabel('Trials [#]')
ylabel('SEM [s]')

figure()
histfit(Isp1,14);
title('Isp Distribution')
xlabel('Isp [s]')
ylabel('Occurrences [N]')

fprintf('\nAvg Thrust [s]\t\tStd Avg Thrust [s]\n');
fprintf('==============\t\t==================\n');
fprintf('%.3f\t\t\t\t%.3f\n',mean(thrustMax),std(thrustMax));

fprintf('\nAvg Isp [s]\t\tStd Avg Isp [s]\t\tAvg Time [s]\t\tStd Avg Time\n');
fprintf('===========\t\t===============\t\t============\t\t============\n');
fprintf('%.3f\t\t\t%.3f\t\t\t\t%.3f\t\t\t\t%.3f\n',mean(Isp1),std(Isp1),mean(time1),std(time1));

fprintf('\nIsp Percision [s]\t\tN for 95%%\t\tN for 97.5%%\t\tN for 99%%\t\t\n');
fprintf('=================\t\t=========\t\t===========\t\t=========\n');
fprintf('%.2f\t\t\t\t\t%.1f\t\t\t\t%.1f\t\t\t%.1f\n',.1,N1(1),N1(2),N1(3));
fprintf('%.2f\t\t\t\t\t%.1f\t\t\t%.1f\t\t\t%.1f\n',.01,N2(1),N2(2),N2(3));