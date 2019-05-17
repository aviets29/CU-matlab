function [ ] = flex(K1,K2,K3,K4,Thd)

global Kg Km Rm

L = 0.45;        % [m]
M_arm = 0.06;    % [kg]
M_tip = 0.05;     % [kg]
fc = 1.8;         % [Hz]

J_arm = M_arm*L^2*(1/3);     % [kg*m^2]
J_hub = 0.002;              % [kg*m^2]
J_M = M_tip*L^2;            % [kg*m^2]
J_L = J_arm + J_M;          % [kg*m^2]

K_arm = (2*pi*fc)^2*(J_L);  % [kg*m^2]

p1 = -Kg^2*Km^2/(J_hub*Rm);
p2 = Kg^2*Km^2*L/(J_hub*Rm);
q1 = K_arm/(L*J_hub);
q2 = -K_arm*(J_hub+J_L)/(J_L*J_hub);
r1 = Kg*Km/(J_hub*Rm);
r2 = -Kg*Km*L/(J_hub*Rm);

l3 = -p1 + K3*r1 + K4*r2;
l2 = -q2 + K1*r1 + K2 + K4*(p2*r1 - r2*p1);
l1 = p1*q2 - q1*p2 + K3*(q1*r2 - r1*q2) + K2*(p2*r1 - r2*p1);
l0 = K1*(q1*r2-r1*q2);

num_Th = K1*[r1 0 (r2*q1-r1*q2)];
den_Th = [1 l3 l2 l1 l0];
num_D =  Thd*K1*[r2 (p2*r1-r2*p1) 0];
den_D =  [1 l3 l2 l1 l0];

H_Th = tf(num_Th,den_Th);
[Th,t] = step(H_Th);
H_D = tf(num_D,den_D);
[D,t2] = step(H_D);
Th = Th*Thd;
ind = find(Th < (Th(end) - Th(end)*.05),1,'last');

time05 = t(ind)
overshoot = 100*abs((max(Th)-Thd)/Thd)

plot(t,Th)
Th_2 = linspace(Th(1),Th(end),4000);
t_2 = linspace(t(1),t(end),4000);
D_2 = linspace(D(1),D(end),4000);
t2_2 = linspace(t2(1),t2(end),4000);

for j = 2:length(Th)
        Vin(j) = (Thd - Th_2(j))*K1 - K3*((Th_2(j) - Th_2(j-1))/(t_2(j)-t_2(j-1))) ...
                  - K2*D_2(j) - K3*((D_2(j)-D_2(j-1))/(t2_2(j)-t2_2(j-1)));
end

if max(Vin) > 5
    error('Exceeds voltage')
end

[u,tgen] = gensig('square',7.5,10,0.1);
figure()
lsim(H_Th,(u-0.5)*Thd,tgen)
title(sprintf('K_{1} = %.3f K_{2} = %.3f K_{3} = %.3f K_{4} = %.3f',K1(1),K2(1),K3(1),K4(1)));
xlabel('time [s]')
ylabel('Angle [rad]')

figure()
lsim(H_D,(u-0.5)*Thd,tgen)
title(sprintf('K_{1} = %.3f K_{2} = %.3f K_{3} = %.3f K_{4} = %.3f',K1(1),K2(1),K3(1),K4(1)));
xlabel('time [s]')
ylabel('Tip deflection [m]')

% for i = 1:length(Th)
%     x_dist = [0 L*cos(Th(i))];
%     y_dist = [0 L*sin(Th(i))];
%     
%     if i == length(Th)
%         d1 = 0;
%         d2 = 0;
%     else
%         if Th(i+1) > Th(i)
%             d1 = [x_dist L*cos(Th(i))-D(i)*sin(Th(i))];
%             d2 = [y_dist L*sin(Th(i))+D(i)*cos(Th(i))];
%         elseif Th(i+1) < Th(i)
%             d1 = [x_dist L*cos(Th(i))+D(i)*sin(Th(i))];
%             d2 = [y_dist L*sin(Th(i))-D(i)*cos(Th(i))];
%         end
%     end
%     plot(x_dist,y_dist,'-b','linewidth',2);
%     hold on;
%     plot(d1,d2,'-b','linewidth',2);
%     hold off;
%     xlim([-L L])
%     ylim([-L L])
%     xlabel('x distance [m]')
%     ylabel('y distance [m]')
%     title('flex moving arm')
%     M(i) = getframe(gcf);
% end
% 
% fps = length(t)/t(end);
% movie2avi(M,'mybar.avi','fps',fps);

end

