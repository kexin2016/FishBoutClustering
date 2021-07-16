function [indStimSctructure,stimNameAll] = makeIndStimSctructure_4(BoutInf,BoutKinematicParameters)

%%
%%%%%%%%% get data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
stimNumber = BoutInf(:,EnumeratorBoutInf.stimNumber);
eyeConv  = BoutInf(:,EnumeratorBoutInf.eyeConv);
numberOfBoutInStim = BoutInf(:,EnumeratorBoutInf. numberOfBoutInStim);


boutMaxAngularSpeed = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutMaxAngularSpeed);
boutMaxAngle = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutMaxAngle);
boutAngle = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutAngle);
boutAmplitude8Max = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutAmplitude8Max);
maxBoutFreqCorr = BoutKinematicParameters(:,EnumeratorBoutKinPar.maxBoutFreqCorr);
boutDistanceX = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutDistanceX);
latencyOfBoutAfterStim = BoutInf(:,EnumeratorBoutInf.latencyOfBoutAfterStim);


uniqueBoutCat = unique(boutCat);
% col = finalClustering.colorMap;



indFirstBouts = find(numberOfBoutInStim == 1);
indFirst3Bouts = find(numberOfBoutInStim <= 3);
indNotFirstBouts = find(numberOfBoutInStim > 1);
indFirst3Bouts = find(latencyOfBoutAfterStim > 6000);



%%
%%%%%%%%%%%%%% OMRSpeed5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indStimSctructure = [];
stimNameAll = [];

indOMRSpeed5 = find(dataSetNumber == EnumeratorDataSet.OMRSpeed5);
stimNumberOMRSpeed5 = BoutInf(indOMRSpeed5,EnumeratorBoutInf.stimNumber);

uniqueStimNumberOMRSpeed5 = unique(stimNumberOMRSpeed5);

stimName = {'OMRSpeed5 spont','OMRSpeed5 0 mm/s','OMRSpeed5 2.5 mm/s','OMRSpeed5 5 mm/s','OMRSpeed5 7.5 mm/s','OMRSpeed5 10 mm/s','OMRSpeed5 15 mm/s','OMRSpeed5 20 mm/s','OMRSpeed5 30 mm/s','OMRSpeed5 40 mm/s','OMRSpeed5 50 mm/s'};
stimNameAll = [];

for n = 1 : length(uniqueStimNumberOMRSpeed5)
    
    indThisStims = find(stimNumber == uniqueStimNumberOMRSpeed5(n));
   
    indStimSctructure(n).ind = intersect(indOMRSpeed5,indThisStims);
    
    

end

%update stim name
stimNameAll = [stimNameAll stimName];
counter = length(uniqueStimNumberOMRSpeed5) +1;

%counter 11
%%
%%%%%%%%%%%%%%%%%% OMRTurns2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indOMRTurns2 = find(dataSetNumber == EnumeratorDataSet.OMRTurns2);
stimNumberOMRTurns2 = BoutInf(indOMRTurns2,EnumeratorBoutInf.stimNumber);

uniqueStimNumberOMRTurns2 = unique(stimNumberOMRTurns2);

indOMRTurnsStimStrcut(1).ind = -1;
indOMRTurnsStimStrcut(2).ind = 0;
indOMRTurnsStimStrcut(3).ind = 1;
indOMRTurnsStimStrcut(4).ind = [2 24];
indOMRTurnsStimStrcut(5).ind = [3 23];
indOMRTurnsStimStrcut(6).ind = [4 22];
indOMRTurnsStimStrcut(7).ind = [5 21];
indOMRTurnsStimStrcut(8).ind = [6 20];
indOMRTurnsStimStrcut(9).ind = [7 19];
indOMRTurnsStimStrcut(10).ind = [8 18];
indOMRTurnsStimStrcut(11).ind = [9 17];
indOMRTurnsStimStrcut(12).ind = [10 16];
indOMRTurnsStimStrcut(13).ind = [11 15];
indOMRTurnsStimStrcut(14).ind = [12 14];
indOMRTurnsStimStrcut(15).ind = 13;

