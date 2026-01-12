close all; clear;

%% 颜色
colors = [84,80,157;178,172,211;91,175,255;174,230,255;...
          76,147,146;182,208,206;218,93,70;231,177,168;246,173,83;255,234,183;...
          239,118,122;69,105,144;72,192,170]/255;

%% 画布与布局（4×2）
%% 画布与布局（4×2）
fig = figure('Units','centimeters','Position',[2 2 12 18]);  % 保持原尺寸

nrows = 4;                  % 4 行
ncols = 2;                  % 2 列
left  = 0.07;               % ↓ 略缩小左右边距、列间距；略加底部给图例留白
right = 0.06;
top   = 0.06;
bottom= 0.10;
hgap  = 0.03;               % 列间距更紧凑（原 0.02 容易让极坐标标签挤到边框）
vgap  = 0.075;              % 行间距适中，避免相互压到

% 计算单个子图宽高
axW = (1 - left - right - (ncols-1)*hgap) / ncols;
axH = (1 - top  - bottom - (nrows-1)*vgap) / nrows;

% 生成 pos（按 (a)(b); (c)(d); (e)(f); (g)(h) 顺序）
pos = cell(nrows, ncols);
for r = 1:nrows
    for c = 1:ncols
        x = left + (c-1)*(axW + hgap);
        y = 1 - top - r*axH - (r-1)*vgap;
        pos{r,c} = [x, y, axW, axH];
    end
end


%% 公共角度刻度
num_variables = 50;
angles = linspace(0, 2*pi, num_variables+1);

% —— 相对期望用的角度刻度（统一 0:0.5:4.5）——
theta_vals_rel = 0:0.5:4.5;
theta_degs_rel = theta_vals_rel * (360/5);

% —— 绝对值用的角度刻度 ——（保持你原配方）
theta_vals_abs = 0:21272160.2214309*5/12/1e6 : 21272160.2214309*5*11/12/1e6;
theta_vals_abs = round(theta_vals_abs,3,'significant');
theta_degs_abs = theta_vals_abs * (360/(21272160.2214309/1e6*5));

%% 载入水箱数据（11×1 cell，内含60×2）
load('水箱柔性供热结果.mat');         % 变量 processedData
numTankGroups = numel(processedData);

%% -------------------- (a) 原始数据-相对期望 --------------------
pax1 = polaraxes('Position', pos{1}); hold(pax1,'on');
pax1.ThetaTick      = theta_degs_rel;
pax1.ThetaTickLabel = string(theta_vals_rel);

for k = 1:9
    Ts = 0 - 2.5*(k-1);
    load(['温度' num2str(Ts) '.mat']);          % 提供 qwh,fch
    load(['INDEX_' num2str(Ts) '.mat']);

    qwh(51:60) = [];  fch(51:60) = [];
    polarplot(pax1, angles, [fch, fch(1)], 'LineWidth',1.5, 'Color',colors(k,:));
end
% title(pax1,'(a)');  % 中文用黑体
set(pax1,'FontName','Times New Roman','FontSize',10);

%% -------------------- (b) 原始数据-绝对值 --------------------
pax2 = polaraxes('Position', pos{5}); hold(pax2,'on');
pax2.RLim = [0 5.1e14];
pax2.ThetaTick      = theta_degs_abs;
pax2.ThetaTickLabel = string(theta_vals_abs);

for k = 1:9
    Ts = 0 - 2.5*(k-1);
    load(['温度' num2str(Ts) '.mat']);
    load(['INDEX_' num2str(Ts) '.mat']);
    load(['QT2PO_' num2str(Ts) '.mat']);        % 提供 QT2PO

    qwh(51:60) = []; fch(51:60) = []; QT2PO(51:60) = [];
    qwh = qwh .* QT2PO;
    fch = fch .* QT2PO .* QT2PO;

    polarplot(pax2, angles*QT2PO(1)/21272160, [fch, fch(1)], ...
        'LineWidth',1.5,'Color',colors(k,:));
end
% title(pax2,'(b)');  % 中文用黑体
set(pax2,'FontName','Times New Roman','FontSize',10);

