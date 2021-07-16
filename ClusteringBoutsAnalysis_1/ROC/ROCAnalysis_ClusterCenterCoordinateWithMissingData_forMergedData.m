AddFunctionToPath

 close all
clear all


    
%%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));
load('C:\Joao analysis\FreeData\clusteringData\assignAllData\final\BoutCat_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto_final.mat');


    %%
%%%%%%%%%%%%%%% save boutDataPCASample in indStructure %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
stimNumber = BoutInf(:,EnumeratorBoutInf.stimNumber);
stimNumber = BoutInf(:,EnumeratorBoutInf.stimNumber);

for n = 1 : length(indStructure)
    
    thisIndRand = indStructure(n).thisIndRand;
    
    indStructure(n).boutDataPCASampleData =  boutDataPCASample(thisIndRand,:);
    indStructure(n).dataSet = unique(dataSetNumber(thisIndRand));
    indStructure(n).stimNumb = unique(stimNumber(thisIndRand));

end

sizeOfdata1 = size(boutDataPCASample,1);

 clearvars boutDataPCASample;
    

%%
%%%%%%%%%%%%%%%%%%%%% make clusterStructure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minNumbClusterPoints = 100;
percClusterThres = 0.10;
corePerc = 15;
makeplot = 1;
% indToInclude = 1;
indToAddAllClusters = [];
% [clusterStructure] = makeClusterStructure_1(indStructure,minNumbClusterPoints,percClusterThres,corePerc,makeplot); 
[clusterStructure] = makeClusterStructure_3(indStructure,minNumbClusterPoints,percClusterThres,corePerc,indToAddAllClusters,makeplot); 


length(find([clusterStructure.BigCluster]==1))

 pause
%%
%%%%%%%%%%%%%%%%%%%% do ROC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[ROCareaNormDimProjtestNoNans] = ROCFunction_2(clusterStructure);


%%
%%%%%%%%%%%%%% make essemble t-SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


numbOfTimes = 20;

numbDimsTsne = 3;
perplexity = 30;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% make essemble t-SNE plot %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cutThreshold = 50;
numbDist =1;
axisLim = [-15 20 -10 10];

[T2Rand,Z2Rand,essembleMatrixPermRand] = essemble_tSne_plot_forMergedData(essembleMatrixRand,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,makeplot,axisLim);

cutThreshold = 10;
numbDist =1;
axisLim = [-15 25 -10 15];

[T2,Z2,essembleMatrixPerm,clusterStructure] = essemble_tSne_plot_forMergedData(essembleMatrix,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,makeplot,axisLim);

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

%  save('GroupsClusters_MK801_74Kins3dim_slow_3000_auto_NoControl_30min.mat','groupClusterSctructure','ROCareaNormDimProjtestNoNans','indStructure','behavioralSpaceStructure','behavioralSpaceStructure','clusterStructure','-v7.3')

% save('GroupsClusters_MK801_74Kins3dim_slow_3000_auto_NoControl_3min.mat','groupClusterSctructure','ROCareaNormDimProjtestNoNans','indStructure','behavioralSpaceStructure','behavioralSpaceStructure','clusterStructure','-v7.3')