stimName = {'OMRTurns2 no stim','OMRTurns2 static grating','OMRTurns2 0','OMRTurns2 15','OMRTurns2 30','OMRTurns2 45','OMRTurns2 60','OMRTurns2 75','OMRTurns2 90','OMRTurns2 105','OMRTurns2 120','OMRTurns2 135','OMRTurns2 150','OMRTurns2 165','OMRTurns2 180'};


for n = 1 : length(indOMRTurnsStimStrcut)
    
    
    indThisStimsFromStruct =  indOMRTurnsStimStrcut(n).ind;
    
    indThisStimsAll = [];
    for nn = 1 : length(indThisStimsFromStruct)
    
    
    
    indThisStims = find(stimNumber == indThisStimsFromStruct(nn));
    
   indThisStimsAll = [indThisStimsAll' indThisStims']';
    
    
    end
    
        indStimSctructure(counter).ind = intersect(indOMRTurns2,indThisStimsAll);
    
        counter = counter +1;  
    

end

%update stim name
stimNameAll = [stimNameAll stimName];

%counter at 26


%%
%%%%%%%%%%% Beeps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


indStimStructure = [];
indStimStructure2 = [];

dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
numberOfBoutInStim  = BoutInf(:,EnumeratorBoutInf.numberOfBoutInStim); 
stimNumber  = BoutInf(:,EnumeratorBoutInf.stimNumber); 

indStimStructure(1).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap200Hz100ms3min);
indStimStructure(2).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap400Hz100ms3min);
indStimStructure(3).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap600Hz100ms3min);
indStimStructure(4).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap800Hz100ms3min);
indStimStructure(5).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap1000Hz100ms3min);
indStimStructure(6).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap1200Hz100ms3min);
indStimStructure(7).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap1400Hz100ms3min);
indStimStructure(8).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap1600Hz100ms3min);
indStimStructure(9).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap1800Hz100ms3min);
indStimStructure(10).ind  = find(dataSetNumber == EnumeratorDataSet.multiBeap2000Hz100ms3min);

indStimStructure(11).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash200Hz100ms3min);
indStimStructure(12).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash400Hz100ms3min);
indStimStructure(13).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash600Hz100ms3min);
indStimStructure(14).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash800Hz100ms3min);
indStimStructure(15).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1000Hz100ms3min);
indStimStructure(16).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1200Hz100ms3min);
indStimStructure(17).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1400Hz100ms3min);
indStimStructure(18).ind = [];
indStimStructure(19).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1800Hz100ms3min);
indStimStructure(20).ind = find(dataSetNumber == EnumeratorDataSet.multiBeapFlash2000Hz100ms3min);

indBeeps200to2000 = find(dataSetNumber == EnumeratorDataSet.Beeps200to2000);
indFlashBeeps200to2000 = find(dataSetNumber == EnumeratorDataSet.FlashBeeps200to2000);
indShortLightFlash = find(dataSetNumber == EnumeratorDataSet.ShortLightFlash);


%beep
indBeepStimOld = find(stimNumber == 4 | stimNumber == 9 | stimNumber == 14 | stimNumber == 19 | stimNumber == 24 | stimNumber == 29 | stimNumber == 34 | stimNumber == 39 | stimNumber == 44 | stimNumber == 49);

%beep
indStimStructure2(1).ind = find(stimNumber == 4);
indStimStructure2(2).ind = find(stimNumber == 9);
indStimStructure2(3).ind = find(stimNumber == 14);
indStimStructure2(4).ind = find(stimNumber == 19);
indStimStructure2(5).ind = find(stimNumber == 24);
indStimStructure2(6).ind = find(stimNumber == 29);
indStimStructure2(7).ind = find(stimNumber == 34);
indStimStructure2(8).ind = find(stimNumber == 39);
indStimStructure2(9).ind = find(stimNumber == 44);
indStimStructure2(10).ind = find(stimNumber == 49);

