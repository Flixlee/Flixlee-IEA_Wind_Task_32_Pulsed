clearvars;clc;close all
RoundRoubin_ReferencePulsed
addpath('our_functions')
% Pulsed Pirates attemped to calculate the TI estimation for the pulsed
% Lidar data
% Members: Felix Lehmann, Jonas Borchert, Matthias Schrade, Niklas Freiberg
%% Task 1 Part1: clean data (9999 in Lidar_N.RWS bzw Lidar_S.RWS)

mistake = Lidar_N.RWS==9999; %Logical Array 
Lidar_N.RWS(mistake)=interp1(Lidar_N.t(~mistake),Lidar_N.RWS(~mistake),Lidar_N.t(mistake)); 

mistake = Lidar_S.RWS==9999;
Lidar_S.RWS(mistake)=interp1(Lidar_S.t(~mistake),Lidar_S.RWS(~mistake),Lidar_S.t(mistake)); 

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

RegressionSubPlot(m,n,1,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N,false,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North');

RegressionSubPlot(m,n,2,Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S,false,...
    range_TI, 'TI Reference_S','TI Lidar_S','10 min TI South');

Lidar_Ref_statistics(Lidar_10min,Reference_10min)
Timecomparison_Lidar(Tstart,Tend,Lidar_10min) 
%% Sonic Data Comparison
%statistics
t1                          = datetime(Tstart); 
t2                          = datetime(Tend); 
t_vec                       = datenum(t1:minutes(10):t2); 

n_10min                     = length(t_vec)-1;
for i_10min= 1:n_10min
    Considered            = Reference.t_N>=t_vec(i_10min) & Reference.t_N<t_vec(i_10min+1);
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
Cup_vs_Sonic(Mast_N,Mast_S,Reference,Tstart,Tend,Sonic_10min) 
%% Metmast Data Comparison
% TI N and TI S
TI_Mast(Mast_N,Mast_S,Reference,Tstart,Tend,Sonic_10min)
%% "time" offset Lidar Northmast
% dt set to 4 sec
Lidar_N_offset = readtable('Lidar_N_offset_day1.xlsx');
Timecomparision_Reference_Lidar_N_offset(Reference,Lidar_N_offset,Lidar_N)

for i_10min= 1:n_10min
    Considered_N_offset                    = Lidar_N_offset.t>=t_vec(i_10min) & Lidar_N_offset.t<t_vec(i_10min+1);   
    Lidar_10min_offset.LOS_N_offset_mean(i_10min) = nanmean(Lidar_N_offset.RWS(Considered_N_offset));
    Lidar_10min_offset.LOS_N_offset_std(i_10min)  = nanstd (Lidar_N_offset.RWS(Considered_N_offset));
    
end


Lidar_10min_offset.t           = t_vec(1:end-1);
Lidar_10min_offset.Timestamp   = datestr(t_vec(1:end-1),31);

Lidar_10min_offset.LOS_N_offset_TI = Lidar_10min_offset.LOS_N_offset_std./Lidar_10min_offset.LOS_N_offset_mean;

m           = 1;
n           = 2;

range_TI = [0, 0.5];

figure('Name','Lidar TI vs Lidar offset TI')

RegressionSubPlot(m,n,1,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N,false,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North');

RegressionSubPlot(m,n,2,Reference_10min.LOS_TI_N,Lidar_10min_offset.LOS_N_offset_TI,false,...
    range_TI, 'TI Reference_N','TI Lidar offset_N ','10 min TI North');
%% delta STD Lidar/Reference (Fit 1)
d_std_N = Reference_10min.LOS_N_std - Lidar_10min.LOS_N_std;
d_std_S = Reference_10min.LOS_S_std - Lidar_10min.LOS_S_std;

d_std_N = d_std_N';
d_std_S = d_std_S';

figure('name','dStd over WD/WS')
subplot(2,2,1);
hold on; box on; grid on;
scatter(Reference_10min.WD_N_mean,d_std_N,'.')
xlabel('mean WD_N [deg]')
ylabel('dStd_N [m/s]') 
title('dStd_N over mean WD_N')

subplot(2,2,2);
hold on; box on; grid on;
scatter(Reference_10min.WD_S_mean,d_std_S,'.')
xlabel('mean WD_S [deg]')
ylabel('dStd_S [m/s]') 
title('dStd_S over mean WD_S')

subplot(2,2,3);
hold on; box on; grid on;
scatter(Reference_10min.LOS_N_mean,d_std_N,'.')
xlabel('mean WS_N [m/s]')
ylabel('dStd_N [m/s]') 
title('dStd_N over mean WS_N')

subplot(2,2,4);
hold on; box on; grid on;
scatter(Reference_10min.LOS_S_mean,d_std_S,'.')
xlabel('mean WS_S [m/s]')
ylabel('dStd_S [m/s]') 
title('dStd_S over mean WS_S')

figure('name','Histogram dStd')
subplot(2,1,1);
hold on; box on; grid on;
histogram(d_std_N)
xlabel('dStd_N [m/s]')
ylabel('n') 
title('dStd_N')

subplot(2,1,2);
hold on; box on; grid on;
histogram(d_std_S)
xlabel('dStd_S [m/s]')
ylabel('n') 
title('dStd_S')

mean_d_std_N = mean(d_std_N);
mean_d_std_S = mean(d_std_S);

Lidar_10min.LOS_N_std_fit1 = Lidar_10min.LOS_N_std + mean_d_std_N;
Lidar_10min.LOS_S_std_fit1 = Lidar_10min.LOS_S_std + mean_d_std_S;

Lidar_10min.LOS_TI_N_fit1 = Lidar_10min.LOS_N_std_fit1./Lidar_10min.LOS_N_mean; 
Lidar_10min.LOS_TI_S_fit1 = Lidar_10min.LOS_S_std_fit1./Lidar_10min.LOS_S_mean;

m           = 2;
n           = 2;

range_Std = [0, 2.5];

figure('Name','Lidar Std Fit 1 vs Reference Std')

RegressionSubPlot(m,n,1,Reference_10min.WS_N_std,Lidar_10min.LOS_N_std,false,...
    range_Std,'Std Reference_N [m/s]','Std Lidar_N [m/s]','10 min Std North');

RegressionSubPlot(m,n,2,Reference_10min.WS_S_std,Lidar_10min.LOS_S_std,false,...
    range_Std, 'Std Reference_S [m/s]','Std Lidar_S [m/s]','10 min Std South');

RegressionSubPlot(m,n,3,Reference_10min.WS_N_std,Lidar_10min.LOS_N_std_fit1,false,...
    range_Std,'Std Reference_N [m/s]','Std Lidar_N [m/s]','10 min Std North Fit1');

RegressionSubPlot(m,n,4,Reference_10min.WS_S_std,Lidar_10min.LOS_S_std_fit1,false,...
    range_Std, 'Std Reference_S [m/s]','Std Lidar_S [m/s]','10 min Std South Fit1'); 

%% Fit 2: fits with the linear eq of the std calculation

fit_m_N = 100/97;
fit_b_N = 0.02;

fit_m_S = 100/91;
fit_b_S = 0.03;

Lidar_10min.LOS_N_std_fit2 = Lidar_10min.LOS_N_std .* fit_m_N + fit_b_N;
Lidar_10min.LOS_S_std_fit2 = Lidar_10min.LOS_S_std .* fit_m_S + fit_b_S;

Lidar_10min.LOS_TI_N_fit2 = Lidar_10min.LOS_N_std_fit2./Lidar_10min.LOS_N_mean; 
Lidar_10min.LOS_TI_S_fit2 = Lidar_10min.LOS_S_std_fit2./Lidar_10min.LOS_S_mean;

figure('Name','Lidar Std Fit 2 vs Reference Std')

RegressionSubPlot(m,n,1,Reference_10min.WS_N_std,Lidar_10min.LOS_N_std,false,...
    range_Std,'Std Reference_N [m/s]','Std Lidar_N [m/s]','10 min Std North');

RegressionSubPlot(m,n,2,Reference_10min.WS_S_std,Lidar_10min.LOS_S_std,false,...
    range_Std, 'Std Reference_S [m/s]','Std Lidar_S [m/s]','10 min Std South');

RegressionSubPlot(m,n,3,Reference_10min.WS_N_std,Lidar_10min.LOS_N_std_fit2,false,...
    range_Std,'Std Reference_N [m/s]','Std Lidar_N [m/s]','10 min Std North Fit2');

RegressionSubPlot(m,n,4,Reference_10min.WS_S_std,Lidar_10min.LOS_S_std_fit2,false,...
    range_Std, 'Std Reference_S [m/s]','Std Lidar_S [m/s]','10 min Std South Fit2');
%% Fit 1.2
d_std = [d_std_N,Lidar_10min.LOS_N_mean'];
d_low_WS= zeros(144,1);
d_high_WS= zeros(144,1);
for i_10min= 1:n_10min
    if d_std(i_10min,2)<=5.5
       d_low_WS(i_10min) = d_std(i_10min,1);
        
    else 
        d_high_WS(i_10min) = d_std(i_10min,1);
    end 
end

mean_d_std_low = mean(d_low_WS);
mean_d_std_high = mean(d_high_WS);

Lidar_10min.LOS_N_std_fit1_2 = zeros(144,1)';

for i_10min= 1:n_10min
    if d_std(i_10min,2)<=5.5
       Lidar_10min.LOS_N_std_fit1_2(i_10min) = Lidar_10min.LOS_N_std(i_10min) + mean_d_std_low;
    
    else
        Lidar_10min.LOS_N_std_fit1_2(i_10min) = Lidar_10min.LOS_N_std(i_10min) + mean_d_std_high;
    end
end

RegressionSubPlot(1,n,1,Reference_10min.WS_N_std,Lidar_10min.LOS_N_std,false,...
    range_Std,'Std Reference_N [m/s]','Std Lidar_N [m/s]','10 min Std North');
RegressionSubPlot(1,n,2,Reference_10min.WS_N_std,Lidar_10min.LOS_N_std_fit1_2,false,...
    range_Std,'Std Reference_N [m/s]','Std Lidar_N [m/s]','10 min Std North Fit1.2');

Lidar_10min.LOS_TI_N_fit1_2 = Lidar_10min.LOS_N_std_fit1_2./Lidar_10min.LOS_N_mean; 
%% TI Comparison Fit1;1.2;2 
m           = 2;
n           = 2; 

range_TI = [0, 0.7];

figure('Name','Lidar TI Fit 1 vs Reference TI')

RegressionSubPlot(m,n,1,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N,false,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North');

RegressionSubPlot(m,n,2,Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S,false,...
    range_TI, 'TI Reference_S','TI Lidar_S','10 min TI South');

RegressionSubPlot(m,n,3,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N_fit1,false,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North Fit1');

RegressionSubPlot(m,n,4,Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S_fit1,false,...
    range_TI, 'TI Reference_S','TI Lidar_S','10 min Ti South Fit1');

figure('Name','Lidar TI Fit 2 vs Reference TI')

RegressionSubPlot(m,n,1,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N,false,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North');

RegressionSubPlot(m,n,2,Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S,false,...
    range_TI, 'TI Reference_S','TI Lidar_S','10 min TI South');

RegressionSubPlot(m,n,3,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N_fit2,false,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North Fit2');

RegressionSubPlot(m,n,4,Reference_10min.LOS_TI_S,Lidar_10min.LOS_TI_S_fit2,false,...
    range_TI, 'TI Reference_S','TI Lidar_S','10 min Ti South Fit2');  

figure('Name','Lidar TI Fit 1.2 vs Reference TI')

RegressionSubPlot(1,n,1,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N,false,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North');

RegressionSubPlot(1,n,2,Reference_10min.LOS_TI_N,Lidar_10min.LOS_TI_N_fit1_2,false,...
    range_TI,'TI Reference_N','TI Lidar_N','10 min TI North Fit1.2');

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
    Lidar_10min_2.t     = datenum(Lidar_10min_2.DateAndTime,'yyyy-mm-ddTHH:MM:SS.FFF'); % doesnt work right now, unused so far
    save('Data_2.mat','Lidar_N_2','Lidar_S_2','Lidar_10min_2');
end
%% TI Period 2 raw
Tstart_2          = '2020-10-20 00:00:00';
Tend_2            = '2020-10-24 23:59:59';
Lidar_10min_2_o  = Calculate10minStastics_Lidar_2(Lidar_N_2,Lidar_S_2,Tstart_2,Tend_2);
Lidar_10min_2_o.LOS_TI_N_2 = Lidar_10min_2_o.LOS_N_std./Lidar_10min_2_o.LOS_N_mean; 
Lidar_10min_2_o.LOS_TI_S_2 = Lidar_10min_2_o.LOS_S_std./Lidar_10min_2_o.LOS_S_mean; 

Lidar_10min_2_o.t = zeros(719,1)';
i=1; 
for ix=1:1:719 
        Lidar_10min_2_o.t(ix) = Lidar_N_2.t(i);
        i= i+150;
end
Timecomparison_Lidar_2_raw(Tstart_2,Tend_2,Lidar_10min_2_o)
%% Find inaccurate mean values and set them to NaN
figure
subplot(2,1,1);
hold on; box on; grid on;
plot(Lidar_10min_2_o.LOS_N_mean,Lidar_10min_2_o.LOS_TI_N_2,'.');
title('inaccurate mean values N')
ylim([-1 1]);
xlabel('LOS mean N [m/s]')
ylabel('LOS TI N')
% inaccurate mean values North set to -1.5<inmeanv_N<1.5

subplot(2,1,2);
hold on; box on; grid on;
plot(Lidar_10min_2_o.LOS_S_mean,Lidar_10min_2_o.LOS_TI_S_2,'.');
title('inaccurate mean values S')
ylim([-1 1]);
xlabel('LOS mean S [m/s]')
ylabel('LOS TI S')
% inaccurate mean values South set to inmeanv_S<2

inmeanv_N = (-1.5<Lidar_10min_2_o.LOS_N_mean)&(Lidar_10min_2_o.LOS_N_mean<1.5);
Lidar_10min_2_o.LOS_N_mean(inmeanv_N == true) = NaN;

inmeanv_S = Lidar_10min_2_o.LOS_S_mean<2;
Lidar_10min_2_o.LOS_S_mean(inmeanv_S == true) = NaN;
%% TI Period 2 filtered and unfitted
%run previous section to get this section work
Lidar_10min_2_o.LOS_TI_N_2 = Lidar_10min_2_o.LOS_N_std./Lidar_10min_2_o.LOS_N_mean; 
Lidar_10min_2_o.LOS_TI_S_2 = Lidar_10min_2_o.LOS_S_std./Lidar_10min_2_o.LOS_S_mean;

Timecomparison_Lidar_2(Tstart_2,Tend_2,Lidar_10min_2_o);
%% TI Period 2 fitted
% North fit -> take fit 1.2 for North
Lidar_10min_2_o.LOS_N_std_fit = Lidar_10min_2_o.LOS_N_std .* fit_m_N + fit_b_N;
% South fit -> take fit 1 for South
Lidar_10min_2_o.LOS_S_std_fit = Lidar_10min_2_o.LOS_S_std + mean_d_std_S;

Lidar_10min_2_o.LOS_TI_N_2_fit = Lidar_10min_2_o.LOS_N_std_fit./Lidar_10min_2_o.LOS_N_mean; % store in csv as solution
Lidar_10min_2_o.LOS_TI_S_2_fit = Lidar_10min_2_o.LOS_S_std_fit./Lidar_10min_2_o.LOS_S_mean; % store in csv as solution 

Timecomparison_Lidar_2_fit(Tstart_2,Tend_2,Lidar_10min_2_o)

%% csv storage:
Final_TI_N = array2table(Lidar_10min_2_o.LOS_TI_N_2_fit);
Final_TI_S = array2table(Lidar_10min_2_o.LOS_TI_S_2_fit); 

writetable(Final_TI_N,'Final_TI_Estimation_N_pulsedpirates.csv')
writetable(Final_TI_S,'Final_TI_Estimation_S_pulsedpirates.csv')