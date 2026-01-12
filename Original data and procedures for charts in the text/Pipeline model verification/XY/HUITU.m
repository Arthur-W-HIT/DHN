% Define data
x = 0:0.1:10;
y1 = sin(x);
y2 = cos(x);
% Define colors
colors=[239 118 122;
            69 105 144;
            72 192  170]/255;
% Create figure
figure;
set(gcf,'unit','centimeters','position',[10 10 9 6])
% Plot data
plot(x, y1, 'LineWidth', 1.5, 'Color', colors(1,:)); hold on;
plot(x, y2, 'LineWidth', 1.5, 'Color', colors(2,:));
% Set grid and hold off
grid on;
hold off;
% Set axes properties
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'LineWidth', 1.2);
% Add labels and title
xlabel('X-axis label', 'FontSize', 10, ' ', 'latex');
ylabel('Y-axis label', 'FontSize', 10, 'Interpreter', 'latex');
title('Title of the Figure', 'FontSize', 10, 'FontWeight', 'bold', 'Interpreter', 'latex');
% Set legend
legend({'$\sin(x)$', '$\cos(x)$'}, 'FontSize', 10, 'Interpreter', 'latex', 'Location', 'best');
% Set the paper size and position for a 90mm wide figure (single column)
% set(gcf, 'PaperUnits', 'centimeters');  % Set units to centimeters
% set(gcf, 'PaperSize', [9 6]);           % Set paper size: 9 cm width, 6 cm height (you can adjust the height)
% set(gcf, 'PaperPosition', [0 0 9 6]);   % Set the actual position: full paper used
set(gcf,'unit','centimeters','position',[10 10 9 6])
% Save the figure with 300 dpi resolution
print('FigureName', '-dpng', '-r300');  % Save as PNG with 300 dpi
