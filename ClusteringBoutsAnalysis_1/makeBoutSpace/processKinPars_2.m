%%
%%%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1) Uploads behavioral data from bout files
%2) Exclude broken bouts
%3) Do Z-score
%4) Do PCA from set kin pars
%5) Save kin pars and Bout Inf

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


indDataSet30 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.Beeps200to2000);
indDataSet31 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.FlashBeeps200to2000);


indDataSet32 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.bigCircleDiferentDirections2);
indDataSet33 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.BeepsLightDarkEyeConv);

% %probably not going to use
indDataSet34 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.SpontaneousMultiFishGray);
indDataSet35 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.SpontaneousMultiFishBlack2);
% indDataSet36 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.ShortLightFlash);

indDataSet36 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.LoomingDiferentSpeeds);


%join data sets
indDataSet = [indDataSet1 indDataSet2 indDataSet3 indDataSet4 indDataSet5 indDataSet6 indDataSet7 indDataSet8 indDataSet9 indDataSet10 indDataSet11 indDataSet12 indDataSet13 indDataSet14 indDataSet15 indDataSet16 indDataSet17 indDataSet18 indDataSet19 indDataSet20 ...
indDataSet21 indDataSet22 indDataSet23 indDataSet24 indDataSet25 indDataSet26 indDataSet27 indDataSet28 indDataSet29 indDataSet30 indDataSet31 indDataSet32 indDataSet33 indDataSet34 indDataSet35 indDataSet36];


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

% %26 + 1st beat kin pars + 2nd beat kin pars + 3rd beat kin pars
indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
    EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
    EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
    EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
    EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
    EnumeratorBoutKinPar.boutDuration...
    EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
    EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7 EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY EnumeratorBoutKinPar.beat1maxTailChange...    
    EnumeratorBoutKinPar.beat2beatDuration EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2 EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
    EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7 EnumeratorBoutKinPar.beat2beatAngle EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2maxTailChange...
    EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
    EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY EnumeratorBoutKinPar.beat3maxTailChange];
    
%%
%%%%%%%%%%%%%%%%% do PCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makeplot = 0;

[boutDataPCASample,meanAllVar,stdAllVar,COEFF,SCORE,latent,maxKinPars] = PCAforBehavior_4(BoutKinematicParametersGood,indKinPars,makeplot);

% figure
% hold on
% plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), 'r.')
% 
% % plot(boutDataPCASample(:,1),boutDataPCASample(:,3), 'k.')


meanPCASpace = mean(SCORE,1);

%save behavioral space vars in structure
% behavioralSpaceStructure.boutDataPCASample = boutDataPCASample;
behavioralSpaceStructure.meanAllVar = meanAllVar;
behavioralSpaceStructure.stdAllVar = stdAllVar;
behavioralSpaceStructure.COEFF = COEFF;
% behavioralSpaceStructure.SCORE = SCORE;
behavioralSpaceStructure.latent = latent;
behavioralSpaceStructure.maxKinPars = maxKinPars;
behavioralSpaceStructure.indKinPars = indKinPars;
behavioralSpaceStructure.meanPCASpace = meanPCASpace;

%%
%%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[boutDataPCASampleAllData] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParameters,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);

boutDataPCASampleAllData = boutDataPCASampleAllData(:,1:3);

%%
% %%%%%%%%%%%% test behavioral space reconstruction %%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% figure
% hold on
% plot3(boutDataPCASampleAllData(:,1),boutDataPCASampleAllData(:,2),boutDataPCASampleAllData(:,3), '.k')
% 
% % plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), 'or')
%  plot3(boutDataPCASampleAllData(indGoodBouts,1),boutDataPCASampleAllData(indGoodBouts,2),boutDataPCASampleAllData(indGoodBouts,3), 'og')
% 

%%
%%%%%%%%%%%%% lable bouts that have mistakes in 74kin space %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indMistakesIn74KinSpace = find(boutDataPCASampleAllData(:,3) > 10);

%look at excluded bouts 
figure
plot3(boutDataPCASampleAllData(:,1),boutDataPCASampleAllData(:,2),boutDataPCASampleAllData(:,3), '.k')
hold on
plot3(boutDataPCASampleAllData(indMistakesIn74KinSpace,1),boutDataPCASampleAllData(indMistakesIn74KinSpace,2),boutDataPCASampleAllData(indMistakesIn74KinSpace,3), 'or')


boutDataPCASampleAllDataGood = boutDataPCASampleAllData;

boutDataPCASampleAllDataGood(indMistakesIn74KinSpace,:) = [];

figure
plot3(boutDataPCASampleAllDataGood(:,1),boutDataPCASampleAllDataGood(:,2),boutDataPCASampleAllDataGood(:,3), '.k')
hold on



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
% %pick random bouts
% numberOfBouts = 10000;
% indAllBouts = 1 : length(boutDataPCASample);
% indPerm = randperm(length(boutDataPCASample));
% thisIndRand = indAllBouts(indPerm(1:numberOfBouts));
% 
% figure
% subplot(2,2,1)
% plot3(boutDataPCASampleAllData(thisIndRand,1),boutDataPCASampleAllData(thisIndRand,2),boutDataPCASampleAllData(thisIndRand,3), '.')
% xlabel('dim1')
% ylabel('dim2')
% zlabel('dim3')
% axis([-15 15 -15 15 -15 15])
% 
% subplot(2,2,2)
% plot3(boutDataPCASampleAllData(thisIndRand,1),boutDataPCASampleAllData(thisIndRand,2),boutDataPCASampleAllData(thisIndRand,4), '.')
% xlabel('dim1')
% ylabel('dim2')
% zlabel('dim4')
% axis([-15 15 -15 15 -15 15])
% 
% subplot(2,2,3)
% plot3(boutDataPCASampleAllData(thisIndRand,1),boutDataPCASampleAllData(thisIndRand,3),boutDataPCASampleAllData(thisIndRand,4), '.')
% xlabel('dim1')
% ylabel('dim3')
% zlabel('dim4')
% axis([-15 15 -15 15 -15 15])
% 
% subplot(2,2,4)
% plot3(boutDataPCASampleAllData(thisIndRand,2),boutDataPCASampleAllData(thisIndRand,3),boutDataPCASampleAllData(thisIndRand,4), '.')
% xlabel('dim2')
% ylabel('dim3')
% zlabel('dim4')
% axis([-15 15 -15 15 -15 15])

%%
%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BoutKinematicParameters = BoutKinematicParametersGood;
% BoutInf = BoutInfGood;

boutDataPCASample = boutDataPCASampleAllData;

save('PCA_FinalData3_74Kins3dim_1','boutDataPCASample','BoutInf','BoutKinematicParameters','indBoutsForPCA','behavioralSpaceStructure','-v7.3')

%%
%%%%%%%%%%%%% save only behavioral space structure %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('BehavioralSpace_FinalData_74Kins3dim_1','behavioralSpaceStructure','-v7.3')

