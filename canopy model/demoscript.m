
%demo script
global S_adj_ratio; % leaf area adjustment index, see L20-21 Os_tiller.m
S_adj_ratio = 1;

stage = 1; % set stage (1 for Jul-11, 2 for Jul-24, 3 for Aug-28)
r = 1; % set replicate number

Os_main('M_0711-9311-ca1.xlsx', strcat('CM_M_0711-9311-ca1',num2str(r),'.txt'), stage);

% run fastTracer with powershell

data1 = importdata('PPFD_WYJ-0828-ca1-rep1.txt'); % 导入数据，数据中包括了第一行的名称
d = data1.data;             % 去掉名称，只保留数值部分。
[row, col] = size(d);
timePointNum = (col - 18)/7;
o = zeros(row, col+timePointNum);
o(:,1:col) = d;    % 输出矩阵的前18列是

leaf_ind = d(:,3)>=1;  % the 3rd column is leaves
stem_ind = d(:,3)==0;  % the 3rd column is stem, not calculate A

o_leaf = o(leaf_ind,:);
o_stem = o(stem_ind,:);

PPF_inds = 18+7 : 7 : 18+7*timePointNum; 

x = o_leaf(:,PPF_inds);

Pmax = 25.2209;
phi = 0.0514;
theta = 0.7536;
Rd = 1.2100;

A = (phi.*x+Pmax-sqrt((phi.*x+Pmax).^2-4*theta.*phi.*x.*Pmax))./(2*theta)-Rd;
o_leaf(:,col+1:end) = A;
o_stem(:,col+1:end) = 0; % assume stem photosynthesis+respiration is zero. 
o = [o_leaf; o_stem];

A = o(:,col+1:end);
S_facet = o(:,18);
groundAreaCM2 = 60*60;
CanopyA = S_facet' * A./groundAreaCM2;
CanopyAall = sum(CanopyA.*3600)/1e6;
CanopyA = [CanopyA, CanopyAall];
dlmwrite('diurnalAc.txt',CanopyA,'delimiter','\t','precision', '%.4f');

% draw the model

d1 = importdata('PPFD_WYJ-0828-ca1-rep1.txt');
d1 = d1.data;

% for single plant
%idx_onePlant = d1(:,1) == 1;
%d1 = d1(idx_onePlant,:);

tri = d1(:,6:14); % 
leafNum = d1(:,3);  % 0: stem, 1,2,3... number from bottom to top. 
leafPosition = d1(:,5);  % 1: lower layer, 2: uppper layer, 0: stem. 

ind_leaf = leafNum>=1;
ind_stem = leafNum==0;

[row,col] = size(tri);
row
seq = [1:row]';
T = [seq, seq+row, seq+row*2];
x = [tri(:,1);tri(:,4);tri(:,7)];
y = [tri(:,2);tri(:,5);tri(:,8)];
z = [tri(:,3);tri(:,6);tri(:,9)];
C = z;
C = [d1(:,18+7*7);d1(:,18+7*7);d1(:,18+7*7)];
C(C>2000) = 2000;
C = log10(C);

figure;

%trisurf(T, x,y,z,C,'FaceAlpha', 0.7, 'EdgeColor',[0/255,139/255,0/255],'LineWidth',0.1); % or use 'FaceColor','g'
trisurf(T, x,y,z,C,'FaceAlpha', 0.7, 'EdgeColor', 'none'); % or use 'FaceColor','g'
axis equal
view(-70,15)


