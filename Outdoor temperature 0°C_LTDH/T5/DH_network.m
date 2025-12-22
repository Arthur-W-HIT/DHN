function [PDH_S_Q_HS,PDH_R_Q_HS,SDH_S_Q_HS,SDH_R_Q_HS,PDH_S_T_all,PDH_R_T_all,SDH_S_T_all,SDH_R_T_all,R_T_all,...
    Q_R2SURR,Q_S2R,Q_P2S] = DH_network(E_CB,Q_T2P,PDH_V_w,SDH_V_w,R_T_o,SDH_R_T_in_o,HRDC,T_s,PDH_nx,t_end,dt,SDH_nx,nt)

%一级热网 primary district heat networks
PDH_L=2408;                 %一级热网长度，m
PDH_d=0.3;                 %一级热网内直径，m
PDH_D=0.325;                 %一级热网外直径，m
PDH_A=1/4*pi*PDH_d^2;               %一级热网内截面积，m^2
PDH_alpha_tt=0.6867;         %一级热网总换热系数，W/(m^2K)
%PDH循环水设置
alpha_w =1.43*10^-7;               %水的热扩散系数 m^2/s，共用
%%% PDH_V_w=0.0305*2*ones(86400,1);                 %PDH体积流量（m^3/s），
PDH_u=PDH_V_w/PDH_A;                   %流速（m/s）
rou_w=997;              %水密度，kg/m^3，共用
Cp_w=4200;              %水比热容，j/kgK，共用

%二级热网 Second district heat networks
SDH_L=2408;                 %二级热网长度，m
SDH_d=0.3;                 %二级热网内直径，m
SDH_D=0.325;                 %二级热网外直径，m
SDH_A=1/4*pi*SDH_d^2;               %二级热网内截面积，m^2
SDH_alpha_tt=0.6867;         %一级热网总换热系数，W/(m^2K)
%%%SDH_V_w=0.0305*ones(86400,1);                 %PDH体积流量（m^3/s）
SDH_u=SDH_V_w/SDH_A;                   %流速（m/s）

%换热器 S2R
k_w=0.6;               %水的导热系数，W/(m*k)
miu_w=0.591*10^-3;             %动力粘度系数，P*s

%建筑参数
rou_a=1.225;                %空气密度
Cp_a=1004;              %空气比热
R_V=11782*30*4;                %建筑体积,m^3

%一级热网时空离散步长设置
%%%PDH_nx = 1000;              % 空间离散点数
PDH_dx = PDH_L / (PDH_nx - 1);              % 空间步长
SDH_dx = SDH_L / (SDH_nx -1);              % 空间步长
%%%t_end =86400;                % 模拟结束时间 (s)
%%%dt = 1;             % 时间步长 (s)
%%%nt = t_end / dt;                % 时间步数

%二级热网时空离散步长设置
%%%SDH_nx = 1000;              % 空间离散点数
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

 T_s=T_s*ones(nt,1);               %环境温度设置，此处为时变温度序列
 PDH_S_T = PDH_S_T_CS ;             %初始温度
 PDH_R_T = PDH_R_T_CS;              %初始温度
 SDH_S_T = SDH_S_T_CS;               %初始温度
 SDH_R_T = SDH_R_T_CS;               %初始温度
 R_T =R_T_o;              %建筑初始温度


 %初始换热量设置
