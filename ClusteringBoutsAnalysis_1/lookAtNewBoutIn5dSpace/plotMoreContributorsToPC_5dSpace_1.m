
% AddFunctionToPath
% 
 close all
% clear all


%%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %pick file of data set to analyse ROC_PreliminaryData74Kins3dimWithCutOffMedium_moreDivided
% % [FileName,PathName] =  uigetfile('*.*');
% % 
% % load(strcat(PathName,FileName));
% 
% 
%  load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto_final.mat','finalClustering')
%  load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto_final.mat','finalClustering')



%%
%%%%%%%%%%%%%%%% define color map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50; 0 0 0])./255;
idx = [3 7 4 1 2 12 8 10 11 6 9 5];


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
    plot(finalData(indThisBoutType,1),finalData(indThisBoutType,2),'.','color',col(idx(h),:))
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
%%%%%%%%%%%%%% look at cat PCA data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
% 
% uniqueBoutCat = unique(boutCat);
%
% for n  =  1 : length(uniqueBoutCat)
%     
%     indThisBoutType = find(boutCat == uniqueBoutCat(n));
%     indThisBoutTypeGood = intersect(indThisBoutType,indGoodBouts);
%     
%     
%     plot3(boutDataPCASample(indThisBoutTypeGood,1),boutDataPCASample(indThisBoutTypeGood,2),boutDataPCASample(indThisBoutTypeGood,3),'.','color',col(n,:))
%      hold on
% end
% 
% axis square




%%
%%%%%%%%%%%%% choose kin pars used in PCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indKinpars = 1:size(BoutKinematicParameters,2);

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
%%%%%%%%%%%%%%%%%%% put kinematic parameters z-score %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
meanAllVar = behavioralSpaceStructure.meanAllVar;
stdAllVar = behavioralSpaceStructure.stdAllVar;
maxKinPars = behavioralSpaceStructure.maxKinPars;
indKinPars = behavioralSpaceStructure.indKinPars;


[newScore] = placeDataIntoFixedZscoreSpace_2(BoutKinematicParameters,indKinPars,maxKinPars,meanAllVar,stdAllVar);


%%
%%%%%%%%%%%%%%% bout kin pars that are interesting %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indsBest = [1,2,37,47,48,46,40,41,38,27,43,59];

indKinNames = {'boutMaxAngularSpeed', 'boutAvrAngularSpeed', 'maxTailChangeMax', 'meanTailChangeMax',  ...
    'headMaxYaw', 'headMeanYaw', 'boutMaxAngle' ,'boutAngle', 'maxBoutFreqCorr', ...
    'boutAmplitude1Max' 'boutAmplitude2Max' 'boutAmplitude3Max' 'boutAmplitude4Max'...
    'boutAmplitude5Max' 'boutAmplitude6Max' 'boutAmplitude7Max' 'boutAmplitudeDiff' 'C1Angle' 'C1MaxAngularSpeed'...
    'C2Angle' 'C2MaxAngularSpeed' 'C1Duration' 'C2Duration' 'boutSpeedY' 'boutDistanceY'...
    'boutDuration'...
    'beat1beatDuration' 'beat1beatAmplitude1' 'beat1beatAmplitude2' 'beat1beatAmplitude3' 'beat1beatAmplitude4' 'beat1beatAmplitude5'...
    'beat1beatAmplitude6' 'beat1beatAmplitude7' 'beat1beatAngle' 'beat1beatMaxAngle' 'beat1beatMaxAngularSpeed' ...
    'beat1beatDistanceX'  'beat1beatDistanceY' 'beat1beatSpeedX' 'beat1beatSpeedY' 'beat1maxTailChange'...    
    'beat2beatDuration' 'beat2beatAmplitude1' 'beat2beatAmplitude2' 'beat2beatAmplitude3' 'beat2beatAmplitude4' 'beat2beatAmplitude5'...
    'beat2beatAmplitude6' 'beat2beatAmplitude7' 'beat2beatAngle' 'beat2beatMaxAngle' 'beat2beatMaxAngularSpeed' ...
    'beat2beatDistanceX'  'beat2beatDistanceY' 'beat2beatSpeedX' 'beat2beatSpeedY' 'beat2maxTailChange'...
    'beat3beatDuration' 'beat3beatAmplitude1' 'beat3beatAmplitude2' 'beat3beatAmplitude3' 'beat3beatAmplitude4' 'beat3beatAmplitude5'...
    'beat3beatAmplitude6' 'beat3beatAmplitude7' 'beat3beatAngle' 'beat3beatMaxAngle' 'beat3beatMaxAngularSpeed' ...
    'beat3beatDistanceX'  'beat3beatDistanceY' 'beat3beatSpeedX' 'beat3beatSpeedY' 'beat3maxTailChange'};


