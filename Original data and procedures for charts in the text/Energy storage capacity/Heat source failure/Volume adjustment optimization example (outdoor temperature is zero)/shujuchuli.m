%%均匀-非均匀对比
clear
colors=[84,80,157;178,172,211;91,175,255;174,230,255;...
    76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
    239,118,122;69,105,144;72,192,170]/255;


load DUIZHAOZU.mat
% x= linspace(0, PDH_nx, PDH_nx)/500*2408; % 空间坐标
y1=R_T_all;
y2=PDH_V_w;
y3=SDH_V_w;
y4=Q_T2P;
y5=Q_P2S;
y6=Q_S2R;
y7=Q_R2SURR;
y9=PDH_S_Q_HS;
y10=PDH_R_Q_HS;
y111=SDH_S_Q_HS;
y12=SDH_R_Q_HS;
y13=PDH_S_T_all;
y14=PDH_R_T_all;
y15=SDH_S_T_all;
y16=SDH_R_T_all;


load 100次迭代优化结果.mat
y11=R_T_all;
y22=PDH_V_w;
y33=SDH_V_w;
y44=Q_T2P;
y55=Q_P2S;
y66=Q_S2R;
y77=Q_R2SURR;
y99=PDH_S_Q_HS;
y1010=PDH_R_Q_HS;
y1111=SDH_S_Q_HS;
y1212=SDH_R_Q_HS;
y133=PDH_S_T_all;
y144=PDH_R_T_all;
y155=SDH_S_T_all;
y166=SDH_R_T_all;

x= linspace(1, t_end, nt); % 时间坐标
% Define colors

