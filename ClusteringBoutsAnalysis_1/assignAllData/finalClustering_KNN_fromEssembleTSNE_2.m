% AddFunctionToPath
% 
%  close all
% clear all
% 




%%
% %%%%%%%%%%%%%%%%%%%%pick ROC data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse
% % GroupsClusters_AllData_74Kins3dims_1.75Smooth_medium_150thres_tsne3
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));
% 
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
% idx =[7 1 9 3 2 4 8 5 10 11 6];%
% idx = 1:12;
% idx = 1:1:11;

col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50;0 0 0])./255;

idx = [9  3 4 6 1 11 10 8 7 5 2 12];

uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);

%    col = jet(length(uniqueClusterAssignmentGroupClusters));
figure
for n = 1 : length(uniqueClusterAssignmentGroupClusters)

    
    
    indThisGroupOfClusters = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(idx(n)));
    
    
    
    plot3(mappedX(indThisGroupOfClusters,1),mappedX(indThisGroupOfClusters,2),mappedX(indThisGroupOfClusters,3),'.','color',col(n,:))
    hold on
%     plot3(mappedX(indsCore2,1),mappedX(indsCore2,2),mappedX(indsCore2,3),'o','color',col(n,:))
    
%      pause 
end

% axis([-20 20 -20 20 -20 20])
axis square


%%
%%%%%%%%%%%% get size of each small cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


indAllDataPoints = [];

sizeOfClustersAll = zeros(1,length(clusterStructure));

for v = 1: length(clusterStructure)
    

indThisCluster = clusterStructure(v).indsCore;

indAllDataPoints = [indAllDataPoints' indThisCluster']';

sizeOfClustersAll(v) = length(indThisCluster);

end


%%
%%%%%%%%%%% exclude bad clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 ClusterOfClusterCatAll = [clusterStructure.ClusterOfClusterCat];
% ClusterOfClusterCatAll(302) = 0;%LLE that are in fast swims
% ClusterOfClusterCatAll(321) = 0;%LLE that are in fast swims
% ClusterOfClusterCatAll(325) = 0;%LLE that are in fast swims
% %  ClusterOfClusterCatAll(63) = 7;
% %  ClusterOfClusterCatAll(66) = 7;
uniqueClusterOfClusterCatAll = unique(ClusterOfClusterCatAll);

%%
%%%%%%%%%%%% make ind struct with types of cluster together %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueClusterOfClusterCatAll(uniqueClusterOfClusterCatAll == 0) =[];


sizeOfBigClusters = zeros(1,length(uniqueClusterOfClusterCatAll));
indGroupCluster = [];
indGroupClusterCat = [];
indGroupClusterVector = [];

for nn = 1:length(uniqueClusterOfClusterCatAll)
    
%     nn =4
   
         indsInclusterStructure = find(ClusterOfClusterCatAll == uniqueClusterOfClusterCatAll(idx(nn)));
         
         thisClusterOriginalIndsAll = [];
         
         for n = 1 : length(indsInclusterStructure)
%       n =1    
       thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).indsCore;
       thisClusterOriginalIndsAll = [thisClusterOriginalIndsAll' thisClusterOriginalInds']';
       
       
       
       
         end
         
         %reassign bouts with maxBoutFreqCorr < 40 that are in fast bouts
            thisClusterOriginalIndsAll2 = thisClusterOriginalIndsAll;
%          if nn == 4
%              
%            indError =  find(BoutKinematicParameters(thisClusterOriginalIndsAll, EnumeratorBoutKinPar.maxBoutFreqCorr) < 40); 
%            thisClusterOriginalIndsAll2(indError) = [];
%            
%            indsAllSlow3 =  indGroupCluster(nn-1).indsAll;
%            indGroupCluster(nn-1).indsAll = [indsAllSlow3' indError']';
% 
%          end
%                   

         indGroupCluster(nn).indsAll = thisClusterOriginalIndsAll2;
         
%             indGroupClusterCat = [indGroupClusterCat (zeros(1,length(thisClusterOriginalIndsAll)) + uniqueClusterOfClusterCatAll(nn))];
%             indGroupClusterVector = [indGroupClusterVector' thisClusterOriginalIndsAll']';  
            
          sizeOfBigClusters(nn) = length(thisClusterOriginalIndsAll2);
         sizeOfBigClustersminFreq(nn) = nanmean(BoutKinematicParameters(thisClusterOriginalIndsAll2, EnumeratorBoutKinPar.maxBoutFreqCorr));
         
         
        
