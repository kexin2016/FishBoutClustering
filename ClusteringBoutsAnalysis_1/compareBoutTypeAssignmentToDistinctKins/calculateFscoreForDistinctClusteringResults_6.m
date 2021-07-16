


clear all
close all


AddFunctionToPath

%get folder name where the folders with each dataset are
dataPath =  uigetdir;


%%
%%%%%%%%%%%%%%%%%%get names of all files of all data sets%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%test function


%creats structure with names of things inside folder
DataFiles = dir(dataPath);

DataFiles(1) = [];
DataFiles(1) = [];
DataFiles(1) = [];%erase first file 


%%
%%%%%%%%%%%%%%%%%% make threshold matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbOflusters = zeros(7,19);
thresholdMatrix = zeros(7,19);

thresholdMatrix(1,:) = [26	25	24.4	24	23.83	23.5	23	20.5	17	16.5	12.5	11	9.5	8	6.5	5	4	3.5	3];
thresholdMatrix(2,:) = [24	23.8	23	22.7	22.6	22.4	21.3	20.7	14	12	10	9	5.4	5.2	4.1	2.6	2.5	2.3	1.9];
thresholdMatrix(3,:) = [27	25.6	25.16	25.12	24.8	24.6	24.5	20.8	17.2	14.8	12	10.2	8.4	5.8	5.6	5.4	4.6	4.2	3.8];
thresholdMatrix(4,:) = [26	25.3	25.1	24.95	24.94	24.7	24.6	24.5	24.38	23.5	17	12	11.5	6.5	4.5	4	3.7	3.3	2.42];
thresholdMatrix(5,:) = [25	24.2	24	23.8	23.5	23.2	22.8	22.1	19.2	18.6	18.4	13.4	10.6	8	6	5.86	5.82	5.2	5];
thresholdMatrix(6,:) = [25.5	24.5	24.2	24.1	23.8	23.69	23.67	23.5	17.5	17.2	14.6	11.8	11	9.8	9.4	6.4	5.2	4.9	4.7];
thresholdMatrix(7,:) = [24.5	23.5	23.2	23.1	22.8	22.7	22.4	21.9	18	13	11.2	10	8.4	7.8	7.4	6.3	6	5	4.2];



%%
%%%%%%%%%%%%%%%% assign all data according to dendrogram cut off %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clusterAssignmentAll = [];

 for nn = 1 : length(DataFiles)
nn

% nn = 1

