

%%
% %%%%%%%%%%%%%%%%% count big clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % figure
% bigClustersCount = zeros(1,length(clusterStructure));
% for nn = 1 : length(clusterStructure)
% 
%     
%         BigCluster = clusterStructure(nn).BigCluster;
%         
%         if BigCluster == 1
% 
%             thisClusterOriginalInds = clusterStructure(nn).thisClusterOriginalInds;
% % clf 
% %         plot(boutDataPCASample(thisClusterOriginalIndsAll,1),boutDataPCASample(thisClusterOriginalIndsAll,2), '.k')
% %         hold on
% %         plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.r')
% % title(nn)
% %     pause
%          bigClustersCount(nn) = 1; 
% 
%        end
% end
% 
% indBigClusters = find(bigClustersCount == 1);


%%
% %%%%%%%%%%%%%%%%%% get inds of all data points %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % figure
% indAllDataPoints = [];
% for n = 1 : length(indBigClusters)
%    
%   %get inds of cluster 1
%  thisClusterOriginalInds = clusterStructure(indBigClusters(n)).indsCore;  
%     
% %     plot3(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2),boutDataPCASample(thisClusterOriginalInds,3), '.', 'color','k')
% %     hold on
%      indAllDataPoints = [indAllDataPoints' thisClusterOriginalInds']';
% %     title(length(indBigClusters))
% %     axis square
% end
% 





%%
% %%%%%%%%%%% look at clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ClusterOfClusterCatAll = [clusterStructure.ClusterOfClusterCat];
% uniqueClusterOfClusterCatAll = unique(ClusterOfClusterCatAll);
% 
% 
% sizeOfGroupOfClusters = zeros(1,(length(uniqueClusterOfClusterCatAll)));
% 
% figure
%  for nn = 2:length(uniqueClusterOfClusterCatAll)
% % nn =2    
%      indsInclusterStructure = find(ClusterOfClusterCatAll == uniqueClusterOfClusterCatAll(nn));
% %  inds = indAll(nn).inds;
% 
% 
% % indsInclusterStructure = indBigClusters(inds);
% 
% subplot(2,6,nn-1)
%  plot(boutDataPCASample(indAllDataPoints,1),boutDataPCASample(indAllDataPoints,2), '.k')
% hold on
% 
% col = jet(length(indsInclusterStructure));
% 
% thisGroupAllInds = [];
% for n = 1 : length(indsInclusterStructure)
%     
% thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).thisClusterOriginalInds;
%    thisGroupAllInds = [thisGroupAllInds'  thisClusterOriginalInds']';
%    
% % plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color','c')
% 
% plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color',col(n,:))
% 
% hold on
% 
% 
% 
% end
% axis([-17 22 -10 20])     
% axis square
% 
% sizeOfGroupOfClusters(nn) = length(thisGroupAllInds);
% 
% title(strcat({num2str(length(indsInclusterStructure))},{' '}, {num2str(sizeOfGroupOfClusters(nn))}))
% 
% 
%  end
% 
% sizeOfGroupOfClusters(1) = [];

 %%
 %%%%%%%%%%%%%%%%%%%% look at components of each group of clusters %%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ClusterOfClusterCatAll = [clusterStructure.ClusterOfClusterCat];
uniqueClusterOfClusterCatAll = unique(uniqueClusterOfClusterCatAll);

 uniqueClusterOfClusterCatAll(uniqueClusterOfClusterCatAll == 0) = [];
 
nnn = 8;
 
indsInclusterStructure = find(ClusterOfClusterCatAll == uniqueClusterOfClusterCatAll(nnn));
col = jet(length(indsInclusterStructure));

figure
for n = 1 : length(indsInclusterStructure)
    clf
thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).indsCore;
bigDataSetNumber = clusterStructure(indsInclusterStructure(n)).bigDataSetNumber;



dataSet = indStructure(bigDataSetNumber).dataSet;
 
 
%plot all poinds
 plot(boutDataPCASample(indAllDataPoints,1),boutDataPCASample(indAllDataPoints,2), '.k')
 hold on  


%plot this cluster
plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color',col(n,:))
 hold on 
axis([-17 22 -10 20])     
axis square
% title(strcat({num2str(bigDataSetNumber)},{' '},{(dataSet)}))
 title(indsInclusterStructure(n))
 pause
end
  
  
 
%%



% 
% % figure
% % for h = 1 : length(uniqueClusterAssignment)
% numbGroupOfCluster =2
%     
%     indThisCluster = find(clusterAssignment == numbGroupOfCluster);
%     indThisGroupClusters = intersect(indCoreGroupClusters,indThisCluster);
%     
%     indThisGroupClustersOriginal = bigClusterVector(indThisGroupClusters);
%     
%     
%     
%     col = jet(length(indThisGroupClustersOriginal));
%     
%     subplot(4,3,h)
%     
%     
%     for hh = 1 : length(indThisGroupClustersOriginal)
%     clf
%         
%     clusterStructure(indThisGroupClustersOriginal(hh)).ClusterOfClusterCat = uniqueClusterAssignment(h);
% 
%         
%     thisClusterOriginalInds = clusterStructure(indThisGroupClustersOriginal(hh)).thisClusterOriginalInds;
%     
%     plot(boutDataPCASample(indAllDataPoints,1),boutDataPCASample(indAllDataPoints,2), '.k')
%     hold on
%     plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color', col(hh,:))
%     hold on
%     
%     title(indThisGroupClustersOriginal(hh))
%     
%     pause
%     end
%     
% % end