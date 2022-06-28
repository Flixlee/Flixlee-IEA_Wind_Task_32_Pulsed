function Timecomparison_Lidar(Tstart,Tend,Lidar_10min)
MyXlim=[datenum(Tstart) datenum(Tend)];


figure('name','time comparison TI Period 1')
subplot(2,1,1);
hold on; box on; grid on;
scatter(Lidar_10min.t,Lidar_10min.LOS_TI_N,'.')
xlim(MyXlim)
datetick('x','keeplimits')
ylabel('TI Lidar') 
title('TI_N')


subplot(2,1,2);
hold on; box on; grid on;
scatter(Lidar_10min.t,Lidar_10min.LOS_TI_S,'.')
xlim(MyXlim)
datetick('x','keeplimits')
ylabel('TI Lidar') 
title('TI_S')


end

