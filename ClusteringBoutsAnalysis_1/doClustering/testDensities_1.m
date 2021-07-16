


clearvars -except indStructure BoutInf BoutKinematicParameters behavioralSpaceStructure boutDataPCASample


%%
%%%%%%%%%%%%%%%% clean indStructure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for n = 1 : length(indStructure)
    
    
 indStructure2(n).thisInds = indStructure(n).thisInds ;
 indStructure2(n).dataSet = indStructure(n).dataSet;
 indStructure2(n).stimNumb = indStructure(n).stimNumb;
 indStructure2(n).thisIndRand = indStructure(n).thisIndRand;



end

indStructure = indStructure2;
clearvars indStructure2



%%
%%%%%%%%%%%%%%%%% do clusterging for example %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


g = 14

scallingFactor = 1.75;

numbOfDims = 6;
densityType = 'local';
   
    
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


% densityType = 'local';
linedensityMethod = 'fastPar';
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
%%%%%%%%%%%%%%% calculate threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% funnymeasureRandThreshold = prctile(funnymeasureRandSortedAll(:,2),95);

funnymeasureRandThreshold = [];


%%  
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indNearest = findnearest(length(thisInds),resampleNumberAll);
% funnymeasureRandThreshold = funnymeasureRandThresholdAll(indNearest);
funnymeasureRandThreshold =[];

tree = [];
decisionMethod = 'allClusterCenters';
[indChoosenClusterCenters] = decideClusterCentersAll_3(dataThisDataSetRand,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance2';

makeplot = 1;
[clusterAssignment] = assignDataPointsAllCases_1(dataThisDataSetRand,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);