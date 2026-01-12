%%二维-多线-相对期望/方差图
close 
clear
colors=[84,80,157;178,172,211;91,175,255;174,230,255;76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 9 6]); % Adjust figure size
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);


for k=1:9

Ts=0-2.5*(k-1);
 filename=['温度' num2str(Ts) '.mat'];
 load(filename)
fileName=['INDEX_' num2str(Ts) '.mat'];
 load(fileName)

qwh=qwh;
fch=fch;

plot(qwh,fch, '--','LineWidth', 1.5, 'Color', colors(k,:));
% plot(xq,yq, '-','LineWidth', 1.5, 'Color', colors(k,:));
hold on
plot(qwh,fch, 'o','MarkerSize',3, 'Color',colors(k,:));

end

%%
close 
clear
colors=[84,80,157;178,172,211;91,175,255;174,230,255;76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 9 6]); % Adjust figure size
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);



for i=3:3

% 
x_fill = [0 6 6 0];       % X坐标：曲线从左到右，X轴从右到左
y_fill = [0 0 2.5 2.5];  % Y坐标：曲线的Y值和X轴上的0值

% 使用 fill 函数填充曲线以上的区域
fill(x_fill, y_fill, colors(2,:), 'FaceAlpha', 0.1, 'EdgeColor', 'none');  % 半透明红色

x_fill = [qwh, fliplr(qwh)];       % X坐标：曲线从左到右，X轴从右到左
y_fill = [fch, zeros(size(qwh))];  % Y坐标：曲线的Y值和X轴上的0值

% 使用 fill 函数填充曲线以上的区域
fill(x_fill, y_fill, 'w', 'FaceAlpha', 1, 'EdgeColor', 'none');  % 半透明红色



qwh_min = min(qwh);  
qwh_max = max(qwh);  
fch_min = min(fch(fch >= 0)); % 只考虑非负y值的最小值，如果曲线在y轴下方也有部分，需要调整  
fch_min_all = min(fch); % 如果要包括曲线在y轴下方的部分，使用这个值  
fch_max = max(fch);  
  
% 创建用于填充多边形的x和y坐标  
% 注意：这里我们创建了一个闭合的多边形，其顶点包括曲线的起点和终点，以及x轴和y轴的交点  
fill_qwh = [qwh_min, qwh, qwh_max, qwh_max, qwh_min];  
fill_fch = [fch_min_all, fch, fch_max, fch_min, fch_min_all]; % 如果要包括y轴下方的部分  
% 如果只填充到x轴下方和曲线非负部分，则使用：  
% fill_y = [0, y(y >= 0), y_max, 0];  
  
% 使用fill函数填充多边形区域  
fill(fill_qwh, fill_fch, colors(3,:), 'EdgeColor', 'none', 'FaceAlpha', 0.1);
end
xlabel('The relative expected heat flux of a source ', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Heat source intensity variance', 'FontSize', 10, 'Interpreter', 'latex');

for k=3:3

Ts=0-2.5*(k-1);
 filename=['温度' num2str(Ts) '.mat'];
 load(filename)
fileName=['INDEX_' num2str(Ts) '.mat'];
 load(fileName)

qwh=qwh;
fch=fch;

pp = spline(qwh, fch);  
  
% 定义插值点  
xq = linspace(min(qwh), max(qwh), 100); % 100 个插值点，均匀分布在 x 的范围内  
  
% 计算插值结果  
yq = ppval(pp, xq); 



plot(qwh,fch, '-','LineWidth', 2, 'Color', colors(k+1,:));
% plot(xq,yq, '-','LineWidth', 1.5, 'Color', colors(k,:));
hold on
plot(qwh,fch, 'o','MarkerSize',3, 'Color',colors(k,:));

ylim([0 2.5])



end


yyaxis right

plot([qwh(3) qwh(3)],[0 24], '.--r','LineWidth', 2);
plot([qwh(44) qwh(44)],[0 24], '.--r','LineWidth', 2);
INDEX1=INDEX(1:3,1);
INDEX2=ones(40,1)*24;
INDEX3=INDEX(44:60,3);
INDEXX=[INDEX1;INDEX2;INDEX3];
plot(qwh(1:3),INDEX1, '-','LineWidth', 2, 'Color', colors(1,:));
plot(qwh(1:3),INDEX1, 'v','MarkerSize',3, 'Color',colors(1,:))
plot(qwh(4:43),INDEX2, '--','LineWidth', 2, 'Color', colors(2,:));
plot(qwh(4:43),INDEX2, 'v','MarkerSize',3, 'Color',colors(2,:))
plot(qwh(44:60),INDEX3, '-','LineWidth', 2, 'Color', colors(1,:));
plot(qwh(44:60),INDEX3, 'v','MarkerSize',3, 'Color',colors(1,:))
% plot(qwh,INDEXX, '-','LineWidth', 2);
% plot(qwh(4:43),INDEX2, '--w','LineWidth', 2);
ylim([0 30])
xlabel('The relative expected heat flux of a source ', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Maximum heat storage duration (h)', 'FontSize', 10, 'Interpreter', 'latex');



