function SonicComparison2(Sonic_10min)

Sonic_10min.WS_N_TI = Sonic_10min.WS_N_std ./ Sonic_10min.WS_N_mean;
Sonic_10min.WS_S_TI = Sonic_10min.WS_S_std ./ Sonic_10min.WS_S_mean;

m           = 2;
n           = 2;

range_MEAN = [0, 10];
range_STD = [0, 3];
range_TI = [0, 0.5];
range_WD = [150, 300];

figure('Name','Sonic comparison North and South')
RegressionSubPlot(m,n,1,Sonic_10min.WS_N_mean,Sonic_10min.WS_S_mean,...
    range_MEAN,'Mean WS_N Sonic','Mean WS_S Sonic','Mean WS');

RegressionSubPlot(m,n,2,Sonic_10min.WS_N_std,Sonic_10min.WS_S_std,...
    range_STD, 'Std WS_N Sonic','Std WS_S Sonic','Std. WS');

RegressionSubPlot(m,n,3,Sonic_10min.WS_N_TI,Sonic_10min.WS_S_TI,...
    range_TI,  'TI_N',  'TI_S',  'TI');

RegressionSubPlot(m,n,4,Sonic_10min.WD_N_mean,Sonic_10min.WD_S_mean,...
    range_WD,  'WD_N',  'WD_S',  'WD');

end