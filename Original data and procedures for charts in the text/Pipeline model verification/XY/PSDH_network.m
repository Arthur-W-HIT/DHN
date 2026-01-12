close
clear
%% 定义问题参数
%管道参数设置
L = 644;          % 长度 (m)
d=0.3;                 %管内径,m
D=0.325;                %管外径,m
C=pi*D;                 %外周长
A=pi*d*d/4';    %内截面积，m^2
alpha_tt=0.6867;         %总换热系数（W/m^2K）
%供水参数设置
alpha_w = 0.14*10^-3;       %热扩散系数 (m^2/s)
V_w=0.0278;             %体积流量（m^3/s）
u=V_w/A;                   %流速（m/s）
rou_w=1000;            %水密度，kg/m^3
Cp_w=4200;              %水比热容，j/kgK
% R_w=;              %水热阻


% QQ= 1e3;            % 热耗散率 (W/m^3/K)

%时空离散步长设置
nx = 1000;            % 空间离散点数
dx = L / (nx - 1);  % 空间步长
t_end = 24*3600;        % 模拟结束时间 (s)
dt = 1;           % 时间步长 (s)
nt = t_end / dt;    % 时间步数

%初始条件设置
T_s=-80;         %环境温度（摄氏度）
x=1:dt:t_end;
T_in =60+20*sin(x/t_end*2*pi);           % 入口温度 (摄氏度)
T_o=60;
%%程序
% 初始化温度分布
T = T_o * ones(nx, 1); % 初始温度场
% 创建存储温度随时间变化的数据
T_all = zeros(nx, nt);

% 主循环：时间步进
for n = 1:nt
    % 创建一个新的温度数组以存储更新后的温度
    T_new = T;
    T_new(1) = T_in(n);
    % 内部点的温度更新（使用显式有限差分法）
    for i = 2:nx-1
        delta_t1=dt/dx*u*(T(i-1)-T(i));         %流动
        delta_t2=alpha_w * dt / dx^2 * (T(i+1) - 2*T(i) + T(i-1)); %轴向热扩散
        delta_t3=alpha_tt*dx* dt*(T_s-T(i-1))/(rou_w*u*A*dt*Cp_w); %热耗散
        T_new(i) = T(i) +delta_t1+delta_t2+delta_t3 ;
    end
    
    % 边界条件（假设两端为绝热边界条件，即温度梯度为零）
    T_new(nx) = T_new(nx-1);
    T_new(1) = T_in(n);
    % 更新温度分布
    T = T_new;
    
    % 保存当前时间步的温度分布
    T_all(:, n) = T;
end

%画图
%绘制结果
x = linspace(0, L, nx); % 空间坐标
time = linspace(0, t_end, nt); % 时间坐标

%在特定位置绘制温度随时间的变化
pos = round(nx); % 选择中间位置
figure;
plot(time, T_all(pos, :));
hold on
plot(time,T_all(2,:))
xlabel('时间 (s)');
ylabel('温度 (K)');
title(['位置 x = ', num2str(x(pos)), ' 处的温度随时间变化']);

% %绘制不同时间步的温度分布
% figure;
% hold on;
% plot_indices = round(linspace(1, nt, 10)); % 选择10个时间步绘制
% for i = plot_indices
%     plot(x, T_all(:, i));
% end
% xlabel('位置 (m)');
% ylabel('温度 (K)');
% title('不同时间步的温度分布');
% legend(arrayfun(@(t) ['t = ', num2str(t)], time(plot_indices), 'UniformOutput', false));
% hold off;
save XY.mat
