
% 313 314 NIL
getLeafCurvature('313-0724-ca1.xlsx');
getLeafCurvature('314-0724-CA2.xlsx');
getLeafCurvature('313314-0724-F1.xlsx');

getLeafCurvature('313-0828-ca1.xlsx');
getLeafCurvature('314-0828-CA2.xlsx');
getLeafCurvature('313314-0828-F1.xlsx');

% WYJ NIL
getLeafCurvature('WYJ-0711-ca1.xlsx');
getLeafCurvature('WYJ-0711-CA2.xlsx');
getLeafCurvature('WYJ-0711-F1.xlsx');

getLeafCurvature('WYJ-0724-ca1.xlsx');
getLeafCurvature('WYJ-0724-CA2.xlsx');
getLeafCurvature('WYJ-0724-F1.xlsx');

getLeafCurvature('WYJ-0828-ca1.xlsx');
getLeafCurvature('WYJ-0828-CA2.xlsx');
getLeafCurvature('WYJ-0828-F1.xlsx');


% JYY69
getLeafCurvature('JP69-0724-CA2.xlsx');
getLeafCurvature('JY5B-0724-ca1.xlsx');
getLeafCurvature('JYY69-0724-F1.xlsx');

getLeafCurvature('JP69-0828-CA2.xlsx');
getLeafCurvature('JY5B-0828-ca1.xlsx');
getLeafCurvature('JYY69-0828-F1.xlsx');

% build 3D model for WYJ

for r = 1:5  % set replicate number
%     stage = 0;
% Os_main('M_plantStructureFile\M_WYJ-0711-ca1.xlsx', strcat('CM_WYJ-0711-ca1-rep',num2str(r),'.txt'), stage);
% Os_main('M_plantStructureFile\M_WYJ-0711-CA2.xlsx', strcat('CM_WYJ-0711-CA2-rep',num2str(r),'.txt'), stage);
% Os_main('M_plantStructureFile\M_WYJ-0711-F1.xlsx', strcat('CM_WYJ-0711-F1-rep',num2str(r),'.txt'), stage);
    stage = 1;
Os_main('M_plantStructureFile\M_WYJ-0724-ca1.xlsx', strcat('CM_WYJ-0724-ca1-rep',num2str(r),'.txt'), stage);
Os_main('M_plantStructureFile\M_WYJ-0724-CA2.xlsx', strcat('CM_WYJ-0724-CA2-rep',num2str(r),'.txt'), stage);
Os_main('M_plantStructureFile\M_WYJ-0724-F1.xlsx', strcat('CM_WYJ-0724-F1-rep',num2str(r),'.txt'), stage);
    stage = 3;
Os_main('M_plantStructureFile\M_WYJ-0828-ca1.xlsx', strcat('CM_WYJ-0828-ca1-rep',num2str(r),'.txt'), stage);
Os_main('M_plantStructureFile\M_WYJ-0828-CA2.xlsx', strcat('CM_WYJ-0828-CA2-rep',num2str(r),'.txt'), stage); 
Os_main('M_plantStructureFile\M_WYJ-0828-F1.xlsx', strcat('CM_WYJ-0828-F1-rep',num2str(r),'.txt'), stage);
end
% build 3D model for 313

for r = 1:5  % set replicate number
    stage = 1;
Os_main('M_plantStructureFile\M_313-0724-ca1.xlsx', strcat('CM_313-0724-ca1-rep',num2str(r),'.txt'), stage);
Os_main('M_plantStructureFile\M_314-0724-CA2.xlsx', strcat('CM_314-0724-CA2-rep',num2str(r),'.txt'), stage);
Os_main('M_plantStructureFile\M_313314-0724-F1.xlsx', strcat('CM_313314-0724-F1-rep',num2str(r),'.txt'), stage);
    stage = 3;
Os_main('M_plantStructureFile\M_313-0828-ca1.xlsx', strcat('CM_313-0828-ca1-rep',num2str(r),'.txt'), stage); % 
Os_main('M_plantStructureFile\M_314-0828-CA2.xlsx', strcat('CM_314-0828-CA2-rep',num2str(r),'.txt'), stage); % 
Os_main('M_plantStructureFile\M_313314-0828-F1.xlsx', strcat('CM_313314-0828-F1-rep',num2str(r),'.txt'), stage);
end
% build 3D model for JP
for r = 1:5  % set replicate number
    stage = 1;
Os_main('M_plantStructureFile\M_JP69-0724-CA2.xlsx', strcat('CM_JP69-0724-CA2-rep',num2str(r),'.txt'), stage);
Os_main('M_plantStructureFile\M_JY5B-0724-ca1.xlsx', strcat('CM_JY5B-0724-ca1-rep',num2str(r),'.txt'), stage);
Os_main('M_plantStructureFile\M_JYY69-0724-F1.xlsx', strcat('CM_JYY69-0724-F1-rep',num2str(r),'.txt'), stage); %
    stage = 3;
Os_main('M_plantStructureFile\M_JP69-0828-CA2.xlsx', strcat('CM_JP69-0828-CA2-rep',num2str(r),'.txt'), stage); % 
Os_main('M_plantStructureFile\M_JY5B-0828-ca1.xlsx', strcat('CM_JY5B-0828-ca1-rep',num2str(r),'.txt'), stage); % 
Os_main('M_plantStructureFile\M_JYY69-0828-F1.xlsx', strcat('CM_JYY69-0828-F1-rep',num2str(r),'.txt'), stage);
end

% build virtual canopies

% need to wait for the analysis of plant architecture traits


