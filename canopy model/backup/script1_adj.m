
for r = 1:5  % set replicate number
%     stage = 0;
% Os_main('M_plantStructureFile\M_WYJ-0711-ca1.xlsx', strcat('CM_WYJ-0711-ca1-rep',num2str(r),'.txt'), stage);
% Os_main('M_plantStructureFile\M_WYJ-0711-CA2.xlsx', strcat('CM_WYJ-0711-CA2-rep',num2str(r),'.txt'), stage);
% Os_main('M_plantStructureFile\M_WYJ-0711-F1.xlsx', strcat('CM_WYJ-0711-F1-rep',num2str(r),'.txt'), stage);
%     stage = 1;
% Os_main('M_plantStructureFile\M_WYJ-0724-ca1.xlsx', strcat('CM_WYJ-0724-ca1-S-rep',num2str(r),'.txt'), stage);
% Os_main('M_plantStructureFile\M_WYJ-0724-CA2.xlsx', strcat('CM_WYJ-0724-CA2-S-rep',num2str(r),'.txt'), stage);
% Os_main('M_plantStructureFile\M_WYJ-0724-F1.xlsx', strcat('CM_WYJ-0724-F1-rep',num2str(r),'.txt'), stage);
%      stage = 3;
% Os_main('M_plantStructureFile\M_WYJ-0828-ca1.xlsx', strcat('CM_WYJ-0828-ca1-S-rep',num2str(r),'.txt'), stage);
%  Os_main('M_plantStructureFile\M_WYJ-0828-CA2.xlsx', strcat('CM_WYJ-0828-CA2-S-rep',num2str(r),'.txt'), stage); 
% Os_main('M_plantStructureFile\M_WYJ-0828-F1.xlsx', strcat('CM_WYJ-0828-F1-rep',num2str(r),'.txt'), stage);
end

global S_adj_ratio;


for r = 1:5  % set replicate number
    stage = 1;
    S_adj_ratio = 1.7935;
Os_main('M_plantStructureFile\M_313-0724-ca1.xlsx', strcat('CM_313-0724-ca1-S-rep',num2str(r),'.txt'), stage);
S_adj_ratio = 1.6252;
Os_main('M_plantStructureFile\M_314-0724-CA2.xlsx', strcat('CM_314-0724-CA2-S-rep',num2str(r),'.txt'), stage);
% Os_main('M_plantStructureFile\M_313314-0724-F1.xlsx', strcat('CM_313314-0724-F1-rep',num2str(r),'.txt'), stage);
    stage = 3;
    S_adj_ratio = 1.3284;
Os_main('M_plantStructureFile\M_313-0828-ca1.xlsx', strcat('CM_313-0828-ca1-S-rep',num2str(r),'.txt'), stage); % 
S_adj_ratio = 1.3814;
Os_main('M_plantStructureFile\M_314-0828-CA2.xlsx', strcat('CM_314-0828-CA2-S-rep',num2str(r),'.txt'), stage); % 
% Os_main('M_plantStructureFile\M_313314-0828-F1.xlsx', strcat('CM_313314-0828-F1-rep',num2str(r),'.txt'), stage);
end