end

%%
%%%%%%%%%%% plot pca hist %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbDivisions = 25;
% xVectorAll = [-18:22/numbDivisions:22;-10:13/numbDivisions:13;-4:7/numbDivisions:7];
xVectorAll{1} = {-18:22/numbDivisions:22};
xVectorAll{2} = {-10:13/numbDivisions:13};
xVectorAll{3} = {-6:7/numbDivisions:7};

figure
for nn = 1 : 3
    
   subplot(1,3,nn)
     xVector = cell2mat(xVectorAll{nn});

for n = 1 : length(indGroupCluster)
    
    
 indThisCluster = indGroupCluster(n).indsAll;
 [nout,xout]= hist(boutDataPCASample(indThisCluster,nn),xVector);
%  subplot(4,3,n)
 plot(xVector,nout/sum(nout),'color',col(n,:),'linewidth',2)
hold on
axis square
end

end



%%
%%%%%%%%%%%% determine number of dims of data set %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandWidthsScalled2 = indStructure(1).bandWidthsScalled;

 numbOfDims =  size(bandWidthsScalled2,1);
%  numbOfDims =  3;
%%
%%%%%%%%%%%%%% make data set to cluster by picking min number of points%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



numbToSample = min(sizeOfBigClusters);
%  numbToSample = 500
% numbToSample*length(uniqueClusterOfClusterCatAll)
thisIndRandFinalAll = [];
finalDataCat = [];


figure
% col = jet(length(indGroupCluster));
 
for i = 1: length(indGroupCluster)
%     i =4
%   i =1  
    indsCore = indGroupCluster(i).indsAll;
    
    indPerm1 = randperm(length(indsCore));
    thisIndRand = indsCore(indPerm1(1:numbToSample));
    thisIndRand2 = thisIndRand;
 
    
    %frequency problem
%     
%         if i == 4
%              
%            indError =  find(BoutKinematicParameters(thisIndRand2, EnumeratorBoutKinPar.maxBoutFreqCorr) < 40); 
%            thisIndRand2(indError) = [];
%             
%         end
    
    
    subplot(1,2,1)  
%     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), boutDataPCASample(thisIndRand,3),'.','color', 'k')
    hold on
    plot3(boutDataPCASample(thisIndRand2,1),boutDataPCASample(thisIndRand2,2), boutDataPCASample(thisIndRand2,3),'.','color', col(i,:))
    hold on
    axis square
    
%      subplot(1,2,2)    
%     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), boutDataPCASample(thisIndRand,3),'.','color', col(i,:))
%     hold on
%     axis square

%      subplot(1,2,2)    
%     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), boutDataPCASample(thisIndRand,3),'.','color', 'k')
%     
    
    
    
    %concatenate vectors
    thisIndRandFinalAll = [thisIndRandFinalAll' thisIndRand2']';
    finalDataCat =  [finalDataCat (zeros(1, length(thisIndRand2)) + i)];
    
     sizeOfBigClustersminFreq2(i) = min(BoutKinematicParameters(thisIndRand2, EnumeratorBoutKinPar.maxBoutFreqCorr));
     
%      pause
end
axis([-20 25 -10 20 -10 10])

finalData = boutDataPCASample(thisIndRandFinalAll,1:numbOfDims);
size(finalData)
% pause

%%
%%%%%%%%%%%%% do k nearest search for bout map %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %pick data to test
% numbToSample = 1000000;
% inds = 1 : 1 : length(boutDataPCASample);
% 
%  indPerm1 = randperm(length(inds));
%  thisIndRand = inds(indPerm1(1:numbToSample));
% 
% 
% boutDataPCASampleRand = boutDataPCASample(thisIndRand,:);

numbOfK = 50;
distanceMethod = 'euclidean';
tic
 [IDX,D] = knnsearch(finalData,finalData,'k',numbOfK,'Distance',distanceMethod);
toc

%find lables



knnLabels = finalDataCat(IDX);

