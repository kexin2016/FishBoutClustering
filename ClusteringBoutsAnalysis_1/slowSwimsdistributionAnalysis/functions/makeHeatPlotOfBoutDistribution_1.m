
function [] = makeHeatPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSet,axisVector,titleName,subplotRow,subplotCol)


figure
for i = 1:length(indDataSet)%length(indStructure)%loop through each data set
    
%      figure
% 
%       clf
subplot(subplotRow,subplotCol,i)

    thisIndRand = indStructure(indDataSet(i)).thisIndRand;
%     thisInds = indStructure(indDataSet(i)).thisInds;
    
%     funnymeasure = indStructure(indDataSet(i)).funnymeasure;
    realRho = indStructure(indDataSet(i)).realRho;
%     indChoosenClusterCenters = indStructure(indDataSet(i)).indChoosenClusterCenters;
%     clusterAssignment =  indStructure(indDataSet(i)).clusterAssignment;
%     rho = indStructure(indDataSet(i)).rho;
%     maxjump = indStructure(indDataSet(i)).maxjump;
%     pointAssignmentMethod = indStructure(indDataSet(i)).pointAssignmentMethod;
%      percentageOfClusters = indStructure(indDataSet(i)).percentageOfClusters;
%       numbOfClusters = indStructure(indDataSet(i)).numbOfClusters;
    
    
    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:3);

%     uniqueClusterAssignment = unique(clusterAssignment);
%     col = jet(length(indChoosenClusterCenters));
    
%     subplot(2,4,i)
    scatter(dataThisDataSetRand(:,1),dataThisDataSetRand(:,2),3,realRho,'filled')
    axis square
%     axis([6 20 -6 8]) 
     axis(axisVector) 
     title(titleName{i});

    box off
    xlabel('dim 1')
    ylabel('dim 2')
   %%
    
end