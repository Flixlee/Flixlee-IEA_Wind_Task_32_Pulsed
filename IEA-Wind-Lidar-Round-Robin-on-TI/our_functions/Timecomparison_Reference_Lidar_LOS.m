function Timecomparison_Reference_Lidar_LOS(Reference,Lidar_N,Lidar_S)
MyXlim=[datenum('2020-09-03 19:00:00') datenum('2020-09-04 19:00:00')];

figure('name','time comparison windspeed')
subplot(2,1,1);
hold on; box on; grid on;
plot(Reference.t_N,Reference.LOS_N)
plot(Lidar_N.t,Lidar_N.RWS)
xlim(MyXlim)
datetick('x','keeplimits')
ylabel('LOS [m/s]') 
title('WS_N')
legend('Reference_N', 'Lidar_N')

subplot(2,1,2);
hold on; box on; grid on;
plot(Reference.t_N,Reference.LOS_S)
plot(Lidar_S.t,Lidar_S.RWS)
xlim(MyXlim)
datetick('x','keeplimits')
ylabel('LOS [m/s]') 
title('WS_S')
legend('Reference_S', 'Lidar_S')

MyXlim_10min=[datenum('2020-09-03 19:00:00') datenum('2020-09-03 19:10:00')];

figure('name','time comparison windspeed')
subplot(2,1,1);
hold on; box on; grid on;
plot(Reference.t_N,Reference.LOS_N)
plot(Lidar_N.t,Lidar_N.RWS)
xlim(MyXlim_10min)
datetick('x','keeplimits')
ylabel('LOS [m/s]') 
title('WS_N')
legend('Reference_N', 'Lidar_N')

subplot(2,1,2);
hold on; box on; grid on;
plot(Reference.t_N,Reference.LOS_S)
plot(Lidar_S.t,Lidar_S.RWS)
xlim(MyXlim_10min)
datetick('x','keeplimits')
ylabel('LOS [m/s]') 
title('WS_S')
legend('Reference_S', 'Lidar_S')
end

