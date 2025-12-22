function [state, options, optchanged] = myOutputFcn(options, state, flag)
    persistent hPlot; % 保持绘图句柄
    optchanged = false;

    switch flag
        case 'init'
            disp('开始优化');
            figure; % 创建一个新图形窗口
            hPlot = plot(nan, nan, 'o-');
            xlabel('Generation');
            ylabel('Best Score');
            title('GA Optimization Progress');
            grid on;
            hold on;
        case 'iter'
            bestScore = min(state.Score); % 获取当前最优适应度值
            disp(['第 ', num2str(state.Generation), ' 代: 最优适应度值 = ', num2str(bestScore)]);
            % 更新绘图
            set(hPlot, 'XData', [get(hPlot, 'XData'), state.Generation]);
            set(hPlot, 'YData', [get(hPlot, 'YData'), bestScore]);
            drawnow;
        case 'done'
            disp('优化完成');
            hold off; % 关闭保持绘图窗口
    end
end
