function ga_main
    % 设置遗传算法的参数
    options = optimoptions('ga', ...
        'PopulationSize', 100, ... % 种群大小
        'MaxGenerations', 100, ... % 最大迭代代数
        'CrossoverFraction', 0.8, ... % 交叉概率
        'Display', 'iter', ... % 显示每一代的结果
        'OutputFcn', @myOutputFcn ... % 自定义输出函数
    );

    % 决策变量的维度，即两个时序变量的长度之和
    nVars = 2 * 24;  % 假设每个时序变量的长度为24

    % 决策变量的上下界（这里假设上下界均为[0.0305, 0.0305*4]）
    lb = 0.0305 * ones(1, nVars);
    ub = 0.0305 * 4 * ones(1, nVars);

    % 调用遗传算法进行优化
    [xOpt, fval] = ga(@Opiti_main, nVars, [], [], [], [], lb, ub, [], options);
    
    % 输出最优解和最优目标函数值
    disp('最优解:');
    disp(xOpt);
    disp('最优目标函数值:');
    disp(fval);

    % 将最优解分成两个时序变量
    n = nVars / 2;
    x1Opt = xOpt(1:n);
    x2Opt = xOpt(n+1:end);

    save('GA_Optimization_Result.mat', 'xOpt', 'fval');

    disp('最优的第一个时序变量:');
    disp(x1Opt);
    disp('最优的第二个时序变量:');
    disp(x2Opt);
end
