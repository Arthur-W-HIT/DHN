function [PDH_S_T_CS,PDH_S_RHL]=CSWDC_PDH_S(T_s,PDH_S_T_in_o,PDH_L,PDH_V_w,PDH_u,PDH_d,PDH_D,PDH_A,PDH_alpha_tt,alpha_w,rou_w,Cp_w,PDH_nx,nt,PDH_dx,dt)
T = T_s(1)* ones(PDH_nx, 1); % 初始温度场
PDH_S_T_in =PDH_S_T_in_o*ones(1,nt);           % 入口温度 (摄氏度)
% 创建存储温度随时间变化的数据
T_all = zeros(PDH_nx, nt);
delta_t3=zeros(nt,PDH_nx);
RHL=zeros(nt,1);
% 主循环：时间步进
for n = 1:nt
    % 创建一个新的温度数组以存储更新后的温度
    T_new = T;
    T_new(1) = PDH_S_T_in(n);
    % 内部点的温度更新（使用显式有限差分法）
    for i = 2:PDH_nx-1
        delta_t1=dt/PDH_dx*PDH_u(1)*(T(i-1)-T(i));         %流动
        delta_t2=alpha_w * dt / PDH_dx^2 * (T(i+1) - 2*T(i) + T(i-1)); %轴向热扩散
        delta_t3(n,i)=-PDH_alpha_tt*PDH_dx* dt*(T_s-T(i-1))./(rou_w*PDH_u(1)*PDH_A*dt*Cp_w); %热耗散
        T_new(i) = T(i) +delta_t1+delta_t2+delta_t3(n,i) ;
    end
    
    % 边界条件（假设两端为绝热边界条件，即温度梯度为零）
    T_new(PDH_nx) = T_new(PDH_nx-1);
    T_new(1) = PDH_S_T_in(n);
    % 更新温度分布
    T = T_new;
    
    % 保存当前时间步的温度分布
    T_all(:, n) = T;
end

PDH_S_T_CS=flip(T_all(:, nt));
RHL=sum(delta_t3,2).*(rou_w.*PDH_u(1).*PDH_A.*dt*Cp_w);
PDH_S_RHL=RHL(nt,1);

end