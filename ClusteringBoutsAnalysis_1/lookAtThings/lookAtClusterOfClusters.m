%%
% %%%%%%%%%% make core for each cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% percentOfHalo = 15;
% for n = 1:length(clusterStructure)
% 
%     
%     
%     thisClusterOriginalInds = clusterStructure(n).thisClusterOriginalInds;
%     
%      if length(thisClusterOriginalInds) > 2%avoid cluster with 1 point
%        densityType = 'rot';
%        
%        tic
%        kdedensThisCluster = kde( boutDataPCASample(thisClusterOriginalInds,1:3)',densityType);
%        
%        densitiesThisCluster = evaluate(kdedensThisCluster,boutDataPCASample(thisClusterOriginalInds,1:3)');
%        toc
%        percentile = prctile(densitiesThisCluster,percentOfHalo);%15 works fine
%     
%        indsCore = find(densitiesThisCluster > percentile);
%        
%        indsCore2 = thisClusterOriginalInds(indsCore);
%        
%        else
%     
%        indsCore2 = thisClusterOriginalInds;
%      end
%         
%      clusterStructure(n).indsCore = indsCore2;
%     
% end
% 
% 
% 
 %%
% %%%%%%%%%%%%% look at group of clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% indAllDataPoints = [];
% sizeOfClustersAll = zeros(1,length(clusterStructure));
% 
% for v = 1: length(clusterStructure)
%     
% clusterStructure(v).ClusterOfClusterCat = 0;
% 
% indThisCluster = clusterStructure(v).indsCore;
% 
% indAllDataPoints = [indAllDataPoints' indThisCluster']';
% 
% sizeOfClustersAll(v) = length(indThisCluster);
% 
% end
% 
% 
% bigClusterVector = find([clusterStructure.BigCluster]);
% 
%  indCoreGroupClusters = find(coreAssignmentGroupOfClusters);
% % indCoreGroupClusters = 1:1:length(coreAssignmentGroupOfClusters);
% 
% figure
% for h = 1 : length(uniqueClusterAssignment)
% 
%     
%     indThisCluster = find(clusterAssignment == uniqueClusterAssignment(h));
%     indThisGroupClusters = intersect(indCoreGroupClusters,indThisCluster);
%     
%     indThisGroupClustersOriginal = bigClusterVector(indThisGroupClusters);
%     
%     
%     
%     col = jet(length(indThisGroupClustersOriginal));
%     
%     subplot(4,3,h)
%     plot(boutDataPCASample(indAllDataPoints,1),boutDataPCASample(indAllDataPoints,2), '.k')
%     hold on
%     
%     for hh = 1 : length(indThisGroupClustersOriginal)
%     
%         
%     clusterStructure(indThisGroupClustersOriginal(hh)).ClusterOfClusterCat = uniqueClusterAssignment(h);
% 
%         
%     thisClusterOriginalInds = clusterStructure(indThisGroupClustersOriginal(hh)).thisClusterOriginalInds;
%     
%    plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color', col(hh,:))
%     hold on
%     end
%     title(uniqueClusterAssignment(h))
%     
% end

%%
% ClusterOfClusterCatAll2
figure
h=13
    indsInclusterStructure = find(ClusterOfClusterCatAll == uniqueClusterOfClusterCatAll(h));
    
    
    
    
    
    col = jet(length(indsInclusterStructure));
    
%     subplot(4,3,h)

    
    
    for hh = 1 : length(indsInclusterStructure)
    clf
        
    clusterStructure(indsInclusterStructure(hh)).ClusterOfClusterCat = uniqueClusterOfClusterCatAll(h);

        
    thisClusterOriginalInds = clusterStructure(indsInclusterStructure(hh)).indsCore;
    plot(boutDataPCASample(indAllDataPoints,1),boutDataPCASample(indAllDataPoints,2), '.k')
    hold on
   plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color', col(hh,:))
    hold on
    title(indsInclusterStructure(hh))

    pause
    
    end

