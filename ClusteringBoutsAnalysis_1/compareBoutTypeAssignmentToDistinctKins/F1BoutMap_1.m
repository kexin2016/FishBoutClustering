% close all
% clear all
% 
% 
%%
% %%%%%%%%%%%%%%%%% load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 



% % load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');
  load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_kNN4_74Kins3dims_1.75Smooth_fast_3000_auto.mat');
% % load('C:\Joao analysis\FreeData\clusteringData\boutMap\BoutMap_kNN4_74Kins3dims_1.75Smooth_fast_3000_auto.mat');


%%
%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);
indMistakesIn74KinSpace = find(mistakesIn74KinSpace);

indBoutsToExclude = [indBadBouts' indMistakesIn74KinSpace']';
indGoodBouts = 1 : length(BoutInf);
indGoodBouts(indBoutsToExclude) = [];



%%
%%%%%%%%%%%%%%%%%%%%%% get stuff out of structure %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clusterAssignmentGroupClusters = groupClusterSctructure.essembleMatrixAssignment;
tsneDistributions = groupClusterSctructure.distributions;

mappedX = tsneDistributions(1).mappedX;


%%
%%%%%%%%%%%%%%%% plot tsne space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% idx =[10 2 9 7 5 4 1 6 11 8 3];%
idx =[7 1 9 3 2 4 8 5 10 11 6];%
% idx = 1:1:11;

col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;



uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);

%    col = jet(length(uniqueClusterAssignmentGroupClusters));
figure
for n = 1 : length(uniqueClusterAssignmentGroupClusters)

    
    
    indThisGroupOfClusters = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(idx(n)));
    
    
    
    plot3(mappedX(indThisGroupOfClusters,1),mappedX(indThisGroupOfClusters,2),mappedX(indThisGroupOfClusters,3),'.','color',col(n,:))
    hold on
%     plot3(mappedX(indsCore2,1),mappedX(indsCore2,2),mappedX(indsCore2,3),'o','color',col(n,:))
    
%     pause 
end

% axis([-20 20 -20 20 -20 20])
axis square



%%
%%%%%%%%%%%%% plot bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


dataToDoMap = finalClustering.dataToDoMap;
indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
clusterAssignmentInAllData = finalClustering.assignment;

uniqueClusterAssignmentInAllData = unique(clusterAssignmentInAllData);
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

figure
for nn = 1 : length(uniqueClusterAssignmentInAllData)
    
    
    indThisCluster = find(clusterAssignmentInAllData == uniqueClusterAssignmentInAllData(nn));
    
%     plot3(dataToDoMap(indThisCluster,1),dataToDoMap(indThisCluster,2),dataToDoMap(indThisCluster,3),'.','color', col(nn,:))
    plot(dataToDoMap(indThisCluster,1),dataToDoMap(indThisCluster,2),'.','color', col(nn,:))

    hold on
    axis square
    
end


%%
% %%%%%%%%%%% plot all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
% 
% uniqueBoutCat = unique(boutCat);
% 
% figure
% for i = 1 : length(uniqueBoutCat)
%     
%     
%     indThisBout = find(boutCat == uniqueBoutCat(i));
%     
%     indThisBoutGood = intersect(indGoodBouts,indThisBout);
%     
% %     plot3(boutDataPCASample(indThisBout(1:100:end),1),boutDataPCASample(indThisBout(1:100:end),2),boutDataPCASample(indThisBout(1:100:end),3),'.','color', col(i,:))
%     plot(boutDataPCASample(indThisBoutGood(1:100:end),1),boutDataPCASample(indThisBoutGood(1:100:end),2),'.','color', col(i,:))
% 
%     
%     hold on
% axis square
%     
%     
%     
% end



%%
% %%%%%%%%%%% plot all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
% 
% uniqueBoutCat = unique(boutCat);
% 
% figure
% for i = 1 : length(uniqueBoutCat)
%     
%     
%     indThisBout = find(boutCat == uniqueBoutCat(i));
%     
% %     plot3(boutDataPCASample(indThisBout(1:100:end),1),boutDataPCASample(indThisBout(1:100:end),2),boutDataPCASample(indThisBout(1:100:end),3),'.','color', col(i,:))
%     plot(boutDataPCASample(indThisBout(1:100:end),1),boutDataPCASample(indThisBout(1:100:end),2),'.','color', col(i,:))
% 
%     
%     hold on
% axis square
%     
%     
%     
% end

