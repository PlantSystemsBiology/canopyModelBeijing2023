%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Os_leaf is used for building a 3D rice leaf model, as a module for build
% a rice tiller.
% Codeded by Qingfeng
% 2020-02-26, Shanghai
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% leafL is the leaf length.
% leafW.relativePosition and leafW.width are two vectors showing the leaf
% width at different relative positions along the leaf from 0 (at leaf base)
% to 1 (at leaf tip). vector length is not limited, recommand 4-7.
% leafA is the leaf angle,
% leafCA is leaf curvature angle. range: 0~pi

function M_data = Os_leaf(leafID, leafBH, leafL, maximalLeafWidth, leafA, leafCA)

global OS_LEAF_SEGMENT_LENGTH;
global OS_DATA_MATRIX_COLUMN_NUM;

% generate leafW.relativePosition and leafW.width from maximalLeafWidth and
% leafID
leafW = Os_leafWidth(maximalLeafWidth,leafID);

beta = 0; %��ʼֵ.ҶƬ����ǣ�ֲ����ת����ǵ�, ��������Ŷ����֡�

k = 1; %����Ҷ��ģ��ʱ���������id����Ҷ��ģ�����ݵ��б꣬ÿ��һ��������

% ----------------------------�ֶ�����Hermite��ֵ---------------------
% ������ò�ֵ�����ҶƬ����������ֵ������Ϊ����ҶƬ�ڡ�������1/4,1/2,3/4,... �ⲿ����ʵ�ʿ�ȵ�һ�롣��Ϊ
% ��ҶƬ��Ҷ��Ϊ���ᡣ
x = leafW.relativePosition .* leafL;  % ʵ��Ҷ�����λ������, ��ֵ��Ϻ�����
y = leafW.width./2;                   % ʵ��Ҷ�����2����Ҷ���ؾ�����Ҷ���ľ��룬��ֵ���������
t = 0:OS_LEAF_SEGMENT_LENGTH:leafL;  %��ֵ�������

if (leafL - t(end) > OS_LEAF_SEGMENT_LENGTH/10)  % ��������ֵ��t�����һ��ֵ����ҶƬ���������1/10��ҶƬ�ֶγ��ȣ�����Ҷ����һ�㡣
    t = [t,leafL];
end

p = pchip(x,y,t);   %��ֵ���㣬pΪ��ֵ�������� ��tΪ�����꣩

if(p(end)<0)  % ����Ҷ����һ�����Ͻ�����ֺ�С�ĸ�ֵ������Ϊ�㡣
    p(end) = 0;
end
% ��ֵ������tΪҶƬ���ȷ�������꣬pΪҶƬ��ȷ�������ꡣ��t,p)��ʾҶƬ��������
% ---------------------------/�ֶ�����Hermite��ֵ----------------%

metaAngle = leafCA/(length(t)-1);   %ÿ��ҶƬ��Ӧ��ҶƬ������Բ�Ľ�, ����ҶƬ���ǰһ��ҶƬ��ת�ǡ�

baseX = 0;
baseZ = 0;

