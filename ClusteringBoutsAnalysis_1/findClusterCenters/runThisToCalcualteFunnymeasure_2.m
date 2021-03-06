
n = indDataSet;

scallingFactor = 1.1;

densityType = 'local';




%%
%%%%%%%%%%%% find number of dimentions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandWidthsScalled2 = indStructure(1).bandWidthsScalled;

numbOfDims =  size(bandWidthsScalled2,1);




%%


 
    %get inf from indStructure
    thisIndRand = indStructure(n).thisIndRand;
    thisInds = indStructure(n).thisInds;
    

%%
%%%%%%%%%%%%%% calculate densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    kdedens = kde(boutDataPCASample(thisInds,1:numbOfDims)',densityType);
%     toc
      
    originalBandWidths = getBW(kdedens);
        
    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbOfDims);
    
    densities = evaluate(kdedens,dataThisDataSetRand');

%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adjustBW(kdedens,originalBandWidths);


% densityType = 'local';
makeplot = 0;
% densityType = 'local';

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT(dataThisDataSetRand,kdedens,scallingFactor,densityType,makeplot);

densitiesScalled = evaluate(kdedensCutOff,boutDataPCASample(thisIndRand,1:numbOfDims)');

%%
%%%%%%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% densityType = 'local';
linedensityMethod = 'slowPar';
resampleMethod = 'onion' ;
numextra = sqrt(length(dataThisDataSetRand));
nsamps = 10;
multirep = 0;
makeplot = 1;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

    
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,...
    funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure]...
    = findClusterCentersDensityValley_6(dataThisDataSetRand,kdedensCutOff,densityType,linedensityMethod,numextra,nsamps,...
    multirep,numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);
  

%%
%%%%%%%%%%%%% look at cluster centers by square  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tree = [];
% [indChoosenClusterCenters] = decideClusterCenters_2(dataThisDataSetRand,tree,clusterCentersSortedIdx,realRho,funnymeasure)
 decisionMethod = 'square';
% decisionMethod = 'dendrogram';
% decisionMethod = 'allClusterCenters';
%  decisionMethod = 'allExcludeOutliers';
funnymeasureRandThreshold =[];

[indChoosenClusterCenters] = decideClusterCentersAll_3(dataThisDataSetRand,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);
indChoosenClusterCenters

    


%%
%%%%%%%%%%%%%%%% save stuff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indStructure(n).kdedens =  kdedens;
indStructure(n).originalBandWidths = originalBandWidths;
indStructure(n).densities = densities;
indStructure(n).thisIndRand = thisIndRand;

indStructure(n).kdedensCutOff = kdedensCutOff;
indStructure(n).bandWidthsScalled = bandWidthsScalled;
indStructure(n).densitiesScalled = densitiesScalled;
indStructure(n).scallingFactor = scallingFactor;    
    
indStructure(n).rho = rho;
indStructure(n).realRho = realRho;
indStructure(n).delta = delta;
indStructure(n).maxjump = maxjump;
indStructure(n).funnymeasure = funnymeasure;
indStructure(n).clusterCentersSortedIdx = clusterCentersSortedIdx;
indStructure(n).funnymeasureRandThreshold = funnymeasureRandThreshold;


