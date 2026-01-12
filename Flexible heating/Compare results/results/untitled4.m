colors=[84,80,157;178,172,211;91,175,255;174,230,255;...
    76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
    239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 19 19*0.6]); % Adjust figure size
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe PS (℃)', 'FontSize', 10, 'Interpreter', 'latex');


for k=1:9

Ts=0-2.5*(k-1);
 filename=['温度' num2str(Ts) '.mat'];
 load(filename)
fileName=['INDEX_' num2str(Ts) '.mat'];
 load(fileName)

% x_fine = linspace(min(qwh), max(qwh), 100);
% 
% % 使用 spline 函数进行样条插值
% y_fine = spline(qwh, fch, x_fine);
plot(qwh,fch,'--','LineWidth', 1, 'Color', colors(k,:));
% plot(x_fine,y_fine,'LineWidth', 1.5, 'Color', colors(k,:));
hold on
plot(qwh,fch, 'o','MarkerSize',3, 'Color',colors(k,:));
end
xlim([0 5])