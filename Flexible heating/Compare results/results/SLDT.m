close all
clear
colors = [84,80,157;178,172,211;91,175,255;174,230,255;...
          76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
          239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 12 12.5]); % 调整图像窗口大小，适合放置两个子图和图例
% pos1 = [0.08 0.57 0.36 0.36]; % 左上角
% pos2 = [0.56 0.57 0.36 0.36]; % 右上角
% pos3 = [0.08 0.12 0.36 0.36]; % 左下角
% pos4 = [0.56 0.12 0.36 0.36]; % 右下角

% pos1 = [0.08 0.57 0.38 0.36]; % 左上角
% pos2 = [0.54 0.57 0.38 0.36]; % 右上角
% pos3 = [0.08 0.12 0.38 0.36]; % 左下角
% pos4 = [0.54 0.12 0.38 0.36]; % 右下角
% 

pos1 = [0.08 0.57 0.35 0.35]; % 左上角
pos2 = [0.54 0.57 0.35 0.35]; % 右上角
pos3 = [0.08 0.12 0.35 0.35]; % 左下角
pos4 = [0.54 0.12 0.35 0.35]; % 右下角

%% 左图：相对期望雷达图


subplot(2,2,1); % 创建左边子图
set(gca, 'Position', pos1); % 调整左图位置和大小

num_variables = 50; 
angles = linspace(0, 2*pi, num_variables+1); % 雷达图的角度

theta_values = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5];
theta_degrees = theta_values * (360 / 5); % 假设6个单位对应360°

pax1 = polaraxes; % 创建极坐标轴
hold on;
pax1.ThetaTick = theta_degrees; 
pax1.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax1, 'Position', pos1); % 确保雷达图居中

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
     qwh(51:60)=[];
     fch(51:60)=[];
    % 插值处理
%     x_fine = linspace(0, 21272160.2214309*5, num_variables);
%     y_fine = spline(qwh, fch, x_fine);

    data = [fch, fch(1)];
    
    % 绘制雷达图
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    hold on;
end
title('(a)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% 右图：绝对值雷达图
subplot(2,2,2); % 创建右边子图
set(gca, 'Position',pos2); % 调整右图位置和大小

theta_values = 0:21272160.2214309*5/12/10^6:21272160.2214309*5*11/12/10^6;
theta_values=round(theta_values , 3, 'significant');
theta_degrees = theta_values * (360 / (21272160.2214309/10^6*5));

pax2 = polaraxes;
hold on;
pax2.RLim = [0 5.1*10^14]; % 设置 r 坐标的范围，范围为 0 到 6
pax2.ThetaTick = theta_degrees;
pax2.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax2, 'Position', pos2); % 确保雷达图居中

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);
     qwh(51:60)=[];
     fch(51:60)=[];
     QT2PO(51:60)=[];
    qwh=qwh.*QT2PO;
    fch=fch.*QT2PO.*QT2PO;
    
%     x_fine = linspace(0, 21272160.2214309*5, num_variables);
%     y_fine = spline(qwh, fch, x_fine);

    data = [fch, fch(1)];
    
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    hold on;
end

title('(b)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% 左图：相对期望雷达图
subplot(2,2,3); % 创建左边子图
set(gca, 'Position',pos3); % 调整左图位置和大小

num_variables = 50; 
angles = linspace(0, 2*pi, num_variables+1); % 雷达图的角度

theta_values = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5];
theta_degrees = theta_values * (360 / 5); % 假设6个单位对应360°

pax1 = polaraxes; % 创建极坐标轴
hold on;
pax1.ThetaTick = theta_degrees; 
pax1.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax1, 'Position',pos3); % 确保雷达图居中

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    originalPath = pwd;
    cd 'F:\王中昊\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\质量并调结果\环境温度0(示例)'
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
     qwh(51:60)=[];
     fch(51:60)=[];
    % 插值处理
 %     x_fine = linspace(0, 21272160.2214309*5, num_variables);
%     y_fine = spline(qwh, fch, x_fine);

    data = [fch, fch(1)];
    
    % 绘制雷达图
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    hold on;
end
title('(c)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% 右图：绝对值雷达图
subplot(2,2,4); % 创建右边子图
set(gca, 'Position',pos4); % 调整右图位置和大小

theta_values = 0:21272160.2214309*5/12/10^6:21272160.2214309*5*11/12/10^6;
theta_values=round(theta_values , 3, 'significant');
theta_degrees = theta_values * (360 / (21272160.2214309/10^6*5));

pax2 = polaraxes;
hold on;
pax2.RLim = [0 5.1*10^14]; % 设置 r 坐标的范围，范围为 0 到 6
pax2.ThetaTick = theta_degrees;
pax2.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax2, 'Position', pos4); % 确保雷达图居中

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);
     qwh(51:60)=[];
     fch(51:60)=[];
    QT2PO(51:60)=[];
    qwh=qwh.*QT2PO;
    fch=fch.*QT2PO.*QT2PO;
    
%     x_fine = linspace(0, 21272160.2214309*5, num_variables);
%     y_fine = spline(qwh, fch, x_fine);

    data = [fch, fch(1)];
    
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    hold on;
end

title('(d)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);
%% 共用图例设置





lgd = legend(arrayfun(@(Ts) ['$T_{\rm{A}} = $' num2str(Ts)], 0:-2.5:-20, 'UniformOutput', false), ...
    'Orientation', 'horizontal', 'NumColumns', 5, 'FontSize', 10, 'Box', 'off', 'Interpreter', 'latex');
lgd.ItemTokenSize = [10, 10]; % 缩短图例线条长度
set(lgd, 'Position', [0.2, 0.01, 0.6, 0.05]); % 调整图例位置，放在两张图的下方
cd('F:\王中昊\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\对照结果\结果')

