
%%
%%%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this scirpt plots the tsne space and the final bout map 


clear all
close all

%%
%%%%%%%%%%%%%%% import BoutCat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
 load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');

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
% idx =[10 2 9 7 5 4 1 6 11 8 3];%
idx =[7 2 11 6 5 8 4 10 1 3 9];%


col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;


% col = jet(length(uniqueClusterAssignmentGroupClusters));

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
   plot(rhoGroupClusters(indChoosenClusterCentersGroupClusters(n)), funnymeasureGroupClusters(indChoosenClusterCentersGroupClusters(n)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',10)
   hold on
   xlabel('Local density (AU)')
   ylabel('-minidip/\rho +1')
    box off
    
    subplot(1,3,2)
%    plot(mappedX((indThisCluster),1), mappedX((indThisCluster),2), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',10)
    plot3(mappedX((indThisCluster),1), mappedX((indThisCluster),2),mappedX((indThisCluster),3), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',5)
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



%%
%%%%%%%%%%%%%%%% get things out structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


dataToDoMap = finalClustering.dataToDoMap;

thisIndRandFinalAll = finalClustering.indsBoutMapInAllData;

clusterAssignment = finalClustering.assignment;

%%
%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%  col = ([ 0 0 255; 255 170 0;0 153 0; 255 255 0;255 0 50; 220 0 220;105 255 102;250 128 114; 0 200 200; 102 255 255])./255;

%  col = ([102 255 255; 255 170 0; 220 0 220; 255 0 50; 250 128 114;105 255 102; 0 0 255;0 200 200;0 153 0;255 255 0])./255;
% col = finalClustering.colorMap;
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;




uniqueClusterAssignment = unique(clusterAssignment);

 figure
% subplot(1,3,1)
% plot(rho, funnymeasure, '.k')
% axis square
% hold on
% subplot(1,3,2)
% plot(rho, funnymeasure, '.k')
% axis square


for n = 1 : length(uniqueClusterAssignment)
    
    
   indThisCluster =  clusterAssignment == uniqueClusterAssignment(n);
   
%    subplot(1,3,1)
%    plot(rho(indChoosenClusterCenters(n)), funnymeasure(indChoosenClusterCenters(n)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',10)
%    hold on
%    xlabel('Local density')
%    ylabel('-minidip/\rho +1')
    subplot(1,2,1)
   plot3(boutDataPCASample(thisIndRandFinalAll(indThisCluster),1), boutDataPCASample(thisIndRandFinalAll(indThisCluster),2),boutDataPCASample(thisIndRandFinalAll(indThisCluster),3), '.k')
   hold on
   axis square
   xlabel('PC 1')
   ylabel('PC 2')
   zlabel('PC 3')

   
   subplot(1,2,2)
   plot3(boutDataPCASample(thisIndRandFinalAll(indThisCluster),1), boutDataPCASample(thisIndRandFinalAll(indThisCluster),2),boutDataPCASample(thisIndRandFinalAll(indThisCluster),3), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',5)
   hold on
   axis square
   xlabel('PC 1')
   ylabel('PC 2')
   zlabel('PC 3')

%    subplot(1,3,3)
%    plot3(boutDataPCASample(thisIndRandFinalAll(indThisCluster),1), boutDataPCASample(thisIndRandFinalAll(indThisCluster),2),rho((indThisCluster)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',5)
%    hold on
%    axis square
%    xlabel('PC 1')
%    ylabel('PC 2')
%    zlabel('Local density')


%     pause
end