ind1stBout = find(numberOfBoutInStim == 1);
dataSetName2 = {'Beep200hz','Beep400hz','Beep600hz','Beep800hz','Beep1000hz','Beep1200hz','Beep1400hz','Beep1600hz','Beep1800hz','Beep2000hz','FlashBeep200hz','FlashBeep400hz','FlashBeep600hz','FlashBeep800hz','FlashBeep1000hz','FlashBeep1200hz','FlashBeep1400hz','FlashBeep1600hz','FlashBeep1800hz','FlashBeep2000hz'};



counter2 = 1;
allStimSctrut = [];

    
    for ii = 1 : length(indStimStructure)
%      ii =1   
       ind2 = indStimStructure(ii).ind;
        
       indFinal = intersect(ind1stBout,intersect(indBeepStimOld,ind2));
       

       allStimSctrut(counter2).ind = indFinal;
        
       counter2 = counter2 + 1;   
    end
    
    
    for ii = 1 : length(indStimStructure2)
%      ii =1   
       ind2 = indStimStructure2(ii).ind;
        
       indFinal = intersect(ind1stBout,intersect(indBeeps200to2000,ind2));

       allStimSctrut(counter2).ind = indFinal;
        
       counter2 = counter2 + 1;    
    end

   for ii = 1 : length(indStimStructure2)
%      ii =1   
       ind2 = indStimStructure2(ii).ind;
        
       indFinal = intersect(ind1stBout,intersect(indFlashBeeps200to2000,ind2));

       allStimSctrut(counter2).ind = indFinal;
        
       counter2 = counter2 + 1;   
   end    
    
   

for t = 1 : 20
    indThisStim1 = allStimSctrut(t).ind;
    indThisStim2 = allStimSctrut(20 + t).ind;
    
    indThisStim = [indThisStim1' indThisStim2']';

    
    
    indStimSctructure(counter).ind = indThisStim;
    

   
    counter = counter + 1;
end   

stimNameAll = [stimNameAll dataSetName2];


% %look at beeps
% for h = 27:length(indStimSctructure)
% 
%     thisInds = indStimSctructure(h).ind;
% 
%     clf
%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), 'k.')
%     axis([-20 20, -15 15])
%     title(stimNameAll{h})
%     pause
% end

%counter at 46

%%
%%%%%%%%%%% Look at prey capture %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stimName = {'Prey NotEyeConv','Prey EyeConv' ,'PreyNaive NotEyeConv','PreyNaive EyeConv','Spont Light NotEyeConv' ,'Spont Light EyeConv'};

indDataSetStruct2(1).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCapture);
indDataSetStruct2(2).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaive);
indDataSetStruct2(3).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.SpontanousEyeTracking);

indNotEyeConv = find(eyeConv == 1);
indEyeConv = find(eyeConv == 2);

eyeStateStruct(1).ind2 = indNotEyeConv;
eyeStateStruct(2).ind2 = indEyeConv;

for n = 1 : length(eyeStateStruct)
            indEyeState = eyeStateStruct(n).ind2;

    
     for h = 1:length(indDataSetStruct2)
         
        
    indThisDataSet = indDataSetStruct2(h).ind;
    
    indThisBouts = intersect(indEyeState,indThisDataSet);
      
    indStimSctructure(counter).ind = indThisBouts;


    counter = counter +1;
     end
end

stimNameAll = [stimNameAll stimName];
%counter at 52

%%
%%%%%%%%% look at Obends Dark Flashs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indDataSetStruct3(1).ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.multiFlash3min1sManyInt3);
indDataSetStruct3(2).ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.multiFlash3min1sManyInt);

% uniqueStimNumberAll = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71];


%pick Dark flashs
uniqueStimNumber = [ 13 , 25 , 27 , 37 , 39 , 41, 49, 51 , 53 , 55 , 61 , 63 , 65 , 67 , 69];

for n = 1 : length(indDataSetStruct3)

%      n =1
    indThisDataSet = indDataSetStruct3(n).ind3;
    

    for hh = 1 : length(uniqueStimNumber)
%      hh = 1   
       
    %get stims    
     indThisStims = find(stimNumber == uniqueStimNumber(hh));
%     length(indThisStims)

    %pick firstBouts
    indFirstBoutsAll = intersect(indFirstBouts,indThisStims);
    %pick from this data set
    indFirstBoutsThisDataSet = intersect(indFirstBoutsAll,indThisDataSet);

    indStimSctructure(counter).ind = indFirstBoutsThisDataSet;
       
    stimName(counter) = {'DarkFlashs'};

    
    counter  = counter +1;

    end

 end
