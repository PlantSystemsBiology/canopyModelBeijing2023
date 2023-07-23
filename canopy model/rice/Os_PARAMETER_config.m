%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSTANT_config is used for setting the CONSTANT as global variables for
% building the model
% Codeded by Qingfeng
% 2020-03-03, Shanghai
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Os_PARAMETER_config(stage)

% ģ�;��������
global OS_DATA_MATRIX_COLUMN_NUM;
OS_DATA_MATRIX_COLUMN_NUM = 17;

% ҶƬ��Ԫ�ߴ���� used in function M_data = Os_leaf(leafID, leafBH, leafL, maximalLeafWidth, leafA, leafCA)
global OS_LEAF_SEGMENT_LENGTH; 
OS_LEAF_SEGMENT_LENGTH = 2; %�����γߴ磬cm��ֱ��������ֱ�Ǳ߳��ȣ����������������û��ɵ���

% ��Ҷ��״���� used in function leafWidth = Os_leafWidth(maximalLeafWidth,leafID)
global IDX_LEAF_POSITION;
global IDX_FLAG_LEAF_WIDTH; 
global IDX_OTHER_LEAF_WIDTH;
IDX_LEAF_POSITION    = [0, 1/4, 1/2, 3/4, 1];
IDX_FLAG_LEAF_WIDTH  = [0.209 1     0.965 0.651 0]; % ����.��ʾҶƬ�Ļ�����1/4,1/2,3/4,�ⲿ���Ŀ��/2. ��flag ��Ҷ��������ͬ�������г���
IDX_OTHER_LEAF_WIDTH = [0.214 0.738 1     0.881 0]; % leaf shape parameters from Watanabe, T. et al. Annals of botany 95, 1131�C43 (2005).  ��������ʾҶƬ�Ļ�����1/4,1/2,3/4,�ⲿ������Կ��. ������ҶƬ����״һ����

% ������� used in function Os_plant (plantID, paramMatrix)
global DIRECTION_ORIENTATION;
global TILLER_ANGLE;
DIRECTION_ORIENTATION = [pi/6, 7*pi/6, -pi/3, 2*pi/3, pi, 4*pi/3, pi/3, 0, -pi/6, pi/2, 5*pi/6, -pi/2, -5*pi/6, pi/6, -2*pi/3, pi/3, pi, 0, 2*pi/3, -pi/3];  % tiller angle and orientation angle, defined and used in Song et al, 2013
TILLER_ANGLE_0 = [0.00, 0.1309, 0.1309, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618];
TILLER_ANGLE_1 = [0.00, 0.1309, 0.1309, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618];
TILLER_ANGLE_2 = [0.06, 0.06, 0.1309, 0.1309, 0.1309, 0.1309, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618];
TILLER_ANGLE_3 = [0.06, 0.06, 0.1309, 0.1309, 0.1309, 0.1309, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618, 0.2618];

if stage == 0
    TILLER_ANGLE = TILLER_ANGLE_0;
elseif stage == 1
    TILLER_ANGLE = TILLER_ANGLE_1;
elseif stage == 2
    TILLER_ANGLE = TILLER_ANGLE_2;
elseif stage == 3
    TILLER_ANGLE = TILLER_ANGLE_3;
else
    TILLER_ANGLE = TILLER_ANGLE_3; % other later stage used the 3 stage
end
% ������������Ҳ�ǳ�������ʾ�����ķ���ǣ��������ĵļнǡ���ˮ���кܶ��������ķ������У�С�ķ���Χ�ڴ������Χ�������ǰ����һ�δӴ�С������

global MAXIMAL_PLANT_NUM;
MAXIMAL_PLANT_NUM = 9; 
% ������������ж�����Ĳ�����������

% ҶƬ�������
global LNC;  %leaf nitrogen content.������ҶƬ����������λ��g/m2����Χ��0.1-5.0�� �û����������
LNC = [1.5826, 1.4742, 1.2574, 1.1599, 0.9702, 0.8564, 0.8564, 0.8564];
global LEAF_SPAD LEAF_SPAD_MEASURE_POINT;  
LEAF_SPAD_MEASURE_POINT = [1/6 1/2 5/6];% relative value from base to tip (0-1)   % Ҷ���صĲ���λ�ã���ҶƬ�ӻ������ⲿ��λ�ã�0��ʾ������1��ʾ�ⲿ��������3������λ�á��������̶�ֵ��
LEAF_SPAD = [  %WT in booting stage
    41.18 40.85 39.77; % Flag Leaf
    42.55 43.67 41.68; % L2
    46.10 46.05 43.70; % L3
    48.60 47.13 45.85; % L4
    48.60 47.13 45.85; % L5
    48.60 47.13 45.85; % L6
    48.60 47.13 45.85; % L7
    48.60 47.13 45.85];% L8

global Chl_CONC; 
Chl_CONC = 317; % unit: umol.m-2 leaf area

% �ڲ�level�Ĳ�����used in function M_canopy = Os_canopy(paramMatrix)
global STEP_X STEP_Y ROW_NUM COL_NUM;
STEP_X = 20; % row distance of canopy, in the x direction  �о��룬��λcm�����������������û��ɵ��ڡ�
STEP_Y = 25; % column distance, y direction  �о��룬��λcm�����������������û��ɵ��ڡ�
ROW_NUM = 3; % row number of canopy ����������������ˮ�������������������û��ɵ��ڡ�
COL_NUM = 6; % col number ���������������������û��ɵ��ڡ�
%������ˮ���Ĺڲ�(canopy)Ϊnum_row�У�num_col�е�һ�鷽��ء�����ÿһ��ˮ�������������ͬһ�������ļ�������ÿһ��ˮ���Ĺ�������
%�а�����һЩ����Ŷ���



end




