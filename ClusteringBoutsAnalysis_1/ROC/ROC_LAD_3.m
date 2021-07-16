%%%%%%%%%%%%% what this function does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) import data with assigned clusters: ex: ClusterAssignmentPreliminaryData74Kins3dimWithCutOffMedium_moreDevided.mat
%2) organize data by each cluster

 %%

AddFunctionToPath

% close all
% clear all
% 


 %%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


PathName = 'C:\Joao analysis\FreeData\clusteringData\ClusterAssignment\final\';
FileName = 'ClusterAssignment_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged8.mat';

% %load all data 4d automatic clustering
%    load(strcat(PathName,FileName), 'behavioralSpaceStructure','boutDataPCASample','indStructure','BoutInf','BoutKinematicParameters');
% 

%%
%%%%%%%%%%%%%%%%%%%%% make clusterStructure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minNumbClusterPoints = 100;
percClusterThres = 0.10;
corePerc = 15;
makeplot = 1;
% indToInclude = 1;

% %adds all data sets of prey cature rot
% indToAddAllClusters = [97 98  99];
% % [clusterStructure] = makeClusterStructure_1(indStructure,minNumbClusterPoints,percClusterThres,corePerc,makeplot); 
% [clusterStructure] = makeClusterStructure_3(indStructure,minNumbClusterPoints,percClusterThres,corePerc,indToAddAllClusters,makeplot); 


%adds only capture swims
% indToAddAllClusters = [61 66];% add fast swims
% indToAddAllClusters = [61 66 123 141];% add fast swims, C starts
%  indToAddAllClusters = [61 66 123 141 48 157 177];% add fast swims, C starts, HAT
%  indToAddAllClusters = [61 66 123 141 48 157 177 347 354 369];% add fast swims, C starts, HAT, capture swims of Rot1
%  indToAddAllClusters = [61 66 123 141 48 157 177 347 354 369 382];% add fast swims, C starts, HAT, capture swims of Rot1, capture swims of Rita naive
%  indToAddAllClusters = [61 66 123 141 48 157 177 347 354 369 382];% add fast swims, C starts, HAT, capture swims of Rot1, capture swims of Rita naive, capture swims of Rita exp1
%   indToAddAllClusters = [61 66 123 141 48 157 177 334 341 356 369 380];% add fast swims, C starts, HAT, capture swims of Rot1, capture swims of Rita naive, capture swims of Rita exp1

%    indToAddAllClusters = [61 66 123 141 48 157 177 347 354 369 382 392 398 421 426];% add fast swims, C starts, HAT, capture swims of Rot1, capture swims of Rita naive, capture swims of strains

indToAddAllClusters = [61 66 123 141 48 157 177 334 341 356 369 380 399];% add fast swims, C starts, HAT, capture swims of Rot1, capture swims of Rita naive, capture swims of Rita exp2


% indExcludeClusters = [53 58 62 126 99 ];%excude 3 slow sims from OMR speed and LEE that is close to capture swims

%   indExcludeClusters = [53 58 62 126 99 147 150];%excude 3 slow sims from OMR speed and LEE that are close to capture swims
    indExcludeClusters = [53 58 62 126 99 147 150   258   259   260  261   262   263   264   265   266   267   268   269   270];%excude 3 slow sims from OMR speed and LEE that are close to capture swims
indExcludeClusters = [ 53    58    62];%exclude 3 slows from OMR speed...

    
    
%  ind = find([clusterStructure.bigDataSetNumber] == 78)
  
%  indExcludeClusters = []

 [clusterStructure] = makeClusterStructure_addCluster_5(indStructure,boutDataPCASample,minNumbClusterPoints,percClusterThres,corePerc,indToAddAllClusters,indExcludeClusters,makeplot); 
% clusterStructure = [];






length(find([clusterStructure.BigCluster]==1))

pause

%%
%%%%%%%%%%%%%%%%%%%% do ROC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %center of 2 clusters to project points
% [ROCareaNormDimProjtestNoNans] = ROCFunction_2(clusterStructure);
% 
%center LAD to project points
% LDA_Center = 1;%use center of cluster to calculate projections
LDA_Center = 2;%use LDA to caculate projections


