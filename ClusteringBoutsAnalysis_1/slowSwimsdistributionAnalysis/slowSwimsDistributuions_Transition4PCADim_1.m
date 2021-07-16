




% clear all
% close all

%%
%%%%%%%%%%%%%%% import BoutCat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');


%%
%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%% make structure with transition4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makeplot = 0;

[indStructureTransitions] = indStructureCreator_LightTransitions4_2(BoutInf,indGoodBouts,boutDataPCASample,makeplot);

%get inds of bouts

thisIndsStimAll = [];
for h = 3 : length(indStructureTransitions)
    
%     thisIndsStim =  indStructureTransitions(nn).thisInds;
         thisIndsStim =  intersect(indGoodBouts, indStructureTransitions(h).thisInds);

    thisIndsStimAll = [thisIndsStimAll thisIndsStim];

end
size(thisIndsStimAll)
 %%
%%%%%%%%%% plot bout type per stim  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);

%  indTransitions4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.DarkLightTransitions4));
indTransitions4 = intersect(indGoodBouts,thisIndsStimAll);
uniqueBoutCat = unique(boutCat);



figure
numbEachBoutType = zeros(1,length(uniqueBoutCat));
   
for n = 1 : length(uniqueBoutCat)
% n =1

    thisBoutType = find(boutCat == uniqueBoutCat(n));
    indThisBoutType = intersect(thisBoutType,indTransitions4);
    
    
% plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));
plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));

hold on
axis square
% title(stimNumb)
% pause
numbEachBoutType(n) = length(indThisBoutType);
end



% for nn = 1 : length(indStructureTransitions)
%    thisIndsStim =  indStructureTransitions(nn).thisInds;
%    stimNumb = indStructureTransitions(nn).stimNumb;
%    
%    figure
% for n = 1 : length(uniqueBoutCat)
% 
%     thisBoutType = find(boutCat == uniqueBoutCat(n));
%     indThisBoutType = intersect(thisBoutType,thisIndsStim);
%     
%     
% % plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));
% plot(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2), '.','color',col(n,:));
% 
% hold on
% axis square
% title(stimNumb)
% % pause
% 
% end
% end


%%
%%%%%%%%%%% make pca of 3 slow swims %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indSlowSwims = find(boutCat <=3);
indBoutsForPCA = intersect(indSlowSwims,indTransitions4);
BoutKinematicParametersGood = BoutKinematicParameters(indBoutsForPCA,:);


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
    
makeplot = 1;

[boutDataPCASampleSlow,meanAllVarSlow,stdAllVarSlow,COEFFSlow,SCORESlow,latentSlow,maxKinParsSlow] = PCAforBehavior_4(BoutKinematicParametersGood,indKinPars,makeplot);

% hist(boutDataPCASampleSlow(:,1),1000)

%%
%%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

meanPCASpaceSlow = mean(SCORESlow,1);


[boutDataPCASampleNew] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParameters,indKinPars,maxKinParsSlow,meanAllVarSlow,stdAllVarSlow,meanPCASpaceSlow,COEFFSlow);

boutDataPCASampleNew = boutDataPCASampleNew(:,1:3);



%%
%%%%%%%%%% plot bout type per stim  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);

indTransitions4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.DarkLightTransitions4));

uniqueBoutCat = unique(boutCat);

xVector = -15:1:20;

colJet = jet(length(indStructureTransitions)-10);

figure
% subplot(1,2,1)  
counter = 1;
for nn = 11 : length(indStructureTransitions)
   thisIndsStim =  indStructureTransitions(nn).thisInds;
   stimNumb = indStructureTransitions(nn).stimNumb;
   
   indThisBoutTypeAll = [];
for n = 1 : 3

    thisBoutType = find(boutCat == uniqueBoutCat(n));
    indThisBoutType = intersect(thisBoutType,thisIndsStim);
    
    indThisBoutTypeAll = [indThisBoutTypeAll indThisBoutType];
end   
% plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));
% plot(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2), '.','color',col(n,:));
% 
% hold on
% axis square
% title(stimNumb)
% pause
  subplot(2,4,counter)
[nout,xout] = hist(boutDataPCASampleNew(indThisBoutTypeAll,1), xVector);

plot(xVector,nout/sum(nout),'-', 'color', colJet(counter,:),'linewidth',2)

hold on
axis square

counter = counter +1;

end


 figure
% subplot(1,2,2)  
counter = 1;
indThisBoutTypeAllAll = [];
for nn = 3 : 10
   thisIndsStim =  indStructureTransitions(nn).thisInds;
   stimNumb = indStructureTransitions(nn).stimNumb;
   
   indThisBoutTypeAll = [];
for n = 1 : 3

    thisBoutType = find(boutCat == uniqueBoutCat(n));
    indThisBoutType = intersect(thisBoutType,thisIndsStim);
    
    indThisBoutTypeAll = [indThisBoutTypeAll indThisBoutType];
    

end  
    indThisBoutTypeAllAll = [indThisBoutTypeAllAll indThisBoutTypeAll];

% plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));
% plot(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2), '.','color',col(n,:));
% 
% hold on
% axis square
% title(stimNumb)
% pause
  subplot(2,4,counter)
[nout,xout] = hist(boutDataPCASampleNew(indThisBoutTypeAll,1), xVector);

plot(xVector,nout/sum(nout),'-', 'color', colJet(counter,:),'linewidth',2)

hold on
axis square

counter = counter +1;

end

figure
xVector2 = -15:0.5:20;

[nout,xout] = hist(boutDataPCASampleNew(indThisBoutTypeAllAll,1), xVector2);

plot(xVector2,nout/sum(nout),'-', 'color', 'k','linewidth',2)
title('all dark together')
hold on
axis square


%%
% %%%%%%%%%%%% make slow swims histogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %pick slow swims
% indSlowSwims = find(boutCat <=3);
% 
% figure
% subplot(1,3,1)
% hist(boutDataPCASample(indSlowSwims,1),1000)
% subplot(1,3,2)
% hist(boutDataPCASample(indSlowSwims,2),1000)
% subplot(1,3,3)
% hist(boutDataPCASample(indSlowSwims,3),1000)
% 
% 
% 
% plot3(boutDataPCASample(indSlowSwims,1),boutDataPCASample(indSlowSwims,2),boutDataPCASample(indSlowSwims,3), '.','color',col(n,:));


