
clear
for k=1:9
Ts=-20+2.5*(k-1);


folderPath = ['F:\王中昊\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\对照结果\结果\'];  
filename=['温度'  num2str(Ts) '.mat'];
fullPath = fullfile(folderPath,filename);  
 load(fullPath);

 fcx_dz(k)=find(fch,1,'first');
 fcd_dz(k)=find(fch,1,'last');

folderPath = ['F:\王中昊\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\质量并调结果\环境温度0(示例)'];  
filename=['温度'  num2str(Ts) '.mat'];
fullPath = fullfile(folderPath,filename);  
 load(fullPath);

 fcx_yh(k)=find(fch,1,'first');
 fcd_yh(k)=find(fch,1,'last');
 
 folderPath = ['F:\王中昊\博士\课题\集中供热管网储能潜力评估\素材\柔性供热\对照结果\结果\'];  
 filename=['QT2PO_'  num2str(Ts) '.mat'];
fullPath = fullfile(folderPath,filename);  
 load(fullPath);

%  fcx_dz_Q(k)=(fcx_dz(k)-1)*0.1*QT2PO(1)/10^6;
%  fcd_dz_Q(k)=(fcd_dz(k)-1)*0.1*QT2PO(1)/10^6;
%  fcx_yh_Q(k)=(fcx_yh(k)-1)*0.1*QT2PO(1)/10^6;
%  fcd_yh_Q(k)=(fcd_yh(k)-1)*0.1*QT2PO(1)/10^6;


 fcx_dz_Q(k)=(fcx_dz(k)-1-10)*0.1*QT2PO(1)/10^6*24;
 fcd_dz_Q(k)=(fcd_dz(k)-11)*0.1*QT2PO(1)/10^6*24;
 fcx_yh_Q(k)=(fcx_yh(k)-11)*0.1*QT2PO(1)/10^6*24;
 fcd_yh_Q(k)=(fcd_yh(k)-1)*0.1*QT2PO(1)/10^6;

end

eta=(fcd_yh_Q-fcx_yh_Q)./(fcd_dz_Q-fcx_dz_Q);

