function MetmastComparison2(Mast_N,Mast_S,Reference_10min)

range_HWS = [0 15];
range_CWS = [0 15];
range_WD = [150 300];
range_TI = [0 0.5];

m           = 2;
n           = 2;

figure('Name','Comparison Metmast North and South')
RegressionSubPlot(m,n,1,Mast_N.USA_WShorizontal,Mast_S.USA_WShorizontal,false,...
    range_HWS,'Horiz. WS_N Sonic [m/s]','Horiz. WS_S Sonic [m/s]','Horizontal Windspeed North and South');

RegressionSubPlot(m,n,2,Mast_N.WS1,Mast_S.WS1,false,...
    range_CWS, 'Horiz. WS_N Cup [m/s]','Horiz. WS_S Cup [m/s]','Horizontal Windspeed North and South');

RegressionSubPlot(m,n,3,Mast_N.USA_WD,Mast_S.USA_WD,true,...
    range_WD,  'WD_N [deg]',  'WD_S [deg]',  'Winddirection North and South');

RegressionSubPlot(m,n,4,Reference_10min.LOS_TI_N,Reference_10min.LOS_TI_S,false,...
    range_TI,  'TI Reference_N',  'TI Reference_S',  'TI North and South');







end