[ROCareaNormDimProjtestNoNans] = ROCFunction_4(clusterStructure,boutDataPCASample,indStructure,LDA_Center);

%%
%%%%%%%%%%%%%% make essemble t-SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


numbOfTimes = 10;

numbDimsTsne = 3;
perplexity = 60;
makeplot = 1;
densityType = 'local';
% scallingFactorGroupClusters = 2.2;
scallingFactorGroupClusters = 2;

linedensityMethod = 'slowPar';
pointAssignmentMethod = 'distance2';
% [groupClusterSctructure] = groupClusters_EssembleTSNE_function_1(ROCareaNormDimProjtestNoNans,boutDataPCASample,clusterStructure,numbOfTimes,numbDims,...
%     perplexity,densityType,scallingFactorGroupClusters,linedensityMethod,cutThreshold,makeplot);
distanceTsne = 1;


[groupClusterSctructureThis,essembleMatrix,essembleMatrixRand] = groupClusters_EssembleTSNE_function_4(ROCareaNormDimProjtestNoNans,numbOfTimes,numbDimsTsne,perplexity,densityType,scallingFactorGroupClusters,linedensityMethod,distanceTsne);


%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% make essemble t-SNE plot %%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cutThreshold = 50;
numbDist =1;
axisLim = [-15 20 -10 10];

[T2Rand,Z2Rand,essembleMatrixPermRand] = essemble_tSne_plot_forMergedData_3(essembleMatrixRand,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,boutDataPCASample,makeplot,axisLim);



cutThreshold =14.5;
numbDist =1;
axisLim = [-15 25 -10 15];

[T2,Z2,essembleMatrixPerm,clusterStructure] = essemble_tSne_plot_forMergedData_3(essembleMatrix,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,boutDataPCASample,makeplot,axisLim);

bigClusterVector = find([clusterStructure.BigCluster]);

% ind1 = find(bigClusterVector == 394);
% ind2 = find(bigClusterVector == 383);
% ind2 = find(bigClusterVector == 381);

% 
% T2(ind1)
% T2(ind2)

groupClusterSctructure.GroupClusyersMethod = 'essemble tsne_d';
groupClusterSctructure.perplexity = perplexity;
groupClusterSctructure.pointAssignmentMethodGroupClusters = pointAssignmentMethod;
groupClusterSctructure.cutThresholdDendrogram = cutThreshold;
groupClusterSctructure.essembleMatrixPerm = essembleMatrixPerm;
groupClusterSctructure.essembleMatrix = essembleMatrix;
groupClusterSctructure.essembleMatrixReorderingMethod = 'average';
groupClusterSctructure.essembleMatrixReorderingDistance = 'seuclidean';
groupClusterSctructure.essembleMatrixAssignment = T2;
groupClusterSctructure.essembleMatrixLinkageResult = Z2;
groupClusterSctructure.distributions = groupClusterSctructureThis;

groupClusterSctructure.essembleMatrixRand = essembleMatrixRand;
groupClusterSctructure.essembleMatrixAssignmentRand = T2Rand;
groupClusterSctructure.essembleMatrixLinkageResultRand = Z2Rand;
groupClusterSctructure.scallingFactorGroupClusters = scallingFactorGroupClusters;
groupClusterSctructure.numbDimsTsne = numbDimsTsne;




%%
% %%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PathName = 'C:\Joao analysis\FreeData\clusteringData\groupOfClusters\withROT\';
% FileName = 'GroupsClusters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged5.mat';
% 
%   save(strcat(PathName,FileName),'groupClusterSctructure','ROCareaNormDimProjtestNoNans','indStructure','behavioralSpaceStructure','behavioralSpaceStructure','clusterStructure','boutDataPCASample','BoutKinematicParameters','BoutInf','-v7.3')
% 
 save('C:\Joao analysis\FreeData\clusteringData\groupOfClusters\withROT\GroupsClusters_AlldataWithRot_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged8.mat','groupClusterSctructure','ROCareaNormDimProjtestNoNans','indStructure','behavioralSpaceStructure','behavioralSpaceStructure','clusterStructure','boutDataPCASample','BoutKinematicParameters','BoutInf','-v7.3')

