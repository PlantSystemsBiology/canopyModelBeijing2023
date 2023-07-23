%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Os_plant is used for building a 3D rice plant model, as a module for build
% a rice canopy.
% Codeded by Qingfeng
% 2020-03-04, Shanghai
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function M_canopy = Os_canopy(paramMatrix)

global STEP_X STEP_Y ROW_NUM COL_NUM;
global OS_DATA_MATRIX_COLUMN_NUM;
global MAXIMAL_PLANT_NUM;

M_canopy = zeros(0,OS_DATA_MATRIX_COLUMN_NUM);
plantID = 0;

for id_row  = 0:ROW_NUM - 1     %��ѭ��
    x_shift = STEP_X * id_row;  %�з����λ�ƣ�Ϊ��ǰ������һ��ˮ����λ��x���ꡣ
    for id_col  = 0:COL_NUM - 1 %��ѭ��
        y_shift = STEP_Y * id_col;  %�з����λ�ƣ�ͬ��, y���ꡣ
        
        %  plantID, measured 9 plants, use these 9 plants to build a
        %  canopy, if the canopy is more than 9 plants, use from the first plant
        %  again. 
        plantID = plantID+1;
        if plantID > MAXIMAL_PLANT_NUM
            plantID = 1;
        end
        paramMatrix_plant = paramMatrix(paramMatrix(:,1) == plantID,:);
        
        
        M_plant = Os_plant (paramMatrix_plant); %����һ��ֲ�ﵥ��
        
        % plant routation QF;2020-4-15
        [X, Y, Z] = convertColumn9to3 (M_plant(:,6:14));
        [theta,r,h] = cart2pol(X,Y,Z);                % Z ����Ϊ��, -ת��Ϊ������ϵ,
        theta = theta + rand*(2*pi);            % ����ֲ���Դ�����Ƕ�
        [X,Y,Z] = pol2cart(theta,r,h); %ת���صѿ�������ϵ
        M_plant(:,6:14) = convertColumn3to9 ([X, Y, Z]);
        %

        M_plant(:,6:14) = [M_plant(:,6)+ x_shift, M_plant(:,7)+ y_shift, M_plant(:,8), ...
            M_plant(:,9)+x_shift,  M_plant(:,10)+y_shift, M_plant(:,11), ...
            M_plant(:,12)+x_shift, M_plant(:,13)+y_shift, M_plant(:,14)];
        M_canopy = [M_canopy; M_plant]; %���뵽ֲ��ڲ���
    end
end

end



