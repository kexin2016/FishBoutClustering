



%%
%%%%%%%% indStructure map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indOMRTurns2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.OMRTurns2))';%1-13
% indOMRSpeed5 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.OMRSpeed5))';%14-23
% 
% indLightDark3min2 =  intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LightDark3min2))';%24-27
% 
% indMultiFlash3min1sManyInt = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt))';%28 dark; 29 light
% indMultiFlash3min1sManyInt3 =  intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt3))';%30 dark; 31 light
% 
% indmultiBeap200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap200Hz100ms3min))';%32
% indmultiBeap400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap400Hz100ms3min))';%33
% indmultiBeap600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap600Hz100ms3min))';%34
% indmultiBeap800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap800Hz100ms3min))';%35
% indmultiBeap1000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1000Hz100ms3min))';%36
% indmultiBeap1200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1200Hz100ms3min))'; %37
% indmultiBeap1400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1400Hz100ms3min))';%38
% indmultiBeap1600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1600Hz100ms3min))'; %39
% indmultiBeap1800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1800Hz100ms3min))';%40
% indmultiBeap2000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap2000Hz100ms3min))'; %41
% indmultiBeapFlash200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash200Hz100ms3min))'; %42
% indmultiBeapFlash400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash400Hz100ms3min))';%43
% indmultiBeapFlash600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash600Hz100ms3min))'; %44
% indmultiBeapFlash800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash800Hz100ms3min))';%45
% indmultiBeapFlash1000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1000Hz100ms3min))';%46
% indmultiBeapFlash1200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1200Hz100ms3min))';%47
% indmultiBeapFlash1400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1400Hz100ms3min))';%48
% indmultiBeapFlash1600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1600Hz100ms3min))';%49
% indmultiBeapFlash1800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1800Hz100ms3min))';%50
% indmultiBeapFlash2000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash2000Hz100ms3min))';%51
% 
% indBeeps200to2000 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.Beeps200to2000))';%32 - 51
% indFlashBeeps200to2000 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.FlashBeeps200to2000))';%32 - 51
% 
% indPhototaxis4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.Phototaxis4))';%52 with obends; 53 no obends
% 
% indPreyCapture = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCapture))';%54-55
% indPreyCaptureNaive = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCaptureNaive))';%56-57
% indSpontanousEyeTracking = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontanousEyeTracking))';%58-59
% 
% indBeepsLightDarkEyeConv = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.BeepsLightDarkEyeConv))';%60 - 64
% indBigCircleDiferentDirections2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.bigCircleDiferentDirections2))';%65 to 72
% indLoomingDiferentSpeeds = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LoomingDiferentSpeeds))';%73 to 78

% %multiFish data
% indSpontaneousMultiFishGray = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishGray))';%79 - 82
% indSpontaneousMultiFishBlack2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishBlack2))';%83 to 86
% 
% 
%%
%%%%%%%%%%%% find number of dimentions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandWidthsScalled2 = indStructure(1).bandWidthsScalled;

numbOfDims =  size(bandWidthsScalled2,1);




%%

n = indDataSet;


% for n = 1 : length(indDataSet)

% n = indDataSet
% close all

% numbOfDims = 3;


% %      
     
    %get inf from indStructure
    thisIndRand = indStructure(n).thisIndRand;
    thisInds = indStructure(n).thisInds;

    funnymeasure = indStructure(n).funnymeasure;
    realRho = indStructure(n).realRho;
    clusterCentersSortedIdx = indStructure(n).clusterCentersSortedIdx;
    rho = indStructure(n).rho;
    maxjump = indStructure(n).maxjump;
    originalBandWidths = indStructure(n).originalBandWidths;
    kdedens= indStructure(n).kdedens;

%     if length(thisIndRand) <  length(thisInds)
        
    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbOfDims);
    
%     else
%         
%           dataThisDataSetRand = boutDataPCASample(thisInds(thisIndRand), 1:numbOfDims);
% 
%     end


  
    %%
%     figure
%     plot3(dataThisDataSetRand(:,1),dataThisDataSetRand(:,2),realRho,'.')
%     axis([-17 22 -10 20 0 max(realRho)])
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

    
      
%                                                                  indChoosenClusterCenters = [indChoosenClusterCenters  912]
         

figure
plot3(dataThisDataSetRand(:,1),dataThisDataSetRand(:,2),realRho,'.')
hold on
plot3(dataThisDataSetRand(indChoosenClusterCenters,1),dataThisDataSetRand(indChoosenClusterCenters,2),realRho(indChoosenClusterCenters),'ro')
    axis([-17 22 -10 20 0 max(realRho)])
    
% % pause   
%%    
% %%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        pointAssignmentMethod = 'pooledDensity2';
% %                                          pointAssignmentMethod = 'distance';
%                                           pointAssignmentMethod = 'distance2';
% 
% 
% makeplot = 1;
% tic
% [clusterAssignment] = assignDataPointsAllCases_1(dataThisDataSetRand,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);
% toc 

% pause
% end