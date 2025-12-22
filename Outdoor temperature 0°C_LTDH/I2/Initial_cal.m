function [PDH_S_T_CS,PDH_R_T_CS,SDH_S_T_CS,SDH_R_T_CS,Q_R2SURR_o,Q_S2R_o,Q_P2S_o,Q_T2P_o] = Initial_cal(PDH_V_w,SDH_V_w,R_T_o,SDH_R_T_in_o,HRDC,T_s,PDH_nx,t_end,dt,SDH_nx)

%一级热网 primary district heat networks
apv=PDH_V_w(1);
bsv=SDH_V_w(1);
PDH_L=2408;                 %一级热网长度，m
PDH_d=0.3;                 %一级热网内直径，m
PDH_D=0.325;                 %一级热网外直径，m
PDH_A=1/4*pi*PDH_d^2;               %一级热网内截面积，m^2
PDH_alpha_tt=0.5364;         %一级热网总换热系数，W/(m^2K)
%PDH循环水设置
alpha_w =1.43*10^-7;               %水的热扩散系数 m^2/s，共用
%%% PDH_V_w=0.0305*2*ones(86400,1);                 %PDH体积流量（m^3/s），
PDH_u=apv/PDH_A;                   %流速（m/s）
rou_w=997;              %水密度，kg/m^3，共用
Cp_w=4200;              %水比热容，j/kgK，共用

%二级热网 Second district heat networks
SDH_L=2408;                 %二级热网长度，m
SDH_d=0.3;                 %二级热网内直径，m
SDH_D=0.325;                 %二级热网外直径，m
SDH_A=1/4*pi*SDH_d^2;               %二级热网内截面积，m^2
SDH_alpha_tt=0.6867;         %一级热网总换热系数，W/(m^2K)
%%%SDH_V_w=0.0305*ones(86400,1);                 %PDH体积流量（m^3/s）
SDH_u=bsv/SDH_A;                   %流速（m/s）

%一级热网时空离散步长设置
%%%PDH_nx = 1000;              % 空间离散点数
PDH_dx = PDH_L / (PDH_nx - 1);              % 空间步长
%%%t_end =86400;                % 模拟结束时间 (s)
%%%dt = 1;             % 时间步长 (s)
nt = t_end / dt;                % 时间步数

%二级热网时空离散步长设置
%%%SDH_nx = 1000;              % 空间离散点数
SDH_dx = SDH_L / (SDH_nx - 1);              % 空间步长

%%初始温度设置
%%% R_T_o=25;              %建筑初始温度
% T_s=0;               %环境初始温度,此处为初始时刻温度值
DELTA_T=(4579+1879*4+1229)*(R_T_o-T_s)*4/(rou_w*SDH_V_w(1)*Cp_w);
%%%SDH_R_T_in_o=41.44;             %二级回水起点
SDH_S_T_in_o=SDH_R_T_in_o+DELTA_T;             %二级供水终点
[SDH_R_T_CS,~]=CSWDC_SDH_R(T_s,SDH_R_T_in_o,SDH_L,SDH_V_w,SDH_u,SDH_d,SDH_D,SDH_A,SDH_alpha_tt,alpha_w,rou_w,Cp_w,SDH_nx,nt,SDH_dx,dt);
[SDH_S_T_CS,~]=CSWDC_SDH_S(T_s,SDH_S_T_in_o,SDH_L,SDH_V_w,SDH_u,SDH_d,SDH_D,SDH_A,SDH_alpha_tt,alpha_w,rou_w,Cp_w,SDH_nx,nt,SDH_dx,dt);

SDH_R_T_out_o=SDH_R_T_CS(SDH_nx);             %二级回水终点
SDH_S_T_out_o=SDH_S_T_CS(1);             %二级供水起点

%%%HRDC=5;                 %换热端差
PDH_R_T_in_o=SDH_S_T_CS(1)+HRDC;             %一级回水起点
PDH_S_T_in_o=PDH_R_T_in_o+(SDH_S_T_CS(1)-SDH_R_T_CS(SDH_nx))*4*SDH_V_w(1)/PDH_V_w(1);           %一级供水终点

[PDH_R_T_CS,~]=CSWDC_PDH_R(T_s,PDH_R_T_in_o,PDH_L,PDH_V_w,PDH_u,PDH_d,PDH_D,PDH_A,PDH_alpha_tt,alpha_w,rou_w,Cp_w,PDH_nx,nt,PDH_dx,dt);
[PDH_S_T_CS,~]=CSWDC_PDH_S(T_s,PDH_S_T_in_o,PDH_L,PDH_V_w,PDH_u,PDH_d,PDH_D,PDH_A,PDH_alpha_tt,alpha_w,rou_w,Cp_w,PDH_nx,nt,PDH_dx,dt);

PDH_R_T_out_o=PDH_R_T_CS(PDH_nx);             %一级回水终点
PDH_S_T_out_o=PDH_S_T_CS(1);           %一级供水起点

%  T_s=T_s*ones(nt,1);               %环境温度设置，此处为时变温度序列
%  PDH_S_T = PDH_S_T_CS ;             %初始温度
%  PDH_R_T = PDH_R_T_CS;              %初始温度
%  SDH_S_T = SDH_S_T_CS;               %初始温度
%  SDH_R_T = SDH_R_T_CS;               %初始温度
%  R_T =R_T_o;              %建筑初始温度


 %初始换热量设置
Q_R2SURR_o= rou_w*Cp_w*abs(SDH_R_T_in_o-SDH_S_T_in_o)*SDH_V_w(1);                 %建筑散热  
Q_S2R_o=Q_R2SURR_o;              %    0.0306m3/s，供49.06，回41.44
% Q_P2S_o=Q_S2R_o+abs(SDH_R_RHL)+abs(SDH_S_RHL);                %一级热网到二级热网
% Q_T2P_o=Q_P2S_o*4+abs(PDH_R_RHL)+abs(PDH_S_RHL);            %火电向热网供热量，正，j/s             
Q_P2S_o=rou_w*Cp_w*abs(SDH_R_T_out_o-SDH_S_T_out_o)*PDH_V_w(1)/4;                %一级热网到二级热网
Q_T2P_o=rou_w*Cp_w*abs(PDH_R_T_out_o-PDH_S_T_out_o)*PDH_V_w(1); %火电向热网供热量，正，j/s 
end