stimNameAll = [stimNameAll stimName];
%counter at 82

%%
%%%%%%%%% look at Obends Light Flashs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indDataSetStruct3(1).ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.multiFlash3min1sManyInt);
indDataSetStruct3(2).ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.multiFlash3min1sManyInt3);

% uniqueStimNumberAll = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71];


%pick Dark flashs
uniqueStimNumber = [ 3 , 5 , 7 , 9 , 11 , 17 , 19 , 21 , 23 , 31 , 33 , 35 , 45 , 47 , 59];

for n = 1 : length(indDataSetStruct3)

%      n =1
    indThisDataSet = indDataSetStruct3(n).ind3;
    

    for hh = 1 : length(uniqueStimNumber)
%      hh = 1   
       
    %get stims    
     indThisStims = find(stimNumber == uniqueStimNumber(hh));
%     length(indThisStims)

    %pick firstBouts
    indFirstBoutsAll = intersect(indFirstBouts,indThisStims);
    %pick from this data set
    indFirstBoutsThisDataSet = intersect(indFirstBoutsAll,indThisDataSet);

    indStimSctructure(counter).ind = indFirstBoutsThisDataSet;
       
    stimName(counter) = {'Light Flashs'};

    
    counter  = counter +1;

    end

 end
stimNameAll = [stimNameAll stimName];
%counter at 112
%%
%%%%%%%%% look at Obends Spont %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indDataSetStruct3(1).ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.multiFlash3min1sManyInt3);
indDataSetStruct3(2).ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.multiFlash3min1sManyInt);

% uniqueStimNumberAll = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71];


%pick Dark flashs
uniqueStimNumber = [ 1 , 15 , 29 , 43 , 57 , 71];

for n = 1 : length(indDataSetStruct3)

%      n =1
    indThisDataSet = indDataSetStruct3(n).ind3;
    

    for hh = 1 : length(uniqueStimNumber)
%      hh = 1   
       
    %get stims    
     indThisStims = find(stimNumber == uniqueStimNumber(hh));
%     length(indThisStims)

    %pick firstBouts
    indFirstBoutsThisDataSet = intersect(indThisDataSet,indThisStims);
    %pick from this data set

    indStimSctructure(counter).ind = indFirstBoutsThisDataSet;
       
    stimName(counter) = {'Spont Obend data set'};

    
    counter  = counter +1;

    end

 end
stimNameAll = [stimNameAll stimName];
%counter at 124
%%
 %%%%%%%%%%% look at phototaxis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

indPhototaxis4 = find(dataSetNumber == EnumeratorDataSet.Phototaxis4);
stimNumberPhototaxis4 = BoutInf(indPhototaxis4,EnumeratorBoutInf.stimNumber);

uniqueStimNumberPhototaxis4 = unique(stimNumberPhototaxis4);
% uniqueStimNumberPhototaxis4 = uniqueStimNumberPhototaxis4(2:2:end);%light adaptation
 uniqueStimNumberPhototaxis4 = uniqueStimNumberPhototaxis4(1:2:end);%phototaxis

 
indPhototaxis4StimStrcut(1).ind = 11;%125
indPhototaxis4StimStrcut(2).ind = [9 23];%126
indPhototaxis4StimStrcut(3).ind = [7 35];%127
indPhototaxis4StimStrcut(4).ind = [5 47];%128
indPhototaxis4StimStrcut(5).ind = [3 59];%129
indPhototaxis4StimStrcut(6).ind = [1 71];%130
indPhototaxis4StimStrcut(7).ind = 21;%131
indPhototaxis4StimStrcut(8).ind = [19 33];%132
indPhototaxis4StimStrcut(9).ind = [17 45];%133
indPhototaxis4StimStrcut(10).ind = [15 57];%134
indPhototaxis4StimStrcut(11).ind = [13 69];%135
indPhototaxis4StimStrcut(12).ind = 31;%136
indPhototaxis4StimStrcut(13).ind = [29 43];%137
indPhototaxis4StimStrcut(14).ind = [27 55];%138
indPhototaxis4StimStrcut(15).ind = [25 67];%139
indPhototaxis4StimStrcut(16).ind = 41;%140
indPhototaxis4StimStrcut(17).ind = [39 53];%141
indPhototaxis4StimStrcut(18).ind = [37 65];%142
indPhototaxis4StimStrcut(19).ind = 51;%143
indPhototaxis4StimStrcut(20).ind = [49 63];%144
indPhototaxis4StimStrcut(21).ind = 61;%145

 

