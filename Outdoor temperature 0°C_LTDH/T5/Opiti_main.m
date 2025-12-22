function y= Opiti_main(x)
%参数设置
t_end=24*3600;              %仿真时长
dt=1;               %仿真步长
nt=t_end/dt;                %时间离散步数
PDH_nx=500;                %一级热网空间离散步数
SDH_nx=500;                %二级热网空间离散步数
n = length(x) / 2;
P_V=x(1:n);
S_V=x(n+1:length(x));
P_V(1)= 0.0305*4;              
S_V(1)= 0.0305;
PDH_V_w= repmat(P_V,  nt/length(P_V),1); 
PDH_V_w= PDH_V_w(:);%一级热网水体积流量，m^3/s）
% SDH_V_w=repmat(S_V, 1, nt/length(S_V))';         %二级热网水体积流量，m^3/s）
SDH_V_w= repmat(S_V,  nt/length(S_V),1); 
SDH_V_w= SDH_V_w(:);

% PDH_V_w=0.0305*4/nxh*ones(nt,1);                %一级热网水体积流量，m^3/s）
% SDH_V_w=0.0305*ones(nt,1);                  %二级热网水体积流量，m^3/s）
SDH_R_T_in_o=37.44;             %二级热网回水温度，靠近用户侧
HRDC=5;                 %换热器P2S处，一级热网回水与二级热网回水温度差
T_s=0;              %环境温度
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

yy = -find(R_T_all < 16, 1);

if isempty(yy)
    y = -24;
else
    y = yy/ 3600;
end

disp(y);  % 显示y

% eval(['save ' 'T_s加100为' num2str(T_s+100)  '_V_PH比SH为' num2str(4/nxh)  '.mat'])
end