%assing points by the most frequent label
 clusterAssignmentAllData = mode(knnLabels');
% dataAssign = knnLabels;

%%
%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueDataAssing = unique(clusterAssignmentAllData);

% figure

sizeOfClusters = zeros(1,length(uniqueDataAssing));

for n = 1 : length(uniqueDataAssing)

     indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing(n));
     
     indThisClusterInAllData = thisIndRandFinalAll(indThisCluster);
     
     subplot(1,2,2)
    plot3(boutDataPCASample(indThisClusterInAllData,1),boutDataPCASample(indThisClusterInAllData,2), boutDataPCASample(indThisClusterInAllData,3),'.','color', col(n,:))
    hold on
    axis square
    
   
        
    sizeOfClusters(n) = length(indThisClusterInAllData);
      sizeOfBigClustersminFreq3(n) = min(BoutKinematicParameters(indThisClusterInAllData, EnumeratorBoutKinPar.maxBoutFreqCorr));

end
axis([-20 25 -10 20 -10 10])

%%
%%%%%%%%%%%%% put same number in bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minSizeOfCusters = min(sizeOfClusters);

sizeOfClusters = zeros(1,length(uniqueDataAssing));

% indThisClusterInAllDataAll = zeros(1,minSizeOfCusters*length(uniqueDataAssing));
% clusterAssignmentInAllData = zeros(1,minSizeOfCusters*length(uniqueDataAssing));

indThisClusterInAllDataAll = [];
clusterAssignmentInAllData = [];

for n = 1 : length(uniqueDataAssing)
    
   indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing(n));

    
    
    indPerm1 = randperm(length(indThisCluster));
    thisIndRand = indThisCluster(indPerm1(1:minSizeOfCusters));
    
    indThisClusterInAllData = thisIndRandFinalAll(thisIndRand);

    plot3(boutDataPCASample(indThisClusterInAllData,1),boutDataPCASample(indThisClusterInAllData,2), boutDataPCASample(indThisClusterInAllData,3),'.','color', col(n,:))
    hold on
    axis square
    
         
    indThisClusterInAllDataAll = [indThisClusterInAllDataAll' indThisClusterInAllData']';
    clusterAssignmentInAllData = [clusterAssignmentInAllData (zeros(1,length(indThisClusterInAllData)) + uniqueDataAssing(n)) ];     
    sizeOfClusters(n) = length(indThisClusterInAllData);
      sizeOfBigClustersminFreq4(n) = mean(BoutKinematicParameters(indThisClusterInAllData, EnumeratorBoutKinPar.maxBoutFreqCorr));

end


%%
%%%%%%%%%%%%%%%%% make final clustering structure %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

finalData = boutDataPCASample(indThisClusterInAllDataAll,1:numbOfDims);

finalClustering.method = 'kNearestNeighbor';
finalClustering.numbOfK = numbOfK;
finalClustering.dataToDoMap = finalData;
finalClustering.distanceMethod = distanceMethod;
finalClustering.indsBoutMapInAllData = indThisClusterInAllDataAll;
finalClustering.assignment = clusterAssignmentInAllData;


%%
%%%%%%%%%%%%%%%%%%%%%%%%% assign all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% numbOfK = 50;
% distanceMethod = 'euclidean';
tic
 [IDX,D] = knnsearch(finalData,boutDataPCASample(:,1:numbOfDims),'k',numbOfK,'Distance',distanceMethod);
toc
% [IDX,D] = knnsearch(finalData,finalData,'k',numbOfK,'Distance',distanceMethod);

%find lables


knnLabels = clusterAssignmentInAllData(IDX);

%assing points by the most frequent label
 clusterAssignmentAllData = mode(knnLabels');
% dataAssign = knnLabels;

%%
%%%%%%%%%%%%%% plot assinged data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


uniqueDataAssing = unique(clusterAssignmentAllData);
countBouts = 0;

figure
for n = 1 : length(uniqueDataAssing)
    
%   n =4
  indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing((n)));
    
    indThisClusterGood = intersect(indGoodBouts,indThisCluster);