for n = 1 : length(indPhototaxis4StimStrcut)
%     n =1
% n


    indOfStims = indPhototaxis4StimStrcut(n).ind;
    
    indThisStimsAll = [];
    for nn = 1 : length(indOfStims)
    
        indThisStims = find(stimNumber == uniqueStimNumberPhototaxis4(n));
        
        indThisStimsAll = [indThisStimsAll' indThisStims']';
        
    end
    
    
   
   
   indThisBouts1 = intersect(indFirst3Bouts,indThisStimsAll);
   indThisBouts = intersect(indPhototaxis4,indThisBouts1);
     
    indStimSctructure(counter).ind = indThisBouts;

   
   stimName{counter} = {'Phototaxis4'};
   
   
   counter = counter + 1;

    
    
end
 
stimNameAll = [stimNameAll stimName];
%counter at 146


%%
%%%%%%%%%%% look at light and dark %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stimName = {'Spont Light','Spont Dark'};

indLightDark3min2 = find(dataSetNumber == EnumeratorDataSet.LightDark3min2);

stimNumberLightDark3min2 = BoutInf(indLightDark3min2,EnumeratorBoutInf.stimNumber);

uniqueStimNumberLightDark3min2 = unique(stimNumberLightDark3min2);

%exclude -1 stim
uniqueStimNumberLightDark3min2(1) = [];

for n = 1 : length(uniqueStimNumberLightDark3min2)
    
    indThisStims = find(stimNumber == uniqueStimNumberLightDark3min2(n));
  
   
       indThisBoutsAll = intersect(indLightDark3min2,indThisStims);

   indStimSctructure(counter).ind = indThisBoutsAll;

   
   counter = counter +1;
  

end

stimNameAll = [stimNameAll stimName];

%counter at 148


%%
%%%%%%%%%%%% spont swimming 3min dark %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stimName = {'spont dark 12','spont dark 44','spont dark 104','spont dark 232','spont dark 447', 'spont dark 790', 'spont dark 1890','spont dark 4700'};




latencyThresholdDark = 30.*700;
indLatencyDark = find( latencyOfBoutAfterStim > latencyThresholdDark);

indDarkLightTransitions4 = find(dataSetNumber == EnumeratorDataSet.DarkLightTransitions4);

darkStim1 = 2:4:32;
darkStim2 = 4:4:32;


for n = 1 : length(darkStim1)

    indThisStim1 = find(stimNumber == darkStim1(n));
    indThisStim2 = find(stimNumber == darkStim2(n));

    indThisStim = [indThisStim1' indThisStim2']';
    
    indThisBouts = intersect(intersect(intersect(indThisStim,indDarkLightTransitions4),indNotFirstBouts),indLatencyDark);
    
    
      indStimSctructure(counter).ind = indThisBouts;
    
     
%        subplot(4,4,n)
%    plot(boutDataPCASample(indThisBouts,1),boutDataPCASample(indThisBouts,2), '.k');
%  axis([-15 10, -10 5])
%  axis square
%     
       counter = counter +1;

end

stimNameAll = [stimNameAll stimName];

%%
%%%%%%%%%%%% spont swimming 3min dark %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stimName = {'spont light 12','spont light 44','spont light 104','spont light 232','spont light 447', 'spont light 790', 'spont light 1890','spont light 4700'};




latencyThresholdLight = 30.*700;

latencyThresholdLight = 30.*700;
indLatencyLight = find( latencyOfBoutAfterStim > latencyThresholdLight);


lightStim1 = 1:4:31;
lightStim2 = 3:4:31;
 