%% -------------------- (c) 质量并调-相对期望 --------------------
pax3 = polaraxes('Position', pos{2}); hold(pax3,'on');
pax3.ThetaTick      = theta_degs_rel;
pax3.ThetaTickLabel = string(theta_vals_rel);

for k = 1:9
    Ts = 0 - 2.5*(k-1);
    old = pwd;
    cd 'D:\WZH\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\质量并调结果\环境温度0(示例)';
    load(['温度' num2str(Ts) '.mat']);
    load(['INDEX_' num2str(Ts) '.mat']);
    cd(old);

    qwh(51:60) = []; fch(51:60) = [];
    polarplot(pax3, angles, [fch, fch(1)], 'LineWidth',1.5,'Color',colors(k,:));
end
% title(pax3,'(c)');  % 中文用黑体
set(pax3,'FontName','Times New Roman','FontSize',10);

%% -------------------- (d) 质量并调-绝对值 --------------------
pax4 = polaraxes('Position', pos{6}); hold(pax4,'on');
pax4.RLim           = [0 5.1e14];
pax4.ThetaTick      = theta_degs_abs;
pax4.ThetaTickLabel = string(theta_vals_abs);

for k = 1:9
    Ts = 0 - 2.5*(k-1);
    old = pwd;
    cd 'D:\WZH\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\质量并调结果\环境温度0(示例)';
    load(['温度' num2str(Ts) '.mat']);
    load(['INDEX_' num2str(Ts) '.mat']);
    load(['QT2PO_' num2str(Ts) '.mat']);
    cd(old);

    qwh(51:60) = []; fch(51:60) = []; QT2PO(51:60) = [];
    qwh = qwh .* QT2PO;
    fch = fch .* QT2PO .* QT2PO;

    polarplot(pax4, angles*QT2PO(1)/21272160, [fch, fch(1)], ...
        'LineWidth',1.5,'Color',colors(k,:));
end
% title(pax4,'(d)');  % 中文用黑体
set(pax4,'FontName','Times New Roman','FontSize',10);

%% -------------------- (e) 水箱柔性-相对期望 --------------------
pax5 = polaraxes('Position', pos{4}); hold(pax5,'on');
pax5.ThetaTick      = theta_degs_rel;
pax5.ThetaTickLabel = string(theta_vals_rel);

for k = 1:numTankGroups
    M = processedData{k};                 % 60×2 [qw,fc]
    qwh = M(:,1)'; fch = M(:,2)'; qwh(51:60)=[]; fch(51:60)=[];
    polarplot(pax5, angles, [fch, fch(1)], 'LineWidth',1.5,'Color',colors(k,:));
end
% title(pax5,'(e)');  % 中文用黑体
set(pax5,'FontName','Times New Roman','FontSize',10);

%% -------------------- (f) 水箱柔性-绝对值（修：显式 Ts） --------------------
pax6 = polaraxes('Position', pos{8}); hold(pax6,'on');
pax6.RLim           = [0 2.5e15];
pax6.ThetaTick      = theta_degs_abs;
pax6.ThetaTickLabel = string(theta_vals_abs);

qt2po_dir = 'D:\WZH\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\对照结果\结果';
for k = 1:9                           % 与环境温度一一对应：-20:2.5:0
    Ts =0 - 2.5*(k-1);;             % ★ 修复：这里显式计算 Ts
    M = processedData{k};             % 取前 9 组对应温度
    qwh = M(:,1)'; fch = M(:,2)'; qwh(51:60)=[]; fch(51:60)=[];

    S = load(fullfile(qt2po_dir, ['QT2PO_' num2str(Ts) '.mat']));
    QT2PO = S.QT2PO(:)';  QT2PO(51:60) = [];

    qwh = qwh .* QT2PO;
    fch = fch .* QT2PO .* QT2PO;

    polarplot(pax6, angles*QT2PO(1)/21272160, [fch, fch(1)], ...
        'LineWidth',1.5,'Color',colors(k,:));
end
% title(pax6,'(f)');  % 中文用黑体
set(pax6,'FontName','Times New Roman','FontSize',10);

