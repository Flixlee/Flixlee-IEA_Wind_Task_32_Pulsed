function Timecomparison_Cup_Sonic(Mast_N,Mast_S)
MyXlim=[datenum('2020-09-03 19:00:00') datenum('2020-09-04 19:00:00')];

figure('name','time comparison windspeed')
subplot(2,1,1);
hold on; box on; grid on;
plot(Mast_N.t,Mast_N.WS3)
plot(Mast_N.t,Mast_N.USA_WShorizontal)
xlim(MyXlim)
datetick('x','keeplimits')
ylabel('WS in m/s') 
title('WS_N')
legend('Cup', 'Sonic')

subplot(2,1,2);
hold on; box on; grid on;
plot(Mast_S.t,Mast_S.WS3)
plot(Mast_S.t,Mast_S.USA_WShorizontal)
xlim(MyXlim)
datetick('x','keeplimits')
ylabel('WS in m/s') 
title('WS_S')
legend('Cup', 'Sonic')

MyXlim_10min=[datenum('2020-09-03 19:00:00') datenum('2020-09-03 19:10:00')];

figure('name','time comparison windspeed')
subplot(2,1,1);
hold on; box on; grid on;
plot(Mast_N.t,Mast_N.WS3)
plot(Mast_N.t,Mast_N.USA_WShorizontal)
xlim(MyXlim_10min)
datetick('x','keeplimits')
ylabel('WS in m/s') 
title('WS_N')
legend('Cup', 'Sonic')

subplot(2,1,2);
hold on; box on; grid on;
plot(Mast_S.t,Mast_S.WS3)
plot(Mast_S.t,Mast_S.USA_WShorizontal)
xlim(MyXlim_10min)
datetick('x','keeplimits')
ylabel('WS in m/s') 
title('WS_S')
legend('Cup', 'Sonic')
end