Q_R2SURR_o= rou_w*Cp_w*abs(SDH_R_T_in_o-SDH_S_T_in_o)*SDH_V_w(1);                 %建筑散热  
Q_S2R_o=Q_R2SURR_o;              %    0.0306m3/s，供49.06，回41.44
% Q_P2S_o=Q_S2R_o+abs(SDH_R_RHL)+abs(SDH_S_RHL);                %一级热网到二级热网
% Q_T2P_o=Q_P2S_o*4+abs(PDH_R_RHL)+abs(PDH_S_RHL);            %火电向热网供热量，正，j/s             
Q_P2S_o=rou_w*Cp_w*abs(SDH_R_T_out_o-SDH_S_T_out_o)*PDH_V_w(1)/4;                %一级热网到二级热网
Q_T2P_o=rou_w*Cp_w*abs(PDH_R_T_out_o-PDH_S_T_out_o)*PDH_V_w(1); %火电向热网供热量，正，j/s 
%%%Q_T2P=Q_T2P_o*0*ones(nt,1);            %火电向热网供热量，正，j/s     
% 初始化温度分布
% 创建存储温度随时间变化的数据
PDH_S_T_all = zeros(PDH_nx, nt);              %一级热网温度场（x，t）  
PDH_R_T_all = zeros(PDH_nx, nt);              %一级热网温度场（x，t）
SDH_S_T_all = zeros(SDH_nx, nt);              %一级热网温度场（x，t）
SDH_R_T_all = zeros(SDH_nx, nt);              %二级热网温度场（x，t）
R_T_all = zeros(1, nt);              %建筑温度场（t）

%换热器 P2S的UA计算
C_min_P2S(1)=min(PDH_V_w(1)*rou_w*Cp_w,SDH_V_w(1)*rou_w*Cp_w);                  %确定初始时刻参数      
syms E_P2S_cal              %声明变量
Q_P2SS(E_P2S_cal)=E_P2S_cal*C_min_P2S(1)*(PDH_S_T(PDH_nx)-SDH_R_T(SDH_nx));               %  Q(E)表达式
y=finverse(Q_P2SS);              %获得反函数Q(E)
y_E=matlabFunction( y );                        %反函数
E_P2S(1)=y_E(Q_P2S_o);                  %获得初始时刻 E,

Cr_P2S(1)=min(PDH_V_w(1)*Cp_w,SDH_V_w(1)*Cp_w)/max(PDH_V_w(1)*Cp_w,SDH_V_w(1)*Cp_w);                %初始时刻热容率

if  Cr_P2S(1)==1               %判断热容率是否为1
    syms NTU_call
    E_P2SS(NTU_call)=NTU_call/(NTU_call+1);        %热容率为1时的E(NTU)
    yy=finverse(E_P2SS);                 %获得NTU（E）
    y_NTU=matlabFunction( yy );             %反函数
    NTU_P2S(1)=y_NTU(E_P2S(1));             %获得初始时刻NTU
 else
    E_P2SS=E_CB(:,ceil(Cr_P2S(1)*1000));                %
    MIN=min(abs(E_P2SS-E_P2S(1)));
    y_NTU=find(abs(E_P2SS-E_P2S(1))==MIN);
    NTU_P2S(1)=y_NTU/1000*2;           %获得初始时刻NTU
 end
 UA_P2S=NTU_P2S(1)*C_min_P2S(1);                %计算所得UA

PDH_S_delta_3=zeros(nt,PDH_nx);
PDH_R_delta_3=zeros(nt,PDH_nx);
SDH_S_delta_3=zeros(nt,SDH_nx);
SDH_R_delta_3=zeros(nt,SDH_nx);

