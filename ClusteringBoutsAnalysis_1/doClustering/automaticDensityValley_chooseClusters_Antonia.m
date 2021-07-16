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
% 
clearvars -except indStructure BoutInf BoutKinematicParameters behavioralSpaceStructure boutDataPCASample


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
%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);


 mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);

indMistakes = find(mistakesIn74KinSpace == 1);

indBadBouts = unique([indBadBouts',indMistakes']');

indGoodBouts = 1 : length(boutDataPCASample);

indGoodBouts(indBadBouts) = [];


%%
%%%%%%%%%%%%%%%%%%%%% create indStructure test%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%make ind structure for data I want to analyse


makeplot =1;


[indStructure] = indStructureCreator_Antonia_AllData(BoutInf,indGoodBouts,boutDataPCASample,makeplot);

%%
%%%%%%%%%%%%% look at size of data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sizeOfDataSet = zeros(1,length(indStructure));
sizeOfDataSetRand = zeros(1,length(indStructure));

for g =  1 : length(indStructure)

    
thisInds = indStructure(g).thisInds;
thisIndRand = indStructure(g).thisIndRand;

sizeOfDataSet(g) = length(thisInds);
sizeOfDataSetRand(g) = length(thisIndRand);

end
 


%%
%%%%%%%%%%%%%%%%%% do assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bandWidthsScalled = indStructure(1).bandWidthsScalled;
% 
% numbOfDims =  size(bandWidthsScalled,1);
numbOfDims =  3;
scallingFactor = 1.75;
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
%%%%%%%%%%%%%%%%% calculate funnykeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% densityType = 'local';
linedensityMethod = 'slowPar';
resampleMethod = 'onion' ;
numextra = sqrt(length(dataThisDataSetRand));
nsamps = 10;
multirep = 0;
makeplot = 0;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

    
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,...
    funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure]...
    = findClusterCentersDensityValley_6(dataThisDataSetRand,kdedensCutOff,densityType,linedensityMethod,numextra,nsamps,...
    multirep,numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);
  
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

 save('ClusterAssignment_isolationLight_74Kins3dim_slow_3000_auto_NoControl.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')



