%%
%%%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1) Uploads behavioral data from bout files
%2) Exclude broken bouts
%3) Do Z-score
%4) Do PCA from set kin pars
%5) Save kin pars and Bout Inf

AddFunctionToPath

% close all
clear all

%%
%%%%%%%%%%%%%%%% pick behavioral space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataPath2 =  uigetfile;


%load behavioral space
load(dataPath2)

%get vars out of structure
meanAllVar = behavioralSpaceStructure.meanAllVar;
stdAllVar = behavioralSpaceStructure.stdAllVar;
COEFF = behavioralSpaceStructure.COEFF;
latent = behavioralSpaceStructure.latent;
maxKinPars = behavioralSpaceStructure.maxKinPars;
indKinPars = behavioralSpaceStructure.indKinPars;
meanPCASpace = behavioralSpaceStructure.meanPCASpace;


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

%spont data sets main rig

indDataSet1 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig0000Lux1);
indDataSet2 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig0100Lux1);
indDataSet3 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig0150Lux1);
indDataSet4 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig0200Lux1);
indDataSet5 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig0300Lux1);
indDataSet6 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig0500Lux1);
indDataSet7 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig1000Lux1);
indDataSet8 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig2000Lux1);
indDataSet9 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig4000Lux1);
indDataSet10 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontMainRig8000Lux1);

%spont data sets par rig
indDataSet11 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig0000lux1);
indDataSet12 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig0100lux1);
indDataSet13 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig0150lux1);
indDataSet14 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig0200lux1);
indDataSet15 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig0300lux1);
indDataSet16 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig0500lux1);
indDataSet17 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig1000lux1);
indDataSet18 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig2000lux1);
indDataSet19 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig4000lux1);
indDataSet20 = find([fishMap.dataSetNumber] == EnumeratorDataSet.spontUniParRig5000lux1);



      
%join data sets
 indDataSet = [indDataSet1 indDataSet2 indDataSet3 indDataSet4 indDataSet5 indDataSet6 indDataSet7...
     indDataSet8 indDataSet9 indDataSet10 ];

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
   
   if size(BoutInf,2) == 149
       
    zeroVector = zeros(1,size(BoutInf,1))';

    BoutInf = [BoutInf zeroVector zeroVector zeroVector];

   end
   
   
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

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

BoutKinematicParametersGood = BoutKinematicParameters(indBoutsForPCA,:);
BoutInfGood  = BoutInf(indBoutsForPCA,:);

%%
%%%%%%%%%%%%%%%%% chooose kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %26 good kin pars
% indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
%     EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
%     EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
%     EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
%     EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
%     EnumeratorBoutKinPar.boutDuration];

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

% % %26 + 1st beat kin pars + 2nd beat kin pars + 3rd beat kin pars
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
%     EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2maxTailChange...
%     EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
%     EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY EnumeratorBoutKinPar.beat3maxTailChange];
%     
% 
% 

%%
%%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[boutDataPCASample] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParameters,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);

boutDataPCASample = boutDataPCASample(:,1:3);

%%
% %%%%%%%%%%%% test behavioral space reconstruction %%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% figure
% hold on
% plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), '.k')
% 
% % plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), 'or')
%  plot3(boutDataPCASample(indGoodBouts,1),boutDataPCASample(indGoodBouts,2),boutDataPCASample(indGoodBouts,3), 'og')
% 

%%
%%%%%%%%%%%%% lable bouts that have mistakes in 74kin space %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indMistakesIn74KinSpace = find(boutDataPCASample(:,3) > 10);

%look at excluded bouts 
figure
plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), '.k')
hold on
plot3(boutDataPCASample(indMistakesIn74KinSpace,1),boutDataPCASample(indMistakesIn74KinSpace,2),boutDataPCASample(indMistakesIn74KinSpace,3), 'or')


boutDataPCASampleGood = boutDataPCASample;

boutDataPCASampleGood(indMistakesIn74KinSpace,:) = [];

% figure
% plot3(boutDataPCASampleGood(:,1),boutDataPCASampleGood(:,2),boutDataPCASampleGood(:,3), '.k')
% hold on



%if data was processed before coreBout mistakesIn74KinSpace and usedToMakeBehavioralSpace this were implemented
%cope with different sizes of BoutInf
   if size(BoutInf,2) == 149
    zeroVector = zeros(1,size(BoutInf,1))';

    BoutInf = [BoutInf zeroVector zeroVector zeroVector];

   end

BoutInf(indMistakesIn74KinSpace,EnumeratorBoutInf.mistakesIn74KinSpace) = zeros(1,length(indMistakesIn74KinSpace)) + 1;
BoutInf(indBoutsForPCA,EnumeratorBoutInf.usedToMakeBehavioralSpace) = zeros(1,length(indBoutsForPCA)) + 1;


%%
% %%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
numberOfBouts2 = 250;

dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);

uniqueDataSetNumber = unique(dataSetNumber);
col = jet(length(uniqueDataSetNumber));
figure
for t = 1 : length(uniqueDataSetNumber)
    
    indThisLux = find(dataSetNumber == uniqueDataSetNumber(t));
    
     %pick random bouts
    indPerm = randperm(length(indThisLux));
    indThisLuxRand = indThisLux(indPerm(1:numberOfBouts2));
    
    
%   subplot(4,3,t)  

     subplot(4,5,t)
%  plot3(boutDataPCASample(indThisLuxRand,1),boutDataPCASample(indThisLuxRand,2),boutDataPCASample(indThisLuxRand,3),'k.', 'color',col(t,:))
 plot(boutDataPCASample(indThisLuxRand,1),boutDataPCASample(indThisLuxRand,2),'k.', 'color',col(t,:))
% hold on
axis square
  axis([-15 10, -10 5])
hold on
end


%%
%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BoutKinematicParameters = BoutKinematicParametersGood;
% BoutInf = BoutInfGood;


% % save('PCA_spontSwimming_74Kins3dim_1','boutDataPCASample','BoutInf','BoutKinematicParameters','indBoutsForPCA','behavioralSpaceStructure','-v7.3')
% 
   save('PCA_spontSwimmingMainRig_74Kins3dim_1','boutDataPCASample','BoutInf','BoutKinematicParameters','indBoutsForPCA','behavioralSpaceStructure','-v7.3')