%bouderies for normal scale
% lowerBoundery =[0,0,0,-20,-60,0,0,0,0,0,0,0,0,0,3,0,0,0];
% higherBoundery = [300,360,40,20,60,14,130,300,250,30,20,360,40,17,360,200,80,50];
close all
lowerBoundery =[-3,-3,-3,-3.3,-3.3,-3.4,-1,-1,-1.5];
higherBoundery = [4,5,4,4,4,4,9,6,7];

lowerBoundery =[-3,-3,-3,-3.3,-3.3,-3.4,-1,-1,-1.5,-6,-7,-7];
higherBoundery = [4,5,4,4,4,4,7,6,7,4,4,3];

% %bouderies for log scale
% lowerBoundery = [0,0,-2, -3.5, -2, -2, 1,2.5, -1, 1, -3, 0, 1, -3, 2,-0.5,2.75,2.75];
% higherBoundery = [6,6,3.5,3.5,5,3.5,5,6,6,3.5,3,6,4,3,6,5.5,4.5,4];

  
 indAngleKin = find(higherBoundery >= 100);
%%
%%%%%%%%%%% make histograms by bout type %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% xAxisLabel = {};

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
uniqueBoutCat = unique(boutCat);
 

% uniqueBoutCat = unique(boutCat);
% figure
numbOfHistDivisions = 20;

 for nn = 1 : length(indsBest)
%     nn = 17
%     nn =4
    thisKinPar = newScore(:,indsBest(nn));
    
   
    
xVector = lowerBoundery(nn):higherBoundery(nn)/numbOfHistDivisions:higherBoundery(nn);
    
%     figure
figure

% %     subplot(1,2,1)
%     thisKinParThisBoutsAvr = zeros(1,length(uniqueBoutCat));
%     thisKinParThisBoutsStd = zeros(1,length(uniqueBoutCat));
%     indExclude = [];   
    
 for n  =  1 : length(uniqueBoutCat)

    
    indThisBoutType = find(boutCat == uniqueBoutCat((n)));
      indThisBoutTypeGood = intersect(indThisBoutType,indGoodBouts);

      thisKinParThisBouts = thisKinPar(indThisBoutTypeGood);
      
%     %calcualte average and std
%     thisKinParThisBoutsAvr(n) = nanmean(thisKinParThisBouts);
%     thisKinParThisBoutsStd(n) = nanstd(thisKinParThisBouts);

    %make distribution
%     figure
   [nout,xout]= hist(thisKinParThisBouts,xVector);
%    subplot(4,3,n)
   
  
   
   plot(xVector,nout/sum(nout),'color',col(idx(n),:),'linewidth',2)
   hold on
%    pause
 axis square

 end
 
   title(indKinNames{(indsBest(nn))})
%   title(nn) 

  ylabel('Probability')
%   axis([lowerBoundery(nn) higherBoundery(nn) 0 0.9])
  box off
  
%   subplot(1,2,2)
%   errorbar(1:length(uniqueBoutCat),thisKinParThisBoutsAvr,thisKinParThisBoutsStd,'o')
%    axis square

 
%  pause
 end
 
 