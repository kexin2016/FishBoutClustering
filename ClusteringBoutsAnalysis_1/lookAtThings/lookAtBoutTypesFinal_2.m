
%%
%%%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this scirpt plots the tsne space and the final bout map 


% clear all
% close all

%%
%%%%%%%%%%%%%%% import BoutCat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%   load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');

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
%%%%%%%%%%%% exclude point %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mappedX2 = mappedX;
mappedX(107,:) = [];

rhoGroupClusters2 = rhoGroupClusters;
rhoGroupClusters(107) = [];

realRhoGroupClusters2 = realRhoGroupClusters;
realRhoGroupClusters(107) = [];

funnymeasureGroupClusters2 = funnymeasureGroupClusters;
funnymeasureGroupClusters(107) = [];
clusterAssignmentGroupClusters(107) = [];
maxjumpGroupClusters2 = maxjumpGroupClusters;

maxjumpGroupClusters(107,:) = [];
maxjumpGroupClusters(:,107) = [];



%%
%%%%%%%%%%%%%%%%%% make dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% makePlot = 0;
data = mappedX2;
lowDensityCutOffGroupClusters = 0;
pointAssignmentMethodGroupClusters ='distance2';


indClusterCentersAll = find(funnymeasureGroupClusters2 >0);
% [~,idx]= sort(funnymeasureGroupClusters(indChoosenClusterCentersGroupClusters));

[val, idx]= sort(funnymeasureGroupClusters2(indClusterCentersAll),'descend');

indClusterCentersAllSorted = indClusterCentersAll(idx);

maxNumbOfClusterCenters = 20;

makePlot =1;
[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_2(data,funnymeasureGroupClusters2,maxNumbOfClusterCenters,rhoGroupClusters2,realRhoGroupClusters2,maxjumpGroupClusters2,pointAssignmentMethodGroupClusters,lowDensityCutOffGroupClusters,indClusterCentersAllSorted,makePlot);

% uniqueClusterAssignmentAll = unique(clusterAssignmentAll);
% 
%  col = jet(length(uniqueClusterAssignmentAll));
% invCol = flipud(col);
% 
% 
% figure
% for h = 1 : length(uniqueClusterAssignmentAll)
%     
% indThisCluster = find(clusterAssignmentAll == uniqueClusterAssignmentAll(h));
%     
%     
% plot(data(indThisCluster,1),data(indThisCluster,2), 'o','color', invCol(h,:))
% axis square
% hold on
% pause
% 
% end
% 


%%
%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% idx =[10 2 9 7 5 4 1 6 11 8 3];%
idx =[7 2 11 6 5 8 4 10 1 3 9];%


col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;


% col = jet(length(uniqueClusterAssignmentGroupClusters));

% col = jet(length(uniqueClusterAssignmentGroupClusters));

uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);
% close all
figure

%  n =8
%  
%    indThisCluster =  find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(n));
%    for nn = 1 : length(indThisCluster)
% clf
   plot(mappedX(:,1), mappedX(:,2), 'ko','MarkerFaceColor','k','MarkerSize',5)
%    plot3(mappedX(:,1), mappedX(:,2),mappedX(:,3), 'ko','MarkerFaceColor','k','MarkerSize',5)
   hold on

%      plot(mappedX(indThisCluster(nn),2), mappedX(indThisCluster(nn),1), 'ko','MarkerFaceColor','r','MarkerSize',5)

   hold on

   axis square
   xlabel('Dim 1')
   ylabel('Dim 2')
   axis([ -25 25 -25 30])
box off
% title(indThisCluster(nn))
% pause
%    end

ii = figure;
jj = figure;

% subplot(1,3,1)
figure(ii)
plot(realRhoGroupClusters2, funnymeasureGroupClusters2, 'ko','MarkerFaceColor','k','MarkerSize',5)
axis square
hold on




for n = 1 : length(uniqueClusterAssignmentGroupClusters)
%  n =10
   indThisCluster =  find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(n));
   
%    subplot(1,3,1)
figure(ii)

   plot(realRhoGroupClusters2(indChoosenClusterCentersGroupClusters(n)), funnymeasureGroupClusters2(indChoosenClusterCentersGroupClusters(n)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',10)
   hold on
   xlabel('Local density (AU)')
   ylabel('-minidip/\rho +1')
    box off
   
    figure(jj)

%     subplot(1,3,2)
%    plot(mappedX((indThisCluster),1), mappedX((indThisCluster),2), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',10)
%      plot3(mappedX((indThisCluster),1), mappedX((indThisCluster),2),mappedX((indThisCluster),3), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',5)
       plot(mappedX((indThisCluster),1), mappedX((indThisCluster),2), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',5)

    hold on
%       plot(mappedX((indChoosenClusterCentersGroupClusters(n)),1), mappedX((indChoosenClusterCentersGroupClusters(n)),2), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',20)

   axis square
   xlabel('Dim 1')
   ylabel('Dim 2')
box off
      axis([ -25 25 -25 30])

%     subplot(1,3,3)
%    plot3(mappedX((indThisCluster),1), mappedX((indThisCluster),2),rho((indThisCluster)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',5)
%    hold on
%    axis square
%     pause 
    
end

figure
% subplot(1,3,3)
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
