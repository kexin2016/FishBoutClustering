
% clear all
 close all

%%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick main folder where data set subfolders and fishMap are
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));



%%
% pointAssignmentMethodAll = {}

for n = 1 : length(dataSetStructure)
    
        n = 16
%     
    %%
    %%%%%%%%%%%% get stuff out of structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    data = dataSetStructure(n).data;
%     clusterAssignmentAll = dataSetStructure(n).clusterAssignmentAll;
    funnymeasureRandSortedAll = dataSetStructure(n).funnymeasureRandSortedAll;
    funnymeasureSorted = dataSetStructure(n).funnymeasureSorted;
    tree = dataSetStructure(n).tree;
    clusterCentersSortedIdx = dataSetStructure(n).clusterCentersSortedIdx;
    realRho = dataSetStructure(n).realRho;
    funnymeasure = dataSetStructure(n).funnymeasure;
    rho = dataSetStructure(n).rho;
    maxjump = dataSetStructure(n).maxjump;
    
    
    %%
%     %%%%%%%%%%%%%%%%%%%% do clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     kdedens = [];
% densityType = 'local';
% linedensityMethod = 'fast';
% numextra = sqrt(length(data));
% nsamps = 10;
% multirep = 0;
% numbPointsToShow = 40;
% clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
% scallingFactor = 1.1;
% resampleMethod = 'onion';
% 
% 
% 
%  makePlot1 = 1;
%  
%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
%      deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,...
%      diffFunnymeasure,jumpFunymeasure] = ...
%      findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,...
%      numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makePlot1);

    
 %%
% %%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% maxNumbOfClusterCenters = 20;
% pointAssignmentMethodDendogram = 'distance2';
% lowDensityCutOff = 0;
% 
% makePlot2 = 1;
% 
% [tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_2(data,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethodDendogram,lowDensityCutOff,clusterCentersSortedIdx,makePlot2);
% 
 
    %%
    %%%%%%%%%%% calcualte dendrogram threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [val, ind] = min(diff(funnymeasureSorted(1:100)));
    
    if ind == 1
       ind = 2 ;
    end
    
    funnymeasureBigFiffThreshold = funnymeasureSorted(ind);
    funnymeasureRandThreshold = prctile(funnymeasureRandSortedAll(:,2),95);
    
    %%
    %%%%%%%%%%%%%%%% decide cluster centers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    decisionMethod = 'allClusterCenters';
    [indChoosenClusterCenters] = decideClusterCentersAll_4(data,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureBigFiffThreshold,decisionMethod);

    
    
    %%
    %%%%%%%%%%%%%%%%%%%%% do point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     pointAssignmentMethod = pointAssignmentMethodAll{n};
    pointAssignmentMethod = 'distance2';
    
    if n == 19
            pointAssignmentMethod = 'distance';

    end
    
    makeplot = 0;
    [clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);

    dataSetStructure(n).indChoosenClusterCenters = indChoosenClusterCenters;
    dataSetStructure(n).pointAssignmentMethod = pointAssignmentMethod;
    dataSetStructure(n).clusterAssignment = clusterAssignment;
    dataSetStructure(n).funnymeasureBigFiffThreshold = funnymeasureBigFiffThreshold;

    
    figure
    subplot(1,2,1)
    uniqueClusterAssignment = unique(clusterAssignment);
    
    col = jet(length(uniqueClusterAssignment));
    
    for nn = 1 : length(uniqueClusterAssignment)
        
        indThisCluster = find(clusterAssignment == uniqueClusterAssignment(nn));
        
        plot(data(indThisCluster,1),data(indThisCluster,2),'o','color',col(nn,:),'markerfacecolor',col(nn,:),'markersize',3)
        hold on
    
    end
    axis square
%     axis equal
    box off
%     axis([-25 25 0 50])
%     axis off
        

    subplot(1,2,2)
    H = dendrogramBlack(tree,0)
    hold on
    line([0  size(tree,1)+2],[funnymeasureBigFiffThreshold funnymeasureBigFiffThreshold], 'color','red')
    line([0  size(tree,1)+2],[funnymeasureRandThreshold funnymeasureRandThreshold], 'color','green')
    axis([0 size(tree,1) + 2 0 1])
    axis square
    ylabel('Separability index')
%     title(length(uniqueClusterAssignment))
    
end