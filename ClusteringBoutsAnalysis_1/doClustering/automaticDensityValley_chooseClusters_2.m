clear all
close all

 %%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick file of data set to analyse
%%PCA_kNN4_74Kins3dim.mat


[FileName,PathName] =  uigetfile('*.*');

load(strcat(PathName,FileName));

%%
% %%%%%%%%%%%%%% defien number of workers to use %%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %matlabpool('close');
% 
% %close matlabpool if it is already opened
% if matlabpool('size') ~= 0 % checking to see if my pool is already open
%     
%     matlabpool close
% %     matlabpool open numberOfWorkers
%     
%     
% end
% 
% %start matlab pool with number of corrers
% matlabpool open 4


% clearvars -except indStructure BoutInf BoutKinematicParameters behavioralSpaceStructure boutDataPCASample


%%
%%%%%%%%%%%%%%%%%%%%%% import control distributions %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));
% 
% 
% %example: resampleDist_Onion_Fast_1.75.mat
% funnymeasureRandThresholdAll = [referenceDistributionInf.funnymeasureRandThreshold];
% resampleNumberAll = [referenceDistributionInf.resampleNumber];

clearvars referenceDistributionInf
%%
%%%%%%%%%%%%%%%%%% do assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandWidthsScalled = indStructure(1).bandWidthsScalled;

numbOfDims =  size(bandWidthsScalled,1);

for g = 1 : length(indStructure)
    
     tic
    g
   
    
    thisInds = indStructure(g).thisInds;
    thisIndRand = indStructure(g).thisIndRand;
    
    clusterCentersSortedIdx = indStructure(g).clusterCentersSortedIdx;
    realRho = indStructure(g).realRho;
    funnymeasure = indStructure(g).funnymeasure;
    
    rho = indStructure(g).rho;
    maxjump = indStructure(g).maxjump;
    
    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbOfDims);
 
    
%%  
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indNearest = findnearest(length(thisInds),resampleNumberAll);
% funnymeasureRandThreshold = funnymeasureRandThresholdAll(indNearest);
funnymeasureRandThreshold =[];

tree = [];
decisionMethod = 'allClusterCenters';
[indChoosenClusterCenters] = decideClusterCentersAll_3(dataThisDataSetRand,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);

indStructure(g).decisionMethod = decisionMethod;
indStructure(g).indChoosenClusterCenters = indChoosenClusterCenters;
    

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance2';

makeplot = 0;
[clusterAssignment] = assignDataPointsAllCases_1(dataThisDataSetRand,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);

indStructure(g).pointAssignmentMethod = pointAssignmentMethod;
indStructure(g).clusterAssignment = clusterAssignment;

%%
%%%%%%%%%%%%%% calculate number and percentage of clusters %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

percentageOfClusters = zeros(1,length(indChoosenClusterCenters));
numbOfClusters = zeros(1,length(indChoosenClusterCenters));
uniqueClusterAssignment = unique(clusterAssignment);

   for nn = 1 : length(indChoosenClusterCenters)
          
          
        indThisCluster = find(clusterAssignment == uniqueClusterAssignment(nn));         
        percentageOfClusters(nn) = length(indThisCluster)./length(thisIndRand);
        numbOfClusters(nn) = length(indThisCluster);
          
   end


indStructure(g).percentageOfClusters = percentageOfClusters;
indStructure(g).numbOfClusters = numbOfClusters;

toc
end


%%
%%%%%%%%%%%%%%%%%% save %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 save('ClusterAssignment_kNN4_16firstHalfbeat3dim_1.75Smooth_slow_3000_auto_NoControl.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')