for n = 1 : length(lightStim1)

    indThisStim1 = find(stimNumber == lightStim1(n));
    indThisStim2 = find(stimNumber == lightStim2(n));

    indThisStim = [indThisStim1' indThisStim2']';
    
    indThisBouts = intersect(intersect(intersect(indThisStim,indDarkLightTransitions4),indNotFirstBouts),indLatencyLight);
    
    
      indStimSctructure(counter).ind = indThisBouts;
    
     
%        subplot(4,4,n)
%    plot(boutDataPCASample(indThisBouts,1),boutDataPCASample(indThisBouts,2), '.k');
%  axis([-15 10, -10 5])
%  axis square
%     
       counter = counter +1;

end

stimNameAll = [stimNameAll stimName];

%%
%%%%%%%%%%%%%% shadow avoidance with different angles %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %all stims
% indStimForBigCircle = 1 : 2: 15;
% stimName = {'0 deg','315 deg','270 deg','225 deg','180 deg','135 deg','90 deg','45 deg'};
% 
% indBigCircleDiferentDirections2 = find(dataSetNumber == EnumeratorDataSet.bigCircleDiferentDirections2);
% 
% 
% 
%  idx = [1,8,7,6,5,4,3,2];
% 
% indBeforeLoom = find(latencyOfBoutAfterStim <= 2500);
% 
% for h  = 1 : length(indStimForBigCircle)%loop through each stim
% 
%     indThisStim = find(stimNumber == indStimForBigCircle(idx(h)));
%     
%     indThisStimBigCircle = intersect(indThisStim,indBigCircleDiferentDirections2);
%     indThisStimFinal =  intersect(indThisStimBigCircle,indBeforeLoom);
%     
%       indStimSctructure(counter).ind = indThisStimFinal;
%     
%  counter = counter +1;
% 
% end
% 
% stimNameAll = [stimNameAll stimName{idx}];

%%
%%%%%%%%%%%%%% shadow avoidance with different angles %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indStimForBigCircle = 1 : 2: 15;
%colapsed stims
indStimForBigCircleSruct(1).ind = 1;
indStimForBigCircleSruct(2).ind = [15 3];
indStimForBigCircleSruct(3).ind = [13 5];
indStimForBigCircleSruct(4).ind = [11 7];
indStimForBigCircleSruct(5).ind = [9];



% stimName = {'0 deg','315 deg','270 deg','225 deg','180 deg','135 deg','90 deg','45 deg'};
stimName = {'0 deg','45 deg','90 deg','135 deg','180 deg'};



indBigCircleDiferentDirections2 = find(dataSetNumber == EnumeratorDataSet.bigCircleDiferentDirections2);



 

indBeforeLoom = find(latencyOfBoutAfterStim <= 2500);

for h  = 1 : length(indStimForBigCircleSruct)%loop through each stim

%     indThisStim = find(stimNumber == indStimForBigCircle(idx(h)));
    indSetOfStims = indStimForBigCircleSruct(h).ind;
    
    indThisStimFinalAll = [];
    for hh = 1 : length(indSetOfStims)
        
        indThisStim = find(stimNumber == indSetOfStims(hh));
        
        
        indThisStimBigCircle = intersect(indThisStim,indBigCircleDiferentDirections2);
        indThisStimFinal =  intersect(indThisStimBigCircle,indBeforeLoom);
        indThisStimFinalAll = [indThisStimFinalAll' indThisStimFinal']';
    end
    
   
    
      indStimSctructure(counter).ind = indThisStimFinalAll;
    
 counter = counter +1;

end

stimNameAll = [stimNameAll stimName];



