% % INDEX=zeros(30,4);
% clear
for i=21:30
qwh = [0.00, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00, 1.10, 1.20, 1.30, 1.40, 1.50, 1.60, 1.70, 1.80, 1.90, 2.00, 2.10, 2.20, 2.30, 2.40, 2.50, 2.60, 2.70, 2.80 2.90];  
  
fch = [0.05, 0.05, 0.05, 2.05, 2.05, 1.85, 2.05, 1.85, 1.95, 1.90, 1.85, 1.80, 1.80, 1.80, 1.70, 1.60,1.35,1.60,1.50, 1.45, 1.35, 1.40, 1.35, 1.30,1.25, 1.20, 1.10, 1.05, 0.95 1.05];

qw=qwh(i);
fc=fch(i);
fileName = ['Result_qw_' num2str(qw, '%.2f') '_fc_' num2str(fc, '%.2f') '.mat'];
load(fileName)

if ~isempty(index1)
     INDEX(i,1)=index1;
else
    INDEX(i,1)=0;
end

if ~isempty(index2)
     INDEX(i,2)=index2;
else
    INDEX(i,2)=0;
end

if ~isempty(index3)
     INDEX(i,3)=index3;
else
    INDEX(i,3)=0;
end

if ~isempty(index4)
     INDEX(i,4)=index4;
else
    INDEX(i,4)=0;
end
end

plot(qwh,fch,'o')

hold on
plot(qwh,INDEX(:,3)/10,'*')