%     subplot(1,2,2)
indThisClusterGood2 = indThisClusterGood;
%     if n ==4
%   
%              
%         
%         indSlowBouts = find(BoutKinematicParameters(:, EnumeratorBoutKinPar.maxBoutFreqCorr) < 40); 
%         indFastBouts = find(BoutKinematicParameters(:, EnumeratorBoutKinPar.maxBoutFreqCorr) >= 40); 
%         
%         indSlowBoutsThis = intersect(indThisClusterGood,indSlowBouts);
%         indFastBoutsThis = intersect(indThisClusterGood,indFastBouts);
% 
% %            indError =  find(BoutKinematicParameters(indThisClusterGood, EnumeratorBoutKinPar.maxBoutFreqCorr) < 40); 
% % %            indThisClusterGood2(indError) = [];
% %            indFastBouts = indThisClusterGood2(indError);
% %             indSlowBouts = intersect(indThisClusterGood,indError);
% size(indError)
%   size( indThisClusterGood) 
%      
%     end
 
 
   
%     plot3(boutDataPCASample(indThisClusterGood,1),boutDataPCASample(indThisClusterGood,2), boutDataPCASample(indThisClusterGood,3),'.','color', col(n,:))
%      if n ==4
%         
%         
%     plot3(boutDataPCASample(indThisClusterGood,1),boutDataPCASample(indThisClusterGood,2), boutDataPCASample(indThisClusterGood,3),'.','color', 'k')
% 
%     end

 plot3(boutDataPCASample(indThisClusterGood,1),boutDataPCASample(indThisClusterGood,2), boutDataPCASample(indThisClusterGood,3), '.','color', col(n,:))
 hold on
%      if n ==4
%         
%         
%     plot3(boutDataPCASample(indSlowBoutsThis,1),boutDataPCASample(indSlowBoutsThis,2), boutDataPCASample(indSlowBoutsThis,3), '.','color','b')
% 
%     end
    hold on
    
    axis square
    countBouts = countBouts + length(boutDataPCASample);
    sizeOfBigClustersminFreq5(n) = nanmean(BoutKinematicParameters(indThisClusterGood, EnumeratorBoutKinPar.maxBoutFreqCorr));
    distX(n) = nanmean(BoutKinematicParameters(indThisClusterGood, EnumeratorBoutKinPar.distBoutDistanceX));

end
axis([-20 25 -10 20 -10 10])

BoutInf(:,EnumeratorBoutInf.boutCat) = clusterAssignmentAllData;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% kin names %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


