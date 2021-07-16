% AddFunctionToPath

% close all
% clear all
% 

%%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse ROC_PreliminaryData74Kins3dimWithCutOffMedium_moreDivided
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));


%load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');


%%
%%%%%%%%%%%%% define order of bout types %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% idx = [10 2 9 7 5 4 1 6 11 8 3];

%%
%%%%%%%%%%%%%%%% define color map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;


%%
%%%%%%%%%%%%% plot bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

finalData = finalClustering.dataToDoMap;
mapAssignment = finalClustering.assignment;
indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;

uniqueBoutType = unique(mapAssignment);
% col = jet(length(uniqueBoutType));

figure
for h = 1 : length(uniqueBoutType)
    
    indThisBoutType = find(mapAssignment == uniqueBoutType((h)));
    
%     plot3(finalData(indThisBoutType,1),finalData(indThisBoutType,2),finalData(indThisBoutType,3),'.','color',col(h,:))
    plot(finalData(indThisBoutType,1),finalData(indThisBoutType,2),'.','color',col(h,:))
    hold on
%    pause 
end
axis square

%%
%%%%%%%%%%%%%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);

indKinSpaceMistake = find(mistakesIn74KinSpace);

indExcludedBoutsAll  = unique([indBadBouts' indKinSpaceMistake']');

indGoodBouts = 1 : length(BoutInf);
indGoodBouts(indExcludedBoutsAll) = [];


% BoutKinematicParametersGood = BoutKinematicParameters(indGoodBouts,:);
% BoutInfGood  = BoutInf(indGoodBouts,:);




%%
%%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%get vars out of structure
meanAllVar = behavioralSpaceStructure.meanAllVar;
stdAllVar = behavioralSpaceStructure.stdAllVar;
COEFF = behavioralSpaceStructure.COEFF;
latent = behavioralSpaceStructure.latent;
maxKinPars = behavioralSpaceStructure.maxKinPars;
indKinPars = behavioralSpaceStructure.indKinPars;
meanPCASpace = behavioralSpaceStructure.meanPCASpace;


[boutDataPCASampleAll] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParameters,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);

%%
%%%%%%%%%%%% plot bout types per PC dimention %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
uniqueBoutCat = unique(boutCat);

nBins = 50;
edgeSpace = 1;

xAxisVector(:,1) = [-18,25];
xAxisVector(:,2) = [-10,15];
xAxisVector(:,3) = [-10,10];
xAxisVector(:,4) = [-10,8];
xAxisVector(:,5) = [-8,8];
xAxisVector(:,6) = [-6,8];

xvector = zeros(nBins,size(xAxisVector,2));

for i = 1 : size(xAxisVector,2)
    
    xvector(:,i) = linspace(xAxisVector(1,i)-edgeSpace,xAxisVector(2,i)+edgeSpace,nBins);
    
end


xlabelName = [];
xlabelName{1} = 'PC 1';
xlabelName{2} = 'PC 2';
xlabelName{3} = 'PC 3';
xlabelName{4} = 'PC 4';
xlabelName{5} = 'PC 5';
xlabelName{6} = 'PC 6';

for nn = 1 : 6
    
    subplot(2,3,nn)
% nn = 1


[nThisBoutType, ~] = hist(boutDataPCASampleAll(:,nn),xvector(:,nn));
%      plot(xvector(:,nn),nThisBoutType/sum(nThisBoutType), '-', 'color','k')
% hold on

maxProbAll = zeros(1, length(uniqueBoutCat));

for n  =  1 : length(uniqueBoutCat)

%     n =1
    indThisBoutType = find(boutCat == uniqueBoutCat((n)));
      indThisBoutTypeGood = intersect(indThisBoutType,indGoodBouts);
      
     [nThisBoutType, ~] = hist(boutDataPCASampleAll(indThisBoutTypeGood,nn),xvector(:,nn));
     plot(xvector(:,nn),nThisBoutType/sum(nThisBoutType), '-', 'color',col(n,:),'linewidth',2)
      
      hold on
      
      maxProbAll(n) = max(nThisBoutType/sum(nThisBoutType));
end

axis square
 axis([xAxisVector(:,nn)',0,max(maxProbAll)+0.01])
xlabel(xlabelName{nn})
ylabel('Probability')
box off
end


