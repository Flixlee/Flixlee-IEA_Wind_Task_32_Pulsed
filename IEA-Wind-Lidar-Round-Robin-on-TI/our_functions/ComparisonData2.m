function  ComparisonData2(Reference_10min,Lidar_10min)

range_MEAN  = [0 10];
range_STD   = [0 10];
range_TI    = [0 0.5];

m           = 2;
n           = 3;


figure('name','comparison Referencedata');

RegressionSubPlot(m,n,1,Reference_10min.LOS_N_mean,Reference_10min.LOS_S_mean,...
    range_MEAN,'mean Reference_N','mean Reference_S','Reference mean N to S');
%1
RegressionSubPlot(m,n,2,Reference_10min.LOS_N_std,Reference_10min.LOS_S_std,...
    range_STD, 'std Reference_N','std Reference_S','Reference std N to S');
%2
RegressionSubPlot(m,n,3,Lidar_10min.LOS_N_mean,Lidar_10min.LOS_S_mean,...
    range_TI,  'Lidar mean N',  'Lidar mean S',  'Lidar mean N to S');
%3
RegressionSubPlot(m,n,4,Lidar_10min.LOS_N_std,Lidar_10min.LOS_S_std,...
    range_MEAN,'Lidar std N','Lidar std S','Lidar std N to S');
%4
RegressionSubPlot(m,n,5,Reference_10min.LOS_TI_N,Reference_10min.LOS_TI_S,...
    range_STD ,'TI Reference_N','TI Reference_S','Reference TI_S über Reference TI_N');
%5
RegressionSubPlot(m,n,6,Lidar_10min.LOS_TI_N,Lidar_10min.LOS_TI_S,...
 range_TI  ,'TI Lidar_N',  'TI Lidar_S',  'Lidar TI_S über Lidar TI_N');    
end 
 
  