colors=[84,80,157;178,172,211;91,175,255;174,230,255;...
    76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
    239,118,122;69,105,144;72,192,170]/255;
wxhs=11;
nxhs=10;
% load CSWDC_T_20_5_10_V_4_0.4.mat
load all_T_20_5_10_V_4_0.4.mat

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 14 13]); % Adjust figure size
% Manually control subplot positions (left, bottom, width, height)
pos1 = [0.1, 0.6, 0.35, 0.3]; % First subplot
pos2 = [0.55, 0.6, 0.35, 0.3]; % Second subplot
pos3 = [0.1, 0.2, 0.35, 0.3]; % Third subplot
pos4 = [0.55, 0.2, 0.35, 0.3]; % Fourth subplot

% Prepare a handle array for the plot lines
h3 = [];
h4 = [];
wxhs=11;
% Plot in the first subplot
subplot('Position', pos4);
for wxh = 1:wxhs
    for nxh = 1:1
        plot(1/3600:1/3600:length(R_T_all_data{wxh,nxh})/3600, R_T_all_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(wxh,:));
        hold on;
    end
end
plot([0 24],[16 16], 'LineWidth', 1.5,'LineStyle',':' ,'Color', colors(12,:));
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Indoor temperature (℃)', 'FontSize', 10, 'Interpreter', 'latex');
title('(d)')
% Plot in the second subplot
subplot('Position', pos3);
for wxh = 1:wxhs
    for nxh = 2:2
        plot(1/3600:1/3600:length(R_T_all_data{wxh,nxh})/3600,  R_T_all_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(wxh,:));
        hold on;
    end
end
plot([0 24],[16 16], 'LineWidth', 1.5,'LineStyle',':' ,'Color', colors(12,:));
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Indoor temperature (℃)', 'FontSize', 10, 'Interpreter', 'latex');
title('(c)')
% Plot in the third subplot
subplot('Position', pos2);
for wxh = 1:wxhs
    for nxh = 3:3
        h3_plot = plot(1/3600:1/3600:length(R_T_all_data{wxh,nxh})/3600, R_T_all_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(wxh,:));
        h3 = [h3, h3_plot]; % Store plot handles for legend
        hold on;
    end
end
plot([0 24],[16 16], 'LineWidth', 1.5,'LineStyle',':' ,'Color', colors(12,:));
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Indoor temperature (℃)', 'FontSize', 10, 'Interpreter', 'latex');
title('(b)')
% Plot in the fourth subplot
subplot('Position', pos1);
for wxh = 1:wxhs
    for nxh = 4:4
        h4_plot = plot(1/3600:1/3600:length(R_T_all_data{wxh,nxh})/3600, R_T_all_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(wxh,:));
        h4 = [h4, h4_plot]; % Store plot handles for legend
        hold on;
    end
end
plot([0 24],[16 16], 'LineWidth', 1.5,'LineStyle',':' ,'Color', colors(12,:));
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Indoor temperature (℃)', 'FontSize', 10, 'Interpreter', 'latex');
title('(a)')
% Create a legend below the third and fourth subplots
hl = legend([h3, h4], '$T_{\rm{A}}=-20$','$T_{\rm{A}}=-17.5$','$T_{\rm{A}}=-15$','$T_{\rm{A}}=-12.5$',...
    '$T_{\rm{A}}=-10$','$T_{\rm{A}}=-7.5$','$T_{\rm{A}}=-5$','$T_{\rm{A}}=-2.5$','$T_{\rm{A}}=0$',...
    '$T_{\rm{A}}=2.5$','$T_{\rm{A}}=5$', ...
    'FontSize', 10, 'Interpreter', 'latex', 'NumColumns', 10);
set(hl, 'box', 'off');

% Manually position the legend below the third and fourth subplots
newPosition = [0.29, 0.05, 0.4, 0.05]; % Adjust [left, bottom, width, height] as needed
set(hl, 'Position', newPosition);
hl.ItemTokenSize = [10,30];

% print('室温_变流速比_变环境室温_x', '-dpng', '-r600');  % Save as PNG with 300 dpi
% saveas(gcf, '室温_变流速比_变环境室温_x.fig')
% close

%%
for wxh = 1:wxhs
    for nxh = 1:nxhs
