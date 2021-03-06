function [clusterAssignmentAllData] = finalClustering_KnearestNeighbour_fromEssembleTSNE_function_1(boutDataPCASample,clusterStructure,clusterAssignmentGroupClusters,indGoodBouts,numbOfDims,makeplot)
%%
%%%%%%%%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numbOfDims
% indGoodBouts
% clusterAssignmentGroupClusters
% clusterStructure
% boutDataPCASample
% makeplot = 1;

%%
%%%%%%%%%%%%%%%%%%%%%% get stuff out of structure %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);
idx = 1:length(uniqueClusterAssignmentGroupClusters);

col = jet(length(uniqueClusterAssignmentGroupClusters));







%%
%%%%%%%%%%%% get size of each small cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


indAllDataPoints = [];

sizeOfClustersAll = zeros(1,length(clusterStructure));

for v = 1: length(clusterStructure)
    

indThisCluster = clusterStructure(v).indsCore;

indAllDataPoints = [indAllDataPoints' indThisCluster']';

sizeOfClustersAll(v) = length(indThisCluster);

end




%%
%%%%%%%%%%%% make ind struct with types of cluster together %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ClusterOfClusterCatAll = [clusterStructure.ClusterOfClusterCat];

uniqueClusterOfClusterCatAll = unique(ClusterOfClusterCatAll);
uniqueClusterOfClusterCatAll(uniqueClusterOfClusterCatAll == 0) =[];


sizeOfBigClusters = zeros(1,length(uniqueClusterOfClusterCatAll));
indGroupCluster = [];
indGroupClusterCat = [];
indGroupClusterVector = [];

for nn = 1 : length(uniqueClusterOfClusterCatAll)
    
%     nn =4
   
         indsInclusterStructure = find(ClusterOfClusterCatAll == uniqueClusterOfClusterCatAll(idx(nn)));
         
         thisClusterOriginalIndsAll = [];
         
         for n = 1 : length(indsInclusterStructure)
%       n =1    
       thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).indsCore;
       thisClusterOriginalIndsAll = [thisClusterOriginalIndsAll' thisClusterOriginalInds']';
       
       
       
       
         end
         
         %reassign bouts with maxBoutFreqCorr < 40 that are in fast bouts

         indGroupCluster(nn).indsAll = thisClusterOriginalIndsAll;
         
          sizeOfBigClusters(nn) = length(thisClusterOriginalIndsAll);
         
         
        
end

%%
%%%%%%%%%%%%%% make data set to cluster by picking min number of points%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbToSample = min(sizeOfBigClusters);
thisIndRandFinalAll = [];
finalDataCat = [];  

if makeplot == 1
figure
end

for i = 1: length(indGroupCluster)
    
    
    indsCore = indGroupCluster(i).indsAll;
    
    indPerm1 = randperm(length(indsCore));
    thisIndRand = indsCore(indPerm1(1:numbToSample));
    thisIndRand2 = thisIndRand;
    
    if makeplot == 1
    subplot(1,2,1)  
%     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), boutDataPCASample(thisIndRand,3),'.','color', 'k')
    hold on
    plot3(boutDataPCASample(thisIndRand2,1),boutDataPCASample(thisIndRand2,2), boutDataPCASample(thisIndRand2,3),'.','color', col(i,:))
    hold on
    axis square
    
    end
    %concatenate vectors
    thisIndRandFinalAll = [thisIndRandFinalAll' thisIndRand2']';
    finalDataCat =  [finalDataCat (zeros(1, length(thisIndRand2)) + i)];
    
     
%      pause
end



    finalData = boutDataPCASample(thisIndRandFinalAll,1:numbOfDims);
    % size(finalData)

%%
%%%%%%%%%%%%% do k nearest search for bout map %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbOfK = 50;
distanceMethod = 'euclidean';
tic
 [IDX,D] = knnsearch(finalData,finalData,'k',numbOfK,'Distance',distanceMethod);
toc

knnLabels = finalDataCat(IDX);

 clusterAssignmentAllData = mode(knnLabels');

 
 %%
%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueDataAssing = unique(clusterAssignmentAllData);

% figure

sizeOfClusters = zeros(1,length(uniqueDataAssing));


    
for n = 1 : length(uniqueDataAssing)

     indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing(n));
     
     indThisClusterInAllData = thisIndRandFinalAll(indThisCluster);
% if makeplot == 1
%      subplot(1,2,2)
%     plot3(boutDataPCASample(indThisClusterInAllData,1),boutDataPCASample(indThisClusterInAllData,2), boutDataPCASample(indThisClusterInAllData,3),'.','color', col(n,:))
%     hold on
%     axis square
%     axis([-20 25 -10 20 -10 10])
% 
% end
        
    sizeOfClusters(n) = length(indThisClusterInAllData);

end


%%
%%%%%%%%%%%%% put same number in bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minSizeOfCusters = min(sizeOfClusters);

sizeOfClusters = zeros(1,length(uniqueDataAssing));

indThisClusterInAllDataAll = [];
clusterAssignmentInAllData = [];

for n = 1 : length(uniqueDataAssing)
    
   indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing(n));

    
    
    indPerm1 = randperm(length(indThisCluster));
    thisIndRand = indThisCluster(indPerm1(1:minSizeOfCusters));
    
    indThisClusterInAllData = thisIndRandFinalAll(thisIndRand);
    
    if makeplot == 1
          subplot(1,2,2)

    plot3(boutDataPCASample(indThisClusterInAllData,1),boutDataPCASample(indThisClusterInAllData,2), boutDataPCASample(indThisClusterInAllData,3),'.','color', col(n,:))
    hold on
    axis square
    
    end    
         
    indThisClusterInAllDataAll = [indThisClusterInAllDataAll' indThisClusterInAllData']';
    clusterAssignmentInAllData = [clusterAssignmentInAllData (zeros(1,length(indThisClusterInAllData)) + uniqueDataAssing(n)) ];     
    sizeOfClusters(n) = length(indThisClusterInAllData);

end

%%
%%%%%%%%%%%%%%%%%%%%%%%%% assign all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
finalData = boutDataPCASample(indThisClusterInAllDataAll,1:numbOfDims);


% numbOfK = 50;
% distanceMethod = 'euclidean';
tic
 [IDX,D] = knnsearch(finalData,boutDataPCASample(:,1:numbOfDims),'k',numbOfK,'Distance',distanceMethod);
toc
% [IDX,D] = knnsearch(finalData,finalData,'k',numbOfK,'Distance',distanceMethod);

%find lables


knnLabels = clusterAssignmentInAllData(IDX);

%assing points by the most frequent label
 clusterAssignmentAllData = mode(knnLabels');
% dataAssign = knnLabels;

%%
%%%%%%%%%%%%%% plot assinged data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


uniqueDataAssing = unique(clusterAssignmentAllData);
countBouts = 0;

if makeplot == 1
figure
end

for n = 1 : length(uniqueDataAssing)
    
%   n =4
indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing((n)));
    
indThisClusterGood = intersect(indGoodBouts,indThisCluster);
    
indThisClusterGood2 = indThisClusterGood;
   

if makeplot == 1

 plot3(boutDataPCASample(indThisClusterGood,1),boutDataPCASample(indThisClusterGood,2), boutDataPCASample(indThisClusterGood,3), '.','color', col(n,:))
 hold on

    hold on
    
    axis square
    axis([-20 25 -10 20 -10 10])

end
    countBouts = countBouts + length(boutDataPCASample);

end

