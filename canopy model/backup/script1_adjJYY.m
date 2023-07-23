global S_adj_ratio;

for r = 1:5  % set replicate number
    stage = 1;
    S_adj_ratio = 1.8991;
Os_main('M_plantStructureFile\M_JY5B-0724-ca1.xlsx', strcat('CM_JY5B-0724-ca1-S-rep',num2str(r),'.txt'), stage);
    S_adj_ratio = 1.0850;
Os_main('M_plantStructureFile\M_JP69-0724-CA2.xlsx', strcat('CM_JP69-0724-CA2-S-rep',num2str(r),'.txt'), stage);
% Os_main('M_plantStructureFile\M_JYY69-0724-F1.xlsx', strcat('CM_JYY69-0724-F1-rep',num2str(r),'.txt'), stage); %
    stage = 3;
    S_adj_ratio = 2.3373;
Os_main('M_plantStructureFile\M_JY5B-0828-ca1.xlsx', strcat('CM_JY5B-0828-ca1-S-rep',num2str(r),'.txt'), stage); % 
    S_adj_ratio = 1.5529;
Os_main('M_plantStructureFile\M_JP69-0828-CA2.xlsx', strcat('CM_JP69-0828-CA2-S-rep',num2str(r),'.txt'), stage); % 
% Os_main('M_plantStructureFile\M_JYY69-0828-F1.xlsx', strcat('CM_JYY69-0828-F1-rep',num2str(r),'.txt'), stage);
end