%% -------------------- (g) 摄氏度200柔性-相对期望（来自 9×1 cell） --------------------
% 支持两种情况：变量名就是“摄氏度200柔性供热结果”，或 .mat 里存的是 C
if exist('摄氏度200柔性供热结果','var')==1
    load 摄氏度200柔性供热结果0mat;
     cell9 = C;
elseif exist('C','var')==1
    cell9 = C;
else
    tmp = whos('-file','摄氏度200柔性供热结果.mat');
    S = load('摄氏度200柔性供热结果.mat', tmp(1).name);
    cell9 = S.(tmp(1).name);
end

pax7 = polaraxes('Position', pos{3}); hold(pax7,'on');
pax7.ThetaTick      = theta_degs_rel;
pax7.ThetaTickLabel = string(theta_vals_rel);

for k = 1:9
    M = cell9{10-k};  qwh = M(:,1)'; fch = M(:,2)'; qwh(51:60)=[]; fch(51:60)=[];
    polarplot(pax7, angles, [fch, fch(1)], 'LineWidth',1.5, 'Color',colors(k,:));
end
% title(pax7,'(g)');  % 中文用黑体
set(pax7,'FontName','Times New Roman','FontSize',10);

%% -------------------- (h) 摄氏度200柔性-绝对值（修：显式 Ts） --------------------
pax8 = polaraxes('Position', pos{7}); hold(pax8,'on');
% pax8.RLim  = [0 5.1e14];      % 与 (b) 相同的径向范围  % 可选：与 (b) 的刻度一致
% pax8.ThetaTick      = theta_degs_abs;
pax8.ThetaTickLabel = string(theta_vals_abs);

for k = 1:9
    Ts = 0- 2.5*(k-1);                         % ★ 修复：显式 Ts
    M = cell9{10-k};  qwh = M(:,1)';  fch = M(:,2)'; qwh(51:60)=[]; fch(51:60)=[];

    S = load(fullfile(qt2po_dir, ['QT2PO_' num2str(Ts) '.mat']));
    QT2PO = S.QT2PO(:)';  QT2PO(51:60) = [];

    qwh = qwh .* QT2PO;
    fch = fch .* QT2PO .* QT2PO;

    polarplot(pax8, angles*QT2PO(1)/21272160, [fch, fch(1)], ...
        'LineWidth',1.5,'Color',colors(k,:));
end
% title(pax8,'(h)');  % 中文用黑体
set(pax8,'FontName','Times New Roman','FontSize',10);

%% 为每幅子图左上角贴边编号 (a)~(h) —— 放在轴外侧不遮内容
panel_labels = {'(a)','(b)','(c)','(d)','(g)','(h)','(e)','(f)'};
axs = [pax1, pax2, pax3, pax4, pax5, pax6, pax7, pax8];

% 贴边参数（单位：figure 归一化坐标）
w = 0.035;  % 文本框宽度（可按需要微调 0.03~0.04）
h = 0.030;  % 文本框高度
dx = 0.010; % 向左“贴边”距离（越大越靠外）
dy = 0.004; % 向上“贴边”距离（越大越靠上）

for i = 1:numel(axs)
    axpos = axs(i).Position;      % [x y w h] 归一化

    % 放在轴的左上角“外侧”
    x = max(axpos(1) - dx - w*0.0, 0.001);
    y = min(axpos(2) + axpos(4) - h + dy, 0.995);

    annotation(gcf,'textbox', [x, y, w, h], ...
        'String', panel_labels{i}, ...
        'Interpreter','tex', ...
        'LineStyle','none', ...
        'HorizontalAlignment','left', ...
        'VerticalAlignment','top', ...
        'FontName','Times New Roman', ...
        'FontSize', 10);
end


%% 图例（9 组温度）
lgd = legend(arrayfun(@(t) sprintf('$T_{\\rm A} = %g$', t), 0:-2.5:-20, 'UniformOutput', false), ...
    'Orientation','horizontal','NumColumns',5,'FontSize',9,'Box','off','Interpreter','latex');
lgd.ItemTokenSize = [10 10];
set(lgd,'Position',[0.10, 0.005, 0.80, 0.04]);
