

close all

dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
stimNumber = BoutInf(:,EnumeratorBoutInf.stimNumber);
latencyOfBoutAfterStim = BoutInf(:,EnumeratorBoutInf.latencyOfBoutAfterStim);

indLoomingDataSet =  find(dataSetNumber == EnumeratorDataSet.bigCircleDiferentDirections2);


indLoomingStim = find(stimNumber == 1 |stimNumber == 3 | stimNumber == 5 | stimNumber == 7 | stimNumber == 9 | stimNumber == 11 | stimNumber == 13 | stimNumber == 15);
indLoomingStim2 = find(stimNumber == 0 |stimNumber == 2 | stimNumber == 4 | stimNumber == 6 | stimNumber == 8 | stimNumber == 10 | stimNumber == 12 | stimNumber == 14);

indBeforeLooming = find(latencyOfBoutAfterStim <= 2500);
indAfterLooming = find(latencyOfBoutAfterStim > 2500);

indLooming = intersect(indBeforeLooming, intersect(indLoomingDataSet,indLoomingStim));
indLoomingAfter = intersect(indAfterLooming, intersect(indLoomingDataSet,indLoomingStim));

% 
% indBeeps =  find(dataSetNumber == EnumeratorDataSet.Beeps200to2000 | dataSetNumber == EnumeratorDataSet.FlashBeeps200to2000...
%     | dataSetNumber == EnumeratorDataSet.multiBeap200Hz100ms3min  | dataSetNumber == EnumeratorDataSet.      multiBeap400Hz100ms3min...
%      | dataSetNumber == EnumeratorDataSet.multiBeap600Hz100ms3min  | dataSetNumber == EnumeratorDataSet.multiBeap800Hz100ms3min...
%       | dataSetNumber == EnumeratorDataSet.multiBeap1000Hz100ms3min | dataSetNumber == EnumeratorDataSet.multiBeap1200Hz100ms3min...
%      | dataSetNumber == EnumeratorDataSet.multiBeap1400Hz100ms3min | dataSetNumber == EnumeratorDataSet.multiBeap1600Hz100ms3min...
%      | dataSetNumber == EnumeratorDataSet.multiBeap1800Hz100ms3min | dataSetNumber == EnumeratorDataSet.multiBeap2000Hz100ms3min...
%       | dataSetNumber == EnumeratorDataSet.multiBeapFlash200Hz100ms3min  | dataSetNumber == EnumeratorDataSet.multiBeapFlash400Hz100ms3min...
%       | dataSetNumber == EnumeratorDataSet.multiBeapFlash600Hz100ms3min   | dataSetNumber == EnumeratorDataSet.multiBeapFlash800Hz100ms3min...
%       | dataSetNumber == EnumeratorDataSet.multiBeapFlash1000Hz100ms3min  | dataSetNumber == EnumeratorDataSet.multiBeapFlash1200Hz100ms3min...
%       | dataSetNumber == EnumeratorDataSet.multiBeapFlash1400Hz100ms3min | dataSetNumber == EnumeratorDataSet.multiBeapFlash1600Hz100ms3min...
%       | dataSetNumber == EnumeratorDataSet.multiBeapFlash1800Hz100ms3min | dataSetNumber == EnumeratorDataSet.multiBeapFlash2000Hz100ms3min);
%  
  indBeepsDataSet =  find(dataSetNumber == EnumeratorDataSet.Beeps200to2000 | dataSetNumber == EnumeratorDataSet.FlashBeeps200to2000);
 
  indBeepsStim =  find(stimNumber == 4  | stimNumber == 9 | stimNumber == 14 | stimNumber == 19 | stimNumber == 24 | stimNumber == 29 | stimNumber == 34 | stimNumber == 39 | stimNumber == 44 | stimNumber == 49);
  indBeeps  = intersect(indBeepsDataSet,indBeepsStim);
  

 indDarkFlashesStim =  find(stimNumber == 13 | stimNumber == 25 | stimNumber == 27 | stimNumber == 37 | stimNumber == 39 | stimNumber == 41 | stimNumber == 49 | ...
     stimNumber == 51 |stimNumber == 53 |stimNumber == 55 |stimNumber == 61 |stimNumber == 63 |stimNumber == 65 |stimNumber == 67 |stimNumber == 69 );
     
 indDarkFlashes =intersect(indDarkFlashesStim, find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt3 | dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt));
 
 %%
 %%%%%%%%%%%%%% pick same amout of bouts from each %%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 numbBouts =250;
maxNumbeBouts =  min([length(indBeeps) length(indLooming) length(indDarkFlashes) length(indLoomingAfter)]);

  indPerm = randperm(maxNumbeBouts);
  
 indBeepsRand  = indBeeps(indPerm(1:numbBouts));
 indLoomingRand  = indLooming(indPerm(1:numbBouts));
 indDarkFlashesRand  = indDarkFlashes(indPerm(1:numbBouts));
 indLoomingAfterRand  = indLoomingAfter(indPerm(1:numbBouts));

  
  
 %%
 %%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% indMistakes = find(boutDataPCASample(:,3) < -100);