%%
%%%%%%%%%%%%%% shadow avoidance different speeds %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indLoomingSpeed = 1:2:47;

 indLoomingDiferentSpeeds = find(dataSetNumber == EnumeratorDataSet.LoomingDiferentSpeeds);
 
 indStimForLoomingSpeedStruct(1).ind = [indLoomingSpeed(1),indLoomingSpeed(2),indLoomingSpeed(3),indLoomingSpeed(4)];
 indStimForLoomingSpeedStruct(2).ind = [indLoomingSpeed(5),indLoomingSpeed(6),indLoomingSpeed(7),indLoomingSpeed(8)];
 indStimForLoomingSpeedStruct(3).ind = [indLoomingSpeed(9),indLoomingSpeed(10),indLoomingSpeed(11),indLoomingSpeed(12)];
 indStimForLoomingSpeedStruct(4).ind = [indLoomingSpeed(13),indLoomingSpeed(14),indLoomingSpeed(15),indLoomingSpeed(16)];
 indStimForLoomingSpeedStruct(5).ind = [indLoomingSpeed(17),indLoomingSpeed(18),indLoomingSpeed(19),indLoomingSpeed(20)];
 indStimForLoomingSpeedStruct(6).ind = [indLoomingSpeed(21),indLoomingSpeed(22),indLoomingSpeed(23),indLoomingSpeed(24)];
 
 stimName = {'0.25 mm/s','0.5 mm/s','1 mm/s','1.5 mm/s','2 mm/s','2.5 mm/s'};

loomingLatency = ([16,8,4,2.67,2,1.6]).*1000;% in ms



 for h  = 1 : length(indStimForLoomingSpeedStruct)%loop through each stim
     
     %     indThisStim = find(stimNumber == indStimForBigCircle(idx(h)));
    indSetOfStims = indStimForLoomingSpeedStruct(h).ind;
    
    indBeforeLoom = find(latencyOfBoutAfterStim <= loomingLatency(h));

    indThisStimFinalAll = [];
     for hh = 1 : length(indSetOfStims)
         
           indThisStim = find(stimNumber == indSetOfStims(hh));
         
        indThisStimBigCircle = intersect(indThisStim,indLoomingDiferentSpeeds);
        indThisStimFinal =  intersect(indThisStimBigCircle,indBeforeLoom);
         
         indThisStimFinalAll = [indThisStimFinalAll' indThisStimFinal']';
     end
     
      
      indStimSctructure(counter).ind = indThisStimFinalAll;
    
 counter = counter +1;

 end
 
 stimNameAll = [stimNameAll stimName];

 
%%
%%%%%%%%%%% Look at prey capture %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stimName = {'Par NotEyeConv ','Par EyeConv' , 'Par UnconvBouts','ParNaive NotEyeConv','ParNaive EyeConv','Spont Light NotEyeConv' ,'Spont Light EyeConv'};
stimName = {'spont indNotEyeConv','spont indEyeConv','spont indUnconvBouts','parNaive indNotEyeConv','parNaive indEyeConv','parNaive indUnconvBouts',...
    'parExp indNotEyeConv','parExp indEyeConv','parExp indUnconvBouts', 'rotNaive indNotEyeConv','rotNaive indEyeConv','rotNaive indUnconvBouts',...
    'rotExp indNotEyeConv','rotExp indEyeConv','rotExp indUnconvBouts'};

eyeConvDiffAll = BoutInf(:,EnumeratorBoutInf.eyeConvDiff);

indUnconvBouts =  find(eyeConvDiffAll <= -25);%unconverging bouts

indDataSetStruct2(1).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.SpontanousEyeTracking);
indDataSetStruct2(2).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaive);
indDataSetStruct2(3).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCapture);

ind1 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureSmallRotTuNaive);
ind2 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureSmallRotTuNaive2);
ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaiveTu2);
ind4 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaiveTu);




indDataSetStruct2(4).ind = [ind1' ind2' ind3' ind4']';

ind5 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureSmallRotTuWithRot);
ind6 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureExpTu);
ind7 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureExpTu2);