%%
%%%%%%%%%%%%%%% pick subsets of kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%all
% indKinParsBout = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
%     EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
%     EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
%     EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
%     EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
%     EnumeratorBoutKinPar.boutDuration...
%     EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
%     EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7 EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY EnumeratorBoutKinPar.beat1maxTailChange...    
%     EnumeratorBoutKinPar.beat2beatDuration EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2 EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
%     EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7 EnumeratorBoutKinPar.beat2beatAngle EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2maxTailChange...
%     EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
%     EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY EnumeratorBoutKinPar.beat3maxTailChange];
% 


%tail kins
indKinParsTail = [EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
    EnumeratorBoutKinPar.maxBoutFreqCorr ...
    EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
    EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff...
    EnumeratorBoutKinPar.boutDuration...
    EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
    EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7...
    EnumeratorBoutKinPar.beat1maxTailChange...    
    EnumeratorBoutKinPar.beat2beatDuration EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2 EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
    EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7...
    EnumeratorBoutKinPar.beat2maxTailChange...
    EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
    EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 ...
    EnumeratorBoutKinPar.beat3maxTailChange];



indKinParsHead = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed  ...
    EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle ...
     EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
    EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
    EnumeratorBoutKinPar.boutDuration...
    EnumeratorBoutKinPar.beat1beatDuration ...
    EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY...    
    EnumeratorBoutKinPar.beat2beatDuration    ...
    EnumeratorBoutKinPar.beat2beatAngle EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY...
    EnumeratorBoutKinPar.beat3beatDuration  ...
    EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY];


indKinParsBout = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
    EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
    EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
    EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
    EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
    EnumeratorBoutKinPar.boutDuration];


%half beats
indKinParsHalfBeats = [EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
    EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7 EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY EnumeratorBoutKinPar.beat1maxTailChange...    
    EnumeratorBoutKinPar.beat2beatDuration EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2 EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
    EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7 EnumeratorBoutKinPar.beat2beatAngle EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2maxTailChange...
    EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
    EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY EnumeratorBoutKinPar.beat3maxTailChange];


%1st half beat
indKinParsHalfBeats1 = [EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
    EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7 EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY EnumeratorBoutKinPar.beat1maxTailChange];    
    

%2nd half beat
indKinParsHalfBeats2 = [EnumeratorBoutKinPar.beat2beatDuration EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2 EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
    EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7 EnumeratorBoutKinPar.beat2beatAngle EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2maxTailChange];

%3rd half beat
indKinParsHalfBeats3 = [EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
    EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY EnumeratorBoutKinPar.beat3maxTailChange];

indKinStructure(1).indKinPars = indKinParsTail;
indKinStructure(2).indKinPars = indKinParsHead;
indKinStructure(3).indKinPars = indKinParsBout;
indKinStructure(4).indKinPars = indKinParsHalfBeats;
indKinStructure(5).indKinPars = indKinParsHalfBeats1;
indKinStructure(6).indKinPars = indKinParsHalfBeats2;
indKinStructure(7).indKinPars = indKinParsHalfBeats3;


%%
%%%%%%%%%%%% make new PC spaces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbOfK = 50;
distanceMethod = 'euclidean';

BoutKinematicParametersGood = BoutKinematicParameters(indGoodBouts,:);

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);

uniqueBoutCat = unique(boutCat);

boutCatGood = boutCat(indGoodBouts);
boutDataPCASampleGood = boutDataPCASample(indGoodBouts,:);

numberOfBouts = 500;

figure
% subplot(3,3,1)
makeBoutMapPlot_1(boutCat(indsBoutMapInAllData),boutDataPCASample(indsBoutMapInAllData,:),col,numberOfBouts)

FscoreAll = zeros(length(uniqueBoutCat),length(indKinStructure));
for i = 1 : length(indKinStructure)

i


makeplot = 0;

indKinParsThis = indKinStructure(i).indKinPars;