%%  室温
% Create figure
figure;
set(gcf,'unit','centimeters','position',[10 10 9 7])
% Plot data
plot(x/3600, y1, 'LineWidth', 1.5, 'Color', colors(3,:)); hold on;
plot(x/3600, y11, 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
plot([0 nt]/3600,[16 16], 'LineWidth', 1, 'Color', colors(8,:),'linestyle','--');
plot([30969 30969]/3600,[0 16], 'LineWidth', 1.5, 'Color', colors(4,:),'linestyle',':');
plot([46251 46251]/3600,[0 16], 'LineWidth', 1.5, 'Color', colors(2,:),'linestyle',':');
grid off;
% Set axes properties
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
% Add labels and title
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Indoor temperature  (℃)', 'FontSize', 10, 'Interpreter', 'latex');
% Set legend
hl=legend('$\rm{CF}\_T_{R}$', '$\rm{VF}\_T_{R}$','FontSize', 10, 'Interpreter', 'latex', 'Location', 'BEST','NumColumns',1);
set(hl,'box','off')
% hl.ItemTokenSize = [15,10];
% xlim([10000,86400]/3600);
ylim([0 32]);
% Save the figure with 300 dpi resolution
print('室温_CF_VF', '-dpng', '-r600');  % Save as PNG with 300 dpi
saveas(gcf, '室温_CF_VF.fig')
close





%%流速
figure;
set(gcf,'unit','centimeters','position',[10 10 9 7])
% Plot data
plot(x/3600, y2, 'LineWidth', 1.5, 'Color', colors(2,:)); hold on;
plot(x/3600, y22, 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
plot(x/3600, y3, 'LineWidth', 1.5, 'Color', colors(4,:)); hold on;
plot(x/3600, y33, 'LineWidth', 1.5, 'Color', colors(3,:)); hold on;

grid off;
% Set axes properties
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
% Add labels and title
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Mass flow of water  (kg/s)', 'FontSize', 10, 'Interpreter', 'latex');
c
% Set legend
hl = legend('$\rm{CF}\_V_{P}$', '$\rm{VF}\_V_{P}$','$\rm{CF}\_V_{S}$', '$\rm{VF}\_V_{S}$', 'FontSize', 10, 'Interpreter', 'latex', 'Location', 'best', 'NumColumns', 2);
set(hl, 'Box', 'off');
% hl.ItemTokenSize = [15,10];
% xlim([10000,86400]/3600);

% Save the figure with 300 dpi resolution
print('流速_CF_VF', '-dpng', '-r600');  % Save as PNG with 300 dpi
saveas(gcf, '流速_CF_VF.fig')
close

%%热量

figure;
set(gcf,'unit','centimeters','position',[10 10 9 7])
% Plot data
% plot(x/3600, y4, 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
% plot(x/3600, y44, 'LineWidth', 1.5, 'Color', colors(1,:),'linestyle',':'); hold on;
plot(x/3600, y5, 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
plot(x/3600, y55, 'LineWidth', 1.5, 'Color', colors(1,:),'linestyle',':'); hold on;
plot(x/3600, y6, 'LineWidth', 1.5, 'Color', colors(3,:)); hold on;
plot(x/3600, y66, 'LineWidth', 1.5, 'Color', colors(3,:),'linestyle',':'); hold on;
plot(x/3600, y7, 'LineWidth', 1.5, 'Color', colors(5,:)); hold on;
plot(x/3600, y77, 'LineWidth', 1.5, 'Color', colors(5,:),'linestyle',':'); hold on;




grid off;
% Set axes properties
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
% Add labels and title
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Heat flux intensity  (W)', 'FontSize', 10, 'Interpreter', 'latex');
xlim([0 46251]/3600)
% ylim([0.0305*0.8 0.0305*4.2])
% Set legend
hl = legend('$\rm{CF}\_Q_{P2S}$', '$\rm{VF}\_Q_{P2S}$','$\rm{CF}\_Q_{S2R}$', '$\rm{VF}\_Q_{S2R}$','$\rm{CF}\_Q_{R2A}$', '$\rm{VF}\_Q_{R2A}$', 'FontSize', 10, 'Interpreter', 'latex', 'Location', 'best', 'NumColumns', 2);
set(hl, 'Box', 'off');
% hl.ItemTokenSize = [15,10];
% xlim([10000,86400]/3600);

% Save the figure with 300 dpi resolution
print('各部分热流强度_CF_VF', '-dpng', '-r600');  % Save as PNG with 300 dpi
saveas(gcf, '各部分热流强度_CF_VF.fig')
close

%%耗散
figure;
set(gcf,'unit','centimeters','position',[10 10 9 7])
% Plot data
% plot(x/3600, y4, 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
% plot(x/3600, y44, 'LineWidth', 1.5, 'Color', colors(1,:),'linestyle',':'); hold on;
plot(x/3600, y5'./abs(y9+y10-y5'), 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
plot(x/3600, y55'./abs(y99+y1010-y55'), 'LineWidth', 1.5, 'Color', colors(1,:),'linestyle',':'); hold on;
plot(x/3600, y6'./abs(y111+y12-y6'), 'LineWidth', 1.5, 'Color', colors(3,:)); hold on;
plot(x/3600, y66'./abs(y1111+y1212-y66'), 'LineWidth', 1.5, 'Color', colors(3,:),'linestyle',':'); hold on;
% plot(x/3600, y7, 'LineWidth', 1.5, 'Color', colors(5,:)); hold on;
% plot(x/3600, y77, 'LineWidth', 1.5, 'Color', colors(5,:),'linestyle',':'); hold on;

grid off;
% Set axes properties
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
% Add labels and title
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Heat transfer efficiency', 'FontSize', 10, 'Interpreter', 'latex');
xlim([0 46251]/3600)
% ylim([0.0305*0.8 0.0305*4.2])
% Set legend
hl = legend('$\rm{CF}\_\eta_{P}$', '$\rm{VF}\_\eta_{P}$','$\rm{CF}\_\eta_{S}$', '$\rm{VF}\_\eta_{S}$','$\rm{CF}\_Q_{R2A}$', '$\rm{VF}\_Q_{R2A}$', 'FontSize', 10, 'Interpreter', 'latex', 'Location', 'best', 'NumColumns', 2);
set(hl, 'Box', 'off');
% hl.ItemTokenSize = [15,10];
% xlim([10000,86400]/3600);

% Save the figure with 300 dpi resolution
print('传热效率_CF_VF', '-dpng', '-r600');  % Save as PNG with 300 dpi
saveas(gcf, '传热效率_CF_VF.fig')
close




%%QP2S温度
figure;
set(gcf,'unit','centimeters','position',[10 10 9 7])
% Plot data
plot(x/3600,y13(500,:), 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
plot(x/3600,y133(500,:), 'LineWidth', 1.5, 'Color', colors(2,:)); hold on;
plot(x/3600, y14(1,:), 'LineWidth', 1.5, 'Color', colors(3,:),'linestyle',':'); hold on;
plot(x/3600, y144(1,:), 'LineWidth', 1.5, 'Color', colors(4,:),'linestyle',':'); hold on;
plot(x/3600, y15(1,:), 'LineWidth', 1.5, 'Color', colors(5,:)); hold on;
plot(x/3600, y155(1,:), 'LineWidth', 1.5, 'Color', colors(6,:)); hold on;
plot(x/3600, y16(500,:), 'LineWidth', 1.5, 'Color', colors(7,:),'linestyle',':'); hold on;
plot(x/3600, y166(500,:), 'LineWidth', 1.5, 'Color', colors(8,:),'linestyle',':'); hold on;

plot(x/3600, y13(500,:)-y16(500,:), 'LineWidth', 1.5, 'Color', colors(7,:),'linestyle',':'); hold on;
plot(x/3600, y133(500,:)-y166(500,:), 'LineWidth', 1.5, 'Color', colors(8,:),'linestyle',':'); hold on;






grid off;
% Set axes properties
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
% Add labels and title
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Heat transfer efficiency', 'FontSize', 10, 'Interpreter', 'latex');
xlim([0 46251]/3600)
% ylim([0.0305*0.8 0.0305*4.2])
% Set legend
hl = legend('$\rm{CF}\_\eta_{P}$', '$\rm{VF}\_\eta_{P}$','$\rm{CF}\_\eta_{S}$', '$\rm{VF}\_\eta_{S}$','$\rm{CF}\_Q_{R2A}$', '$\rm{VF}\_Q_{R2A}$', 'FontSize', 10, 'Interpreter', 'latex', 'Location', 'best', 'NumColumns', 2);
set(hl, 'Box', 'off');
% hl.ItemTokenSize = [15,10];
xlim([10000,86400]/3600);

% Save the figure with 300 dpi resolution
print('传热效率_CF_VF', '-dpng', '-r600');  % Save as PNG with 300 dpi
saveas(gcf, '传热效率_CF_VF.fig')
close