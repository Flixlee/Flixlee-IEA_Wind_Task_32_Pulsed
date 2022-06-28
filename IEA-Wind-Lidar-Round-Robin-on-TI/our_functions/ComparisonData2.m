function  ComparisonData2(Reference_10min,Lidar_10min)

range_MEAN  = [0 10];
range_STD   = [0 10];
range_TI    = [0 0.5];

m           = 2;
n           = 3;


figure('name','comparison Referencedata');

RegressionSubPlot(m,n,1,Reference_10min.LOS_N_mean,Reference_10min.LOS_S_mean,false,...
    range_MEAN,'Mean Reference_N [m/s]','Mean Reference_S [m/s]','Reference Mean N to S');
%1
RegressionSubPlot(m,n,2,Reference_10min.LOS_N_std,Reference_10min.LOS_S_std,false,...
    range_STD, 'Std Reference_N [m/s]','std Reference_S [m/s]','Reference std N to S');
%2
RegressionSubPlot(m,n,3,Lidar_10min.LOS_N_mean,Lidar_10min.LOS_S_mean,false,...
    range_TI,  'Mean Lidar_N [m/s]',  'Mean Lidar_S',  'Mean Lidar N to S');
%3
RegressionSubPlot(m,n,4,Lidar_10min.LOS_N_std,Lidar_10min.LOS_S_std,false,...
    range_MEAN,'Std Lidar_N [m/s]','Std Lidar_S [m/s]','Std Lidar N to S');
%4
RegressionSubPlot(m,n,5,Reference_10min.LOS_TI_N,Reference_10min.LOS_TI_S,false,...
    range_STD ,'TI Reference_N','TI Reference_S','Reference TI_S to Reference TI_N');
%5
RegressionSubPlot(m,n,6,Lidar_10min.LOS_TI_N,Lidar_10min.LOS_TI_S,false,...
 range_TI  ,'TI Lidar_N',  'TI Lidar_S',  'Lidar TI_S to Lidar TI_N');    
end 
 
  