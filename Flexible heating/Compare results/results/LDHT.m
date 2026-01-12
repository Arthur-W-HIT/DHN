%% 相对期望雷达图
close all
clear
colors = [84,80,157;178,172,211;91,175,255;174,230,255;...
          76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
          239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 9 11]); % 调整图像大小
% set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);

% 定义雷达图的角度范围
num_variables = 60; % 假设我们有100个数据点要映射到雷达图的轴上
angles = linspace(0, 2*pi, num_variables+1); % 为雷达图生成角度
% labels = {'A', 'B', 'C', 'D', 'E'}; % 每个轴的标签
% 自定义角度刻度标签（0 到 5.5）
theta_values = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5]; % 你想设置的刻度值

% 将这些值转换为角度
theta_degrees = theta_values * (360 / 6); % 假设 6 个单位跨度对应 360°

% 使用 polaraxes 设置
pax = polaraxes; % 创建极坐标轴
hold on;

% 设置刻度
pax.ThetaTick = theta_degrees; % 设置角度刻度
pax.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); % 自定义刻度标签

% 其余绘制内容...


% 自定义角度刻度标签
% angle_labels = arrayfun(@(x) num2str(x, '%.2f'), 0:0.01:0.59, 'UniformOutput', false); % 创建0至0.59的标签
% 
% % 设置角度刻度
% pax.ThetaTick = linspace(0, 360 - (360/num_variables), num_variables); % 60个刻度，等间隔分布在360度上
% pax.ThetaTickLabel = angle_labels; % 角度标签设为0到0.59的值




for k = 1:9

    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);

    % 如果qwh长度不足num_variables，进行插值补充数据
    x_fine = linspace(min(qwh), max(qwh), num_variables);
    y_fine = spline(qwh, fch, x_fine); % 样条插值

    % 使数据形成闭合环
    data = [y_fine, y_fine(1)];
    
    % 绘制雷达图
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    hold on;
end

% 设置图例和标题
lgd = legend(arrayfun(@(Ts) ['$T_{\rm{A}} = $' num2str(Ts)], 0:-2.5:-20, 'UniformOutput', false), ...
    'Location', 'southoutside', 'Orientation', 'vertical', 'NumColumns', 3, 'FontSize', 10, 'Box', 'off', 'Interpreter', 'latex');

% 缩短图例线条的长度
lgd.ItemTokenSize = [10, 10]; % 调整第一个值来缩短线条长度（默认值通常较大）
xlabel('Relative expected value', 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter', 'latex'); % X 轴标签
ylabel('Variance', 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter', 'latex'); % Y 轴标签

set(gca, 'FontName', 'Times New Roman');
% title('Relative expectation and variance of heat source intensity', 'FontSize', 10, 'Interpreter', 'latex');


%% 绝对值雷达图
close all
clear
colors = [84,80,157;178,172,211;91,175,255;174,230,255;...
          76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
          239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 9 11]); % 调整图像大小
% set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);

% 定义雷达图的角度范围
num_variables = 60; % 假设我们有100个数据点要映射到雷达图的轴上
angles = linspace(0, 2*pi, num_variables+1); % 为雷达图生成角度
% labels = {'A', 'B', 'C', 'D', 'E'}; % 每个轴的标签
% 自定义角度刻度标签（0 到 5.5）
theta_values = 0:21272160.2214309*6/12/10^7:21272160.2214309*6*11/12/10^7; % 你想设置的刻度值
% 
% % 将这些值转换为角度
theta_degrees = theta_values * (360 / 6); % 假设 6 个单位跨度对应 360°

% 使用 polaraxes 设置
pax = polaraxes; % 创建极坐标轴
hold on;

% 设置刻度
pax.ThetaTick = theta_degrees; % 设置角度刻度
pax.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); % 自定义刻度标签

% 其余绘制内容...


% 自定义角度刻度标签
% angle_labels = arrayfun(@(x) num2str(x, '%.2f'), 0:0.01:0.59, 'UniformOutput', false); % 创建0至0.59的标签
% 
% % 设置角度刻度
% pax.ThetaTick = linspace(0, 360 - (360/num_variables), num_variables); % 60个刻度，等间隔分布在360度上
% pax.ThetaTickLabel = angle_labels; % 角度标签设为0到0.59的值




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
    % 如果qwh长度不足num_variables，进行插值补充数据
    x_fine = linspace(min(qwh), max(qwh), num_variables);
    y_fine = spline(qwh, fch, x_fine); % 样条插值

    % 使数据形成闭合环
    data = [y_fine, y_fine(1)];
    
    % 绘制雷达图
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
    hold on;
end

% 设置图例和标题
lgd = legend(arrayfun(@(Ts) ['$T_{\rm{A}} = $' num2str(Ts)], 0:-2.5:-20, 'UniformOutput', false), ...
    'Location', 'southoutside', 'Orientation', 'vertical', 'NumColumns', 3, 'FontSize', 10, 'Box', 'off', 'Interpreter', 'latex');

% 缩短图例线条的长度
lgd.ItemTokenSize = [10, 10]; % 调整第一个值来缩短线条长度（默认值通常较大）
% xlabel('Relative expected value', 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter', 'latex'); % X 轴标签
% ylabel('Variance', 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter', 'latex'); % Y 轴标签

set(gca, 'FontName', 'Times New Roman');