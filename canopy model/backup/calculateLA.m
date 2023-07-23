
% AQpara= fittingAQs();
% % OUTPUT the AQ fitting results to FILE
% dlmwrite('AQ_fit_param_all.txt',AQpara,'delimiter','\t','precision', '%.2f');

% run from HERE
groundAreaCM2 = 3600; % 60cm * 60cm

global Date;
global Genotype;
global CULTIVAR;
Date = ["0724", "0828"]; % MMDD
Genotype = ["ca1","CA2","F1"]; % 
CULTIVAR1 = ["WYJ","WYJ","WYJ"]; % two cultivars
CULTIVAR2 = ["313","314","313314"]; % two cultivars
CULTIVAR3 = ["JY5B","JP69","JYY69"]; % two cultivars

CULTIVAR = CULTIVAR1;  %%% set the cultivar sets

addpath('..')
diurnalData_all = zeros(0,18); % cultivar, stage, rep, 6hour to 18hour, wholeday  :: totally 14 columns
diurnalData_all_MeanStd = zeros(0,18);
for s=1:2 % stage or DAS
    for c=1:3 % cultivar
        diurnalData_5reps = zeros(0,18);
        for rep = 1:5 % replication
            
            PPF_file = strcat('.\PPF\PPF_',CULTIVAR{c},'-',Date{s}, '-',Genotype{c},'-rep', num2str(rep),'.txt');
            PPF_file
            PPF_file2 = strcat('PPF_',CULTIVAR{c},'-',Date{s}, '-',Genotype{c},'-rep', num2str(rep),'.txt');
            diurnalData = canopyPS(PPF_file, PPF_file2, groundAreaCM2, s, c);  % if 3-c, means exchange cultivar AQ curves
            temp(:, 4:17) = diurnalData; % data body: 6hour to 18hourAc, wholedayAc
            
            temp(:,1) = c; %index, cultivar
            temp(:,2) = s; % index, stage
            temp(:,3) = rep; % index, replicate
            diurnalData_5reps = [diurnalData_5reps; temp]; % put into output matrix
        end
        diurnalData_all = [diurnalData_all; diurnalData_5reps]; % put into output matrix
        
        AcMean = mean(diurnalData_5reps);
        AcStd = std(diurnalData_5reps);
        diurnalData_all_MeanStd = [diurnalData_all_MeanStd; AcMean; AcStd]; 
        
    end
end

filenameOutput = strcat('Ac5reps_analysis_',CULTIVAR{3},'.xlsx');
varNames = {'Cultivar','Stage','Replicate','Ac_6h_to_18h','Ac_wholeday'};
cult =diurnalData_all(:,1);
sta = diurnalData_all(:,2);
rep = diurnalData_all(:,3);
Ac6to18 = diurnalData_all(:,4:16);
Acall = diurnalData_all(:,17);
diurnalData_all_table = table(cult,sta,rep,Ac6to18,Acall,'VariableNames',varNames);
writetable(diurnalData_all_table,filenameOutput,'Sheet',1);

cult =diurnalData_all_MeanStd(:,1);
sta = diurnalData_all_MeanStd(:,2);
rep = diurnalData_all_MeanStd(:,3);
Ac6to18 = diurnalData_all_MeanStd(:,4:16);
Acall = diurnalData_all_MeanStd(:,17);
diurnalData_all_MeanStd_table = table(cult,sta,rep,Ac6to18,Acall,'VariableNames',varNames);
writetable(diurnalData_all_MeanStd_table,filenameOutput,'Sheet',2); % sheet 2


% % % T_preserve = readtable('Ac_analysis2.xlsx');


%%
% 第3列是器官编号，1.2.3 etc是叶片从bottom 到 top 顺序。0是茎。1 是最下的1片叶子。
% 第18列是三角形面元面积 单位 cm2
% 第19列至第31列是 叶片吸收的PPFD 单位umol光子/平方米叶面积/秒
% 第32列至第44列是 叶片光合A 单位umol CO2/平方米叶面积/秒

