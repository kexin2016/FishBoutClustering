
 function [T2,Z2,essembleMatrixPerm,clusterStructure] = essemble_tSne_plot_4(essembleMatrix,boutDataPCASample,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,makeplot)

%%
%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% essembleMatrix
% boutDataPCASample
% clusterStructure
% groupClusterSctructureThis
% cutThreshold = 20;

%%
%%%%%%%%%%%%%%%%%%%%%%%%% reorder essembleMatrix %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 Z2 = linkage(essembleMatrix,'average','seuclidean');
%  Z2 = linkage(essembleMatrix,'single','seuclidean');
    if makeplot == 1
figure
subplot(1,2,1)
[H,T,perm2] = dendrogram(Z2,0);
axis square


    else
        [H,T,perm2] = dendrogram(Z2,0);
close all
        
    end

essembleMatrixPerm = essembleMatrix(perm2,perm2);

 if makeplot == 1
subplot(1,3,1)
% [H,T,~] = dendrogram(Z2,0,'colorthreshold',cutThreshold);
[H,T,~] = dendrogramBlack(Z2,0);
ylabel('Minimum distance')

axis square
 end
 
%choose number of clusters
% T = cluster(Z1,'maxclust',10)
% T = cluster(Z,'cutoff',c,'depth',d) 
T2 = cluster(Z2,'cutoff',cutThreshold,'criterion', 'distance');

clusterAssignmentGroupClusters = T2;

 if makeplot == 1
     
     title(length(unique(T2)))

subplot(1,3,2)

imagesc(essembleMatrixPerm./max(max(essembleMatrixPerm)))
axis square
colormap gray

 end
%%
%%%%%%%%%%%%%%%%% plot tsne space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mappedX = groupClusterSctructureThis(numbDist).mappedX;


uniqueClusterAssignmentGroupClusters = unique(T2);
col = jet(length(uniqueClusterAssignmentGroupClusters));

if makeplot == 1
    
subplot(1,3,3)



for h = 1 : length(uniqueClusterAssignmentGroupClusters)

    
    indThisCluster = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(h));

%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),mappedX(indThisCluster,3),'.','color',col(h,:))
    plot(mappedX(indThisCluster,1),mappedX(indThisCluster,2),'ok','MarkerFaceColor',col(h,:),'MarkerEdgeColor',col(h,:),'MarkerSize',3)

    hold on
    
end
xlabel('Dim 1')
ylabel('Dim 2')
axis square
box off
end
%%
%%%%%%%%%%%%%%%%%%%%% plot data points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignmentGroupClusters = unique(T2);

indAllDataPoints = [];

sizeOfClustersAll = zeros(1,length(clusterStructure));

for v = 1: length(clusterStructure)
    
clusterStructure(v).ClusterOfClusterCat = 0;

indThisCluster = clusterStructure(v).indsCore;

indAllDataPoints = [indAllDataPoints' indThisCluster']';

sizeOfClustersAll(v) = length(indThisCluster);

end



bigClusterVector = find([clusterStructure.BigCluster]);

if makeplot == 1

figure

end

for h = 1 : length(uniqueClusterAssignmentGroupClusters)

    
    indThisCluster = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(h));
%     indThisGroupClusters = intersect(indCoreGroupClusters,indThisCluster);
    
    indThisGroupClustersOriginal = bigClusterVector(indThisCluster);
    
    
    
    col = jet(length(indThisGroupClustersOriginal));
    
    if makeplot == 1
    subplot(4,4,h)
    plot(boutDataPCASample(indAllDataPoints,1),boutDataPCASample(indAllDataPoints,2), '.k')
    hold on
%     axis square
    axis([-20 25 -10 15])
    axis([-20 25 -10 15])
    end
    
    for hh = 1 : length(indThisGroupClustersOriginal)
    
        
    clusterStructure(indThisGroupClustersOriginal(hh)).ClusterOfClusterCat = uniqueClusterAssignmentGroupClusters(h);

        
    thisClusterOriginalInds = clusterStructure(indThisGroupClustersOriginal(hh)).thisClusterOriginalInds;
    
    if makeplot == 1
    plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color', col(hh,:))
    hold on
    end
    
    end
    
%     title(uniqueClusterAssignmentGroupClusters(h))
if makeplot == 1
        title((length(indThisGroupClustersOriginal)))
end
end

% end

%%
%%%%%%%%%%%% save stuff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% groupClusterSctructure.GroupClusyersMethod = 'essemble tsne_d';
% groupClusterSctructure.perplexity = perplexity;
% groupClusterSctructure.pointAssignmentMethodGroupClusters = pointAssignmentMethod;
% groupClusterSctructure.cutThresholdDendrogram = cutThreshold;
% groupClusterSctructure.essembleMatrixPerm = essembleMatrixPerm;
% groupClusterSctructure.essembleMatrix = essembleMatrix;
% groupClusterSctructure.essembleMatrixReorderingMethod = 'average';
% groupClusterSctructure.essembleMatrixReorderingDistance = 'seuclidean';
% groupClusterSctructure.essembleMatrixAssignment = T2;
% groupClusterSctructure.essembleMatrixLinkageResult = Z2;
% groupClusterSctructure.distributions = groupClusterSctructureThis;


