%%
 PDH_L=2408;
  SDH_L=2408;
PDH_x = linspace(0, PDH_L, PDH_nx); % 空间坐标
PDH_time = linspace(0, t_end, nt); % 时间坐标
SDH_x = linspace(0, SDH_L, SDH_nx); % 空间坐标
SDH_time = linspace(0, t_end, nt); % 时间坐标


%在特定位置绘制温度随时间的变化
pos = round(PDH_nx); % 选择末尾
figure;
plot(PDH_time, PDH_S_T_all(pos,:));            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');
title(['一级供   位置 x = ', num2str(PDH_x(pos)), ' 处的温度随时间变化']);

%在特定位置绘制温度随时间的变化
pos = round(PDH_nx); % 选择末尾
figure;
plot(PDH_time, PDH_S_T_all(pos,:),'--');            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');
% title(['一级供   位置 x = ', num2str(PDH_x(pos)), ' 处的温度随时间变化']);
hold on
pos = round(1); % 选择初始段
plot(PDH_time, PDH_S_T_all(pos,:));            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');

hold on
pos = round(1); % 选择初始段
plot(SDH_time, SDH_S_T_all(pos,:));            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');

hold on
pos = round(SDH_nx-3); % 选择初始段
plot(SDH_time, SDH_S_T_all(pos,:));            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');



%在特定位置绘制温度随时间的变化
pos = round(PDH_nx-2); % 选择末尾
figure;
plot(PDH_time, PDH_S_T_all(pos,:));            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');
% title(['一级供   位置 x = ', num2str(PDH_x(pos)), ' 处的温度随时间变化']);
hold on
pos = round(3); % 选择初始段
plot(PDH_time, PDH_R_T_all(pos,:));            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');

hold on
pos = round(3); % 选择初始段
plot(SDH_time, SDH_R_T_all(pos,:));            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');

hold on
pos = round(SDH_nx-2); % 选择初始段
plot(SDH_time, SDH_S_T_all(pos,:));            %一级供
xlabel('时间 (s)');
ylabel('温度 (K)');




%%换热量
plot(SDH_time, Q_T2P/4);
xlabel('时间 (s)');
ylabel('温度 (K)');

hold on
plot(SDH_time, Q_P2S,'--');

hold on
plot(SDH_time, Q_S2R,'*');

hold on
plot(SDH_time, Q_R2SURR,'.');

hold on
plot(SDH_time, Q_S2R-Q_R2SURR,'*');

legend('Q_T2P','Q_P2S','Q_S2R','Q_R2SURR','Q_S2R-Q_R2SURR')



%%换热量
plot(PDH_time, Q_T2P,'.');

hold on
plot(PDH_time, Q_P2S*4-PDH_S_Q_HS'-PDH_R_Q_HS','*');

hold on
plot(SDH_time, -SDH_S_Q_HS-SDH_R_Q_HS,'*');

hold on


legend('Q_P2S','Q_R2SURR+SDH_S_Q_HS+SDH_R_Q_HS')
