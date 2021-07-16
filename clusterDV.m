function [clusterAssignment] = clusterDV(X,numbOfDims)
sizeOfdata1 = size(X,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%2nd part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%
scallingFactor = 1.75;
densityType = 'local';

   
    thisInds = randperm(size(X,1),min(floor(0.7*size(X,1)),10000));
    thisIndRand = 1:size(X,1);
    
%%
%%%%%%%%%%%%%% calculate densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    kdedens = kde(X(thisInds,1:numbOfDims)',densityType);
%     toc
      
    originalBandWidths = getBW(kdedens);
        
    dataThisDataSetRand = X(thisIndRand, 1:numbOfDims);
    
    densities = evaluate(kdedens,dataThisDataSetRand');
%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adjustBW(kdedens,originalBandWidths);


% densityType = 'local';
makeplot = 1;
% densityType = 'local';

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT(dataThisDataSetRand,kdedens,scallingFactor,densityType,makeplot);

densitiesScalled = evaluate(kdedensCutOff,X(thisIndRand,1:numbOfDims)');  
    
%%


% densityType = 'local';
linedensityMethod = 'fastPar';
resampleMethod = 'onion' ;
numextra = sqrt(length(dataThisDataSetRand));
nsamps = 10;
multirep = 10;
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
funnymeasureRandThreshold = prctile(funnymeasureRandSortedAll(:,2),95);


tree = [];
decisionMethod = 'allClusterCenters';
[indChoosenClusterCenters] = decideClusterCentersAll_3(dataThisDataSetRand,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);
%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance2';

makeplot = 0;
[clusterAssignment] = assignDataPointsAllCases_1(dataThisDataSetRand,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);
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

end

