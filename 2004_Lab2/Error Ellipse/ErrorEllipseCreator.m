function [] = ErrorEllipseCreator(N,x,y) 

% Randomly create y data, meters
figure; plot(x,y,'k.','markersize',6)
grid on; 
xlim([0 260]);
ylim([-30 30]);
xlabel('x [ft]'); 
ylabel('y [ft]'); hold on;
title('Error Ellipes for Isp Model')
% Calculate covariance matrix
P = cov(x,y);
mean_x= mean(x);
mean_y= mean(y);
% Calculate the define the error ellipses
n=100; 
% Number of points around ellipse
p=0:pi/n:2*pi; 
% angles around a circle
[eigvec,eigval] = eig(P); 
% Compute eigen-stuff
xy_vect= [cos(p'),sin(p')] * sqrt(eigval) * eigvec'; 
% Transformation
x_vect= xy_vect(:,1);
y_vect= xy_vect(:,2);
% Plot the error ellipses overlaid on the same figure
plot(1*x_vect+mean_x, 1*y_vect+mean_y, 'b')
plot(2*x_vect+mean_x, 2*y_vect+mean_y,'g')
plot(3*x_vect+mean_x, 3*y_vect+mean_y,'r')
