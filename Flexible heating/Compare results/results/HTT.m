close all
clear
colors = [84,80,157;178,172,211;91,175,255;174,230,255;...
          76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
          239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 12 18]); % 增加高度以容纳3行子图

% 定义6个子图位置（3行2列）
positions = {
    [0.08, 0.70, 0.35, 0.22],  % 1行1列
    [0.54, 0.70, 0.35, 0.22],  % 1行2列
    [0.08, 0.45, 0.35, 0.22],  % 2行1列
    [0.54, 0.45, 0.35, 0.22],  % 2行2列
    [0.08, 0.20, 0.35, 0.22],  % 3行1列（新增）
    [0.54, 0.20, 0.35, 0.22]   % 3行2列（新增）
};

%% 加载水箱柔性供热数据
load('水箱柔性供热结果.mat'); % 假设变量名为processedData (11×1 cell)
numTankGroups = numel(processedData); % 获取水箱数据组数(11组)

%% 左图：相对期望雷达图 (1/6)
pax1 = polaraxes('Position', positions{1});
hold on;

num_variables = 50; 
angles = linspace(0, 2*pi, num_variables+1);

% 设置角度刻度和标签
theta_values = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5];
theta_degrees = theta_values * (360 / 5); 
pax1.ThetaTick = theta_degrees;
pax1.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false);

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    qwh(51:60) = [];
    fch(51:60) = [];
    
    data = [fch, fch(1)]; % 闭合处理
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(a) 原始数据-相对期望');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);

%% 右图：绝对值雷达图 (2/6)
pax2 = polaraxes('Position', positions{2});
hold on;

% 设置角度刻度和范围
theta_values = 0:21272160.2214309 * 5/12/10^6:21272160.2214309 * 5 * 11/12/10^6;
theta_values = round(theta_values, 3, 'significant');
theta_degrees = theta_values * (360 / (21272160.2214309/10^6 * 5));

pax2.RLim = [0 5.1 * 10^14];
pax2.ThetaTick = theta_degrees;
pax2.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false);

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);
    
    qwh(51:60) = [];
    fch(51:60) = [];
    QT2PO(51:60) = [];
    
    qwh = qwh .* QT2PO;
    fch = fch .* QT2PO .* QT2PO;
    
    data = [fch, fch(1)]; % 闭合处理
    polarplot(angles*QT2PO(1)/21272160, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(b) 原始数据-绝对值');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);

%% 左图：相对期望雷达图 (3/6)
pax3 = polaraxes('Position', positions{3});
hold on;

theta_values = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5];
theta_degrees = theta_values * (360 / 5); 
pax3.ThetaTick = theta_degrees;
pax3.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false);

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    originalPath = pwd;
    cd 'D:\WZH\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\质量并调结果\环境温度0(示例)'
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    qwh(51:60) = [];
    fch(51:60) = [];
    
    data = [fch, fch(1)]; % 闭合处理
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    cd(originalPath);
end
title('(c) 质量并调-相对期望');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);

%% 右图：绝对值雷达图 (4/6)
pax4 = polaraxes('Position', positions{4});
hold on;

theta_values = 0:21272160.2214309 * 5/12/10^6:21272160.2214309 * 5 * 11/12/10^6;
theta_values = round(theta_values, 3, 'significant');
theta_degrees = theta_values * (360 / (21272160.2214309/10^6 * 5));

pax4.RLim = [0 5.1 * 10^14];
pax4.ThetaTick = theta_degrees;
pax4.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false);

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    cd 'D:\WZH\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\质量并调结果\环境温度0(示例)'
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);
    
    qwh(51:60) = [];
    fch(51:60) = [];
    QT2PO(51:60) = [];
    
    qwh = qwh .* QT2PO;
    fch = fch .* QT2PO .* QT2PO;
    
    data = [fch, fch(1)]; % 闭合处理
    polarplot(angles*QT2PO(1)/21272160, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(d) 质量并调-绝对值');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);

%% 新增：水箱柔性供热结果-相对期望 (5/6)
pax5 = polaraxes('Position', positions{5});
hold on;

% 设置角度刻度和标签
theta_values = [0 1 2 3 4 5];
theta_degrees = theta_values * (360 / 5); 
pax5.ThetaTick = theta_degrees;
pax5.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false);

% 处理水箱数据并绘制
for k = 1:numTankGroups
    tankMatrix = processedData{k}; % 获取60×2数据矩阵
    qwh_tank = tankMatrix(:,1)'; % 第一列为qw值
    fch_tank = tankMatrix(:,2)'; % 第二列为fc值
   
    qwh_tank(51:60) = [];
    fch_tank(51:60) = [];
    % QT2PO(51:60) = [];
    
    
    data = [fch_tank, fch_tank(1)]; % 闭合处理
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(e) 水箱柔性-相对期望');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);

%% 新增：水箱柔性供热结果-绝对值 (6/6)
pax6 = polaraxes('Position', positions{6});
hold on;

% 设置角度刻度和范围
theta_values = 0:21272160.2214309 * 5/12/10^6:21272160.2214309 * 5 * 11/12/10^6;
theta_values = round(theta_values, 3, 'significant');
theta_degrees = theta_values * (360 / (21272160.2214309/10^6 * 5));

pax6.RLim = [0 25 * 10^14];
pax6.ThetaTick = theta_degrees;
pax6.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false);

% 处理水箱数据并绘制
for k = 1:numTankGroups
    tankMatrix = processedData{k}; % 获取60×2数据矩阵
    qwh_tank = tankMatrix(:,1)'; % 第一列为qw值
    fch_tank = tankMatrix(:,2)'; % 第二列为fc值
    
    qwh_tank(51:60) = [];
    fch_tank(51:60) = [];
    cd 'D:\WZH\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\对照结果\结果'
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);
    QT2PO(51:60) = [];
    
    qwh_tank = qwh_tank .* QT2PO;
    fch_tank = fch_tank .* QT2PO .* QT2PO;

    data = [fch_tank, fch_tank(1)]; % 闭合处理
    polarplot(angles*QT2PO(1)/21272160, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(f) 水箱柔性-绝对值');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);

%% 图例设置
% 原始数据图例（9组）
lgd1 = legend(arrayfun(@(Ts) ['$T_{\rm{A}} = $' num2str(Ts)], 0:-2.5:-20, 'UniformOutput', false), ...
    'Orientation', 'horizontal', 'NumColumns', 5, 'FontSize', 9, 'Box', 'off', 'Interpreter', 'latex');
lgd1.ItemTokenSize = [10, 10];
set(lgd1, 'Position', [0.1, 0.02, 0.8, 0.04]);

% 水箱数据图例（11组）
tankTemps = arrayfun(@(k) ['$T_{\rm{Tank}} = $' num2str(-2.5*(k-1))], 1:numTankGroups, 'UniformOutput', false);
lgd2 = legend(tankTemps, 'Orientation', 'horizontal', 'NumColumns', 5, 'FontSize', 9, 'Box', 'off', 'Interpreter', 'latex');
lgd2.ItemTokenSize = [10, 10];
set(lgd2, 'Position', [0.1, -0.02, 0.8, 0.04]);

%% 保存结果
% cd('D:\WZH\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\对照结果\结果')
% print(gcf, 'RadarPlot_3x2.png', '-dpng', '-r600');