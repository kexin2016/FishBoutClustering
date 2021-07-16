% 
% clear all
% close all

 %%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse
% %%PCA_kNN4_74Kins3dim.mat
% 
% 
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));

% pause
%%
%%%%%%%%%%%%%% defien number of workers to use %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%matlabpool('close');

%close matlabpool if it is already opened
if matlabpool('size') ~= 0 % checking to see if my pool is already open
    
    matlabpool close
%     matlabpool open numberOfWorkers
    
    
end

%start matlab pool with number of corrers
matlabpool open 4



%%
%%%%%%%%%%%%%%%%%%% import mat file with indStructure %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%most of the data


clearvars -except indStructure BoutInf BoutKinematicParameters behavioralSpaceStructure boutDataPCASample


scallingFactor = 1.75;

numbOfDims = 3;
densityType = 'local';

for g = 1 : length(indStructure)
    tic
    g
   
    
    thisInds = indStructure(g).thisInds;
    thisIndRand = indStructure(g).thisIndRand;
    
%%
%%%%%%%%%%%%%% calculate densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    kdedens = kde(boutDataPCASample(thisInds,1:numbOfDims)',densityType);
%     toc
      
    originalBandWidths = getBW(kdedens);
        
    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbOfDims);
    
    densities = evaluate(kdedens,dataThisDataSetRand');

indStructure(g).kdedens =  kdedens;
indStructure(g).originalBandWidths = originalBandWidths;
indStructure(g).densities = densities;
indStructure(g).thisIndRand = thisIndRand;

%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adjustBW(kdedens,originalBandWidths);


% densityType = 'local';
makeplot = 0;
% densityType = 'local';

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT(dataThisDataSetRand,kdedens,scallingFactor,densityType,makeplot);

densitiesScalled = evaluate(kdedensCutOff,boutDataPCASample(thisIndRand,1:numbOfDims)');


indStructure(g).kdedensCutOff = kdedensCutOff;
indStructure(g).bandWidthsScalled = bandWidthsScalled;
indStructure(g).densitiesScalled = densitiesScalled;
indStructure(g).scallingFactor = scallingFactor;    
    
%%


% densityType = 'local';
linedensityMethod = 'fastPar';
resampleMethod = 'onion' ;
numextra = sqrt(length(dataThisDataSetRand));
nsamps = 10;
multirep = 10;
makeplot = 0;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

    
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,...
    funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure]...
    = findClusterCentersDensityValley_6(dataThisDataSetRand,kdedensCutOff,densityType,linedensityMethod,numextra,nsamps,...
    multirep,numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);
  

%%
%%%%%%%%%%%%%%% calculate threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
funnymeasureRandThreshold = prctile(funnymeasureRandSortedAll(:,2),95);



%%
%%%%%%%%%%%% Add variables to indStructure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indStructure(g).rho = rho;
indStructure(g).realRho = realRho;
indStructure(g).delta = delta;
indStructure(g).maxjump = maxjump;
indStructure(g).funnymeasure = funnymeasure;
indStructure(g).clusterCentersSortedIdx = clusterCentersSortedIdx;
indStructure(g).funnymeasureRandThreshold = funnymeasureRandThreshold;
    
  %%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [indChoosenClusterCenters] = decideClusterCenters_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
%  funnymeasureRandThreshold = funnymeasureRandSorterAvr(2);
%  funnymeasureRandThreshold =[];

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
%%%%%%%%%%%%%%% save choosen cluster centers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('ClusterAssignment_kNN4_74Kins3dims_1.75Smooth_fast_3000_auto.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')