%时间步进
for i=1:nt
    PDH_S_T_new =PDH_S_T;              %PDHS的新数组
    PDH_R_T_new =PDH_R_T;              %PDHR的新数组
    SDH_S_T_new =SDH_S_T;              %SDHS的新数组
    SDH_R_T_new =SDH_R_T;              %SDHR的新数组
    R_T_new =R_T; 
   
    %首站换热器
    PDH_S_T_new(1)=Q_T2P(i)/(PDH_V_w(i)*Cp_w*rou_w)+PDH_R_T(PDH_nx);              %热源加热PDH回水
    %PDHS计算
    for a=2:PDH_nx-1                
        PDH_S_delta_1=PDH_u(i)*(PDH_S_T(a-1)-PDH_S_T(a))*dt/PDH_dx;              %轴向流动
        PDH_S_delta_2=alpha_w*dt/PDH_dx^2*(PDH_S_T(a-1)-2*PDH_S_T(a)+PDH_S_T(a+1));               %轴向热扩散
        PDH_S_delta_3(i,a)=PDH_alpha_tt*PDH_D*pi*PDH_dx* dt*(T_s(i)-PDH_S_T(a-1))/(rou_w*PDH_u(i)*PDH_A*dt*Cp_w);             %热耗散
        PDH_S_T_new(a)=PDH_S_T(a)+PDH_S_delta_1+PDH_S_delta_2+PDH_S_delta_3(i,a);              %PDHS内部更新
    end
    PDH_S_T_new(PDH_nx)=PDH_S_T_new(PDH_nx-1);              %PDHS边界处温度

    %换热器   P2S换热量计算
    C_min_P2S(i)=min(PDH_V_w(i)*rou_w*Cp_w,SDH_V_w(i)*rou_w*Cp_w);               % 最小换热量
    NTU_P2S(i)=UA_P2S/C_min_P2S(i);              %NTU,UA_P2S待确定
    Cr_P2S(i)=min(PDH_V_w(i)*Cp_w,SDH_V_w(i)*Cp_w)/max(PDH_V_w(i)*Cp_w,SDH_V_w(i)*Cp_w);               %热容率
    if  Cr_P2S(i)==1
        E_P2S(i)=NTU_P2S(i)/(NTU_P2S(i)+1);
    else
        E_P2S(i)=(1-exp(-NTU_P2S(i)*(1-Cr_P2S(i))))/(1-Cr_P2S(i)*exp(-NTU_P2S(i)*(1-Cr_P2S(i))));             %有效系数
    end
    Q_P2S(i)=E_P2S(i)*C_min_P2S(i)*(PDH_S_T(PDH_nx)-SDH_R_T(SDH_nx));             %一级热网与二级热网换热量

   %PDHR计算
    PDH_R_T_new(1)=-4*Q_P2S(i)/(PDH_V_w(i)*Cp_w*rou_w)+PDH_S_T(PDH_nx);              %PDHS放热变为PDHR，Q为正
    for b=2:PDH_nx-1
         PDH_R_delta_1=PDH_u(i)*(PDH_R_T(b-1)-PDH_R_T(b))*dt/PDH_dx;              %轴向流动
         PDH_R_delta_2=alpha_w*dt/PDH_dx^2*(PDH_R_T(b-1)-2*PDH_R_T(b)+PDH_R_T(b+1));               %轴向热扩散
         PDH_R_delta_3(i,b)=PDH_alpha_tt*PDH_D*pi*PDH_dx* dt*(T_s(i)-PDH_R_T(b-1))/(rou_w*PDH_u(i)*PDH_A*dt*Cp_w);             %热耗散
        PDH_R_T_new(b)=PDH_R_T(b)+PDH_R_delta_1+PDH_R_delta_2+PDH_R_delta_3(i,b);              %PDHR内部更新
    end
    PDH_R_T_new(PDH_nx)=PDH_R_T_new(PDH_nx-1);              %PDHR边界处温度

    %SDHS计算
    SDH_S_T_new(1)=Q_P2S(i)/(SDH_V_w(i)*Cp_w*rou_w)+SDH_R_T(SDH_nx);              %SDHR吸热变为SDHS，Q为正
     for c=2:SDH_nx-1
        SDH_S_delta_1=SDH_u(i)*(SDH_S_T(c-1)-SDH_S_T(c))*dt/SDH_dx;              %轴向流动
        SDH_S_delta_2=alpha_w*dt/SDH_dx^2*(SDH_S_T(c-1)-2*SDH_S_T(c)+SDH_S_T(c+1));               %轴向热扩散
        SDH_S_delta_3(i,c)=SDH_alpha_tt*SDH_D*pi*SDH_dx* dt*(T_s(i)-SDH_S_T(c-1))/(rou_w*SDH_u(i)*SDH_A*dt*Cp_w);             %热耗散
        SDH_S_T_new(c)=SDH_S_T(c)+ SDH_S_delta_1+ SDH_S_delta_2+ SDH_S_delta_3(i,c);              %SDHS内部更新
     end
     SDH_S_T_new(SDH_nx)=SDH_S_T_new(SDH_nx-1);              %SDHS边界处温度
    
     %换热器   S2R计算
     Re(i)=rou_w*SDH_u(i)*SDH_d/miu_w;              %Reynolds , miu_w 待确定
     Pr(i)=Cp_w*miu_w/k_w;                 %Prant数,k_w待确定
     f(i)=(0.790*log(Re(i))-1.64)^(-2);                %摩擦系数
