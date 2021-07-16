
  function [clusterAssignmentAllData] = assignAllDataPointsByDistance_3(finalData,indsNotAssigned,thisIndRand,clusterAssignment,makeplot)


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


distances = pdist2(finalData(indsNotAssigned,:),finalData(thisIndRand,:),'euclidean');

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
    
     clusterAssignmentAllData(indsNotAssigned(n)) = thisPointClusterAssignment;
    
end

%%
%%%%%%%%%%% Assigned already assigned points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignment = unique(clusterAssignment);

for nn = 1 : length(uniqueClusterAssignment)
    
    indThisCluster = find(clusterAssignment == uniqueClusterAssignment(nn));
    

      
      
    clusterAssignmentAllData(thisIndRand(indThisCluster)) = uniqueClusterAssignment(nn);
    
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

