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

m           = 1;
n           = 2;

range_TI = [0, 0.5];

figure('Name','Lidar TI vs Reference TI')

RegressionSubPlot(m,n,1,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North');

RegressionSubPlot(m,n,2,Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S,...
    range_TI, 'TI Reference_S','TI Lidar_S','10 min TI South');

Lidar_Ref_statistics(Lidar_10min,Reference_10min)
 
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
    
SonicComparison2(Sonic_10min)
%% Cup Data Comparison
% statistics
% WD1 not on same hight as Cup
CupComparison(Mast_N,Mast_S,Reference,Tstart,Tend)
%% Timecomparison Cup Sonic
Timecomparison_Cup_Sonic(Mast_N,Mast_S)
%% Cup vs Sonic statistics
Cup_vs_Sonic(Mast_N,Mast_S,Reference,Tstart,Tend,Sonic_10min) %neu in auswertung einfügen
%% Metmast Data Comparison
% TI N and TI S
TI_Mast(Mast_N,Mast_S,Reference,Tstart,Tend,Sonic_10min)
%% "time" offset Lidar Northmast
% dt = 6.5 s ?!
% Calculate10minStastics_Lidar_offset(Lidar_N,Lidar_S,Tstart,Tend);
%% Load Lidar Period 2
if isfile('Data_2.mat') % datenum takes a while, so we better store the data
    load('Data_2.mat','Lidar_N_2','Lidar_S_2','Lidar_10min_2');
else 
    
    Lidar_N_2        	= readtable('Lidar_20201020-20201024_1Hz_LOS3_178m.csv');
    Lidar_S_2       	= readtable('Lidar_20201020-20201024_1Hz_LOS2_178m.csv');
    Lidar_10min_2       = readtable('Lidar_20201020-20201024_10min_new.csv');
      
    % add numeric time
  
    Lidar_N_2.t     	= datenum(Lidar_N_2.Timestamp,'yyyy-mm-ddTHH:MM:SS.FFF');
    Lidar_S_2.t      	= datenum(Lidar_S_2.Timestamp,'yyyy-mm-ddTHH:MM:SS.FFF');
    Lidar_10min_2.t     = datenum(Lidar_10min_2.DateAndTime); % HILFE David
    save('Data_2.mat','Lidar_N_2','Lidar_S_2','Lidar_10min_2');
end

