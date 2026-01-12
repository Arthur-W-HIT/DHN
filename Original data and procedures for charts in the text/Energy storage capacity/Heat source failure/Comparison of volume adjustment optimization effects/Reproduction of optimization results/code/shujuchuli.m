%%
%数据处理
clear
wxhs=11;
nxhs=10;
R_T_all_data = cell(wxhs, nxhs);
PDH_R_Q_HS_data = cell(wxhs, nxhs);
PDH_S_Q_HS_data= cell(wxhs, nxhs);
SDH_R_Q_HS_data = cell(wxhs, nxhs);
SDH_S_Q_HS_data= cell(wxhs, nxhs);
Q_P2S_data= cell(wxhs, nxhs);
Q_R2SURR_data= cell(wxhs, nxhs);
Q_S2R_data= cell(wxhs, nxhs);
Q_T2P_data= cell(wxhs, nxhs);

% Use a parallel for loop to load the data
parfor wxh = 1:wxhs
    for nxh=1:nxhs
    T_ss = -20+(wxh-1)*2.5;
    dataFile = ['T_s加100为' num2str(T_ss+100)  '_V_PH比SH为' num2str(4/nxh)  '.mat'];
    loadedData = load(dataFile);
        % Store the loaded data in the preallocated cell array
    R_T_all_data{wxh,nxh} = loadedData.R_T_all;
    PDH_R_Q_HS_data{wxh,nxh} = loadedData.PDH_R_Q_HS;
    PDH_S_Q_HS_data{wxh,nxh} = loadedData.PDH_S_Q_HS;
    SDH_R_Q_HS_{wxh,nxh} = loadedData.SDH_R_Q_HS;
    SDH_S_Q_HS_data{wxh,nxh} = loadedData.SDH_S_Q_HS;
    Q_P2S_data{wxh,nxh} = loadedData.Q_P2S;
    Q_R2SURR_data{wxh,nxh} = loadedData.Q_R2SURR;
    Q_S2R_{wxh,nxh} = loadedData.Q_S2R;
    Q_T2P_data{wxh,nxh} = loadedData.Q_T2P;
    end
end


%%
% 画图
for wxh = 1:wxhs
    plot(1:length(R_T_all_data{wxh,3}), R_T_all_data{wxh,3})
    hold on % Keep the current plot so that the next plots are added to it
end
legend('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')

% Add labels and a title to the plot for clarity
xlabel('Index')
ylabel('R_T_all')
title('R_T_all vs Index for Different Temperatures')