kinParNames = {'numbHalfBeats','boutDuration','distBoutDuration','maxBoutFreq','minBoutFreq','meanBoutFreq','headMaxYaw','headMeanYaw','headMinYaw',...
'boutAngle','distBoutAngle','boutMaxAngle','boutMaxAngularSpeed','boutAvrAngularSpeed','boutDistanceX','boutDistanceY','boutSpeedX','boutSpeedY',...
'distBoutDistanceX','distBoutDistanceY','distBoutSpeedX','distBoutSpeedY', 'maxTailChangeAvr', 'meanTailChangeAvr', 'maxTailChangeMax', 'meanTailChangeMax',... 
'boutTailWaveSpeedMax', 'boutTailWaveSpeedMin', 'boutTailWaveSpeedMean', 'boutTailAngularVelocityMax', 'boutTailAngularVelocityMin', 'boutTailAngularVelocityMean',... 
'boutTailAmplitudePositionRateMax', 'boutTailAmplitudePositionRateMin', 'boutTailAmplitudePositionRateMean', 'boutHalfBendingPosMax', 'boutHalfBendingPosMin',... 
'boutHalfBendingPosMean', 'boutCruvatureMax', 'boutCruvatureMin', 'boutCruvatureMean', 'boutCurvatureRateMax', 'boutCurvatureRateMin', 'boutCurvatureRateMean',.... 
'boutAbsAmplitude1Avr', 'boutAbsAmplitude2Avr', 'boutAbsAmplitude3Avr', 'boutAbsAmplitude4Avr', 'boutAbsAmplitude5Avr', 'boutAbsAmplitude6Avr', 'boutAbsAmplitude7Avr',.... 
'boutAbsAmplitude8Avr', 'boutAbsAmplitude9Avr', 'boutAbsAmplitude10Avr', 'boutAmplitude1Max', 'boutAmplitude2Max', 'boutAmplitude3Max', 'boutAmplitude4Max',... 
'boutAmplitude5Max', 'boutAmplitude6Max', 'boutAmplitude7Max', 'boutAmplitude8Max', 'boutAmplitude9Max', 'boutAmplitude10Max',...
'absAUC1', 'absAUC2', 'absAUC3', 'absAUC4', 'absAUC5', 'absAUC6', 'absAUC7', 'absAUC8', 'absAUC9', 'absAUC10',... 
'beat1upDown', 'beat1numbBeatInBout', 'beat1beatDuration', 'beat1beatFrequency', 'beat1beatAmplitude1','beat1beatAmplitude2', 'beat1beatAmplitude3', 'beat1beatAmplitude4',...
'beat1beatAmplitude5', 'beat1beatAmplitude6', 'beat1beatAmplitude7', 'beat1beatAmplitude8', 'beat1beatAmplitude9', 'beat1beatAmplitude10', 'beat1beatAmplitudeAvr',... 
'beat1beatAmplitudeMax', 'beat1beatMaxTailAngle', 'beat1beatMinTailAngle', 'beat1beatHalfBendAngle', 'beat1beatMaxTailPos', 'beat1beatMinTailPos', 'beat1beatHalfBendPos',... 
'beat1beatWaveSpeed', 'beat1beatAngularVelocity', 'beat1beatAmplitudePositionRate', 'beat1AUC1', 'beat1AUC2', 'beat1AUC3',  'beat1AUC4', 'beat1AUC5', 'beat1AUC6','beat1AUC7',... 
'beat1AUC8', 'beat1AUC9', 'beat1AUC10','beat1AUCAvr', 'beat1AUCmax', 'beat1beatAngle', 'beat1beatMaxAngle', 'beat1beatMaxAngularSpeed', 'beat1beatDistanceX', 'beat1beatDistanceY',...
'beat1beatSpeedX', 'beat1beatSpeedY', 'beat1maxTailChange', 'beat1meanTailChange', 'beat1beatMaxCurvature', 'beat1beatMaxCurvatureRate', 'beat2upDown', 'beat2numbBeatInBout',...
'beat2beatDuration', 'beat2beatFrequency', 'beat2beatAmplitude1', 'beat2beatAmplitude2', 'beat2beatAmplitude3', 'beat2beatAmplitude4', 'beat2beatAmplitude5', 'beat2beatAmplitude6',...
'beat2beatAmplitude7', 'beat2beatAmplitude8', 'beat2beatAmplitude9', 'beat2beatAmplitude10', 'beat2beatAmplitudeAvr', 'beat2beatAmplitudeMax', 'beat2beatMaxTailAngle',...
'beat2beatMinTailAngle', 'beat2beatHalfBendAngle', 'beat2beatMaxTailPos', 'beat2beatMinTailPos', 'beat2beatHalfBendPos', 'beat2beatWaveSpeed', 'beat2beatAngularVelocity',...
'beat2beatAmplitudePositionRate', 'beat2AUC1', 'beat2AUC2', 'beat2AUC3', 'beat2AUC4', 'beat2AUC5', 'beat2AUC6', 'beat2AUC7', 'beat2AUC8', 'beat2AUC9', 'beat2AUC10', 'beat2AUCAvr',...
'beat2AUCmax', 'beat2beatAngle', 'beat2beatMaxAngle', 'beat2beatMaxAngularSpeed',  'beat2beatDistanceX', 'beat2beatDistanceY', 'beat2beatSpeedX', 'beat2beatSpeedY',...
'beat2maxTailChange', 'beat2meanTailChange', 'beat2beatMaxCurvature', 'beat2beatMaxCurvatureRate', 'beat3upDown', 'beat3numbBeatInBout', 'beat3beatDuration', 'beat3beatFrequency',...
'beat3beatAmplitude1', 'beat3beatAmplitude2', 'beat3beatAmplitude3','beat3beatAmplitude4', 'beat3beatAmplitude5', 'beat3beatAmplitude6', 'beat3beatAmplitude7',...
'beat3beatAmplitude8', 'beat3beatAmplitude9', 'beat3beatAmplitude10', 'beat3beatAmplitudeAvr', 'beat3beatAmplitudeMax', 'beat3beatMaxTailAngle', 'beat3beatMinTailAngle',...
'beat3beatHalfBendAngle', 'beat3beatMaxTailPos', 'beat3beatMinTailPos', 'beat3beatHalfBendPos', 'beat3beatWaveSpeed', 'beat3beatAngularVelocity','beat3beatAmplitudePositionRate',...
'beat3AUC1', 'beat3AUC2', 'beat3AUC3', 'beat3AUC4', 'beat3AUC5', 'beat3AUC6', 'beat3AUC7', 'beat3AUC8', 'beat3AUC9', 'beat3AUC10', 'beat3AUCAvr', 'beat3AUCmax','beat3beatAngle',...
'beat3beatMaxAngle','beat3beatMaxAngularSpeed','beat3beatDistanceX','beat3beatDistanceY','beat3beatSpeedX','beat3beatSpeedY','beat3maxTailChange','beat3meanTailChange',...
'beat3beatMaxCurvature','beat3beatMaxCurvatureRate','firstBeatAmplitudeDiff','boutAmplitudeDiff','meanBoutFreqCorr','maxBoutFreqCorr','minBoutFreqCorr','maxDiffBodyAngle',...
'boutMaxAngleRatio','C1Angle','C1Duration','C1MaxAngularSpeed','C2Angle','C2Duration','C2MaxAngularSpeed','eyeConvAvr'};




