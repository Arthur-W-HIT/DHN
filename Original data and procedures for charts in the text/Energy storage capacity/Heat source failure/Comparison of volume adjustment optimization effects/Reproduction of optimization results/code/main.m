clear
for wxh=1:11
    for nxh=1:1
%%
%参数设置
t_end=24*3600;              %仿真时长
dt=1;               %仿真步长
nt=t_end/dt;                %时间离散步数
PDH_nx=500;                %一级热网空间离散步数
SDH_nx=500;                %二级热网空间离散步数

% PDH_V_w=0.0305*(4/nxh)*ones(nt,1);                %一级热网水体积流量，m^3/s）
% SDH_V_w=0.0305*ones(nt,1);                  %二级热网水体积流量，m^3/s）
% x=[   0.0426    0.1214    0.1205    0.1219    0.1220    0.1219    0.1181    0.1192    0.1163    0.1205    0.1203 0.1156    0.1205    0.1052    0.0629    0.0477    0.0955    0.1197    0.1114    0.0622    0.0829    0.0846...
%  0.0403    0.0980    0.0471    0.1130    0.1216    0.1220    0.1218    0.1199    0.1217    0.1175    0.1191 0.1180    0.1218    0.1205    0.1219    0.1076    0.1045    0.0341    0.0968    0.0680    0.0442    0.0571 0.1120    0.0927    0.0696    0.1101];
WXH=2.5*(wxh-1)-20;
T_s=WXH;              %环境温度
fileName = ['GA_Optimization_Result' num2str(WXH+100)] ;
load(fileName);
x=xOpt;
n=24;
P_V=x(1:n);
S_V=x(n+1:length(x));
P_V(1)= 0.0305*4;              
S_V(1)= 0.0305;
PDH_V_w= repmat(P_V,  nt/length(P_V),1); 
PDH_V_w= PDH_V_w(:);%一级热网水体积流量，m^3/s）
% SDH_V_w=repmat(S_V, 1, nt/length(S_V))';         %二级热网水体积流量，m^3/s）
SDH_V_w= repmat(S_V,  nt/length(S_V),1); 
SDH_V_w= SDH_V_w(:);




SDH_R_T_in_o=41.44;             %二级热网回水温度，靠近用户侧
HRDC=5;                 %换热器P2S处，一级热网回水与二级热网回水温度差
% T_s=0+(wxh-1)*2.5;              %环境温度
load E_CB.mat       %加载NTU查表函数
R_T_o=25;               %初始建筑温度
%%
%初始温度场计算
[PDH_S_T_CS,PDH_R_T_CS,SDH_S_T_CS,SDH_R_T_CS,Q_R2SURR_o,Q_S2R_o,Q_P2S_o,Q_T2P_o] = Initial_cal...
    (PDH_V_w,SDH_V_w,R_T_o,SDH_R_T_in_o,HRDC,T_s,PDH_nx,t_end,dt,SDH_nx);
%%
%参数补充
Q_T2P=0*Q_T2P_o*ones(nt,1);               %s热源热流量，Q_T2P_o为初始平衡热流量
%%
%热网仿真
 [PDH_S_Q_HS,PDH_R_Q_HS,SDH_S_Q_HS,SDH_R_Q_HS,PDH_S_T_all,PDH_R_T_all,SDH_S_T_all,SDH_R_T_all,R_T_all,...
    Q_R2SURR,Q_S2R,Q_P2S] = DH_network(E_CB,Q_T2P,PDH_V_w,SDH_V_w,R_T_o,SDH_R_T_in_o,HRDC,T_s,PDH_nx,t_end,dt,SDH_nx,nt);

% eval(['save ' 'T_s加100为' num2str(T_s+100)  '_V_PH比SH为' num2str(4/nxh)  '.mat'])
index = find(R_T_all < 16, 1)/3600;

fileNameE = ['Result' num2str((WXH+100)*10)];
save(fileNameE);
wxh
nxh
    end
end