%%
%%%%%%%%%%%%%%%% do pca space with good bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[boutDataPCASampleThis,meanAllVarThis,stdAllVarThis,COEFFThis,SCOREThis,latentThis,maxKinParsThis] = PCAforBehavior_4(BoutKinematicParametersGood,indKinParsThis,makeplot);

%%
%%%%%%%%%%%%%%%% put all bouts in PC space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

meanPCASpaceThis = mean(SCOREThis,1);

[boutDataPCASampleAllDataThis] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParameters,indKinParsThis,maxKinParsThis,meanAllVarThis,stdAllVarThis,meanPCASpaceThis,COEFFThis);

%%
%%%%%%%%%%% do k nearest search for new bout map %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutMapData = boutDataPCASampleAllDataThis(indsBoutMapInAllData,1:3);
boutCatOriginalMap = boutCat(indsBoutMapInAllData);

numbOfK = 50;
distanceMethod = 'euclidean';
tic
 [IDX,~] = knnsearch(boutMapData,boutMapData,'k',numbOfK,'Distance',distanceMethod);
toc

knnLabels = boutCatOriginalMap(IDX);
clusterAssignmentThisMap = mode(knnLabels');
clusterAssignmentThisMap = clusterAssignmentThisMap';


% corr([clusterAssignmentThisMap,boutCatOriginalMap])

%compare both bout maps
% figure
% subplot(1,2,1)
% makeBoutMapPlot_1(boutCat(indsBoutMapInAllData),boutDataPCASample(indsBoutMapInAllData,:),col,numberOfBouts)
% 
% subplot(1,2,2)
% makeBoutMapPlot_1(clusterAssignmentThisMap,boutMapData,col,numberOfBouts)

% title(corr([clusterAssignmentThisMap,boutCatOriginalMap]))

%%
%%%%%%%%%%%%%%% use k-NN to assign all the data %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
 [IDX,D] = knnsearch(boutMapData,boutDataPCASampleAllDataThis(:,1:3),'k',numbOfK,'Distance',distanceMethod);
toc


knnLabels = boutCatOriginalMap(IDX);%!!!

%assing points by the most frequent label
 clusterAssignmentAllDataThisMap = mode(knnLabels');
 clusterAssignmentAllDataThisMap = clusterAssignmentAllDataThisMap';
% dataAssign = knnLabels;
% numberOfBouts = 100;

% plot(boutDataPCASampleAllDataThis(:,1),boutDataPCASampleAllDataThis(:,2), 'k.')
% hold on
% plot(boutMapData(:,1),boutMapData(:,2), 'r.')
% axis square



%%
%%%%%%%%%%%%%%% calculate F1 score %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%only use good data

boutDataPCANewMap = boutDataPCASampleAllDataThis(indsBoutMapInAllData, 1:3);
boutCatNewMap = clusterAssignmentAllDataThisMap(indsBoutMapInAllData);

boutDataPCAGoodNewSpace = boutDataPCASampleAllDataThis(indGoodBouts, 1:3);
boutCatGoodNewSpace = clusterAssignmentAllDataThisMap(indGoodBouts);

% indGoodBouts
% indsBoutMapInAllData




% figure
% subplot(1,2,1)
% makeBoutMapPlot_1(boutCatNewMap,boutDataPCANewMap,col,numberOfBouts)
% 
% subplot(1,2,2)
% makeBoutMapPlot_1(boutCatAllGoodData,boutDataPCAAllGoodData(:,1:3),col,numberOfBouts)
% 
% 
%%
%%%%%%%%%%%%% calculate F1 measures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stats = confusionmatStats(boutCatGood,boutCatGoodNewSpace);



Fscore = stats.Fscore;
FscoreAll(:,i) = Fscore;



%%
%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% subplot(3,3,i+1)
figure
makeBoutMapPlot_1(boutCatOriginalMap,boutMapData,col,numberOfBouts)



end

%%
%%%%%%%%%%%%%%% F score average %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FscoreAllAvr = nanmean(FscoreAll,1);

FscoreAll2 = [FscoreAll' FscoreAllAvr']';

% subplot(3,3,9)
figure
imagesc(FscoreAll2')
colormap gray
% axis square
box off
axis off
caxis([0 1])
