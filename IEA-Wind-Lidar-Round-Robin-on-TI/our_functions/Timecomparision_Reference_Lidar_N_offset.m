function Timecomparision_Reference_Lidar_N_offset(Reference,Lidar_N_offset,Lidar_N)
MyXlim=[datenum('2020-09-03 19:00:00') datenum('2020-09-03 19:10:00')];

figure('name','time comparison windspeed')
subplot(2,1,1);
hold on; box on; grid on;
plot(Reference.t,Reference.LOS_N)
plot(Lidar_N_offset.t,Lidar_N_offset.RWS)
xlim(MyXlim)
datetick('x','keeplimits')
ylabel('LOS in m/s') 
title('WS_N offset')
legend('Reference_N', 'Lidar_N offset')

subplot(2,1,2);
hold on; box on; grid on;
plot(Reference.t,Reference.LOS_N)
plot(Lidar_N.t,Lidar_N.RWS)
xlim(MyXlim)
datetick('x','keeplimits')
ylabel('LOS in m/s') 
title('WS_N')
legend('Reference_N', 'Lidar_N')
end

