 function [BoutInfThisBout] = boutCatFunctionWithDistanceToCenterCalculator_1(BoutInfThisBout,BoutKinematicParametersThisBout,meanAllVar,stdAllVar,COEFF,maxKinPars,indKinPars,meanPCASpace,numbOfK,boutDataPCASampleFinalArray,BoutInfFinalArray,distanceMethod,indClosestBoutToTheCenter,numDim)

%%
%%%%%%%%%%%%%%%%%%%%try function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% boutMapPath = 'C:\Joao analysis\BehaviorDataAnalysis_151022\FreelyMovingBehaviorAnalysis_4\assignBoutTypesUsingMap\BoutMap\BoutMap_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat';
% 
% load(boutMapPath)
% 
% BoutInfThisBout
% BoutKinematicParametersThisBout
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

[boutDataPCASample] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParametersThisBout,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);

boutDataPCASample = boutDataPCASample(:,1:numDim);

%%
%%%%%%%%%%%%%% cat new data by k neightbour %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutCatFinalArray = BoutInfFinalArray(:,EnumeratorBoutInf.boutCat);

% numbOfK = 50;
% distanceMethod = 'euclidean';
% tic
 [IDX,~] = knnsearch(boutDataPCASampleFinalArray,boutDataPCASample,'k',numbOfK,'Distance',distanceMethod);
% toc

% [IDX,D] = knnsearch(boutMapData,boutMapData,'k',numbOfK,'Distance',distanceMethod);

%find lables


knnLabels = boutCatFinalArray(IDX);

%assing points by the most frequent label
 clusterAssignmentAllData = mode(knnLabels');
% dataAssign = knnLabels;





%%
%%%%%%%%%%%%%%%% calculate distance to center bout %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutCatFinalArray = BoutInfFinalArray(:,EnumeratorBoutInf.boutCat);


thisBoutCat = unique(clusterAssignmentAllData);


%find center of this bout
boutCatOfCenters = boutCatFinalArray(indClosestBoutToTheCenter);
indThisCenter = find(boutCatOfCenters == thisBoutCat);

clusterCenterThis = boutDataPCASampleFinalArray(indClosestBoutToTheCenter(indThisCenter),:);



distToClusterCenter = pdist2(clusterCenterThis,boutDataPCASample);




%%
%%%%%%%%%%%%%%%% update BoutInfThisBout array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutInfThisBout(:,EnumeratorBoutInf.boutCat) = clusterAssignmentAllData;
BoutInfThisBout(:,EnumeratorBoutInf.distToClusterCenter) = distToClusterCenter;