boutDataPCASample2 = boutDataPCASample;
% boutDataPCASample2(indMistakes,:) = [];

  figure
%    plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), 'k.')
hold on
 plot3(boutDataPCASample2(indLoomingRand,1),boutDataPCASample2(indLoomingRand,2),boutDataPCASample2(indLoomingRand,3), 'o','MarkerEdgeColor', 'k','MarkerFaceColor','b')
 hold on
%  plot3(boutDataPCASample2(indBeepsRand,1),boutDataPCASample2(indBeepsRand,2),boutDataPCASample2(indBeepsRand,3), 'o','MarkerEdgeColor', 'k','MarkerFaceColor','r')
 
 hold on
 plot3(boutDataPCASample2(indDarkFlashesRand,1),boutDataPCASample2(indDarkFlashesRand,2),boutDataPCASample2(indDarkFlashesRand,3), 'o','MarkerEdgeColor', 'k','MarkerFaceColor','g')
 hold on
%  plot3(boutDataPCASample2(indLoomingAfterRand,1),boutDataPCASample2(indLoomingAfterRand,2),boutDataPCASample2(indLoomingAfterRand,3), 'o','MarkerEdgeColor', 'k','MarkerFaceColor','c')
axis square
axis([-15 25 -15 15 -15 15])


 
 
 
 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
  maxBoutFreq = BoutKinematicParameters(:, EnumeratorBoutKinPar.maxBoutFreqCorr);
  meanBoutFreq = BoutKinematicParameters(:, EnumeratorBoutKinPar.meanBoutFreqCorr);
  boutAmplitude7Max = abs(BoutKinematicParameters(:, EnumeratorBoutKinPar.boutAmplitude7Max));
  boutAmplitude2Max = abs(BoutKinematicParameters(:, EnumeratorBoutKinPar.boutAmplitude2Max));

  boutMaxAngle = BoutKinematicParameters(:, EnumeratorBoutKinPar.boutMaxAngle);
  boutMaxAngularSpeed = BoutKinematicParameters(:, EnumeratorBoutKinPar.boutMaxAngularSpeed);
   
   
   
  figure
  subplot(1,3,1)
  plot(meanBoutFreq(indLoomingRand),boutAmplitude7Max(indLoomingRand), '.','MarkerEdgeColor', 'b','MarkerFaceColor','b','markerSize',10)
  hold on
 
  plot(meanBoutFreq(indBeepsRand),boutAmplitude7Max(indBeepsRand), '.','MarkerEdgeColor', 'r','MarkerFaceColor','r','markerSize',10)
  plot(meanBoutFreq(indDarkFlashesRand),boutAmplitude7Max(indDarkFlashesRand), '.','MarkerEdgeColor', 'g','MarkerFaceColor','g','markerSize',10)
%   plot(meanBoutFreq(indLoomingAfterRand),boutAmplitude7Max(indLoomingAfterRand), '.','MarkerEdgeColor', 'c','MarkerFaceColor','c','markerSize',10)
  axis square
  xlabel('meanBoutFreq')
  ylabel('boutAmplitude7Max')
  axis([15 35 0 250])

  subplot(1,3,2)
  plot(maxBoutFreq(indLoomingRand),boutAmplitude2Max(indLoomingRand), '.','MarkerEdgeColor', 'b','MarkerFaceColor','b','markerSize',10)
  hold on
 
  plot(maxBoutFreq(indBeepsRand),boutAmplitude2Max(indBeepsRand), '.','MarkerEdgeColor', 'r','MarkerFaceColor','r','markerSize',10)
  plot(maxBoutFreq(indDarkFlashesRand),boutAmplitude2Max(indDarkFlashesRand), '.','MarkerEdgeColor', 'g','MarkerFaceColor','g','markerSize',10)
%   plot(maxBoutFreq(indLoomingAfterRand),boutAmplitude2Max(indLoomingAfterRand), '.','MarkerEdgeColor', 'c','MarkerFaceColor','c','markerSize',10)
  axis square
  xlabel('maxBoutFreq')
  ylabel('boutAmplitude2Max')
  axis([20 65 0 120])

  subplot(1,3,3)
  plot(boutMaxAngle(indLoomingRand),boutMaxAngularSpeed(indLoomingRand), '.','MarkerEdgeColor', 'b','MarkerFaceColor','b','markerSize',10)
  hold on
  plot(boutMaxAngle(indBeepsRand),boutMaxAngularSpeed(indBeepsRand), '.','MarkerEdgeColor', 'r','MarkerFaceColor','r','markerSize',10)
  plot(boutMaxAngle(indDarkFlashesRand),boutMaxAngularSpeed(indDarkFlashesRand), '.','MarkerEdgeColor', 'g','MarkerFaceColor','g','markerSize',10)
%   plot(boutMaxAngle(indLoomingAfterRand),boutMaxAngularSpeed(indLoomingAfterRand), '.','MarkerEdgeColor', 'c','MarkerFaceColor','c','markerSize',10)
  axis square
  xlabel('boutMaxAngle')
  ylabel('boutMaxAngularSpeed')
  axis([0 250 0 20])