indDataSetStruct2(5).ind = [ind5' ind6' ind7']';


indNotEyeConv = find(eyeConv == 1);
indEyeConv = find(eyeConv == 2);

eyeStateStruct(1).ind2 = indNotEyeConv;
eyeStateStruct(2).ind2 = indEyeConv;
eyeStateStruct(3).ind2 = intersect(indNotEyeConv, indUnconvBouts);

for n = 1 : length(eyeStateStruct)
            indEyeState = eyeStateStruct(n).ind2;

    
     for h = 1:length(indDataSetStruct2)
         
        
    indThisDataSet = indDataSetStruct2(h).ind;
    
    indThisBouts = intersect(indEyeState,indThisDataSet);
      
    indStimSctructure(counter).ind = indThisBouts;


    counter = counter +1;
     end
end

stimNameAll = [stimNameAll stimName];
%counter at 52

 
% 
% 
% 
% stimTitle = {'front 0.25 cm/s','Left 0.25 cm/s','Back 0.25 cm/s','Right 0.25 cm/s',...
%     'front 0.5 cm/s','Left 0.5 cm/s','Back 0.5 cm/s','Right 0.5 cm/s',...
%     'front 1 cm/s','Left 1 cm/s','Back 1 cm/s','Right 1 cm/s'...
%     'front 1.5 cm/s','Left 1.5 cm/s','Back 1.5 cm/s','Right 1.5 cm/s'...
%     'front 2 cm/s','Left 2 cm/s','Back 2 cm/s','Right 2 cm/s'...
%     'front 2.5 cm/s','Left 2.5 cm/s','Back 2.5 cm/s','Right 2.5 cm/s'};
% 
% lineVal = [16,16,16,16,8,8,8,8,4,4,4,4,2.67,2.67,2.67,2.67,2,2,2,2,1.666,1.666,1.666,1.666];% in sec
% 
% 

%%
%%%%%%%%%%%%%%%%%%%%%%%% get social behaviour %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indStimSctructure(counter).ind = find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishGray);
stimNameAll{counter} = 'social1000Lux';
counter = counter +1;

indStimSctructure(counter).ind = find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishBlack2);
stimNameAll{counter} = 'social0Lux';
counter = counter +1;

%190 and 191

%%
%%%%%%%%%%%%%%%%%% prey capture according to eye states %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% stimName = {'spont spont','spont start','spont conv','spont end',...
%    'parNaive spont','parNaive start','parNaive conv','parNaive end',...
%    'parExp spont','parExp start','parExp conv','parExp end',...
%     'RotNaive spont','RotNaive start','RotNaive conv','RotNaive end',...
%      'RotExp spont','RotExp start','RotExp conv','RotExp end'};

stimName = {'spont spont','spont start','spont conv','spont end',...
   'parNaive spont','parNaive start','parNaive conv','parNaive end',...
   'parExp spont','parExp start','parExp conv','parExp end',...
    'RotNaive spont','RotNaive start','RotNaive conv','RotNaive end',...
     'RotExp spont','RotExp start','RotExp conv','RotExp end'};


% 
eyeStateCat = BoutInf(:,EnumeratorBoutInf.eyeStateCat);


indDataSetStruct2(1).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.SpontanousEyeTracking);
indDataSetStruct2(2).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaive);
indDataSetStruct2(3).ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCapture);

ind1 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureSmallRotTuNaive);
ind2 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureSmallRotTuNaive2);
ind3 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaiveTu2);
ind4 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaiveTu);




indDataSetStruct2(4).ind = [ind1' ind2' ind3' ind4']';

ind5 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureSmallRotTuWithRot);
ind6 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureExpTu);
ind7 = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureExpTu2);



indDataSetStruct2(5).ind = [ind5' ind6' ind7']';


indNotEyeConv = find(eyeConv == 1);
indEyeConv = find(eyeConv == 2);

eyeStateStruct(1).ind2 = find(eyeStateCat == 2);%not - not
eyeStateStruct(2).ind2 = find(eyeStateCat == 1);%not-conv
eyeStateStruct(3).ind2 = find(eyeStateCat == 3);%conv - conv
eyeStateStruct(4).ind2= find(eyeStateCat == 4);%conv - not



for n = 1 : length(eyeStateStruct)%loop through eye state
            indEyeState = eyeStateStruct(n).ind2;

    
     for h = 1:length(indDataSetStruct2)%loop through dataset
         
        
    indThisDataSet = indDataSetStruct2(h).ind;
    
    indThisBouts = intersect(indEyeState,indThisDataSet);
      
    indStimSctructure(counter).ind = indThisBouts;


    counter = counter +1;
     end
end

stimNameAll = [stimNameAll stimName];