%%
%%%%%%%%%%%%%%%%%% load this data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars -except DataFiles dataPath nn indGoodBouts thresholdMatrix numbOflusters clusterAssignmentAll clusterAssignmentStruct

   load(char(strcat(dataPath, '\', DataFiles(nn).name)),'groupClusterSctructure','boutDataPCASample','clusterStructure','BoutInf','behavioralSpaceStructure','indStructure','-mat');%!!! it should break in uni fish debug
   
   
 %%
%%%%%%%%%%%% determine number of dims of data set %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandWidthsScalled2 = indStructure(1).bandWidthsScalled;

 numbOfDims =  size(bandWidthsScalled2,1);
%  numbOfDims =  3;
  
   clearvars indStructure
%%
%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TF = exist('indGoodBouts','var');

if TF == 0
    
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);
indMistakesIn74KinSpace = find(mistakesIn74KinSpace);

indBoutsToExclude = [indBadBouts' indMistakesIn74KinSpace']';
indGoodBouts = 1 : length(BoutInf);
indGoodBouts(indBoutsToExclude) = [];

end

%%
%%%%%%%%%%%%%%%% get stuff I need from structures %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
essembleMatrix = groupClusterSctructure.essembleMatrix;
groupClusterSctructureThis = groupClusterSctructure.distributions;


   
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% apply this threshold %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clusterAssignmentAll = [];
for h = 1 : size(thresholdMatrix,2)
%     h =1

h

   makeplot = 0;
   numbDist = 1;
   cutThresholdThis = thresholdMatrix(nn,h);
   
   [T2,Z2,essembleMatrixPerm,clusterStructure] = essemble_tSne_plot_4(essembleMatrix,boutDataPCASample,clusterStructure,groupClusterSctructureThis,cutThresholdThis,numbDist,makeplot);

   % unique([clusterStructure.ClusterOfClusterCat])
clusterAssignmentGroupClusters = T2;

numbOflustersThis = unique([clusterStructure.ClusterOfClusterCat]);
numbOflustersThis(numbOflustersThis == 0) = [];
   numbOflusters(nn,h) = length(numbOflustersThis);
   
%%
%%%%%%%%%%%%%%%%%%%%% do assignment to all data %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 makeplot = 0;
 
[clusterAssignmentThis] = finalClustering_KnearestNeighbour_fromEssembleTSNE_function_1(boutDataPCASample,clusterStructure,clusterAssignmentGroupClusters,indGoodBouts,numbOfDims,makeplot);

clusterAssignmentAll = [clusterAssignmentAll' clusterAssignmentThis']';

end%threshold loop

clusterAssignmentStruct(nn).dataSetName = DataFiles(nn).name;
clusterAssignmentStruct(nn).clusterAssignmentAll = clusterAssignmentAll;


 end%data set loop
 

 
 
 save('clusterAssignmentStruct3.mat','clusterAssignmentStruct','-v7.3')
 
  clearvars -except DataFiles dataPath nn indGoodBouts thresholdMatrix numbOflusters clusterAssignmentAll clusterAssignmentStruct

%%
%%%%%%%%%%%%%%%%%%%%%% calculate F score %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbInt = 1000;
indGoodBoutsPart = indGoodBouts(1:numbInt:length(indGoodBouts));

clusterAssignmentAllOrig = clusterAssignmentStruct(4).clusterAssignmentAll;

F1All = zeros(size(clusterAssignmentAllOrig,1), length(clusterAssignmentStruct) );


for j = 1 : size(clusterAssignmentAllOrig,1)%loop through each cluster solution
    
    j
    
    %%
    %%%%%%%%%%%%%%%%%%% make original clustering solution %%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    clusterAssignmentAllOrigThisSolution = clusterAssignmentAllOrig(j,:);
    
    uniqueBoutCat = unique(clusterAssignmentAllOrigThisSolution);
    
    boutCatThisPart = clusterAssignmentAllOrigThisSolution(indGoodBoutsPart);
    uniqueBoutCatThis = unique(boutCatThisPart);
    
    % make binary matrix original clustering
    binaryOriginalMatrix = zeros(length(indGoodBoutsPart),length(indGoodBoutsPart));

    for jj = 1 : length(uniqueBoutCatThis)
    
    
   indThisCluster = find(boutCatThisPart == uniqueBoutCatThis(jj));
   
   binaryOriginalMatrix(indThisCluster,indThisCluster) = 1;
   
    
    end

   
   
    
    for jjj = 1 : length(clusterAssignmentStruct) 
        
         if jjj ~= 4%avoid comparing original distribution with it self
    %%
    %%%%%%%%%%%%%%%%%%% make other clustering solution %%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        
       
            
        clusterAssignmentAllThis = clusterAssignmentStruct(jjj).clusterAssignmentAll;
        
          clusterAssignmentAllThisSolution = clusterAssignmentAllThis(j,:);
    
        uniqueBoutCat = unique(clusterAssignmentAllThisSolution);
    
        boutCatThisPartThis = clusterAssignmentAllThisSolution(indGoodBoutsPart);
    
    
        % make binary matrix original clustering
        binaryMatrixThis = zeros(length(indGoodBoutsPart),length(indGoodBoutsPart));

        for jj = 1 : length(uniqueBoutCatThis)
    
    
        indThisCluster2 = find(boutCatThisPartThis == uniqueBoutCat(jj));
   
        binaryMatrixThis(indThisCluster2,indThisCluster2) = 1;
   
    
        end
        
        
        %%
        %%%%%%%%%%%%%%%%%%% calculate f score %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        F1 = F1ScoreCalculator_2(binaryOriginalMatrix,binaryMatrixThis);



        F1All(j,jjj) = F1; 

        
         end
        
         
    end
    

end





