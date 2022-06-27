function Timecomparison_Lidar_2_fit(Tstart_2,Tend_2,Lidar_10min_2_o)
MyXlim=[datenum(Tstart_2) datenum(Tend_2)];
MyYlim=[-0.5 0.5];

figure('name','time comparison TI Period 2 Fit')
subplot(2,1,1);
hold on; box on; grid on;
scatter(Lidar_10min_2_o.t,Lidar_10min_2_o.LOS_TI_N_2_fit,'.')
xlim(MyXlim)
ylim(MyYlim)
datetick('x','keeplimits')
yticks(-0.5:0.1:0.5)
ylabel('TI in m/s') 
title('TI 2 Fit_N')


subplot(2,1,2);
hold on; box on; grid on;
scatter(Lidar_10min_2_o.t,Lidar_10min_2_o.LOS_TI_S_2_fit,'.')
xlim(MyXlim)
ylim([0 0.5])
datetick('x','keeplimits')
yticks(0:0.1:0.5)
ylabel('TI in m/s') 
title('TI 2 Fit_S')


end

