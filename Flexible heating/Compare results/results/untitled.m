%%%雷达双图
close all
clear
colors = [84,80,157;178,172,211;91,175,255;174,230,255;...
          76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
          239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 14 8]); % 调整图像窗口大小，适合放置两个子图和图例

%% 左图：相对期望雷达图
subplot(1,2,1); % 创建左边子图
set(gca, 'Position', [0.05, 0.2, 0.4,0.65]); % 调整左图位置和大小

num_variables = 50; 
angles = linspace(0, 2*pi, num_variables+1); % 雷达图的角度

theta_values = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5];
theta_degrees = theta_values * (360 / 6); % 假设6个单位对应360°

pax1 = polaraxes; % 创建极坐标轴
hold on;
pax1.ThetaTick = theta_degrees; 
pax1.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax1, 'Position', [0.05, 0.2, 0.4,0.65]); % 确保雷达图居中

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);

    % 插值处理
    x_fine = linspace(min(qwh), max(qwh), num_variables);
    y_fine = spline(qwh, fch, x_fine); 

    data = [y_fine, y_fine(1)];
    
    % 绘制雷达图
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    hold on;
end
title('(a)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% 右图：绝对值雷达图
subplot(1,2,2); % 创建右边子图
set(gca, 'Position',[0.55, 0.2, 0.4,0.65]); % 调整右图位置和大小

theta_values = 0:21272160.2214309*6/12/10^7:21272160.2214309*6*11/12/10^7;

theta_degrees = theta_values * (360 / (21272160.2214309/10^7*6));

pax2 = polaraxes;
hold on;
pax2.ThetaTick = theta_degrees;
pax2.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax2, 'Position', [0.55, 0.2, 0.4,0.65]); % 确保雷达图居中

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);
    qwh=qwh.*QT2PO;
    fch=fch.*QT2PO.*QT2PO;
    
    x_fine = linspace(min(qwh), max(qwh), num_variables);
    y_fine = spline(qwh, fch, x_fine);

    data = [y_fine, y_fine(1)];
    
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    hold on;
end
title('(b)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% 共用图例设置
lgd = legend(arrayfun(@(Ts) ['$T_{\rm{A}} = $' num2str(Ts)], 0:-2.5:-20, 'UniformOutput', false), ...
    'Orientation', 'horizontal', 'NumColumns', 5, 'FontSize', 10, 'Box', 'off', 'Interpreter', 'latex');
lgd.ItemTokenSize = [10, 10]; % 缩短图例线条长度
set(lgd, 'Position', [0.2, 0.05, 0.6, 0.05]); % 调整图例位置，放在两张图的下方
