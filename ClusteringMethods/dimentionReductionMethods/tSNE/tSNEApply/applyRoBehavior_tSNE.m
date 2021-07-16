AddFunctionToPath

close all
clear all

%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat firle format
%2) applies tSNE

AddFunctionToPath

close all
clear all

%%
%%%%%%%%%%%%%%%%%%%%%pick Bout fish map%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick main folder where data set subfolders and fishMap are
dataPath =  uigetdir;

%get fishStimMap name and path
DataFiles = dir(dataPath);

%determine wich are folder
isFolderVector = [DataFiles(:).isdir];

%fins fishMap
nameFishMap = DataFiles(find(isFolderVector == 0)).name;


%make file of fish map
pathFishName = strcat(dataPath, '\',nameFishMap);

%load fish map
load(pathFishName)

%%
%%%%%%%%%%%%%%%% pick data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%OMRTurns2
indDataSet1 = find([fishMap.dataSetNumber] == EnumeratorDataSet.OMRTurns2);

%OMRSpeed5
indDataSet2 = find([fishMap.dataSetNumber] == EnumeratorDataSet.OMRSpeed5);

%Obends
indDataSet3 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiFlash3min1sManyInt3);
indDataSet4 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiFlash3min1sManyInt);
 
%beeps
indDataSet5 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap200Hz100ms3min);
indDataSet6 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap400Hz100ms3min);
indDataSet7 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap600Hz100ms3min);
indDataSet8 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap800Hz100ms3min);
indDataSet9 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1000Hz100ms3min);
indDataSet10 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1200Hz100ms3min);
indDataSet11 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1400Hz100ms3min);
indDataSet12 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1600Hz100ms3min);
indDataSet13 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1800Hz100ms3min);
indDataSet14 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap2000Hz100ms3min);

indDataSet15 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash200Hz100ms3min);
indDataSet16 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash400Hz100ms3min);
indDataSet17 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash600Hz100ms3min);
indDataSet18 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash800Hz100ms3min);
indDataSet19 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1000Hz100ms3min);
indDataSet20 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1200Hz100ms3min);
indDataSet21 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1400Hz100ms3min);
indDataSet22 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1600Hz100ms3min);
indDataSet23 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1800Hz100ms3min);
indDataSet24 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash2000Hz100ms3min);
 
%phototaxis
indDataSet25 = find([fishMap.dataSetNumber] == EnumeratorDataSet.Phototaxis4);

%prey capture
indDataSet26 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCapture);
indDataSet27 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureNaive);
indDataSet28 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.SpontanousEyeTracking);
indDataSet29 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.LightDark3min2);
indDataSet30 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.SpontaneousMultiFishGray);

% %join data sets
% indDataSet = [indDataSet1 indDataSet2 indDataSet3 indDataSet4 indDataSet5 indDataSet6 indDataSet7 indDataSet8 indDataSet9 indDataSet10 indDataSet11 indDataSet12 indDataSet13 indDataSet14 indDataSet15 indDataSet16 indDataSet17 indDataSet18 indDataSet19 indDataSet20 ...
% indDataSet21 indDataSet22 indDataSet23 indDataSet24 indDataSet25 indDataSet26 indDataSet27 indDataSet28 indDataSet29 indDataSet30];

indDataSet = indDataSet1;
%%
%%%%%%%%%%%%%%%%%concatenate data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BoutInfAll = [];
BoutKinematicParametersAll = [];
FishDataAll = [];
stimOrderAll = [];
indStimStartAll = [];
indBoutStartThisFishAll  = [];
indBoutEndThisFishAll = [];

for n = 1 : length(fishMap(indDataSet))%file loop
    n 
    
   
    %%
    %%%%%%%%%%%%%%load fish file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pathSelectedFish = fishMap(indDataSet(n)).fishPath;
    
     %%
    %%%%%%% avoid corrupt files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
   
    
    load(pathSelectedFish)
    
    
   for nn = 1 : length(allBoutStructure)%loop through each fish
       
   %get bout variables
   BoutInf = allBoutStructure(nn).BoutInf;
   BoutKinematicParameters = allBoutStructure(nn).BoutKinematicParameters;
%     FishData = allBoutStructure(nn).FishData;
   stimOrder = FileInfStructure.stimOrder;
   indStimStart = FileInfStructure.indStimStartAll;
   
   %concatenate fish variables
   
   indStimStartAll = [indStimStartAll' indStimStart']';
   BoutInfAll = [BoutInfAll' BoutInf']';
   BoutKinematicParametersAll = [BoutKinematicParametersAll' BoutKinematicParameters']';
   
   stimOrderAll = [stimOrderAll' stimOrder']';
   indStimStartAll = [indStimStartAll' indStimStart']';
   
   
   
   %%
   %%%%%%%%%%%%% recreat bout inds so that it works with FishDataAll %%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   indBoutStartAllData = BoutInf(:,EnumeratorBoutInf.indBoutStartAllData);
   indBoutEndAllData = BoutInf(:,EnumeratorBoutInf.indBoutEndAllData);
   
