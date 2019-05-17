%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotstuffs Function
% ASEN 2003 Lab 5
%
% Authors: Alec Viets and Thomas Pestolesi
% Date Published: 3/8/2016
% Date Changed: 3/28/2016
%
% Inputs: Theta, Th [rads] ; Omega Theoretical, w_theo [rad/s] ;
%         Omega Theoretical, w_exp [rad/s] ; residuals [rad/s] ;
%         balanced? [bool] ; Moment [N*m]
% Outputs: Graphics and table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ] = Plotstuffs(Th,w_theo,w_exp,residuals,balanced,Moment)

%Define figure
figure( )
count = 1;
for i = 1:8
    %Create plots
    if i == 1
        %Plot for different 
        plot(Th,w_exp,'.b')
        hold on;
    else
        plot(Th,w_theo(:,count))
        hold on;
        count = count + 1;
    end
end

%Create plot labels
if balanced
    title('Balanced Wheel Analysis')
    xlabel('\theta [rad]')
    ylabel('\omega [rad/s]')
    xlim([.5,15])
    legend('0 N*m Theory','0 N*m Experiment','0.5 N*m','0.8 N*m','1 N*m','1.2 N*m','1.4 N*m','1.6 N*m','Location','Northwest');
else
    title('Unbalanced Wheel Analysis')
    xlabel('\theta [rad]')
    ylabel('\omega [rad/s]')
    xlim([.5,15])
    legend('0 N*m Theory','0 N*m Experiment','0.5 N*m','0.8 N*m','1 N*m','1.2 N*m','1.4 N*m','1.6 N*m','Location','Northwest');
end

%Create table
if balanced
    fprintf('\t\t\t\t\t\t    Balanced\n');
else
    fprintf('\t\t\t\t\t\t    Unbalanced\n');
end

fprintf('Moment [N*m] | Mean Residual [Rad/s] | Std of Residuals [Rad/s] \n')
for i = 1:7
    
    residuals_Mean(i) = mean(residuals{i});
    residuals_Norm{i} = residuals{i}./std(residuals{i});
    
    %Check if balanced or unbalanced
    if balanced
        fprintf('%.2f\t\t\t\t%.2f\t\t\t\t%.2f \n',Moment(i),residuals_Mean(i),std(residuals{i}));
    else
        fprintf('%.2f\t\t\t\t%.2f\t\t\t\t %.2f \n',Moment(i),residuals_Mean(i),std(residuals{i}));
    end
end
fprintf('\n');

%Find best moment
[~,I] = min(abs(residuals_Mean));

if balanced == false
    %Create histograms for normalized residuals
    figure()
    %Create subplots
    subplot(2,1,1);
    histogram(residuals_Norm{I});
    
    title(sprintf('Unbalanced Normalized Residuals for Moment = %.2f N*m',Moment(I)));
    xlabel('\sigma [#]')
    ylabel('\omega [rad/s]')
    xlim([-7,5])
    
    subplot(2,1,2);
    M = find(abs(residuals_Norm{I}) >= abs(3*std(residuals_Norm{I})));
    residuals_Norm{I}(M,:) = [ ];
    histogram(residuals_Norm{I});
    
    title(sprintf('Unbalanced Normalized Residuals for Moment = %.2f N*m w/o Outliers',Moment(I)));
    xlabel('\sigma [#]')
    ylabel('\omega [rad/s]')
    xlim([-7,5])
    
end
end
