function [alpha_max,cl_max,liftslope,alpha_0,cd_i_max,e_max] = plotCoeffs(N,A,M,rho,alpha,v,S,AR,d,type,fig)

L = N.*cosd(alpha) - A.*sind(alpha);
D = N.*sind(alpha) + A.*cosd(alpha); 

cl = smooth(smooth(L./(.5*rho.*v.^2*S)));
cd = smooth(smooth(D./(.5*rho.*v.^2*S)));

M_LE = (M - d*N);
cm = smooth(smooth(M_LE./(.5*rho.*v.^2*S*.06)));


for i = 2:length(cl)-1
    if cl(i) > cl(i-1) && cl(i) < cl(i+1) && alpha(i) > 0
        cl_max = cl(i);
        alpha_max = alpha(i);
        cl_max_ind = i;
    end
end

cl_max = max(cl(1:26));
cl_max_ind = find(cl == cl_max);
alpha_max = alpha(cl_max_ind);

count = 1;
for i = 1:length(alpha)
    if alpha(i) > -3.5 && alpha(i) < 3.5
        inds1(count) = i;
        count = count + 1;
    end
    if alpha(i) > -.5 && alpha(i) < .5
        ind2 = i;
    end
end

p = polyfit(alpha(inds1)*pi/180,cl(inds1),1);
liftslope = p(1);
alpha_0 = -(180/pi)*p(2)/p(1);

cd_skin = cd(ind2);
cd_i = cd - cd_skin;

p2 = polyfit(alpha,cd_i,2);
fit = polyval(p2,alpha);
cd_i_new = fit - min(fit);

e =  cl.^2./(pi*cd_i*AR);
%e = cl(cl_max_ind).^2./(pi*cd_i(cl_max_ind)*AR);

e_max = e(cl_max_ind);
cd_i_max = cd_i(cl_max_ind);

%% PLLT for short wing


%if strcmp(type,'Short') || strcmp(type,'Long')
if ~strcmp(type,'Elliptical')
    Num = 1:2:99;
    a0_t = 2*pi;
    a0_r = 2*pi;
    aero_t = 0*(pi/180);
    aero_r = 0*(pi/180);
    c_r = .06;
    c_t = .06;
    b = sqrt(AR*S);
    
    for j = 1:length(alpha)
        geo_t = alpha(j)*(pi/180); 
        geo_r = alpha(j)*(pi/180);
        [e_s(j),c_L_s(j),c_Di_s(j)] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,Num);
    end
   
%     plot(alpha,c_L_s,alpha,cl,'Linewidth',1.3);
%     title(['Experiment & PLLT for ',type, ' Wing at ' num2str(round(v(1))),' m/s']);
%     xlabel('\alpha [deg]');
%     ylabel('C_l [n/a]');
%     xlim([min(alpha),max(alpha)]);
%     legend('PLLT','Experimental','Location','Southeast');
%     grid on
    
    p = polyfit(alpha*pi/180,c_L_s',1);
    a = p(1);
    Alpha_0 = -(180/pi)*p(2)/p(1);
else
    a0 = 2*pi;
    a = a0/(1+(a0/(pi*AR)));
    Alpha_0 = 0;
    e_s = 1;
    
    figure(1)
    plot(alpha,a*alpha*pi/180,alpha,cl,'Linewidth',1.3);
    title(['Comparison of Experiment to PLLT for ',type, ' Wing at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_l [n/a]');
    xlim([min(alpha),max(alpha)]);
    legend('PLLT','Experimental','Location','Southeast');
    grid on
end

if fig == 1
    figure(9)
    plot(alpha,cl,'linewidth',1.2);
    title(['C_{l} vs. \alpha at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_{l} [n/a]');
    xlim([min(alpha) max(alpha)]);
    legend('Short','Long','Elliptical','Location','Best');
    hold on
    
    figure(11)
    plot(alpha,cd,'linewidth',1.2);
    title(['C_{d} vs. \alpha at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_{m,LE} [n/a]');
    xlim([min(alpha) max(alpha)]);
    legend('Short','Long','Elliptical','Location','Best');
    hold on
    
    figure(13)
    plot(alpha,cm,'linewidth',1.2);
    title(['C_{m,LE} vs. \alpha at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_{m,LE} [n/a]');
    xlim([min(alpha) max(alpha)]);
    legend('Short','Long','Elliptical','Location','Best');
    hold on
    
    figure(15)
    plot(alpha,cd_i_new,'linewidth',1.2);
    hold on
    scatter(alpha,cd_i,'.');
    title(['C_{d,i} vs. \alpha at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_{d,i} [n/a]');
    xlim([min(alpha) max(alpha)]);
    legend('Short fit','Short data','Long fit','Long data','Elliptical fit','Elliptical data','Location','Best')
    
    fprintf('Type\t\tLift Slope\t\tAlpha L=0\t\tSpan Efficiency\n')
    fprintf('PLLT\t\t%.2f pi\t\t\t%.2f\t\t\t%.2f\n',a/pi,Alpha_0,e_s(1));
    fprintf('15\t\t\t%.2f pi\t\t\t%.2f\t\t\t%.2f\n',liftslope/pi,alpha_0,e_max);
else
    fprintf('25\t\t\t%.2f pi\t\t\t%.2f\t\t\t%.2f\n\n',liftslope/pi,alpha_0,e_max);
    figure(10)
    plot(alpha,cl,'linewidth',1.2);
    title(['C_{l} vs. \alpha at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_{l} [n/a]');
    xlim([min(alpha) max(alpha)]);
    legend('Short','Long','Elliptical','Location','Best');
    hold on
    
    figure(12)
    plot(alpha,cd,'linewidth',1.2);
    title(['C_{d} vs. \alpha at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_{m,LE} [n/a]');
    xlim([min(alpha) max(alpha)]);
    legend('Short','Long','Elliptical','Location','Best');
    hold on
    
    figure(14)
    plot(alpha,cm,'linewidth',1.2);
    title(['C_{m,LE} vs. \alpha at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_{m,LE} [n/a]');
    xlim([min(alpha) max(alpha)]);
    legend('Short','Long','Elliptical','Location','Best');
    hold on
    
    figure(16)
    plot(alpha,cd_i_new,'linewidth',1.2);
    hold on
    scatter(alpha,cd_i,'.')
    title(['C_{d,i} vs. \alpha For ' type ' Wing at ' num2str(round(v(1))),' m/s']);
    xlabel('\alpha [deg]');
    ylabel('C_{d,i} [n/a]');
    xlim([min(alpha) max(alpha)]);
    legend('Short fit','Short data','Long fit','Long data','Elliptical fit','Elliptical data','Location','Best');
end
end


