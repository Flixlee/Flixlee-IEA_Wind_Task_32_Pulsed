function CupComparison(Mast_N,Mast_S,Reference,Tstart,Tend)
%statistics
t1                          = datetime(Tstart); 
t2                          = datetime(Tend); 
t_vec                       = datenum(t1:minutes(10):t2); 

n_10min                     = length(t_vec)-1;
for i_10min= 1:n_10min
    Considered            = Reference.t>=t_vec(i_10min) & Reference.t<t_vec(i_10min+1);
	Cup_10min.WS_N_mean(i_10min)    = nanmean(Mast_N.WS1 (Considered));     
    Cup_10min.WS_S_mean(i_10min)    = nanmean(Mast_S.WS1 (Considered)); 
  	Cup_10min.WS_N_std(i_10min)     = nanstd (Mast_N.WS1 (Considered)); 
    Cup_10min.WS_S_std(i_10min)     = nanstd (Mast_S.WS1 (Considered));
    Cup_10min.WD_N_mean(i_10min)    = nanmean(Mast_N.WD1 (Considered));     
    Cup_10min.WD_S_mean(i_10min)    = nanmean(Mast_S.WD1 (Considered));
    
end


Cup_10min.t           = t_vec(1:end-1);
Cup_10min.Timestamp   = datestr(t_vec(1:end-1),31); 

Cup_10min.WS_N_TI = Cup_10min.WS_N_std ./ Cup_10min.WS_N_mean;
Cup_10min.WS_S_TI = Cup_10min.WS_S_std ./ Cup_10min.WS_S_mean;

m           = 2;
n           = 2;

range_MEAN = [0, 10];
range_STD = [0, 3];
range_TI = [0, 0.5];
range_WD = [150, 300];

figure('Name','Cup comparison North and South')
RegressionSubPlot(m,n,1,Cup_10min.WS_N_mean,Cup_10min.WS_S_mean,...
    range_MEAN,'Mean WS_N Cup','Mean WS_S Cup','10 min mean Windspeed North and South');

RegressionSubPlot(m,n,2,Cup_10min.WS_N_std,Cup_10min.WS_S_std,...
    range_STD, 'Std WS_N Cup','Std WS_S Cup','10 min std. Windspeed North and South');

RegressionSubPlot(m,n,3,Cup_10min.WS_N_TI,Cup_10min.WS_S_TI,...
    range_TI,  'TI_N',  'TI_S',  'TI');

RegressionSubPlot(m,n,4,Cup_10min.WD_N_mean,Cup_10min.WD_S_mean,...
    range_WD,  'WD_N',  'WD_S',  'WD');
end

