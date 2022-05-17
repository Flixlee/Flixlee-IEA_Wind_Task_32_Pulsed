clearvars;clc;close all
RoundRoubin_ReferencePulsed
addpath('our_functions')
%% Task 1 Part1: clean data (9999 in Lidar_N.RWS bzw Lidar_S.RWS)

Fehlerwerte = Lidar_N.RWS==9999; %Logical Array 
Lidar_N.RWS(Fehlerwerte)=interp1(Lidar_N.t(~Fehlerwerte),Lidar_N.RWS(~Fehlerwerte),Lidar_N.t(Fehlerwerte)); 

Fehlerwerte = Lidar_S.RWS==9999;
Lidar_S.RWS(Fehlerwerte)=interp1(Lidar_S.t(~Fehlerwerte),Lidar_S.RWS(~Fehlerwerte),Lidar_S.t(Fehlerwerte)); 

% call function for Timecomparison Reference Lidar LOS 1 day and 10 min
Timecomparison_Reference_Lidar_LOS(Reference,Lidar_N,Lidar_S)

%% Task 2 comparison pulsed (simple 10min)

Lidar_10min = Calculate10minStastics_Lidar(Lidar_N,Lidar_S,Tstart,Tend);


Lidar_10min.LOS_TI_N = Lidar_10min.LOS_N_std./Lidar_10min.LOS_N_mean; 
Lidar_10min.LOS_TI_S = Lidar_10min.LOS_S_std./Lidar_10min.LOS_S_mean; 


p_N = polyfit(Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N,1); %Regression
p_S = polyfit(Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S,1);

x_N = [0 , 0.7];
x_S = x_N;
y_N = polyval(p_N, x_N); 
y_S = polyval(p_S, x_S);

r_N = corrcoef(Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N); %R = corealcoefficient ()
r_S = corrcoef(Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S);

r_srt_N = r_N(1,2)^2 ;%R^2 = determination coefficient
r_srt_N_string = ['R^2 = ' , num2str(r_srt_N)]; 

r_srt_S = r_S(1,2)^2;
r_srt_S_string = ['R^2 = ' , num2str(r_srt_S)]; 

x_r = 0.5*x_N(2);
y_r = 0.2*x_N(2);

figure('name','comparison TI');
subplot(1,2,1);
hold on; grid on; box on;
plot(x_N,y_N) 
plot(Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N,'b.')
text(x_r,y_r,r_srt_N_string); 
title('Lidar TI_N über Reference TI_N')
xlabel('TI Reference')
ylabel('TI Lidar')
axis equal
xlim(x_N)
ylim(x_N)

subplot(1,2,2);
hold on; grid on; box on;
plot(x_S,y_S) 
plot(Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S,'b.')
text(x_r,y_r,r_srt_S_string);
title('Lidar TI_S über Reference TI_S')
xlabel('TI Reference')
ylabel('TI Lidar')
axis equal
xlim(x_S)
ylim(x_S)

%% Comparison Reference TI and Lidar TI data
ComparisonData(Reference_10min,Lidar_10min) 
%% Metmast Data Comparison
MetmastComparison(Mast_N,Mast_S,Reference_10min)
% change to 10min for comparison

%% Sonic Data Comparison
%statistics
t1                          = datetime(Tstart); 
t2                          = datetime(Tend); 
t_vec                       = datenum(t1:minutes(10):t2); 

n_10min                     = length(t_vec)-1;
for i_10min= 1:n_10min
    Considered            = Reference.t>=t_vec(i_10min) & Reference.t<t_vec(i_10min+1);
	Sonic_10min.WS_N_mean(i_10min)    = nanmean(Mast_N.USA_WShorizontal (Considered));     
    Sonic_10min.WS_S_mean(i_10min)    = nanmean(Mast_S.USA_WShorizontal (Considered)); 
  	Sonic_10min.WS_N_std(i_10min)     = nanstd (Mast_N.USA_WShorizontal (Considered)); 
    Sonic_10min.WS_S_std(i_10min)     = nanstd (Mast_S.USA_WShorizontal (Considered));
    Sonic_10min.WD_N_mean(i_10min)    = nanmean(Mast_N.USA_WD (Considered));     
    Sonic_10min.WD_S_mean(i_10min)    = nanmean(Mast_S.USA_WD (Considered));
    
end


Sonic_10min.t           = t_vec(1:end-1);
Sonic_10min.Timestamp   = datestr(t_vec(1:end-1),31);    
    
SonicComparison(Sonic_10min)
%time
Timecomparison_Cup_Sonic(Mast_N,Mast_S)








