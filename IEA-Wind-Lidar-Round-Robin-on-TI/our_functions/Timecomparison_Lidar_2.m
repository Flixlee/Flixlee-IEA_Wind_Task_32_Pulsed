function Timecomparison_Lidar_2(Tstart_2,Tend_2,Lidar_10min_2_o)
MyXlim=[datenum(Tstart_2) datenum(Tend_2)];

figure('name','time comparison TI Period 2')
subplot(2,1,1);
hold on; box on; grid on;
scatter(Lidar_10min_2_o.t,Lidar_10min_2_o.LOS_TI_N_2,'.')
xlim(MyXlim)
datetick('x','keeplimits')
yticks(-0.5:0.1:0.5)
ylabel('TI') 
title('TI 2_N')


subplot(2,1,2);
hold on; box on; grid on;
scatter(Lidar_10min_2_o.t,Lidar_10min_2_o.LOS_TI_S_2,'.')
xlim(MyXlim)
ylim([0 0.5])
datetick('x','keeplimits')
yticks(0:0.1:0.5)
ylabel('TI') 
title('TI 2_S')


end

