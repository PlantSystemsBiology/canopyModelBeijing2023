
% script 3, draw a canopy 3D model

d1 = importdata('PPFD_WYJ-0724-ca1-rep1-demo1.txt');
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
% 
% ind_le = [ind_leaf; ind_leaf; ind_leaf];
% ind_st = [ind_stem; ind_stem; ind_stem];
% C(1) = 0;
% C(ind_st) = 1.7;
% C(ind_le) = 2.7;
% C(2) = 3;

figure;

%trisurf(T, x,y,z,C,'FaceAlpha', 0.7, 'EdgeColor',[0/255,139/255,0/255],'LineWidth',0.1); % or use 'FaceColor','g'
trisurf(T, x,y,z,C,'FaceAlpha', 0.7, 'EdgeColor', 'none'); % or use 'FaceColor','g'
axis equal
view(-70,15)


xd = [52.5 127.5];
yd = [27.5 137.5];
zd = [0 180];

p1 = [xd(1), yd(1), zd(1)];
p2 = [xd(2), yd(1), zd(1)];
p3 = [xd(2), yd(2), zd(1)];
p4 = [xd(1), yd(2), zd(1)];
p5 = [xd(1), yd(1), zd(2)];
p6 = [xd(2), yd(1), zd(2)];
p7 = [xd(2), yd(2), zd(2)];
p8 = [xd(1), yd(2), zd(2)];

s1 = [p1, p2, p3];
s2 = [p1, p3, p4];
s3 = [p5, p6, p7];
s4 = [p5, p7, p8];

s5 = [p1, p2, p6];
s6 = [p1, p6, p5];
s7 = [p4, p3, p7];
s8 = [p4, p7, p8];

s9 = [p2, p3, p7];
s10 = [p2, p7, p6];
s11 = [p4, p1, p5];
s12 = [p4, p5, p8];

tri2 = [s1;s2;s3;s4;s5;s6;s7;s8;s9;s10;s11;s12];

[row,col] = size(tri2);
row
seq = [1:row]';
T = [seq, seq+row, seq+row*2];
x1 = [tri2(:,1);tri2(:,4);tri2(:,7)];
y1 = [tri2(:,2);tri2(:,5);tri2(:,8)];
z1 = [tri2(:,3);tri2(:,6);tri2(:,9)];



hold on
trisurf(T, x1,y1,z1,'FaceAlpha', 0.1, 'EdgeColor', 'none'); % or use 'FaceColor','g'
axis equal
view(-70,15)


