%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Os_tiller is used for building a 3D rice tiller model, as a module for build
% a rice plant.
% Codeded by Qingfeng
% 2020-03-03, Shanghai
% 2020-03-18, modified.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [M_data, radi0] = Os_tiller(paramMatrix)

global OS_DATA_MATRIX_COLUMN_NUM;
global S_adj_ratio;
beta = 0; % leaf orientation angle, initial value.

M_data = zeros(0,OS_DATA_MATRIX_COLUMN_NUM);

tillerID = paramMatrix(1,2); % ��2����tillerID

leafOrSpikeID_v = paramMatrix(:,3); % ID����0�� flag leaf 1�� second leaf 2. etc
leafBH_v = paramMatrix(:,4);        % Ҷ�����߶�
leafL_v = paramMatrix(:,5) * sqrt(S_adj_ratio);         % ҶƬ����
leafmaximalW_v = paramMatrix(:,6) * sqrt(S_adj_ratio);  % ҶƬ�����
leafCA_v = paramMatrix(:,7);        % ҶƬ�����ĵĻ���ӦԲ�Ľ�
leafA_v = paramMatrix(:,8)*5;         % ҶƬ�Ƕȣ�Ҷ�����뾥��֮��ĽǶ�

leafNum = max(leafOrSpikeID_v);

for n = 1: leafNum
    %n
    leafBH = leafBH_v(n);
    leafL = leafL_v(n);
    leafmaximalW = leafmaximalW_v(n);
    leafA = leafA_v(n);
    leafCA = leafCA_v(n);
    leafID = n;
    % call Os_leaf function.
    M_data_leaf = Os_leaf(leafID, leafBH, leafL, leafmaximalW, leafA, leafCA);
    
    [X, Y, Z] = convertColumn9to3 (M_data_leaf(:,6:14)); % ��9�еľ���ת��Ϊ3�е�
    [theta,r,h] = cart2pol(X,Y,Z);                % Z ����Ϊ��, -ת��Ϊ������ϵ,
    theta = theta + beta;                         % Ҷ�����ž�����ת��beta�ȵ�ĳһ����
    beta = beta + pi + randn*(pi*15/180);       % beta����pi��Ϊ��һҶƬ�ķ���
    [X,Y,Z] = pol2cart(theta,r,h); %ת���صѿ�������ϵ
    
    M_data_leaf(:,6:14) = convertColumn3to9 ([X,Y,Z]); % ��3�еľ���ת��Ϊ9�е�
    M_data = [M_data;M_data_leaf];
end
stemL = 0; %��ʼ��

if leafBH_v(1)>leafBH_v(end)
    if sum(leafOrSpikeID_v==0)==1     % �����1������
        stemL = leafBH_v(leafOrSpikeID_v == 0);
    elseif sum(leafOrSpikeID_v==0)==0 % ���û������
        stemL = leafBH_v(leafOrSpikeID_v == 1);
    elseif sum(leafOrSpikeID_v==1)==0 % ���û����Ҷ
        stemL = leafBH_v(leafOrSpikeID_v == 2);
    else  % ���������ѡ�����Ҷ�����߶�Ϊ���ѳ���
        stemL = leafBH_v(leafOrSpikeID_v == 3);
    end
else
    stemL = leafBH_v(end);
end
[M_stem, radi0] = Os_stem (stemL); % ����Os_stem������һ��stem
M_data = [M_data;M_stem]; % ��stem�Ľṹ���뵽����������
M_data(:,2) = tillerID; % 2,�������

end


