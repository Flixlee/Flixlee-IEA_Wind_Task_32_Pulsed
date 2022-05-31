function Cup_vs_Sonic(Mast_N,Mast_S,Reference,Tstart,Tend,Sonic_10min)
%Cup_10min
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
    Cup_10min.WD_N_mean(i_10min)    = nanmean(Mast_N.WD1 (Considered)); % not same hight as Sonic     
    Cup_10min.WD_S_mean(i_10min)    = nanmean(Mast_S.WD1 (Considered)); % not same hight as Sonic  
     
end


Cup_10min.t           = t_vec(1:end-1);
Cup_10min.Timestamp   = datestr(t_vec(1:end-1),31); 

% REAL FUNCTION

m           = 2;
n           = 2;

range_MEAN = [0, 10];
range_WD = [150, 300];

figure('Name','Sonic vs Cup 10min Mean')
RegressionSubPlot(m,n,1,Sonic_10min.WS_N_mean,Cup_10min.WS_N_mean,...
    range_MEAN,'Mean WS_N Sonic [m/s]','Mean WS_N Cup [m/s]','Mean WS North');

RegressionSubPlot(m,n,2,Sonic_10min.WS_S_mean,Cup_10min.WS_S_mean,...
    range_MEAN,'Mean WS_S Sonic [m/s]','Mean WS_S Cup [m/s]','Mean WS South');

RegressionSubPlot(m,n,3,Sonic_10min.WD_N_mean,Cup_10min.WD_N_mean,...
    range_WD,  'Mean WD_N Sonic [deg]','Mean WD_N Cup [deg]','Mean WD North');

RegressionSubPlot(m,n,4,Sonic_10min.WD_S_mean,Sonic_10min.WD_N_mean,...
    range_WD,  'Mean WD_S Sonic [deg]','Mean WD_S Cup [deg]','Mean WD South');
end

