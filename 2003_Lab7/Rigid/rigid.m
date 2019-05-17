function [time05,overshoot,w,zeta] = rigid(Kp,Kd,Thd)

global Kg Km Rm J L
 
% m
num = Kp*Kg*Km/(J*Rm);
den = [1 , (Kg^2*Km^2/(J*Rm) + Kd*Kg*Km/(J*Rm)) , Kp*Kg*Km/(J*Rm)];
H = tf(num,den);

[Th,t] = step(H);
Th = Th*Thd;
plot(t,Th);
hold on
ylim=get(gca,'ylim');
xlim=get(gca,'xlim');
text(xlim(2)-.2,ylim(1)+.3,sprintf('Kp = %.3f',Kp))
text(xlim(2)-.2,ylim(1)+.2,sprintf('Kd = %.3f',Kd))
title('Dampened Movement of Rigid Bar')
xlabel('Time [s]')
ylabel('Angle [rad]')

ind = 1;
for j = 1:length(Th)
    if Th(j) < (Thd - Thd*.05)
        ind = ind +1;
    end
end


[u,tgen] = gensig('square',7.5,10,0.1);
figure()
lsim(H,(u-0.5)*Thd,tgen)
title(sprintf('K_{1} = %.3f K_{3} = %.3f',Kp(1),Kd(1)));
xlabel('Time [s]')
ylabel('Angle [rad]')

w = sqrt(Kp*Kg*Km/(J*Rm));
zeta = (Kd*Kg*Km+Kg^2*Km^2)/(2*sqrt(Kp*Kg*Km*J*Rm));
time05 = 3/(zeta*w);
overshoot = exp(-zeta*pi/sqrt(1-zeta^2));

end
% for i = 1:length(Th)
%     x_dist = [0,L*cos(Th(i))];
%     y_dist = [0,L*sin(Th(i))];
% 
%     plot(x_dist,y_dist,'-b','linewidth',2);
%     xlim([-L L])
%     ylim([-L L])
%     axis square
%     xlabel('x distance [m]')
%     ylabel('y distance [m]')
%     title('Stiff moving arm')
%     M(i) = getframe(gcf);
% end
% 
% fps = length(t)/t(end);
% movie2avi(M,'mybar.avi','fps',fps);


