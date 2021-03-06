% close all
% clear all
% 

%%
%%%%%%%%%%%%%%%%% load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');
%  load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_kNN4_74Kins3dims_1.75Smooth_fast_3000_auto.mat');
% load('C:\Joao analysis\FreeData\clusteringData\boutMap\BoutMap_kNN4_74Kins3dims_1.75Smooth_fast_3000_auto.mat');


%%
%%%%%%%%%%%%%%%%%%%%%% get stuff out of structure %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clusterAssignmentGroupClusters = groupClusterSctructure.essembleMatrixAssignment;
% tsneDistributions = groupClusterSctructure.distributions;
% 
% mappedX = tsneDistributions(1).mappedX;
% 

cutThreshold = groupClusterSctructure.cutThresholdDendrogram;
essembleMatrixPerm = groupClusterSctructure.essembleMatrixPerm;
essembleMatrix = groupClusterSctructure.essembleMatrix;
T2 = groupClusterSctructure.essembleMatrixAssignment;
Z2 = groupClusterSctructure.essembleMatrixLinkageResult;
groupClusterSctructureThis = groupClusterSctructure.distributions;

essembleMatrixRand = groupClusterSctructure.essembleMatrixRand;
T2Rand = groupClusterSctructure.essembleMatrixAssignmentRand;
Z2Rand = groupClusterSctructure.essembleMatrixLinkageResultRand;

mappedX = groupClusterSctructureThis(1).mappedX;

   cutThreshold = 30;
 numbDist = 34;
 axisLim = [-15 15 -10 10];
makeplot =1;
[T2,Z2,essembleMatrixPerm,clusterStructure] = essemble_tSne_plot_5(essembleMatrix,boutDataPCASample,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,makeplot,axisLim);



% 
% groupClusterSctructure.essembleMatrixAssignment = T2;
% groupClusterSctructure.essembleMatrixLinkageResult = Z2;
% groupClusterSctructure.essembleMatrixPerm = essembleMatrixPerm;
% groupClusterSctructure.cutThresholdDendrogram = cutThreshold;

%%
% %%%%%%%%%%%%%%%% plot tsne space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);
% 
% % idx =[10 2 9 7 5 4 1 6 11 8 3];%
% idx =[7 1 9 3 2 4 8 5 10 11 6];%
%  idx = 1:1:length(uniqueClusterAssignmentGroupClusters);
% 
% % col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;
% col = jet(length(idx));
% 
% 
% 
% %    col = jet(length(uniqueClusterAssignmentGroupClusters));
% figure
% for n = 1 : length(uniqueClusterAssignmentGroupClusters)
% 
%     
%     
%     indThisGroupOfClusters = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(idx(n)));
%     
%     
%     
%     plot3(mappedX(indThisGroupOfClusters,1),mappedX(indThisGroupOfClusters,2),mappedX(indThisGroupOfClusters,3),'.','color',col(n,:))
%     hold on
% %     plot3(mappedX(indsCore2,1),mappedX(indsCore2,2),mappedX(indsCore2,3),'o','color',col(n,:))
%     
% %     pause 
% end
% 
% % axis([-20 20 -20 20 -20 20])
% axis square
% 
% 
% 
% %%
% % %%%%%%%%%%%%% plot bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % 
% % dataToDoMap = finalClustering.dataToDoMap;
% % indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
% % clusterAssignmentInAllData = finalClustering.assignment;
% % 
% % uniqueClusterAssignmentInAllData = unique(clusterAssignmentInAllData);
% % col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;
% % 
% % figure
% % for nn = 1 : length(uniqueClusterAssignmentInAllData)
% %     
% %     
% %     indThisCluster = find(clusterAssignmentInAllData == uniqueClusterAssignmentInAllData(nn));
% %     
% % %     plot3(dataToDoMap(indThisCluster,1),dataToDoMap(indThisCluster,2),dataToDoMap(indThisCluster,3),'.','color', col(nn,:))
% %     plot(dataToDoMap(indThisCluster,1),dataToDoMap(indThisCluster,2),'.','color', col(nn,:))
% % 
% %     hold on
% %     axis square
% %     
% % end
% % 
% % 
% % 
% % %%
% % %%%%%%%%%%% plot all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
% % 
% % uniqueBoutCat = unique(boutCat);
% % 
% % figure
% % for i = 1 : length(uniqueBoutCat)
% %     
% %     
% %     indThisBout = find(boutCat == uniqueBoutCat(i));
% %     
% % %     plot3(boutDataPCASample(indThisBout(1:100:end),1),boutDataPCASample(indThisBout(1:100:end),2),boutDataPCASample(indThisBout(1:100:end),3),'.','color', col(i,:))
% %     plot(boutDataPCASample(indThisBout(1:100:end),1),boutDataPCASample(indThisBout(1:100:end),2),'.','color', col(i,:))
% % 
% %     
% %     hold on
% % axis square
% %     
% %     
% %     
% % end
% % 
% % 
