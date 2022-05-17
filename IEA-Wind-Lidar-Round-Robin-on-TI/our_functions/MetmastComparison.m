function MetmastComparison(Mast_N,Mast_S,Reference_10min)

p_HWS = polyfit(Mast_N.USA_WShorizontal,Mast_S.USA_WShorizontal,1);
p_CWS = polyfit(Mast_N.WS1,Mast_S.WS1,1);
p_WD = polyfit(Mast_N.USA_WD,Mast_S.USA_WD,1);
p_R_TI = polyfit(Reference_10min.LOS_TI_N,Reference_10min.LOS_TI_S,1);

x_max_HWS = [0, 15];
x_max_CWS = [0, 15];
x_max_WD = [150, 300];
x_max_TI = [0, 0.5];

y_HWS = polyval(p_HWS,x_max_HWS);
y_CWS = polyval(p_CWS,x_max_CWS);
y_WD = polyval(p_WD,x_max_WD);
y_R_TI = polyval(p_R_TI,x_max_TI);

r_HWS = corrcoef(Mast_N.USA_WShorizontal,Mast_S.USA_WShorizontal);
r_CWS = corrcoef(Mast_N.WS1,Mast_S.WS1);
r_WD = corrcoef(Mast_N.USA_WD,Mast_S.USA_WD);
r_R_TI = corrcoef(Reference_10min.LOS_TI_N,Reference_10min.LOS_TI_S); 

r_sq_HWS = r_HWS(1,2)^2;
r_sq_HWS_str = ['R^2 = ' , num2str(r_sq_HWS)];

r_sq_CWS = r_CWS(1,2)^2;
r_sq_CWS_str = ['R^2 = ' , num2str(r_sq_CWS)];

r_sq_WD = r_WD(1,2)^2;
r_sq_WD_str = ['R^2 = ' , num2str(r_sq_WD)];

r_sq_R_TI = r_R_TI(1,2)^2;
r_sq_R_str_TI = ['R^2 = ' , num2str(r_sq_R_TI)];

x_pos_HWS = 0.75*x_max_HWS(2);
y_pos_HWS = 0.2*x_max_HWS(2);

x_pos_CWS = 0.75*x_max_CWS(2);
y_pos_CWS = 0.2*x_max_CWS(2);

x_pos_WD = 0.80*x_max_WD(2);
y_pos_WD = 0.60*x_max_WD(2);

x_r_pos = 0.5*x_max_TI(2);
y_r_pos = 0.2*x_max_TI(2);

figure('name','comparison Metmast North and South');
subplot(2,2,1);
hold on; grid on;box on;
plot(Mast_N.USA_WShorizontal,Mast_S.USA_WShorizontal,'.')
plot(x_max_HWS,y_HWS)
title('Horizontal Windspeed North and South')
xlabel('Horiz. WS_N Sonic')
ylabel('Horiz. WS_S Sonic')
text(x_pos_HWS,y_pos_HWS,r_sq_HWS_str);
axis equal
xlim(x_max_HWS)
ylim(x_max_HWS)

subplot(2,2,2);
hold on; grid on;box on;
plot(Mast_N.WS1,Mast_S.WS1,'.')
plot(x_max_CWS,y_CWS)
title('Horizontal Windspeed North and South')
xlabel('Horiz. WS_N Cup')
ylabel('Horiz. WS_S Cup')
text(x_pos_CWS,y_pos_CWS,r_sq_CWS_str);
axis equal
xlim(x_max_CWS)
ylim(x_max_CWS)

subplot(2,2,3);
hold on; grid on;box on;
plot(Mast_N.USA_WD,Mast_S.USA_WD,'.')
plot(x_max_WD,y_WD)
title('Winddirection North and South')
xlabel('WD_N')
ylabel('WD_S')
text(x_pos_WD,y_pos_WD,r_sq_WD_str);
axis equal
xlim(x_max_WD)
ylim(x_max_WD)

subplot(2,2,4);
hold on; grid on;box on;
plot(Reference_10min.LOS_TI_N,Reference_10min.LOS_TI_S,'.')
plot(x_max_TI,y_R_TI)
text(x_r_pos,y_r_pos,r_sq_R_str_TI); 
title('Reference TI_S and Reference TI_N')
xlabel('TI Reference_N')
ylabel('TI Reference_S')
axis equal
xlim(x_max_TI)
ylim(x_max_TI)
end