%      Nu_S2R(i)=((f(i)/8)*(Re(i)-1000)*Pr(i))/(1+12.7(f(i)/8*(Pr(i)^(2/3)-1)^0.5));                    %Nusselt数
     Nu_S2R(i)=(f(i)/8*(Re(i)-1000)*Pr(i))/(1+12.7*(f(i)/8)^0.5*(Pr(i)^(2/3)-1));                    %Nusselt数
     h_S2R(i)=k_w*SDH_d*Nu_S2R(i);                %对流换热系数 
     Q_S2R(i)=h_S2R(i)/h_S2R(1)*(SDH_S_T(SDH_nx)-R_T)/(SDH_S_T_CS(SDH_nx)-R_T_o)*Q_S2R_o;             %二级热网与用户换热量,  h_S2R_o,Q_S2R_o待确定

     %SDHR计算
     SDH_R_T_new(1)=-Q_S2R(i)/(SDH_V_w(i)*Cp_w*rou_w)+SDH_S_T(SDH_nx);              %SDHS放热变为SDHR，Q为正
     for d=2:SDH_nx-1     
         SDH_R_delta_1=SDH_u(i)*(SDH_R_T(d-1)-SDH_R_T(d))*dt/SDH_dx;              %轴向流动
         SDH_R_delta_2=alpha_w*dt/SDH_dx^2*(SDH_R_T(d-1)-2*SDH_R_T(d)+SDH_R_T(d+1));               %轴向热扩散
         SDH_R_delta_3(i,d)=SDH_alpha_tt*SDH_D*pi*SDH_dx* dt*(T_s(i)-SDH_R_T(d-1))/(rou_w*SDH_u(i)*SDH_A*dt*Cp_w);             %热耗散
        SDH_R_T_new(d)=SDH_R_T(d)+SDH_R_delta_1+SDH_R_delta_2+SDH_R_delta_3(i,d);              %SDHR内部更新
     end
     SDH_R_T_new(SDH_nx)=SDH_R_T_new(SDH_nx-1);              %SDHS边界处温度
     
     %换热器 R2SURR计算
     Q_R2SURR(i)=Q_R2SURR_o*(R_T-T_s(i))/(R_T_o-T_s(1));
     
     %R_T计算
     R_T_new=(Q_S2R(i)-Q_R2SURR(i))/(rou_a*R_V*Cp_a)+R_T;
     
    %保存
    PDH_S_T_all (:,i)= PDH_S_T;              %一级热网温度场（x，t）  
    PDH_R_T_all(:,i) = PDH_R_T;              %一级热网温度场（x，t）
    SDH_S_T_all(:,i) = SDH_S_T;              %一级热网温度场（x，t）
    SDH_R_T_all(:,i) = SDH_R_T;              %二级热网温度场（x，t）
    R_T_all(1,i) =R_T;              %建筑温度场（t）
   
    %更新
    PDH_S_T=PDH_S_T_new ;              %PDHS的新数组
    PDH_R_T= PDH_R_T_new ;              %PDHR的新数组
    SDH_S_T =SDH_S_T_new ;              %SDHS的新数组
    SDH_R_T =SDH_R_T_new ;              %SDHR的新数组
    R_T=R_T_new ; 
end
  PDH_S_Q_HS=sum( PDH_S_delta_3,2).*(rou_w*PDH_u*PDH_A*dt*Cp_w);
  PDH_R_Q_HS=sum( PDH_R_delta_3,2).*(rou_w*PDH_u*PDH_A*dt*Cp_w);
  SDH_S_Q_HS=sum( SDH_S_delta_3,2).*(rou_w*SDH_u*SDH_A*dt*Cp_w);
  SDH_R_Q_HS=sum( SDH_R_delta_3,2).*(rou_w*SDH_u*SDH_A*dt*Cp_w);
end

