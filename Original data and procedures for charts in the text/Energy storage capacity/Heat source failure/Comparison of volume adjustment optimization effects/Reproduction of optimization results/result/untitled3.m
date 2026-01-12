%%均匀-非均匀对比
colors=[84,80,157;178,172,211;91,175,255;174,230,255;...
    76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
    239,118,122;69,105,144;72,192,170]/255;

%获取未优化前最大时长
load all_T_20_5_10_V_4_0.4.mat
for wxh=1:11
    for nxh=1:1
        a=R_T_all_data{wxh,nxh};
        ZDSC(wxh,nxh)=find(a<16,1)/3600;
    end
end

for wxh=1:11
    for nxh=1:1
     WXH=(wxh-1)*2.5-20;
     fileName = ['GA_Optimization_Result' num2str(WXH+100)] ;
     load(fileName); 
     GA_ZDSC(wxh,nxh)=fval;
    end
end



x= 1:1:11; % 时间坐标
y1=ZDSC;
y2=-GA_ZDSC;
y3=(y2-y1)./y1*100;


figure;
set(gcf,'unit','centimeters','position',[10 10 9 7])
ax = gca; % 获取当前坐标轴句柄  
tightInset = get(ax, 'TightInset');  
pos = get(gcf, 'Position');  
% newPos = [pos(1), pos(2), pos(3) - tightInset(3), pos(4) - tightInset(4)];  
% set(gcf, 'Position', newPos);
set(gcf, 'Position', pos);



yyaxis left;
% 绘制 y1 的折线图，突出每个数据点
plot(x, y1, 'LineWidth', 1.5, 'Color', colors(1,:), 'LineStyle', '-', 'Marker', 's', 'MarkerSize', 3, 'MarkerEdgeColor', colors(1,:), 'MarkerFaceColor', colors(2,:)); 
hold on;
% 绘制 y2 的折线图，突出每个数据点
plot(x, y2, 'LineWidth', 1.5, 'Color', colors(3,:), 'LineStyle', '-', 'Marker', 'o', 'MarkerSize', 3, 'MarkerEdgeColor', colors(3,:), 'MarkerFaceColor', colors(4,:));
% 设置左坐标轴标签
ylabel('Maximum heating duration (h)', 'FontSize', 10, 'Interpreter', 'latex');
xlim([1 11]) 
ylim([5 17]) 
% 使用右坐标轴绘制 y3
% plot(x, y4, 'LineWidth', 1.5, 'Color', colors(3,:), 'LineStyle', '-', 'Marker', 'o', 'MarkerSize', 7, 'MarkerEdgeColor', colors(3,:), 'MarkerFaceColor', colors(8,:));


yyaxis right;

% 绘制 y3，设置为右坐标轴
plot(x, y3, 'LineWidth', 1.5, 'Color', colors(5,:), 'LineStyle', '-', 'Marker', 'h', 'MarkerSize', 3, 'MarkerEdgeColor', colors(5,:), 'MarkerFaceColor',colors(6,:));
% 设置右坐标轴标签
ylabel('Rate of change (%)', 'FontSize', 10, 'Interpreter', 'latex');
ylim([0 70]) 
xlabel('Heat source failure scenario', 'FontSize', 10, 'Interpreter', 'latex');
xticks(x);  % 设置横坐标的刻度
set(gca, 'XTickLabel', {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K'}, ...
    'FontName', 'Times New Roman');  % 设置坐标轴字体
grid off;

hl = legend('$\rm{MHD}_{Ori}$', '$\rm{MHD}_{Opt}$','$\eta$', 'FontSize', 10, 'Interpreter', 'latex', ...
    'Location', 'best', 'NumColumns', 3);  % 设置为两列

% 设置图例的位置，防止被挡住
set(hl,'box','off')
hl.ItemTokenSize = [15,50];

% print('优化前后MHD', '-dpng', '-r600');  % Save as PNG with 300 dpi
% saveas(gcf, '优化前后MHD.fig')
% close