%%
%%%%%%%%%%%%%%% bout kin pars that are interesting %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%26 good kin pars
indKinPars = [EnumeratorBoutKinPar.headMaxYaw,EnumeratorBoutKinPar.boutMaxAngle,EnumeratorBoutKinPar.boutMaxAngularSpeed,EnumeratorBoutKinPar.distBoutDistanceX,...
    EnumeratorBoutKinPar.distBoutSpeedX, EnumeratorBoutKinPar.maxTailChangeMax,EnumeratorBoutKinPar.boutAmplitude2Max...
    EnumeratorBoutKinPar.boutAmplitude7Max,EnumeratorBoutKinPar.C1Angle,EnumeratorBoutKinPar.C1Duration,EnumeratorBoutKinPar.C1MaxAngularSpeed...
    EnumeratorBoutKinPar.C2Angle,EnumeratorBoutKinPar.C2Duration,EnumeratorBoutKinPar.C2MaxAngularSpeed,EnumeratorBoutKinPar.beat1beatAmplitude7,...
    EnumeratorBoutKinPar.beat2beatAmplitude7, EnumeratorBoutKinPar.maxBoutFreqCorr,EnumeratorBoutKinPar.meanBoutFreqCorr];



%bouderies for normal scale
lowerBoundery =[0,0,0,-20,-60,0,0,0,0,0,0,0,0,0,3,0,0,0];
higherBoundery = [300,360,40,20,60,14,130,300,250,30,20,360,40,17,360,200,80,50];

% %bouderies for log scale
% lowerBoundery = [0,0,-2, -3.5, -2, -2, 1,2.5, -1, 1, -3, 0, 1, -3, 2,-0.5,2.75,2.75];
% higherBoundery = [6,6,3.5,3.5,5,3.5,5,6,6,3.5,3,6,4,3,6,5.5,4.5,4];

  
 indAngleKin = find(higherBoundery >= 100);
 
 
