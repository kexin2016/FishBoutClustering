
function [indStimSctructure,stimNameAll] = makeIndStimSctructure_ForBehaviours(BoutInf,BoutKinematicParameters)

%%
%%%%%%%%% get data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
stimNumber = BoutInf(:,EnumeratorBoutInf.stimNumber);
% eyeConv  = BoutInf(:,EnumeratorBoutInf.eyeConv);
eyeStateCat  = BoutInf(:,EnumeratorBoutInf.eyeStateCat);


numberOfBoutInStim = BoutInf(:,EnumeratorBoutInf. numberOfBoutInStim);
latencyOfBoutAfterStim = BoutInf(:,EnumeratorBoutInf.latencyOfBoutAfterStim);

indFirstBouts = find(numberOfBoutInStim == 1);
indFirst3Bouts = find(numberOfBoutInStim <= 3);
indNotFirstBouts = find(numberOfBoutInStim > 1);
indFirst3Bouts = find(latencyOfBoutAfterStim > 3);



%%
%%%%%%%%%%%%%% OMRSpeed5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indOMRSpeed5 = find(dataSetNumber == EnumeratorDataSet.OMRSpeed5);



indThisStim = find(stimNumber >= 6);

 indStimSctructure(1).ind = intersect(indOMRSpeed5,indThisStim);


stimNameAll{1} = {'OMRSpeed5'};

%%
%%%%%%%%%%%%%%%%%% OMRTurns2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indOMRTurns2 = find(dataSetNumber == EnumeratorDataSet.OMRTurns2);


indThisStim = find(stimNumber == 9 | stimNumber == 17 |...
    stimNumber == 10 | stimNumber == 16 | stimNumber == 11 | stimNumber == 15 | stimNumber == 12 | stimNumber == 14 | stimNumber == 13);


 indStimSctructure(2).ind = intersect(indOMRTurns2,indThisStim);
stimNameAll{2} = {'OMRTurns2'};

%%
%%%%%%%%%%% Beeps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indStimStructure = [];


indBeeps  = find(dataSetNumber == EnumeratorDataSet.multiBeap200Hz100ms3min | dataSetNumber == EnumeratorDataSet.multiBeap600Hz100ms3min...
    | dataSetNumber == EnumeratorDataSet.multiBeap800Hz100ms3min & dataSetNumber == EnumeratorDataSet.multiBeap1000Hz100ms3min...
   | dataSetNumber == EnumeratorDataSet.multiBeap1200Hz100ms3min | dataSetNumber == EnumeratorDataSet.multiBeap1400Hz100ms3min...
   | dataSetNumber == EnumeratorDataSet.multiBeap1600Hz100ms3min | dataSetNumber == EnumeratorDataSet.multiBeap1800Hz100ms3min);


indBeepStimOld = find(stimNumber == 4 | stimNumber == 9 | stimNumber == 14 | stimNumber == 19 | stimNumber == 24 | stimNumber == 29 | stimNumber == 34 | stimNumber == 39 | stimNumber == 44 | stimNumber == 49);

 indStimSctructure(3).ind = intersect(indFirstBouts,intersect(indBeeps,indBeepStimOld));

stimNameAll{3} = {'Beeps'};


%%
%%%%%%%%%%%%%%%%%%% light transitions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind1 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.multiFlash3min1sManyInt3);
ind2 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.multiFlash3min1sManyInt);


indDarkFlashsDataSet = [ind1',ind2']';
indDarkFlashs = find(stimNumber ==  13 | stimNumber == 25 | stimNumber == 27 | stimNumber == 37 | stimNumber == 39 | stimNumber == 41 ...
    | stimNumber == 49 | stimNumber == 51 | stimNumber == 53 | stimNumber == 55 | stimNumber == 61 | stimNumber == 63 | stimNumber == 65 ...
| stimNumber == 67 | stimNumber == 69);

 indStimSctructure(4).ind = intersect(indFirstBouts,intersect(indDarkFlashsDataSet,indDarkFlashs));
stimNameAll{4} = {'Dark flashs'};

%%
%%%%%%%%%%%%%%%%%%%%%% phototaxis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indPhototaxis4 = find(dataSetNumber == EnumeratorDataSet.Phototaxis4);

indDarkPhotoStim = find(stimNumber ==  11 | stimNumber == 9 | stimNumber == 23 | stimNumber == 7 | stimNumber == 35 | stimNumber == 5 ...
    | stimNumber == 47 | stimNumber == 3 | stimNumber == 59 | stimNumber == 1 | stimNumber == 71 | stimNumber == 21 | stimNumber == 19 ...
| stimNumber == 33 | stimNumber == 17 | stimNumber == 45);

indStimSctructure(5).ind = intersect(indFirst3Bouts,intersect(indPhototaxis4,indDarkPhotoStim));
stimNameAll{5} = {'Phototaxis'};



%%
%%%%%%%%%%%%%%%%%%%%% prey capture %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indHunting = find(eyeStateCat ~=2);

ind1 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCapture);
ind2 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaive);
% ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaiveTu2);
% ind4 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaiveTu);

indPrey = [ind1' ind2' ]';

 indStimSctructure(6).ind = intersect(indHunting,indPrey);

stimNameAll{6} = {'Par capture'};

%%
%%%%%%%%%%%%%%%%% spont swimming %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indLightDark3min2 = find(dataSetNumber == EnumeratorDataSet.LightDark3min2);
indThisStim = find(stimNumber == 1);

 indStimSctructure(7).ind = intersect(indThisStim,indLightDark3min2);

stimNameAll{7} = {'spont light'};


%%
%%%%%%%%%%%%%%%%%%%looms %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% indLooms = find(stimNumber ==  1 | stimNumber == 14 | stimNumber == 3 | stimNumber == 13 | stimNumber == 5 | stimNumber == 11 ...
%     | stimNumber == 7 | stimNumber == 9 );
% 
indLooms = find(stimNumber ==  1 | stimNumber == 15 | stimNumber == 3 | stimNumber == 13 | stimNumber == 5 | stimNumber == 11 | stimNumber ==7 ...
    | stimNumber == 9 );





indBigCircleDiferentDirections2 = find(dataSetNumber == EnumeratorDataSet.bigCircleDiferentDirections2);
indBeforeLoom = find(latencyOfBoutAfterStim <= 2500);

 indStimSctructure(8).ind = intersect(indBeforeLoom,intersect(indLooms,indBigCircleDiferentDirections2));

stimNameAll{8} = {'looms'};

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%5 social behaviour light %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indSpontaneousMultiFishGray2 = find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishGray);

 indStimSctructure(9).ind = indSpontaneousMultiFishGray2;

stimNameAll{9} = {'social avoidance light'};

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%5 social behaviour dark %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indSpontaneousMultiFishBlack = find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishBlack2);

 indStimSctructure(10).ind = indSpontaneousMultiFishBlack;
 
 stimNameAll{10} = {'social avoidance black'};






end