%    indNegInds = find(indBoutStartAllData<0);
%    
%    if ~isempty(indNegInds)
%       
%        pause
%        
%    end
   
   if isempty(FishDataAll)
       
       indBoutStartThisFish = indBoutStartAllData;
       indBoutEndThisFish = indBoutEndAllData;
       
   else
       
       indBoutStartThisFish = length(FishDataAll) + indBoutStartAllData;
       indBoutEndThisFish = length(FishDataAll) + indBoutEndAllData;
   end
   
       indBoutStartThisFishAll = [indBoutStartThisFishAll' indBoutStartThisFish']';
       indBoutEndThisFishAll = [indBoutEndThisFishAll' indBoutEndThisFish']';
       
   %concatenate all fish data
%      FishDataAll = [FishDataAll' FishData']';
   
   end
   
   
    
end

BoutInf = BoutInfAll;
BoutKinematicParameters = BoutKinematicParametersAll;

%%
%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indGoodBouts] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

BoutKinematicParametersGood = BoutKinematicParameters(indGoodBouts,:);
BoutInfGood  = BoutInf(indGoodBouts,:);



%%
%%%%%%%%%%%%%%%%% chooose kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%26 good kin pars
indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
    EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
    EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
    EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
    EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
    EnumeratorBoutKinPar.boutDuration];
% 
% %26 + 1st beat kin pars
% indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
%     EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
%     EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
%     EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
%     EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
%     EnumeratorBoutKinPar.boutDuration...
%     EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
%     EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7 EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY EnumeratorBoutKinPar.beat1maxTailChange];
% 

% %26 + 1st beat kin pars + 2nd beat kin pars
% indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
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
%     EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2maxTailChange];


%%
%%%%%%%%%%%%%%%%%%%%%%%% do log abs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kinData=abs(BoutKinematicParametersGood);
for n=1:size(kinData,2)
    kinData(:,n) = kinData(:,n)+max(kinData(~isinf(kinData(:,n)),n))/100;
end

%do log
              kinData = log(kinData);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% do z-score %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%uses nanZscore function
[zScore,meanAllVar,stdAllVar] = nanZScore_parOutput(kinData);

%erase nans
zScore(isnan(zScore))=0;

data = zScore;

%%
%%%%%%%%%%%%% pickl random bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %pick random bouts
 numberOfBouts2 = 5000;
 
    indPerm = randperm(length(data));
    thisIndRand = indPerm(1:numberOfBouts2);
    
    dataRand = data(thisIndRand,indKinPars);
%%    
%%%%%%%%%%%%%%%%% do PCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makeplot = 1;

[boutDataPCASample,meanAllVar,stdAllVar,COEFF,SCORE,latent] = PCAforBehavior_3(BoutKinematicParametersGood(thisIndRand,:),indKinPars,makeplot);

 pause  

%%
%%%%%%%%%%%% tsne fast %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbDims = 2;
initial_dims = 3;
perplexity = 10;
landmarks = 1;

tic
[mappedX, landmarks, costs] = fast_tsne(dataRand, numbDims, initial_dims, landmarks, perplexity);
toc

%reorder mappedX
mappedX2 = mappedX(landmarks,:);

%%
%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(1,2,1)
plot(mappedX2(:,1),mappedX2(:,2), '.')
 
subplot(1,2,2)
plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), '.')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

densityType = 'local';
kdedens = kde(mappedX2',densityType);

rho = evaluate(kdedens,mappedX2');

figure
subplot(1,2,1)
plot3(mappedX2(:,1),mappedX2(:,2),rho, '.')

subplot(1,2,2)
scatter(mappedX2(:,1),mappedX2(:,2),10,rho, 'filled')

%%
%%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kdedens = [];
densityType = 'local';
linedensityMethod = 'fast';
numextra = sqrt(length(data));
nsamps = 10;
multirep = 0;
makeplot = 1;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

[rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(mappedX2,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);

%%
% %%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% maxNumbOfClusterCenters = 30;
% makePlot = 1;
% pointAssignmentMethod = 'distance';
% lowDensityCutOff = 0;
% 
% [tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_1(data,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot);
% 


%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 tree = [];
[indChoosenClusterCenters] = decideClusterCenters_1(mappedX2,tree,clusterCentersSortedIdx,realRho,funnymeasure);




%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance';

makeplot = 1;
[clusterAssignment] = assignDataPointsAllCases_1(mappedX2,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);


%%
%%%%%%%%%%%%%% look at clusters in pcs space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignment = unique(clusterAssignment);

col = jet(length(uniqueClusterAssignment));

figure
subplot(1,2,1)
plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), 'k.')
hold on

subplot(1,2,2)
plot(mappedX(:,1),mappedX(:,2), 'k.')
hold on

for h  =  1 :  length(uniqueClusterAssignment)

    
    indThisCluster = find(clusterAssignment == uniqueClusterAssignment(h));
    
 subplot(1,2,1)
hold on
plot3(boutDataPCASample(indThisCluster,1),boutDataPCASample(indThisCluster,2),boutDataPCASample(indThisCluster,3), '.', 'color', col(h,:))

subplot(1,2,2)
hold on
plot(mappedX2(indThisCluster,1),mappedX2(indThisCluster,2), '.', 'color', col(h,:))
pause
end