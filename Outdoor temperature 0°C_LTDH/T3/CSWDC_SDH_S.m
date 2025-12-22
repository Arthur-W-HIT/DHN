function [SDH_S_T_CS,SDH_S_RHL]=CSWDC_SDH_S(T_s,SDH_S_T_in_o,SDH_L,SDH_V_w,SDH_u,SDH_d,SDH_D,SDH_A,SDH_alpha_tt,alpha_w,rou_w,Cp_w,SDH_nx,nt,SDH_dx,dt)
T = T_s(1)* ones(SDH_nx, 1); % 初始温度场
SDH_S_T_in =SDH_S_T_in_o*ones(1,nt);           % 入口温度 (摄氏度)
% 创建存储温度随时间变化的数据
T_all = zeros(SDH_nx, nt);
delta_t3=zeros(nt,SDH_nx);
RHL=zeros(nt,1);
% 主循环：时间步进
for n = 1:nt
    % 创建一个新的温度数组以存储更新后的温度
    T_new = T;
    T_new(1) = SDH_S_T_in(n);
    % 内部点的温度更新（使用显式有限差分法）
    for i = 2:SDH_nx-1
        delta_t1=dt/SDH_dx*SDH_u(1)*(T(i-1)-T(i));         %流动
        delta_t2=alpha_w * dt / SDH_dx^2 * (T(i+1) - 2*T(i) + T(i-1)); %轴向热扩散
        delta_t3(n,i)=-SDH_alpha_tt*SDH_dx* dt*(T_s-T(i-1))./(rou_w*SDH_u(1)*SDH_A*dt*Cp_w); %热耗散
        T_new(i) = T(i) +delta_t1+delta_t2+delta_t3(n,i) ;
    end
    
    % 边界条件（假设两端为绝热边界条件，即温度梯度为零）
    T_new(SDH_nx) = T_new(SDH_nx-1);
    T_new(1) = SDH_S_T_in(n);
    % 更新温度分布
    T = T_new;
    
    % 保存当前时间步的温度分布
    T_all(:, n) = T;
end

SDH_S_T_CS=flip(T_all(:, nt));
RHL=sum(delta_t3,2).*(rou_w.*SDH_u(1).*SDH_A*dt*Cp_w);
SDH_S_RHL=RHL(nt,1);

end