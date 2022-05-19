function SonicComparison(Sonic_10min)

Sonic_10min.WS_N_TI = Sonic_10min.WS_N_std ./ Sonic_10min.WS_N_mean;
Sonic_10min.WS_S_TI = Sonic_10min.WS_S_std ./ Sonic_10min.WS_S_mean;

p_mean = polyfit(Sonic_10min.WS_N_mean,Sonic_10min.WS_S_mean,1);
p_std = polyfit(Sonic_10min.WS_N_std,Sonic_10min.WS_S_std,1);
p_S_TI = polyfit(Sonic_10min.WS_N_TI,Sonic_10min.WS_S_TI,1);
p_WD = polyfit(Sonic_10min.WD_N_mean,Sonic_10min.WD_S_mean,1);

x_max_mean = [0, 10];
x_max_std = [0, 3];
x_max_TI = [0, 0.5];
x_max_WD = [150, 300];

y_mean = polyval(p_mean,x_max_mean);
y_std = polyval(p_std,x_max_std);
y_S_TI = polyval(p_S_TI,x_max_TI);
y_WD = polyval(p_WD,x_max_WD);

r_mean = corrcoef(Sonic_10min.WS_N_mean,Sonic_10min.WS_S_mean);
r_std = corrcoef(Sonic_10min.WS_N_std,Sonic_10min.WS_S_std);
r_S_TI = corrcoef(Sonic_10min.WS_N_TI,Sonic_10min.WS_S_TI); 
r_WD = corrcoef(Sonic_10min.WD_N_mean,Sonic_10min.WD_S_mean);

r_sq_mean = r_mean(1,2)^2;
r_sq_mean_str = ['R^2 = ' , num2str(r_sq_mean)];

r_sq_std = r_std(1,2)^2;
r_sq_std_str = ['R^2 = ' , num2str(r_sq_std)];

r_sq_S_TI = r_S_TI(1,2)^2;
r_sq_S_TI_str = ['R^2 = ' , num2str(r_sq_S_TI)];

r_sq_WD = r_WD(1,2)^2;
r_WD_str = ['R^2 = ' , num2str(r_sq_WD)];

x_pos_mean = 0.75*x_max_mean(2);
y_pos_mean = 0.2*x_max_mean(2);

x_pos_std = 0.75*x_max_std(2);
y_pos_std = 0.2*x_max_std(2);

x_pos_TI = 0.5*x_max_TI(2);
y_pos_TI = 0.2*x_max_TI(2);

x_pos_WD = 0.5*x_max_WD(2);
y_pos_WD = 0.2*x_max_WD(2);

figure('name','Sonic comparison North and South');
subplot(2,2,1);
hold on; grid on;box on;
plot(Sonic_10min.WS_N_mean,Sonic_10min.WS_S_mean,'.')
plot(x_max_mean,y_mean)
title('10 min mean Windspeed North and South')
xlabel('Mean WS_N Sonic')
ylabel('Mean WS_S Sonic')
text(x_pos_mean,y_pos_mean,r_sq_mean_str);
axis equal
xlim(x_max_mean)
ylim(x_max_mean)

subplot(2,2,2);
hold on; grid on;box on;
plot(Sonic_10min.WS_N_std,Sonic_10min.WS_S_std,'.')
plot(x_max_std,y_std)
title('10 min std. Windspeed North and South')
xlabel('Std. WS_N Sonic')
ylabel('Std. WS_S Sonic')
text(x_pos_std,y_pos_std,r_sq_std_str);
axis equal
xlim(x_max_std)
ylim(x_max_std)

subplot(2,2,3);
hold on; grid on;box on;
plot(Sonic_10min.WS_N_TI,Sonic_10min.WS_S_TI,'.')
plot(x_max_TI,y_S_TI)
title('10 min TI North and South')
xlabel('TI_N')
ylabel('TI_S')
text(x_pos_TI,y_pos_TI,r_sq_S_TI_str);
axis equal
xlim(x_max_TI)
ylim(x_max_TI)

subplot(2,2,4);
hold on; grid on;box on;
plot(Sonic_10min.WD_N_mean,Sonic_10min.WD_S_mean,'.')
plot(x_max_WD,y_WD)
title('WD North and South')
xlabel('WD_N')
ylabel('WD_S')
text(x_pos_WD,y_pos_WD,r_WD_str);
axis equal
xlim(x_max_WD)
ylim(x_max_WD)

end

