function Lidar_Ref_statistics(Lidar_10min,Reference_10min)
m           = 2;
n           = 2;

range_mean = [0, 10];
range_std = [0, 3];

figure('Name','Lidar mean vs Reference mean')
% mean
%N
RegressionSubPlot(m,n,1,Reference_10min.LOS_N_mean,Lidar_10min.LOS_N_mean,false,...
    range_mean,'Mean Reference_N [m/s]','Mean Lidar_N [m/s]','Mean North');
%S
RegressionSubPlot(m,n,2,Reference_10min.LOS_S_mean,Lidar_10min.LOS_S_mean,false,...
    range_mean, 'Mean Reference_S [m/s]','Mean Lidar_S [m/s]','Mean South');
%std
%N
RegressionSubPlot(m,n,3,Reference_10min.LOS_N_std,Lidar_10min.LOS_N_std,false,...
    range_std,'Std Reference_N [m/s]','Std Lidar_N [m/s]','Std North');
%S
RegressionSubPlot(m,n,4,Reference_10min.LOS_S_std,Lidar_10min.LOS_S_std,false,...
    range_std,'Std Reference_S [m/s]','Std Lidar_S [m/s]','Std South');

end

