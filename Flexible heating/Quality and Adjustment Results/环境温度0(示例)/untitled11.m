% 示例：期望和方差的雷达图

% 定义不同变量的期望和方差（或标准差）
mean_values = [4, 5, 3, 4.5;   % 数据集1的期望
               3.5, 4.5, 4, 4]; % 数据集2的期望
variance_values = [1, 0.5, 0.8, 1;   % 数据集1的方差
                   0.8, 1, 0.6, 0.9]; % 数据集2的方差

% 变量的名称
labels = {'Variable 1', 'Variable 2', 'Variable 3', 'Variable 4'};

% 创建雷达图的角度
num_variables = size(mean_values, 2);
angles = linspace(0, 2*pi, num_variables + 1);

% 创建图像
figure;
hold on;

% 设置颜色
colors = lines(size(mean_values, 1));

% 绘制每个数据集的雷达图
for i = 1:size(mean_values, 1)
    % 生成雷达图数据
    mean_data = [mean_values(i, :), mean_values(i, 1)];  % 闭合环
    var_data = [variance_values(i, :), variance_values(i, 1)];  % 闭合环
    
    % 绘制雷达图（期望值）
    polarplot(angles, mean_data, 'LineWidth', 1.5, 'Color', colors(i, :));
    hold on;
    
    % 绘制方差范围（可用阴影区或误差棒来表示）
    polarplot(angles, mean_data + var_data, '--', 'LineWidth', 1, 'Color', colors(i, :)); % 加方差的上限
    polarplot(angles, mean_data - var_data, '--', 'LineWidth', 1, 'Color', colors(i, :)); % 加方差的下限
end

% 设置图例
legend({'Dataset 1 (mean)', 'Dataset 1 (+/- variance)', ...
        'Dataset 2 (mean)', 'Dataset 2 (+/- variance)'}, ...
        'Location', 'southoutside', 'Orientation', 'horizontal');

% 设置标签
set(gca, 'ThetaTick', angles(1:end-1)*(180/pi), 'ThetaTickLabel', labels);

% 设置标题
title('Radar Chart: Mean and Variance of Variables', 'FontSize', 14);

% 结束
hold off;
