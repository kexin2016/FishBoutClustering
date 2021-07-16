
  function [clusterAssignmentAllData] = assignAllDataPointsByDistance_4(finalData,mapData,clusterAssignment,makeplot)


 %%
%  %%%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  makeplot = 1;
%  
% thisIndRand = clusterMapOriginalInds;
%%
%%%%%%%% calculate distances between all points and assigned points %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%  size(allInds,2) - size(indsNotAssigned,2)


distances = pdist2(finalData,mapData,'euclidean');

% imagesc(distances)

%%
%%%%%%%%%%%%%% Assign not assignbed points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clusterAssignmentAllData = zeros(1,length(finalData));
coreVectorAllData = zeros(1,length(finalData));

for n = 1:size(distances,1)
%     n
    thisPointDist = distances(n,:);
    
     [~,minInd] = min(thisPointDist);
     
     thisPointClusterAssignment = clusterAssignment(minInd);
    
     clusterAssignmentAllData(n) = thisPointClusterAssignment;
    
end





%%
%%%%%%%%%%%% look at all assignements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if makeplot == 1

uniqueClusterAssignmentAllData = unique(clusterAssignmentAllData);
col = jet(length(uniqueClusterAssignmentAllData));



figure

for nn = 1 : length(uniqueClusterAssignmentAllData)
    
    indThisCluster = find(clusterAssignmentAllData == uniqueClusterAssignmentAllData(nn));
    

    
   
    plot3(finalData(indThisCluster,1),finalData(indThisCluster,2),finalData(indThisCluster,3),'.','color',col(nn,:))
    hold on
    axis square
    
  
    
   
    
    
end

end

