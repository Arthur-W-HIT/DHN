colors=[84,80,157;178,172,211;91,175,255;174,230,255;...
    76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
    239,118,122;69,105,144;72,192,170]/255;

load CSWDC_T_20_5_10_V_4_0.4.mat

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 14 11]); % Adjust figure size
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
for wxh = 1:1
    for nxh = 1:3
        plot(1:length(PDH_S_T_CS_data{wxh,nxh}), PDH_S_T_CS_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(nxh,:));
        hold on;
    end
end
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe PS (℃)', 'FontSize', 10, 'Interpreter', 'latex');

% Plot in the second subplot
subplot('Position', pos3);
for wxh = 1:1
    for nxh = 1:3
        plot(1:length(PDH_R_T_CS_data{wxh,nxh}), PDH_R_T_CS_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(nxh,:));
        hold on;
    end
end
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe PR (℃)', 'FontSize', 10, 'Interpreter', 'latex');

% Plot in the third subplot
subplot('Position', pos2);
for wxh = 1:1
    for nxh = 1:3
        h3_plot = plot(1:length(SDH_S_T_CS_data{wxh,nxh}), SDH_S_T_CS_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(nxh,:));
        h3 = [h3, h3_plot]; % Store plot handles for legend
        hold on;
    end
end
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe SS (℃)', 'FontSize', 10, 'Interpreter', 'latex');

% Plot in the fourth subplot
subplot('Position', pos1);
for wxh = 1:1
    for nxh = 1:3
        h4_plot = plot(1:length(SDH_R_T_CS_data{wxh,nxh}), SDH_R_T_CS_data{wxh,nxh}, 'LineWidth', 1.5, 'Color', colors(nxh,:));
        h4 = [h4, h4_plot]; % Store plot handles for legend
        hold on;
    end
end
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
xlabel('Distance from entrance (m)', 'FontSize', 10, 'Interpreter', 'latex');
ylabel('Water temperature in pipe SR (℃)', 'FontSize', 10, 'Interpreter', 'latex');

% Create a legend below the third and fourth subplots
hl = legend([h3, h4], '$\gamma=-20$','$\gamma=-17.5$','$\gamma=-15$','$\gamma=-12.5$',...
    '$\gamma=-10$','$\gamma=-7.5$','$\gamma=-5$','$\gamma=-2.5$','$\gamma=0$',...
    '$\gamma=2.5$','$\gamma=5$', ...
    'FontSize', 10, 'Interpreter', 'latex', 'NumColumns', 8);
set(hl, 'box', 'off');

% Manually position the legend below the third and fourth subplots
newPosition = [0.29, 0.05, 0.4, 0.05]; % Adjust [left, bottom, width, height] as needed
set(hl, 'Position', newPosition);
hl.ItemTokenSize = [10,30];

% print('变流速比_温度为零下20', '-dpng', '-r600');  % Save as PNG with 300 dpi
% saveas(gcf, '变流速比_温度为零下20.fig')
% close