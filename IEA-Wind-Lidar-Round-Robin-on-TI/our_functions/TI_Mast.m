function  TI_Mast(Mast_N,Mast_S,Reference,Tstart,Tend,Sonic_10min)
%Cup_10min
t1                          = datetime(Tstart); 
t2                          = datetime(Tend); 
t_vec                       = datenum(t1:minutes(10):t2); 

n_10min                     = length(t_vec)-1;
for i_10min= 1:n_10min
    Considered            = Reference.t_N>=t_vec(i_10min) & Reference.t_N<t_vec(i_10min+1);
	Cup_10min.WS_N_mean(i_10min)    = nanmean(Mast_N.WS1 (Considered));     
    Cup_10min.WS_S_mean(i_10min)    = nanmean(Mast_S.WS1 (Considered)); 
  	Cup_10min.WS_N_std(i_10min)     = nanstd (Mast_N.WS1 (Considered)); 
    Cup_10min.WS_S_std(i_10min)     = nanstd (Mast_S.WS1 (Considered));
    Cup_10min.WD_N_mean(i_10min)    = nanmean(Mast_N.WD1 (Considered)); % not same hight as Sonic     
    Cup_10min.WD_S_mean(i_10min)    = nanmean(Mast_S.WD1 (Considered)); % not same hight as Sonic  
     
end


Cup_10min.t           = t_vec(1:end-1);
Cup_10min.Timestamp   = datestr(t_vec(1:end-1),31); 

% Real Function
Cup_10min_N_TI = Cup_10min.WS_N_std./Cup_10min.WS_N_mean;
Cup_10min_S_TI = Cup_10min.WS_S_std./Cup_10min.WS_S_mean;

Sonic_10min_N_TI = Sonic_10min.WS_N_std./Sonic_10min.WS_N_mean;
Sonic_10min_S_TI = Sonic_10min.WS_S_std./Sonic_10min.WS_S_mean;


m           = 1;
n           = 2;

range_TI = [0, 0.5];

figure('Name','TI Cup vs Sonic')
RegressionSubPlot(m,n,1,Sonic_10min_N_TI,Cup_10min_N_TI,...
    range_TI,'Sonic TI_N','Cup TI_N','TI_N');

RegressionSubPlot(m,n,2,Sonic_10min_S_TI,Cup_10min_S_TI,...
    range_TI,'Sonic TI_S','Cup TI_S','TI_S');
end

