close all
clear all


%%
%%%%%%%%%%%%%%%%% load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');
 load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_kNN4_74Kins3dims_1.75Smooth_fast_3000_auto.mat');
% load('C:\Joao analysis\FreeData\clusteringData\boutMap\BoutMap_kNN4_74Kins3dims_1.75Smooth_fast_3000_auto.mat');


%%
%%%%%%%%%%%%%%%% get things out structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mappedX = groupClusterSctructure.mappedX;
originalBandWidthsGroupClusters = groupClusterSctructure.originalBandWidthsGroupClusters;
scallingFactorGroupClusters = groupClusterSctructure.scallingFactorGroupClusters;
kdedensGroupClusters = groupClusterSctructure.kdedensGroupClusters;
densityTypeGroupClusters = groupClusterSctructure.densityTypeGroupClusters;
rhoGroupClusters = groupClusterSctructure.rhoGroupClusters;
realRhoGroupClusters = groupClusterSctructure.realRhoGroupClusters;
deltaGroupClusters = groupClusterSctructure.deltaGroupClusters;
funnymeasureGroupClusters = groupClusterSctructure.funnymeasureGroupClusters;
funnymeasureSortedGroupClusters = groupClusterSctructure.funnymeasureSortedGroupClusters;
maxjumpGroupClusters = groupClusterSctructure.maxjumpGroupClusters;
indChoosenClusterCentersGroupClusters = groupClusterSctructure.indChoosenClusterCentersGroupClusters;
clusterAssignmentGroupClusters = groupClusterSctructure.clusterAssignmentGroupClusters;
pointAssignmentMethodGroupClusters = groupClusterSctructure.pointAssignmentMethodGroupClusters;

%%
%%%%%%%%%%%%%%%%%% make dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makePlot = 0;
maxNumbOfClusterCenters = 20;
data = mappedX;
lowDensityCutOffGroupClusters = 0;
pointAssignmentMethodGroupClusters ='distance2';


indClusterCentersAll = find(funnymeasureGroupClusters >0);
% [~,idx]= sort(funnymeasureGroupClusters(indChoosenClusterCentersGroupClusters));

[val, idx]= sort(funnymeasureGroupClusters(indClusterCentersAll),'descend');

indClusterCentersAllSorted = indClusterCentersAll(idx);

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_2(data,funnymeasureGroupClusters,maxNumbOfClusterCenters,rhoGroupClusters,realRhoGroupClusters,maxjumpGroupClusters,pointAssignmentMethodGroupClusters,lowDensityCutOffGroupClusters,indClusterCentersAllSorted,makePlot);




%%
%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;


% col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

% col = ([ 0 0 255; 255 170 0;0 153 0; 255 255 0;255 0 50; 220 0 220;105 255 102;250 128 114; 0 200 200; 102 255 255])./255;
% col = ([ 0 0 255; 255 170 0;0 153 0; 255 255 0;255 0 50; 220 0 220;105 255 102;250 128 114; 0 200 200; 102 255 255])./255;
% col = ([102 255 255; 255 170 0; 220 0 220; 255 0 50; 250 128 114;105 255 102;0 150 255; 0 0 200;0 153 0;255 255 0])./255;
% col = ([102 255 255; 0 150 255;  0 0 200; 255 170 0; 220 0 220;255 255 0; 255 0 50; 250 128 114;105 255 102;0 153 0])./255;
uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentAll);


% col = jet(length(uniqueClusterAssignmentGroupClusters));

uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);

figure
subplot(1,3,1)
plot(rhoGroupClusters, funnymeasureGroupClusters, '.k')
axis square
hold on




for n = 1 : length(uniqueClusterAssignmentGroupClusters)

   indThisCluster =  clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(n);
   
   subplot(1,3,1)
   plot(rhoGroupClusters(indChoosenClusterCentersGroupClusters(n)), funnymeasureGroupClusters(indChoosenClusterCentersGroupClusters(n)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',10)
   hold on
   xlabel('Local density (AU)')
   ylabel('-minidip/\rho +1')
    box off
    
    subplot(1,3,2)
%    plot(mappedX((indThisCluster),1), mappedX((indThisCluster),2), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',10)
    plot3(mappedX((indThisCluster),1), mappedX((indThisCluster),2),mappedX((indThisCluster),3), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',5)
   hold on
%       plot(mappedX((indChoosenClusterCentersGroupClusters(n)),1), mappedX((indChoosenClusterCentersGroupClusters(n)),2), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',20)

   axis square
   xlabel('Dim 1')
   ylabel('Dim 2')
box off
   
%     subplot(1,3,3)
%    plot3(mappedX((indThisCluster),1), mappedX((indThisCluster),2),rho((indThisCluster)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',5)
%    hold on
%    axis square
%     pause 
    
end

subplot(1,3,3)
dendrogram(tree)
ylabel('-minidip/\rho +1')
axis square