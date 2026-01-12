colors=[84,80,157;178,172,211;91,175,255;174,230,255;...
    76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183]/255;

load BW.mat
load XY.mat
load XM.mat
x= linspace(0, t_end, nt)/3600; % 时间坐标
y1=T_all(2,:);
y2=T_all(pos, :);
m_in=max(y1);
m_out=max(y2);
obj1=find(y1==m_in);
obj2=find(y2==m_out);
lt=(obj2-obj1)/3600
% Define colors

% Create figure
figure;
set(gcf,'unit','centimeters','position',[10 10 9 7])
% Plot data
plot(x, y1, 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
plot(x, y2, 'LineWidth', 1.5, 'Color', colors(2,:));
plot(obj1/3600,y1(obj1),'s', 'LineWidth', 2, 'Color', colors(3,:))
plot(obj2/3600,y2(obj2),'s', 'LineWidth', 2, 'Color', colors(4,:))
plot([obj1/3600 obj1/3600], [30 90], 'LineWidth', 1.5, 'Color', colors(6,:),'linestyle','--');
plot([obj2/3600 obj2/3600], [30 90], 'LineWidth', 1.5, 'Color', colors(6,:),'linestyle','--');
x_start = obj1/3600;  % 起始点 x 坐标
x_end = obj2/3600;    % 终点 x 坐标
y = 50;           % y 坐标保持不变
% 计算向量分量
u = x_end - x_start;  % x 方向分量
v = 0;                % y 方向分量为 0
% 绘制线段并在两端加上箭头
quiver(x_start, y, u, v, 0, 'MaxHeadSize', 0.001 ,'LineWidth', 1.5, 'Color', colors(7,:));  % 正向箭头
quiver(x_end, y, -u, v, 0, 'MaxHeadSize', 0.001, 'LineWidth', 1.5, 'Color', colors(7,:));  % 反向箭头
text(15000/3600, 40, 'Lag time = 1.54 h', 'FontSize', 10, 'fontname', 'times new roman', 'Color', 'black', 'Interpreter', 'latex');


% Set grid and hold off

% load XM.mat
% x= linspace(0, t_end, nt); % 时间坐标
% y2=T_all(pos, :);
% plot(x, y2, 'LineWidth', 1.5, 'Color', colors(2,:),'linestyle','--');
% 
% load XY.mat
% x= linspace(0, t_end, nt); % 时间坐标
% y2=T_all(pos, :);
% plot(x, y2, 'LineWidth', 1.5, 'Color', colors(3,:),'linestyle','--');

grid off;
% Set axes properties
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
% Add labels and title
xlabel('Time (h)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe (℃)', 'FontSize', 10, 'Interpreter', 'latex');
% Set legend
hl=legend({'$T_{\rm{in}}$', '$T_{\rm{out}}$','$T_{\rm{in}}^{\rm{max}}$','$T_{\rm{out}}^{\rm{max}}$',}, 'FontSize', 10, 'Interpreter', 'latex', 'Location', 'best');
set(hl,'box','off')
xlim([10000,86400]/3600);
ylim([30,90]);
% Save the figure with 300 dpi resolution
print('BW延迟时间验证', '-dpng', '-r300');  % Save as PNG with 300 dpi
saveas(gcf, 'BW延迟时间验证.fig')