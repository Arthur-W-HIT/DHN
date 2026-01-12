%%均匀-非均匀对比
colors=[84,80,157;178,172,211;91,175,255;174,230,255;...
    76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
    239,118,122;69,105,144;72,192,170]/255;


x= linspace(0, PDH_nx, PDH_nx)/500*2408; % 时间坐标
y1=PDH_S_T_CS;
y2=PDH_R_T_CS;
y3=SDH_S_T_CS;
y4=SDH_R_T_CS;


% Define colors

% Create figure
figure;
set(gcf,'unit','centimeters','position',[10 10 9 9])
% Plot data
plot(x, y1, 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
plot([0 2408], [y3(SDH_nx)+5+y3(SDH_nx)-y4(1)   y3(SDH_nx)+5+y3(SDH_nx)-y4(1)  ], 'LineWidth', 1.5, 'Color', colors(2,:),'LineStyle','--'); 


plot(x, y2, 'LineWidth', 1.5, 'Color', colors(3,:));
plot([0 2408], [y3(SDH_nx)+5  y3(SDH_nx)+5 ], 'LineWidth', 1.5, 'Color', colors(4,:),'LineStyle','--');

plot(x, y3, 'LineWidth', 1.5, 'Color', colors(5,:));
plot([0 2408], [y3(SDH_nx)   y3(SDH_nx)  ], 'LineWidth', 1.5, 'Color', colors(6,:),'LineStyle','--');


plot(x, y4, 'LineWidth', 1.5, 'Color', colors(7,:));
plot([0 2408], [y4(1)   y4(1) ], 'LineWidth', 1.5, 'Color', colors(8,:),'LineStyle','--');






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
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe (℃)', 'FontSize', 10, 'Interpreter', 'latex');
% Set legend
hl=legend('PS','PS_E' ,'PR','PR_E','SS','SS_E' ,'SR','SR_E','FontSize', 10, 'Interpreter', 'latex', 'Location', 'northoutside','NumColumns',4);
set(hl,'box','off')
hl.ItemTokenSize = [15,10];
% xlim([10000,86400]/3600);
ylim([30 100]);
% Save the figure with 300 dpi resolution
print('均匀_非均匀场对比', '-dpng', '-r300');  % Save as PNG with 300 dpi
saveas(gcf, '均匀_非均匀场对比.fig')

%% 变环境温度 结果
colors=[84,80,157;178,172,211;91,175,255;174,230,255;...
    76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
    239,118,122;69,105,144;72,192,170]/255;

load CSWDC_T_20_5_10_V_4_0.4.mat
wxhs=11;

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

% Plot in the first subplot
subplot('Position', pos4);
for wxh = 1:wxhs
    for nxh = 1:1
        plot(1:length(PDH_S_T_CS_data{wxh,nxh}), PDH_S_T_CS_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(wxh,:));
        hold on;
    end
end
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
ylim([80 125])
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe PS (℃)', 'FontSize', 10, 'Interpreter', 'latex');
title('(d)')
% Plot in the second subplot
subplot('Position', pos3);
for wxh = 1:wxhs
    for nxh = 1:1
        plot(1:length(PDH_R_T_CS_data{wxh,nxh}), PDH_R_T_CS_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(wxh,:));
        hold on;
    end
end
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe PR (℃)', 'FontSize', 10, 'Interpreter', 'latex');
title('(c)')
% Plot in the third subplot
subplot('Position', pos2);
for wxh = 1:wxhs
    for nxh = 1:1
        h3_plot = plot(1:length(SDH_S_T_CS_data{wxh,nxh}), SDH_S_T_CS_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(wxh,:));
        h3 = [h3, h3_plot]; % Store plot handles for legend
        hold on;
    end
end
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe SS (℃)', 'FontSize', 10, 'Interpreter', 'latex');
title('(b)')
% Plot in the fourth subplot
subplot('Position', pos1);
for wxh = 1:wxhs
    for nxh = 1:1
        h4_plot = plot(1:length(SDH_R_T_CS_data{wxh,nxh}), SDH_R_T_CS_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(wxh,:));
        h4 = [h4, h4_plot]; % Store plot handles for legend
        hold on;
    end
end
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe SR (℃)', 'FontSize', 10, 'Interpreter', 'latex');
title('(a)')
% Create a legend below the third and fourth subplots
hl = legend([h3, h4], '$T_{\rm{A}}=-20$','$T_{\rm{A}}=-17.5$','$T_{\rm{A}}=-15$','$T_{\rm{A}}=-12.5$',...
    '$T_{\rm{A}}=-10$','$T_{\rm{A}}=-7.5$','$T_{\rm{A}}=-5$','$T_{\rm{A}}=-2.5$','$T_{\rm{A}}=0$',...
    '$T_{\rm{A}}=2.5$','$T_{\rm{A}}=5$', ...
    'FontSize', 10, 'Interpreter', 'latex', 'NumColumns', 8);
set(hl, 'box', 'off');

% Manually position the legend below the third and fourth subplots
newPosition = [0.29, 0.05, 0.4, 0.05]; % Adjust [left, bottom, width, height] as needed
set(hl, 'Position', newPosition);
hl.ItemTokenSize = [10,30];

print('PS变温_流速比4_x', '-dpng', '-r600');  % Save as PNG with 300 dpi
saveas(gcf, 'PS变温_流速比4_x.fig')
close