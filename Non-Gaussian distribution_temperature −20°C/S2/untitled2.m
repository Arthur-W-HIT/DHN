fc=0.1;
qw=0.5;
Q_T2P_o=21.27;
nt=24*3600;
Q_T2P1=normrnd(qw,fc,nt,1).*Q_T2P_o.*ones(nt,1);  
obj1=find(Q_T2P1<0);
Q_T2P1(obj1)=0;



nu = 5;                         % 自由度(>2 才有有限方差)，越小越重尾
z  = trnd(nu, nt, 1);           % 重尾
z  = z / sqrt(nu/(nu-2));       % 归一化为单位方差（理论方差）
f  = qw + fc * z;   
Q_T2P2 = f .* Q_T2P_o .* ones(nt,1);             %s热源热流量，Q_T2P_o为初始平衡热流量
obj2=find(Q_T2P2<0);
Q_T2P2(obj2)=0;

m0 = 0; s0 = 1;                 % 先随便给一个形状参数（只决定偏态强弱）
z  = lognrnd(m0, s0, nt, 1);    % 右偏
z  = (z - mean(z)) / std(z);    % 样本标准化为 0 均值、1 方差
f  = qw + fc * z;        
Q_T2P3 = f .* Q_T2P_o .* ones(nt,1);             %s热源热流量，Q_T2P_o为初始平衡热流量
obj3=find(Q_T2P3<0);
Q_T2P3(obj3)=0;

a = qw - sqrt(3)*fc;
b = qw + sqrt(3)*fc;
Q_T2P4 = unifrnd(a, b, nt, 1) .* Q_T2P_o .* ones(nt,1);             %s热源热流量，Q_T2P_o为初始平衡热流量
obj4=find(Q_T2P4<0);
Q_T2P4(obj4)=0;