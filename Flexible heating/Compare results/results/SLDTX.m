close all
clear
colors = [84,80,157;178,172,211;91,175,255;174,230,255;...
          76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
          239,118,122;69,105,144;72,192,170]/255;

figure;
set(gcf, 'unit', 'centimeters', 'position', [10 10 12 12.5]);

pos1 = [0.08 0.57 0.35 0.35];
pos2 = [0.54 0.57 0.35 0.35];
pos3 = [0.08 0.12 0.35 0.35];
pos4 = [0.54 0.12 0.35 0.35];

%% Left Plot: Relative Radar Chart
subplot(2,2,1);
set(gca, 'Position', pos1);

num_variables = 50; 
angles = linspace(0, 2*pi, num_variables+1);

theta_values = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5];
theta_degrees = theta_values * (360 / 5);

pax1 = polaraxes;
hold on;
pax1.ThetaTick = theta_degrees; 
pax1.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax1, 'Position', pos1);

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    qwh(51:60) = [];
    fch(51:60) = [];

    data = [fch, fch(1)];
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(a)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% Right Plot: Absolute Radar Chart with Angle based on qwh and QT2PO product
subplot(2,2,2);
set(gca, 'Position', pos2);

theta_values = 0:21272160.2214309*5/12/10^6:21272160.2214309*5*11/12/10^6;
theta_values = round(theta_values , 3, 'significant');
theta_degrees = theta_values * (360 / (21272160.2214309/10^6*5));

pax2 = polaraxes;
hold on;
pax2.RLim = [0 5.1*10^14];
pax2.ThetaTick = theta_degrees;
pax2.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax2, 'Position', pos2);

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);

    qwh(51:60) = [];
    fch(51:60) = [];
    QT2PO(51:60) = [];

    % Calculate angle based on qwh and QT2PO product
    angle_qwh_QT2PO = qwh .* QT2PO;
    angles = linspace(0, 2*pi, length(angle_qwh_QT2PO) + 1);

    % Prepare data for plot
    fch_modified = fch .* QT2PO .* QT2PO;
    data = [fch_modified, fch_modified(1)];
    
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end

title('(b)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% Bottom Left Plot: Relative Radar Chart
subplot(2,2,3);
set(gca, 'Position', pos3);

num_variables = 50; 
angles = linspace(0, 2*pi, num_variables+1);

theta_values = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5];
theta_degrees = theta_values * (360 / 5);

pax1 = polaraxes;
hold on;
pax1.ThetaTick = theta_degrees; 
pax1.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax1, 'Position', pos3);

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    qwh(51:60) = [];
    fch(51:60) = [];

    data = [fch, fch(1)];
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end
title('(c)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% Bottom Right Plot: Absolute Radar Chart with Angle based on qwh and QT2PO product
subplot(2,2,4);
set(gca, 'Position', pos4);

theta_values = 0:21272160.2214309*5/12/10^6:21272160.2214309*5*11/12/10^6;
theta_values = round(theta_values , 3, 'significant');
theta_degrees = theta_values * (360 / (21272160.2214309/10^6*5));

pax2 = polaraxes;
hold on;
pax2.RLim = [0 5.1*10^14];
pax2.ThetaTick = theta_degrees;
pax2.ThetaTickLabel = arrayfun(@(x) num2str(x), theta_values, 'UniformOutput', false); 
set(pax2, 'Position', pos4);

for k = 1:9
    Ts = 0 - 2.5 * (k - 1);
    filename = ['温度' num2str(Ts) '.mat'];
    load(filename);
    fileName = ['INDEX_' num2str(Ts) '.mat'];
    load(fileName);
    fileName = ['QT2PO_' num2str(Ts) '.mat'];
    load(fileName);

    qwh(51:60) = [];
    fch(51:60) = [];
    QT2PO(51:60) = [];

    angle_qwh_QT2PO = qwh .* QT2PO;
    angles = linspace(0, 2*pi, length(angle_qwh_QT2PO) + 1);

    fch_modified = fch .* QT2PO .* QT2PO;
    data = [fch_modified, fch_modified(1)];
    
    polarplot(angles, data, 'LineWidth', 1.5, 'Color', colors(k,:));
end

title('(d)')
set(gca, 'FontName', 'Times New Roman','FontSize',10);

%% Shared Legend
lgd = legend(arrayfun(@(Ts) ['$T_{\rm{A}} = $' num2str(Ts)], 0:-2.5:-20, 'UniformOutput', false), ...
    'Orientation', 'horizontal', 'NumColumns', 5, 'FontSize', 10, 'Box', 'off', 'Interpreter', 'latex');
lgd.ItemTokenSize = [10, 10];
set(lgd, 'Position', [0.2, 0.01, 0.6, 0.05]);
cd('F:\王中昊\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\对照结果\结果')
