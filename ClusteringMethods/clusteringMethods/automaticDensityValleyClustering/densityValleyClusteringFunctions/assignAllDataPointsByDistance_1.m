
 function [clusterAssignmentAllData,coreAllData,rhoAllData, realRhoAllData] = assignAllDataPointsByDistance_1(neuralDataStructure,makeplot)


 %%
%  %%%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  makeplot = 1;
%  
%%
%%%%%%%%%%%% get variables out of structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
finalData = neuralDataStructure.finalData;
kdedens = neuralDataStructure.kdedens;
densityType = neuralDataStructure.densityType;
scallingFactor = neuralDataStructure.scallingFactor;
kdedensCutOff = neuralDataStructure.kdedensCutOff;
originalBandWidths = neuralDataStructure.originalBandWidths;
tree = neuralDataStructure.tree;
indChoosenClusterCenters = neuralDataStructure.indChoosenClusterCenters;
pointAssignmentMethod = neuralDataStructure.pointAssignmentMethod;
clusterAssignment = neuralDataStructure.clusterAssignment;
coreVector = neuralDataStructure.coreVector;
thisIndRand = neuralDataStructure.thisIndRand;
rho = neuralDataStructure.rho;
realRho = neuralDataStructure.realRho;
funnymeasure = neuralDataStructure.funnymeasure;
maxjump = neuralDataStructure.maxjump;
%%
%%%%%%%% calculate distances between all points and assigned points %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



allInds = 1 : 1 : size(finalData,1);
indsNotAssigned = allInds;
indsNotAssigned(thisIndRand) = [];

%  size(allInds,2) - size(indsNotAssigned,2)


distances = pdist2(finalData(indsNotAssigned,:),finalData(thisIndRand,:),'euclidean');

% imagesc(distances)

%%
%%%%%%%%%%%%%% Assign not assignbed points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clusterAssignmentAllData = zeros(1,length(allInds));
coreAllData = zeros(1,length(allInds));

for n = 1:size(distances,1)
%     n
    thisPointDist = distances(n,:);
    
     [~,minInd] = min(thisPointDist);
     
     thisPointClusterAssignment = clusterAssignment(minInd);
     thisPointCore = coreVector(minInd);

     thisPointRho = rho(minInd);
     thisPointRealRho = realRho(minInd);

   
     
     clusterAssignmentAllData(indsNotAssigned(n)) = thisPointClusterAssignment;
     coreAllData(indsNotAssigned(n)) = thisPointCore;
     rhoAllData (indsNotAssigned(n)) = thisPointRho;
     realRhoAllData(indsNotAssigned(n)) = thisPointRealRho;
    
end

%%
%%%%%%%%%%% Assigned already assigned points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignment = unique(clusterAssignment);

for nn = 1 : length(uniqueClusterAssignment)
    
    indThisCluster = find(clusterAssignment == uniqueClusterAssignment(nn));
    
      coreThisCluster = coreVector(indThisCluster);
    thisPointRho = rho(indThisCluster);
     thisPointRealRho = realRho(indThisCluster);

      
      
    clusterAssignmentAllData(thisIndRand(indThisCluster)) = uniqueClusterAssignment(nn);
    coreAllData(thisIndRand(indThisCluster)) = coreThisCluster;
    rhoAllData (thisIndRand(indThisCluster)) = thisPointRho;
    realRhoAllData(thisIndRand(indThisCluster)) = thisPointRealRho;
    
end



%%
%%%%%%%%%%%% look at all assignements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if makeplot == 1

uniqueClusterAssignmentAllData = unique(clusterAssignmentAllData);
col = jet(length(uniqueClusterAssignmentAllData));

figure
subplot(1,3,2)
plot3(finalData(:,1),finalData(:,2),finalData(:,3),'.','color','k')
hold on
axis square


subplot(1,3,3)
plot3(finalData(:,1),finalData(:,2),rhoAllData,'.','color','k')
hold on
axis square

for nn = 1 : length(uniqueClusterAssignmentAllData)
    
    indThisCluster = find(clusterAssignmentAllData == uniqueClusterAssignmentAllData(nn));
    
    coreThisCluster = coreAllData(indThisCluster);
    
    indCoreThisClusrer = find(coreThisCluster == 1);
    
    subplot(1,3,1)
    plot3(finalData(indThisCluster,1),finalData(indThisCluster,2),finalData(indThisCluster,3),'.','color',col(nn,:))
    hold on
    axis square
    
     subplot(1,3,2)
    plot3(finalData(indThisCluster(indCoreThisClusrer),1),finalData(indThisCluster(indCoreThisClusrer),2),finalData(indThisCluster(indCoreThisClusrer),3),'.','color',col(nn,:))
    hold on
    axis square
    
     subplot(1,3,3)
    plot3(finalData(indThisCluster,1),finalData(indThisCluster,2),rhoAllData(indThisCluster),'.','color',col(nn,:))
    hold on
    axis square
    
    
end

end