yy(wxh,nxh) = find( R_T_all_data{wxh,nxh}< 16, 1)/3600;

if isempty(yy)
    y = -24;
else
    y = yy/ 3600;
end
    end
end

% 定义网格数据
[X,Y] = meshgrid(1:1:10,-20:2.5:5 ); % 定义X和Y的范围
Z = yy; % 定义Z轴函数

% 创建三维图
figure;
surf(X, Y, Z);

% 美化图像
colormap turbo;               % 设置颜色映射，可以尝试 'jet', 'parula', 'hsv' 等
shading interp;               % 插值色彩，使颜色更平滑
lighting phong;               % 设置光照模型为Phong，使得表面效果更好
camlight headlight;           % 在相机位置添加光源，照亮表面
material shiny;               % 让表面更加光滑和有光泽

% 添加轴标签和标题
xlabel('X-axis', 'FontSize', 12, 'FontWeight', 'bold'); % X轴标签
ylabel('Y-axis', 'FontSize', 12, 'FontWeight', 'bold'); % Y轴标签
zlabel('Z-axis', 'FontSize', 12, 'FontWeight', 'bold'); % Z轴标签
title('3D Surface Plot', 'FontSize', 14, 'FontWeight', 'bold'); % 标题

% 设置坐标轴和网格线
grid on;                      % 打开网格线
set(gca, 'FontSize', 12);     % 设置坐标轴字体大小
set(gca, 'LineWidth', 1.5);   % 设置坐标轴线条宽度

% 设置视角
view(135, 30);                % 设置观察角度（方位角和俯仰角）

% 调整背景颜色
set(gcf, 'Color', 'w');       % 将背景颜色设置为白色（期刊常用的背景色）


% 清除之前的数据
clc;
clear;
close all;

% 输入数据矩阵（你的数据）
Z = [
    5.2203 5.0122 4.8078 4.5306 4.5250 4.5386 4.5708 4.5733 4.5369 4.4539;
    5.4544 5.2831 5.0444 4.7717 4.7408 4.7464 4.7683 4.7828 4.7781 4.7161;
    5.7308 5.5386 5.2772 5.0272 4.9528 4.9517 4.9681 4.9811 4.9997 4.9450;
    6.0297 5.8000 5.5456 5.3281 5.1989 5.1894 5.2006 5.2097 5.2375 5.2039;
    6.3775 6.1178 5.8606 5.6931 5.5081 5.4756 5.4803 5.4847 5.5108 5.4986;
    6.7847 6.5639 6.2236 6.1350 5.9203 5.8281 5.8244 5.8225 5.8447 5.8342;
    7.2708 7.1039 6.7261 6.5681 6.4461 6.2847 6.2592 6.2489 6.2658 6.2497;
    7.8642 7.6931 7.4150 7.0986 7.0681 6.9214 6.8289 6.8050 6.7833 6.7914;
    8.6058 8.4772 8.1500 7.8133 7.7839 7.6944 7.6150 7.5614 7.5269 7.5275;
    9.5458 9.3592 9.0206 8.7714 8.5675 8.5361 8.4472 8.3881 8.3569 8.3639;
    10.7761 10.6264 10.2678 9.9464 9.7739 9.6322 9.5911 9.4978 9.4344 9.4253
];

% 创建 X 和 Y 轴的网格
[X, Y] = meshgrid(1:size(Z, 2), 1:size(Z, 1));

% 创建三维曲面图
figure;
surf(X, Y, Z);

% 美化图像
colormap jet;                 % 使用 'jet' 颜色映射
shading interp;               % 平滑颜色
lighting phong;               % 光照设置为Phong模型
camlight headlight;           % 在相机位置添加光源
material shiny;               % 增加表面光泽

% 添加轴标签和标题
xlabel('X-axis', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Y-axis', 'FontSize', 12, 'FontWeight', 'bold');
zlabel('Z-axis', 'FontSize', 12, 'FontWeight', 'bold');
title('3D Surface Plot of the Data', 'FontSize', 14, 'FontWeight', 'bold');

% 设置视角
view(135, 30);

% 设置背景颜色为白色
set(gcf, 'Color', 'w');

% 打开网格线
grid on;