%%
%%%%%%%%%%% make histograms by bout type %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % xAxisLabel = {};
% 
% boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
% uniqueBoutCat = unique(boutCat);
%  
% 
% % uniqueBoutCat = unique(boutCat);
% % figure
% numbSubPlots = ceil(sqrt(length(indKinPars)));
% numbOfHistDivisions = 50;
% 
% figure
%  for nn = 1 : length(indKinPars)
% %      nn = 17
% %     nn =4
%     thisKinPar = BoutKinematicParameters(:,indKinPars(nn));
%     
%    
%     
% %    %get numb of bouts per bout type
% %    numbBoutTypes = zeros(1,length(uniqueBoutCat));
% %    
% %    for n  =  1 : length(uniqueBoutCat)
% %     indThisBoutType = find(boutCat == uniqueBoutCat(n));
% %     indThisBoutTypeGood = intersect(indThisBoutType,indGoodBouts);
% %     
% %     numbBoutTypes(n) = length(indThisBoutTypeGood);
% %          
% %    end
% %    
% %    numberOfBouts2 = min(numbBoutTypes);
% %    
% %    thisIndRandAll = [];
% %     for n  =  1 : length(uniqueBoutCat)
% %     indThisBoutType = find(boutCat == uniqueBoutCat(n));
% %     indThisBoutTypeGood = intersect(indThisBoutType,indGoodBouts);
% %     
% %        %pick random bouts
% %     thisInds = 1: length(indThisBoutTypeGood);
% %     indPerm = randperm(length(thisInds));
% %     thisIndRand = thisInds(indPerm(1:numberOfBouts2));
% %     
% %     thisIndRandAll =[thisIndRandAll thisIndRand];
% %     end
% %    
% %     %make bins
% %     outLierThresMax = prctile(log(abs(thisKinPar(thisIndRandAll))),99.9);
% %       xVector = 0:outLierThresMax/numbOfHistDivisions:outLierThresMax;
% 
% %%fixed boundery
%  xVector = lowerBoundery(nn):higherBoundery(nn)/numbOfHistDivisions:higherBoundery(nn);
%     
% %     figure
% clf
% %     subplot(1,2,1)
%     thisKinParThisBoutsAvr = zeros(1,length(uniqueBoutCat));
%     thisKinParThisBoutsStd = zeros(1,length(uniqueBoutCat));
%     indExclude = [];   
%     
%  for n  =  1 : length(uniqueBoutCat)
% 
%     
%     indThisBoutType = find(boutCat == uniqueBoutCat((n)));
%       indThisBoutTypeGood = intersect(indThisBoutType,indGoodBouts);
% %       indThisBoutTypeGood = intersect(indThisClusterInAllDataAll,intersect(indThisBoutType,indGoodBouts));
% 
%  if nn == 4 ||  nn == 5%don't do abs for distX
%     thisKinParThisBouts = (((thisKinPar(indThisBoutTypeGood))));
% 
%  else
%     thisKinParThisBouts = ((abs(thisKinPar(indThisBoutTypeGood))));
%     
%  end
%      %exclude angle mistake
%     if nn == indAngleKin(1) ||  nn == indAngleKin(2) ||  nn == indAngleKin(3) ||  nn == indAngleKin(4) ||  nn == indAngleKin(5) ||  nn == indAngleKin(6) ||  nn == indAngleKin(7) ||  nn == indAngleKin(8)
%         
%         indExclude = find(abs(thisKinParThisBouts) > 360);
%         
%     end
%     
%      if nn == 17 ||  nn == 18
%         
%         indExclude = find(thisKinParThisBouts < 0 | thisKinParThisBouts > 200);
%         
%     end
%     
%     thisKinParThisBouts(indExclude) = [];
%     
%     %calcualte average and std
%     thisKinParThisBoutsAvr(n) = nanmean(thisKinParThisBouts);
%     thisKinParThisBoutsStd(n) = nanstd(thisKinParThisBouts);
% 
%     %make distribution
% %     figure
%    [nout,xout]= hist(thisKinParThisBouts,xVector);
%    subplot(4,3,n)
%    
%   
%    
%    plot(xVector,nout/sum(nout),'color',col(n,:),'linewidth',2)
%    hold on
% %    pause
%  axis square
% 
%  end
%  
%    title(kinParNames{indKinPars(nn)})
% %   title(nn) 
% 
%   ylabel('Probability')
% %   axis([lowerBoundery(nn) higherBoundery(nn) 0 0.9])
%   box off
%   
% %   subplot(1,2,2)
% %   errorbar(1:length(uniqueBoutCat),thisKinParThisBoutsAvr,thisKinParThisBoutsStd,'o')
% %    axis square
% 
%  
%  pause
%  end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  save('BoutCat_AllData_74Kins3dims_1.75Smooth_medium_100thres_tsne_4.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','clusterStructure','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNans','groupClusterSctructure','finalClustering','-v7.3')
 
%  save('BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat','BoutInf','BoutKinematicParameters','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNansGood','behavioralSpaceStructure','boutDataPCASample','clusterStructureGood','groupClusterSctructure','indStructure','finalClustering','-v7.3')

save('BoutCat_kNN4_74Kins5dims_1.75Smooth_slow_3000_auto_12ClusterSolution.mat','BoutInf','BoutKinematicParameters','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNans','behavioralSpaceStructure','boutDataPCASample','clusterStructure','groupClusterSctructure','indStructure','finalClustering','-v7.3')

 
%%
%%%%%%%%%%% save cluster map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('BoutMap_kNN4_74Kins5dims_1.75Smooth_slow_3000_auto_12ClusterSolution.mat','behavioralSpaceStructure','finalClustering','-v7.3')


