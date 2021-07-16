%%%%%%%%%%%%% what this function does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) import data with assigned clusters: ex: ClusterAssignmentPreliminaryData74Kins3dimWithCutOffMedium_moreDevided.mat
%2) organize data by each cluster

 %%

AddFunctionToPath

close all
clear all



 %%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


PathName = 'C:\Joao analysis\FreeData\clusteringData\ClusterAssignment\final\';
FileName = 'ClusterAssignment_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';

%load all data 4d automatic clustering
%      load(strcat(PathName,FileName), 'behavioralSpaceStructure','boutDataPCASample','indStructure','BoutInf','BoutKinematicParameters');


%%
%%%%%%%%%%%%%%%%%%%% choose clusters to add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %merged 10
% indCaptureSwims = [334 341 356 369 380 399 419];
% indFast = [61 66 73 76 79 82 86 123 141 48 157 177];
% indSlowConvUnconv = [337 348 361 373 386 505 423] ;
% indCStart = [148 418];%small c start and good LLC


%merged11
indCaptureSwims = [334 341 357 371 382 403 424];

indFast = [61 66 73 76 79 82 86 123 141 48 157 177];
indSlowConvUnconv = [337 349 363 375 389 410 429] ;
indCStart = [148];%small c start and good LLC


indToAddAllClusters = [indCaptureSwims indFast indSlowConvUnconv indCStart];% add fast swims, C starts, HAT, capture swims of Rot1, capture swims of Rita naive, capture swims of Rita exp2

indExcludeClusters = [];
minNumbClusterPoints = 100;
percClusterThres = 0.10;
corePerc = 15;
makeplot = 1;


 [clusterStructure] = makeClusterStructure_addCluster_5(indStructure,boutDataPCASample,minNumbClusterPoints,percClusterThres,corePerc,indToAddAllClusters,indExcludeClusters,makeplot); 
% clusterStructure = [];




%%
%%%%%%%%%%%%%%%%%%%% choose clusters to exclude %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %merged 10
% indLLEBad = [126 122 147];%LEE that are close to capture swims
% indSpeedOMR = [ 49    50    51    52  53    54    55    56   57    58    59    60 62    63    64    65  67    68    69    70    71  72 74  75  78 80 81  83    84   85   87    88];
% indSpontDeep = [ 389   390   391   392   393   408   409   410   411   412];

%merged 11
indLLEBad = [126 122 147];%LEE that are close to capture swims
indSpeedOMR = [ 49    50    51    52  53    54    55    56   57    58    59    60 62    63    64    65  67    68    69    70    71  72 74  75  78 80 81  83    84   85   87    88];

indDeep1 = find([clusterStructure.bigDataSetNumber] == 113);
indDeep2 = find([clusterStructure.bigDataSetNumber] == 118);
indSpontDeep = [indDeep1 indDeep2];
indSlow = [40 100];

    indExcludeClusters = [indLLEBad indSpeedOMR indSpontDeep indSlow];
%    bigDataSetNumber =  [clusterStructure.bigDataSetNumber];
   
minNumbClusterPoints = 100;
percClusterThres = 0.10;
corePerc = 15;
makeplot = 1;


 [clusterStructure] = makeClusterStructure_addCluster_5(indStructure,boutDataPCASample,minNumbClusterPoints,percClusterThres,corePerc,indToAddAllClusters,indExcludeClusters,makeplot); 
% clusterStructure = [];


%  ind = find([clusterStructure.bigDataSetNumber] == 78)
  
%  indExcludeClusters = []

%%
%%%%%%%%%%%%%%%%%%%%% make clusterStructure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



minNumbClusterPoints = 100;
percClusterThres = 0.10;
corePerc = 15;
makeplot = 1;


 [clusterStructure] = makeClusterStructure_addCluster_5(indStructure,boutDataPCASample,minNumbClusterPoints,percClusterThres,corePerc,indToAddAllClusters,indExcludeClusters,makeplot); 
% clusterStructure = [];






length(find([clusterStructure.BigCluster]==1))

% pause

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


numbOfTimes = 70;

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
% groupClusterSctructureThis = [];
% essembleMatrix = [];
% essembleMatrixRand = [];
% 



[groupClusterSctructureThis,essembleMatrix,essembleMatrixRand] = groupClusters_EssembleTSNE_function_5(ROCareaNormDimProjtestNoNans,numbOfTimes,numbDimsTsne,perplexity,densityType,scallingFactorGroupClusters,linedensityMethod,distanceTsne,groupClusterSctructureThis,essembleMatrix,essembleMatrixRand);


%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% make essemble t-SNE plot %%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cutThreshold = 50;
numbDist =1;
axisLim = [-15 20 -10 10];

[T2Rand,Z2Rand,essembleMatrixPermRand] = essemble_tSne_plot_forMergedData_3(essembleMatrixRand,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,boutDataPCASample,makeplot,axisLim);



cutThreshold = 15.5;
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
%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PathName = 'C:\Joao analysis\FreeData\clusteringData\GroupOfClusters\';
FileName = 'GroupsClusters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';

%    save(strcat(PathName,FileName),'groupClusterSctructure','ROCareaNormDimProjtestNoNans','indStructure','behavioralSpaceStructure','behavioralSpaceStructure','clusterStructure','boutDataPCASample','BoutKinematicParameters','BoutInf','-v7.3')

%  save('C:\Joao analysis\FreeData\clusteringData\groupOfClusters\withROT\GroupsClusters_AlldataWithRot_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged8.mat','groupClusterSctructure','ROCareaNormDimProjtestNoNans','indStructure','behavioralSpaceStructure','behavioralSpaceStructure','clusterStructure','boutDataPCASample','BoutKinematicParameters','BoutInf','-v7.3')

