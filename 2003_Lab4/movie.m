
% Load data and assign coordinates of contact points
Data = load('CompExercise4.txt');
t = Data(:,1);
x = [Data(:,2),Data(:,4)];
y = [Data(:,3),Data(:,5)];

% Create default font size
set(gcf,'defaultaxesfontsize',12);

%Start loop to create each frame
for i = 1:length(Data(:,1))
    % Create a frame by plotting the bar at t(i)
    h = plot(x(i,:),y(i,:),'-b','linewidth',2);
    
    % Include time step
    time = sprintf('%.2f s',t(i));
    text(3,3,time,'fontsize',12)
    
    %Format graph
    xlim([0 4])
    ylim([0 4])
    axis square
    xlabel('x distance [m]')
    ylabel('y distance [m]')
    title('Falling bar')
    %Store the frame
    M(i) = getframe(gcf);
end

%Convert the movie to avi
movie2avi(M,'mybar.avi');

%plot the final position
plot(x(i,[1 2]),y(i,[1 2]),'-b','linewidth',2)
xlim([0 4])
ylim([0 4])
% Include time step
time = sprintf('%.2f s',t(i));
text(3,3,time,'fontsize',12)
axis square
xlabel('x distance [m]')
ylabel('y distance [m]')
title('Falling bar')

