close all
clear
colors = [84,80,157;178,172,211;91,175,255;174,230,255;...
          76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
          239,118,122;69,105,144;72,192,170]/255;

% 调整图形窗口尺寸和布局
figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 12 16]); % 减少高度2cm
set(gcf, 'Color', 'w'); % 白色背景

% 紧凑布局：减小垂直间距
positions = {
    [0.08, 0.72, 0.35, 0.20],  % (a)
    [0.54, 0.72, 0.35, 0.20],  % (b)
    [0.08, 0.46, 0.35, 0.20],  % (c)
    [0.54, 0.46, 0.35, 0.20],  % (d)
    [0.08, 0.20, 0.35, 0.20],  % (e)
    [0.54, 0.20, 0.35, 0.20]   % (f)
};

%% 加载水箱柔性供热数据
load('水箱柔性供热结果.mat'); % 假设变量名为processedData (11×1 cell)
numTankGroups = numel(processedData); % 获取水箱数据组数(11组)

%% 通用设置
theta_values_base = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5];
theta_degrees_base = theta_values_base * (360 / 5); 
num_variables = 50;
angles = linspace(0, 2*pi, num_variables+1);

%% (a) 相对期望雷达图
pax1 = polaraxes('Position', positions{1});
hold on;
pax1.ThetaTick = theta_degrees_base;
pax1.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values_base, 'UniformOutput', false);

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
title('(a)', 'FontName', 'Times New Roman', 'FontSize', 10, 'FontWeight', 'bold');

%% (b) 绝对值雷达图
pax2 = polaraxes('Position', positions{2});
hold on;

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
title('(b)', 'FontName', 'Times New Roman', 'FontSize', 10, 'FontWeight', 'bold');

%% (c) 质量并调-相对期望
pax3 = polaraxes('Position', positions{3});
hold on;
pax3.ThetaTick = theta_degrees_base;
pax3.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values_base, 'UniformOutput', false);

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
title('(c)', 'FontName', 'Times New Roman', 'FontSize', 10, 'FontWeight', 'bold');

%% (d) 质量并调-绝对值
pax4 = polaraxes('Position', positions{4});
hold on;
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
title('(d)', 'FontName', 'Times New Roman', 'FontSize', 10, 'FontWeight', 'bold');

%% (e) 水箱柔性-相对期望
pax5 = polaraxes('Position', positions{5});
hold on;
theta_values = [0 1 2 3 4 5];
theta_degrees = theta_values * (360 / 5); 
pax5.ThetaTick = theta_degrees;
pax5.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false);

for k = 1:numTankGroups
    tankMatrix = processedData{k};
    qwh_tank = tankMatrix(:,1)';
    fch_tank = tankMatrix(:,2)';
   
    qwh_tank(51:60) = [];
    fch_tank(51:60) = [];
    
    data = [fch_tank, fch_tank(1)];
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(e)', 'FontName', 'Times New Roman', 'FontSize', 10, 'FontWeight', 'bold');

%% (f) 水箱柔性-绝对值
pax6 = polaraxes('Position', positions{6});
hold on;
pax6.RLim = [0 25 * 10^14];
pax6.ThetaTick = theta_degrees;
pax6.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false);

for k = 1:numTankGroups
    tankMatrix = processedData{k};
    qwh_tank = tankMatrix(:,1)';
    fch_tank = tankMatrix(:,2)';
    
    qwh_tank(51:60) = [];
    fch_tank(51:60) = [];
    cd 'D:\WZH\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\对照结果\结果'
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);
    QT2PO(51:60) = [];
    
    qwh_tank = qwh_tank .* QT2PO;
    fch_tank = fch_tank .* QT2PO .* QT2PO;

    data = [fch_tank, fch_tank(1)];
    polarplot(angles*QT2PO(1)/21272160, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(f)', 'FontName', 'Times New Roman', 'FontSize', 10, 'FontWeight', 'bold');

%% 统一图例设置（顶部和底部）
% 温度图例（顶部）
lgd1 = legend(arrayfun(@(Ts) ['$T_{\rm{A}} = ' num2str(Ts) '$'], 0:-2.5:-20, 'UniformOutput', false), ...
    'Orientation', 'horizontal', 'NumColumns', 5, 'FontSize', 8, 'Box', 'off', 'Interpreter', 'latex');
lgd1.ItemTokenSize = [8, 8];
set(lgd1, 'Position', [0.1, 0.94, 0.8, 0.04]); % 移至顶部

% 水箱图例（底部）
tankTemps = arrayfun(@(k) ['$T_{\rm{Tank}} = ' num2str(-2.5*(k-1)) '$'], 1:numTankGroups, 'UniformOutput', false);
lgd2 = legend(tankTemps, 'Orientation', 'horizontal', 'NumColumns', 5, 'FontSize', 8, 'Box', 'off', 'Interpreter', 'latex');
lgd2.ItemTokenSize = [8, 8];
set(lgd2, 'Position', [0.1, 0.02, 0.8, 0.04]); % 移至底部

%% 统一调整极坐标轴样式
allAxes = findall(gcf, 'Type', 'polaraxes');
for i = 1:numel(allAxes)
    set(allAxes(i), 'FontName', 'Times New Roman', 'FontSize', 8);
    set(allAxes(i), 'LineWidth', 0.8); % 减细轴线
    grid(allAxes(i), 'off'); % 移除网格线减少视觉干扰
end

%% 保存结果（紧凑格式）
% set(gcf, 'PaperPositionMode', 'auto');
% print(gcf, 'RadarPlot_3x2_Optimized.png', '-dpng', '-r600');