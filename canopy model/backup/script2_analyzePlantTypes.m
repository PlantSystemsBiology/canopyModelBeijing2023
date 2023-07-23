
% script2 analysis of plant types

% 'M_plantStructureFile\M_WYJ-0711-ca1.xlsx',
% 'M_plantStructureFile\M_WYJ-0711-CA2.xlsx',
% 'M_plantStructureFile\M_WYJ-0711-F1.xlsx',

Date = ["0724","0828"]; % MMDD
Genotype = ["ca1","CA2","F1"]; %
CULTIVAR1 = ["WYJ","WYJ","WYJ"]; % two cultivars
CULTIVAR2 = ["313","314","313314"]; % two cultivars
CULTIVAR3 = ["JY5B","JP69","JYY69"]; % two cultivars

CULTIVAR = CULTIVAR2; % HERE: change to be 1 2 3

% Cultivar, date, genotype, leafID, avgH, avgL, avgW, avgCA, avgA
outputData = zeros(0, 9);
k=1;
for c = 1:3
    c
    for s = 1:2
        s
        
        file = strcat('M_plantStructureFile_analysis\M_',CULTIVAR{c},'-',Date{s},'-',Genotype{c},'.xlsx');
        file_sorted = strcat('M_plantStructureFile_analysis\MS_',CULTIVAR{c},'-',Date{s},'-',Genotype{c},'.xlsx');
        sheet = 1;
        paramMatrix = xlsread(file,sheet);  % read the parameter matrix from Excel file.
        [row,col]=size(paramMatrix);
        plantNum = max(paramMatrix(:,1));
        dataOf9Plants_m = zeros(0, 10);
        for p = 1:plantNum
            p
            % sort the tillers by the stem height
            tillerNum = max(paramMatrix(paramMatrix(:,1)==p,2));
            stemHeightofTillers = zeros(1,tillerNum);
            dataOfOnePlant = {};
            
            for t = 1:tillerNum
                stemHeightofTillers(t) = max(paramMatrix(paramMatrix(:,1)==p&paramMatrix(:,2)==t,4));
                dataOfOneStem = paramMatrix(paramMatrix(:,1)==p&paramMatrix(:,2)==t,:);
                dataOfOnePlant{t} = dataOfOneStem;
            end
            [SortedData,order]=sort(stemHeightofTillers,'descend');
            for t = 1:tillerNum
                dataOfOnePlant2{t} = dataOfOnePlant{order(t)};
            end
            for t = 1:tillerNum
                dataOf9Plants_m = [dataOf9Plants_m; dataOfOnePlant2{t}];
            end
            
%             m = paramMatrix (:,1:8);
%             plantNum = m(:,1);
%             tillerNum = m(:,2);
%             leafNum = m(:,3);
%             leafH = m(:,4);
%             leafL = m(:,5);
%             leafW = m(:,6);
%             leafCA = m(:,7);
%             leafA = m(:,8);
%             
%             
%             %   for p = 1:max(plantNum)
%             
%             for i = 1:max(leafNum)
%                 ind = leafNum == i;
%                 outputData(k,5:end) = mean(m(ind, 4:8));
%                 outputData(k,1) = c; % cultivar
%                 outputData(k,2) = s; % stage
%                 outputData(k,3) = c; % genotype
%                 outputData(k,4) = i; % leaf ID
%                 k = k+1;
%             end
%             %  end
            
            
        end
        xlswrite(file_sorted,dataOf9Plants_m); % write the sorted data to xls file, sorted tillers by stem height
           
    end
end
    
%     xlswrite('PlantStru_analysis.xlsx',outputData);
    
    
