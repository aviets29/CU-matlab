clear all; close all;
files = dir('*.txt');

for i = 1:length(files)
 
    data = load(files(i).name);
    t = (data(1:9000,1)-data(1,1))*.001;
    Th = data(1:9000,2);
    d = data(1:9000,3);
    w = data(1:9000,4);
    v_tip = data(1:9000,5);
    Thd = data(1:9000,6);
    V_out = data(1:9000,7);
    K1 = data(1:9000,8);
    K2 = data(1:9000,9);
    K3 = data(1:9000,10);
    K4 = data(1:9000,11);
    
    if K2 == 0
        figure()
        plot(t,Th,t,Thd)
        title(sprintf('K_{1} = %.3f K_{3} = %.3f',K1(1),K3(1)));
        xlabel('time [s]')
        ylabel('\theta [rad]')
        xlim([t(1) t(end)]);
        
   else
        figure()
        plot(t,Th,t,Thd)
        title(sprintf('K_{1} = %.3f K_{2} = %.3f K_{3} = %.3f K_{4} = %.3f',K1(1),K2(1),K3(1),K4(1)));
        xlabel('time [s]')
        ylabel('\theta [rad]')
        xlim([t(1) t(end)]);
        
        figure()
        plot(t,d,t,Thd)
        title(sprintf('K_{1} = %.3f K_{2} = %.3f K_{3} = %.3f K_{4} = %.3f',K1(1),K2(1),K3(1),K4(1)));
        xlabel('time [s]')
        ylabel('Tip deflection [m]')
        xlim([t(1) t(end)]);
    end
ind1 = find(Thd < 0,1,'last');
ind = find(Th < (Th(end) - Th(end)*.05),1,'last');

time05(i) = t(ind)-t(ind1);
overshoot(i) = 100*abs((max(Th)-Thd(1))/Thd(1));

end