% s: stage, 1.2.3.4.5, c: cultivar, 1.2
function [LA,CanopyAbsPPFD] = canopyLA(FastTracerOutPutfilename,FastTracerOutPutfilename2, groundAreaCM2, s, c)

data1 = importdata(FastTracerOutPutfilename); % 导入数据，数据中包括了第一行的名称
d = data1.data;             % 去掉名称，只保留数值部分。
[row, col] = size(d);
timePointNum = (col - 18)/7;
o = zeros(row, col+timePointNum);
o(:,1:col) = d;    % 输出矩阵的前18列是

leaf_ind = d(:,3)>=1;  % the 3rd column is leaves
stem_ind = d(:,3)==0;  % the 3rd column is stem, not calculate A

o_leaf = o(leaf_ind,:);
o_stem = o(stem_ind,:);

totalPPF_ind = 18+7 : 7 : 18+7*timePointNum;

AQpara= importdata('AQ_fit_param_313.txt');

AQpara_target_avg = mean(AQpara(AQpara(:,1) == c & AQpara(:,2) == s & AQpara(:,3) == c, :));
AQpara_target_avg
Pmax = AQpara_target_avg(4);
phi = AQpara_target_avg(5);
theta = AQpara_target_avg(6);
Rd = AQpara_target_avg(7);

leafArea = o_leaf(:,18); % leaf area, no stem
LA = sum(leafArea);

x = o_leaf(:,totalPPF_ind);
sum(sum(x))
A = (phi.*x+Pmax-sqrt((phi.*x+Pmax).^2-4*theta.*phi.*x.*Pmax))./(2*theta)-Rd;

o_leaf(:,col+1:end) = A;

o_stem(:,col+1:end) = 0; % assume stem photosynthesis+respiration is zero. 

o = [o_leaf; o_stem];

% output to FILE
canopy3dmodelPPFDAFilename = strcat('A-',FastTracerOutPutfilename2);
o2 = o(:,[1:18,totalPPF_ind,col+1:end]);
%dlmwrite(canopy3dmodelPPFDAFilename,o2,'delimiter','\t','precision', '%.2f');

S_facet = o(:,18);
PPFD = o(:,totalPPF_ind);
A = o(:,col+1:end);

% 计算总吸收光强度
CanopyAbsPPFD = S_facet' * PPFD;

% 计算总光合
CanopyA = S_facet' * A./groundAreaCM2;

CanopyAall = sum(CanopyA.*3600)/1e6;
CanopyA = [CanopyA, CanopyAall];

diurnaldatafile = strcat('Ac-',FastTracerOutPutfilename2);
diurnalData = CanopyA;

% dlmwrite(diurnaldatafile,diurnalData,'delimiter','\t','precision', '%.4f');

% figure;
% plot(hour1,CanopyAbsPPFD);
% xlabel('Time (hour)');
% ylabel('Canopy Absorbed PPFD (\mumol^-^2s^-^1)');
% set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
% set(get(gca,'XLabel'),'FontSize',14,'Vertical','top');
% set(get(gca,'YLabel'),'FontSize',14,'Vertical','bottom');
% 
% set(get(gca,'XAxis'),'FontSize',12);
% set(get(gca,'YAxis'),'FontSize',12);
% 
% figure;
% plot(hour(1:end-1),CanopyA(1:end-1));
% xlabel('Time (hour)');
% ylabel('Canopy Photosynthesis A_c (\mumol m^-^2s^-^1)');
% set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
% set(get(gca,'XLabel'),'FontSize',14,'Vertical','top');
% set(get(gca,'YLabel'),'FontSize',14,'Vertical','bottom');
% 
% set(get(gca,'XAxis'),'FontSize',12);
% set(get(gca,'YAxis'),'FontSize',12);

end