DataOfLeaf = zeros(1,9);                 %���ڴ洢һƬҶ�ӵ�ģ��
positionOnLeaf = zeros(1,1);
for m = 1:length(t)-1   %ÿһ��Ҷ�ӣ���Ϊ ��ֵ�����-1 ��
    
    x1 = baseX;             %����Ҷ���������x
    z1 = baseZ;             %����Ҷ���������z
    nextX = baseX+(t(m+1)-t(m))*sin(metaAngle*(m-1));     %��һ��Ҷ���������x
    nextZ = baseZ+(t(m+1)-t(m))*cos(metaAngle*(m-1));     %��һ��Ҷ���������z
    
    x2 = nextX;             %��һ��Ҷ���������x ��Ϊ ����Ҷ���յ�����x
    z2 = nextZ;             %��һ��Ҷ���������z ��Ϊ ����Ҷ���յ�����z
    
    ylist = 0: OS_LEAF_SEGMENT_LENGTH :p(m);                   %ҶƬ��ķ���Ϊy�����᷽�򣬰�ƬҶ��y����ֵΪ0������Ҷ������Ӧ��ָ��������p(m)�����metaS
    
    if p(m) - ylist(end) > 0.1        %�������metaS�ȼ��ָ�y����ʣ����ͷ����0.1 cm
        ylist = [ylist,p(m)];         %�򲹼�һ����ֵ
    end
    
    ylist_2 = 0: OS_LEAF_SEGMENT_LENGTH :p(m+1);               %���ڱ���Ҷ���յ�λ��Ҷ����ķָ�뱾��ҶƬ���Ҷ��ָ���ͬ
    
    if p(m+1) - ylist_2(end) > 0.1
        ylist_2 = [ylist_2,p(m+1)];
    end
    
    %------------------------------��һ��Ҷ�ӹ���������-----------------
    length1 = length(ylist);
    length2 = length(ylist_2);
    
    for i = 1:min(length1,length2)-1          % ����Ҷ����ʼ������������
        DataOfLeaf(k,:) = [x1, ylist(i),  z1,   x2, ylist_2(i),z2,   x1, ylist(i+1),z1];
        positionOnLeaf(k,1) = OS_LEAF_SEGMENT_LENGTH *(m-1) + OS_LEAF_SEGMENT_LENGTH * 1/3;
        %     positionOnLeaf(k,1)
        k = k+1;
        DataOfLeaf(k,:) = [x1, ylist(i+1),z1,   x2, ylist_2(i),z2,   x2, ylist_2(i+1),z2];
        positionOnLeaf(k,1) = OS_LEAF_SEGMENT_LENGTH *(m-1) + OS_LEAF_SEGMENT_LENGTH * 2/3;
        k = k+1;
    end
    
    if(length1 > length2)                       % ����ʣ��������β���
        for i=length2:length1-1
            DataOfLeaf(k,:) = [x1, ylist(i),  z1,   x2, ylist_2(length2),z2,   x1, ylist(i+1),z1];
            positionOnLeaf(k,1) = OS_LEAF_SEGMENT_LENGTH*(m-1) + OS_LEAF_SEGMENT_LENGTH * 1/3;
            k = k+1;
        end
        
    elseif(length1 < length2)                   % ����ʣ��������β���
        for i=length1:length2-1
            DataOfLeaf(k,:) = [x1, ylist(length1),  z1,   x2, ylist_2(i),z2,   x2, ylist_2(i+1),z2];
            positionOnLeaf(k,1) = OS_LEAF_SEGMENT_LENGTH*(m-1) + OS_LEAF_SEGMENT_LENGTH * 2/3;
            k = k+1;
        end
    end
    
    %-----------------------------/��һ��Ҷ�ӹ���������-----------------
    
    baseX = nextX;           %�ѱ������λ�ø���Ϊ�����յ�λ��(��һ��ѭ��������һ��ҶƬ��
    baseZ = nextZ;
end   %/ÿһ��Ҷ�ӣ���Ϊ ��ֵ�����-1 ��

M = DataOfLeaf;

%-----------------��������ҶƬ------------------
M2 = M;
M2(:,2) = -M2(:,2);                         %y����Գ�Ϊ����
M2(:,5) = -M2(:,5);
M2(:,8) = -M2(:,8);
M = [M;M2];                                 %����Ҷ������Ϊһ��ƬҶ�ӣ���Ҷ�����غ�
positionOnLeaf = [positionOnLeaf;positionOnLeaf];
[row2,col2]=size(M);

[X, Y, Z] = convertColumn9to3 (M); % �任���ݽṹΪ3��


leafpetiollength = 5; % 2021-11-2, QF
Z = Z + leafpetiollength;
[M_petiol,radi0] = Os_stem (leafpetiollength);
% M_petiol = M_petiol * 0.2;
% radi0 = radi0 * 0.2;

[Xpetiol, Ypetiol, Zpetiol] = convertColumn9to3 (M_petiol(:,6:14)); % �任���ݽṹΪ3��


%---------------ת��Ϊ������ϵ, Y ����Ϊ��----------------------
[theta,r,h] = cart2pol(X,Z,Y);              % Y ����Ϊ��
theta = theta - leafA;                    %ҶƬ��ת Ҷ�� �Ƕ�
[theta2,r2,h2] = cart2pol(Xpetiol,Zpetiol,Ypetiol);              % Y ����Ϊ��(Ҷ����
theta2 = theta2 - leafA;                    %ҶƬ��ת Ҷ�� �Ƕ� (Ҷ����

%---------------ת���صѿ�������ϵ---------------------------
[X,Z,Y] = pol2cart(theta,r,h);
[Xpetiol,Zpetiol,Ypetiol] = pol2cart(theta2,r2,h2);

Z = Z + leafBH;                          %ҶƬ�߶�λ�õ���
Zpetiol = Zpetiol + leafBH;                          %Ҷ���߶�λ�õ���

M_data = zeros(row2,OS_DATA_MATRIX_COLUMN_NUM);
% M_data column 1-3 for IDs, column 5 is for supplementary ID.
M_data(:,3) = leafID; % 0���ӣ�1��Ҷ��2���Ժ��ǵ���������Ҷ�ӣ�-1�Ǿ���
M_data(:,4) = positionOnLeaf./leafL;  % relative position along leaf, from 0 to 1. 

%---------------���ݽṹת����9��---------------------------
M_data(:,6:14) = convertColumn3to9 ([X,Y,Z]);
M_data(:,15:17) = 0;

M_petiol(:,6:14) = convertColumn3to9 ([Xpetiol,Ypetiol,Zpetiol]);

M_data = [M_data; M_petiol];

%% draw the leaf
%Draw3DModel(M_data,5);

%%
end


