function [BoutInf] = boutCatFunctionWithDistanceToCenterCalculator_2(BoutInf,BoutKinematicParameters,meanAllVar,stdAllVar,COEFF,maxKinPars,indKinPars,meanPCASpace,numbOfK,boutMapData,distanceMethod,mapAssignment,indClosestBoutToTheCenter)

%%
%%%%%%%%%%%%%%%%%%%%try function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% boutMapPath = 'C:\Joao analysis\BehaviorDataAnalysis_151022\FreelyMovingBehaviorAnalysis_4\assignBoutTypesUsingMap\BoutMap\BoutMap_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat';
% 
% load(boutMapPath)
% 
% BoutInf
% BoutKinematicParameters
% 
% 
% 
% %get vars out of structure
% meanAllVar
% stdAllVar
% COEFF 
% latent
% maxKinPars 
% indKinPars
% meanPCASpace 
% 
% 
% 
% numbOfK 
% boutMapData 
% distanceMethod
% mapAssignment

%%
%%%%%%%%%%%% put bout in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[boutDataPCASample] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParameters,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);

boutDataPCASample = boutDataPCASample(:,1:size(boutMapData,2));

%%
%%%%%%%%%%%%%% cat new data by k neightbour %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% numbOfK = 50;
% distanceMethod = 'euclidean';
% tic
 [IDX,~] = knnsearch(boutMapData,boutDataPCASample,'k',numbOfK,'Distance',distanceMethod);
% toc

% [IDX,D] = knnsearch(boutMapData,boutMapData,'k',numbOfK,'Distance',distanceMethod);

%find lables


knnLabels = mapAssignment(IDX);

%assing points by the most frequent label
 clusterAssignmentAllData = mode(knnLabels');
% dataAssign = knnLabels;


%%
%%%%%%%%%%%%%%%%%%% calcualte distances to center bout %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distToClusterCenter = zeros(1,length(clusterAssignmentAllData));
for n  = 1 : length(clusterAssignmentAllData)

    
    indClosestBoutToTheCenterThisBout = indClosestBoutToTheCenter(clusterAssignmentAllData(n));
    
    
centerBoutThis = boutMapData(indClosestBoutToTheCenterThisBout,:);
distToClusterCenter(n) = pdist2(centerBoutThis,boutDataPCASample(n,1:size(boutMapData,2)));



end



%%
%%%%%%%%%%%%%%%% update BoutInf array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutInf(:,EnumeratorBoutInf.boutCat) = clusterAssignmentAllData;
BoutInf(:,EnumeratorBoutInf.distToClusterCenter) = distToClusterCenter;
