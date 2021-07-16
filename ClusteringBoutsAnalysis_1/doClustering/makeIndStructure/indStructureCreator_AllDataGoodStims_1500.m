function [indStructure2] = indStructureCreator_AllDataGoodStims_1500(BoutInf,indGoodBouts,boutDataPCASample,makeplot)



%%
%%%%%%%%%%%%%%%% pick data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
numberOfBoutInStim = BoutInf(:,EnumeratorBoutInf.numberOfBoutInStim);
stimNumber = BoutInf(:,EnumeratorBoutInf.stimNumber);
eyeConv = BoutInf(:,EnumeratorBoutInf.eyeConv);

indFirstBouts = find(numberOfBoutInStim == 1);


%%
%%%%%%%%%%%%%% get inds of all stims %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueStimNumbers = unique(stimNumber);

clear vars  stimIndStructure

for x  = 1 : length(uniqueStimNumbers)

    thisInd = find(stimNumber == uniqueStimNumbers(x));
    
    %use only good bouts
    thisIndGood = intersect(indGoodBouts,thisInd)';

    stimIndStructure(x).thisInd = thisIndGood;
    stimIndStructure(x).thisStimNumber = uniqueStimNumbers(x);
    
end
% unique(stimNumber)

stimIndStructure(1) = [];

%%
%%%%%%%%%%% get inds for all data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indOMRTurns2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.OMRTurns2))';%1-13
indOMRSpeed5 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.OMRSpeed5))';%14-23

indLightDark3min2 =  intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LightDark3min2))';%24-27

indMultiFlash3min1sManyInt = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt))';%28 dark; 29 light
indMultiFlash3min1sManyInt3 =  intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt3))';%30 dark; 31 light

indmultiBeap200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap200Hz100ms3min))';%32
indmultiBeap400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap400Hz100ms3min))';%33
indmultiBeap600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap600Hz100ms3min))';%34
indmultiBeap800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap800Hz100ms3min))';%35
indmultiBeap1000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1000Hz100ms3min))';%36
indmultiBeap1200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1200Hz100ms3min))'; %37
indmultiBeap1400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1400Hz100ms3min))';%38
indmultiBeap1600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1600Hz100ms3min))'; %39
indmultiBeap1800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1800Hz100ms3min))';%40
indmultiBeap2000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap2000Hz100ms3min))'; %41
indmultiBeapFlash200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash200Hz100ms3min))'; %42
indmultiBeapFlash400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash400Hz100ms3min))';%43
indmultiBeapFlash600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash600Hz100ms3min))'; %44
indmultiBeapFlash800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash800Hz100ms3min))';%45
indmultiBeapFlash1000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1000Hz100ms3min))';%46
indmultiBeapFlash1200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1200Hz100ms3min))';%47
indmultiBeapFlash1400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1400Hz100ms3min))';%48
indmultiBeapFlash1600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1600Hz100ms3min))';%49
indmultiBeapFlash1800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1800Hz100ms3min))';%50
indmultiBeapFlash2000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash2000Hz100ms3min))';%51

indBeeps200to2000 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.Beeps200to2000))';%32 - 51
indFlashBeeps200to2000 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.FlashBeeps200to2000))';%32 - 51

indPhototaxis4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.Phototaxis4))';%52 with obends; 53 no obends

indPreyCapture = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCapture))';%54-55
indPreyCaptureNaive = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCaptureNaive))';%56-57
indSpontanousEyeTracking = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontanousEyeTracking))';%58-59

indBeepsLightDarkEyeConv = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.BeepsLightDarkEyeConv))';%60 - 64
indBigCircleDiferentDirections2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.bigCircleDiferentDirections2))';%65 to 72
indLoomingDiferentSpeeds = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LoomingDiferentSpeeds))';%73 to 78

%multiFish data
indSpontaneousMultiFishGray = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishGray))';%79 - 82
indSpontaneousMultiFishBlack2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishBlack2))';%83 to 86

%prey capture by fish
%87 - 103

%prey capture by fish naive
%104 - 115


% disp('done')
% pause

%%
%%%%%%%%%%%%%%%%%%%%%%% OMRTurns2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%add equivalent angles together

clear vars  indStructure

uniqueStimNumberOMRTurns2 =  unique(stimNumber(indOMRTurns2));

%initialize indStructureCounter
counter = 1; 

%0 degrees
thisStimInd = stimIndStructure(2).thisInd;
thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '0 degrees';

counter = counter +1;

%15 degrees
thisStimInd1 = stimIndStructure(3).thisInd;
thisStimInd2 = stimIndStructure(25).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '15 degrees';

counter = counter +1;

%30 degrees
thisStimInd1 = stimIndStructure(4).thisInd;
thisStimInd2 = stimIndStructure(24).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '30 degrees';

counter = counter +1;

%45 degrees
thisStimInd1 = stimIndStructure(5).thisInd;
thisStimInd2 = stimIndStructure(23).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '45 degrees';

counter = counter +1;

%60 degrees
thisStimInd1 = stimIndStructure(6).thisInd;
thisStimInd2 = stimIndStructure(22).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '60 degrees';

counter = counter +1;

%75 degrees
thisStimInd1 = stimIndStructure(7).thisInd;
thisStimInd2 = stimIndStructure(21).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '75 degrees';

counter = counter +1;

%90 degrees
thisStimInd1 = stimIndStructure(8).thisInd;
thisStimInd2 = stimIndStructure(20).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '90 degrees';

counter = counter +1;

%105 degrees
thisStimInd1 = stimIndStructure(9).thisInd;
thisStimInd2 = stimIndStructure(19).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '105 degrees';

counter = counter +1;

%120 degrees
thisStimInd1 = stimIndStructure(10).thisInd;
thisStimInd2 = stimIndStructure(18).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '120 degrees';

counter = counter +1;

%135 degrees
thisStimInd1 = stimIndStructure(11).thisInd;
thisStimInd2 = stimIndStructure(17).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '135 degrees';

counter = counter +1;

%150 degrees
thisStimInd1 = stimIndStructure(12).thisInd;
thisStimInd2 = stimIndStructure(16).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '150 degrees';

counter = counter +1;


%165 degrees
thisStimInd1 = stimIndStructure(13).thisInd;
thisStimInd2 = stimIndStructure(15).thisInd;
thisStimInd = unique([thisStimInd1' thisStimInd2']');

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '165 degrees';

counter = counter +1;

%180 degrees
thisStimInd = stimIndStructure(14).thisInd;

thisInds = intersect(thisStimInd,indOMRTurns2);

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'OMRTurns2';
indStructure(counter).stimNumb = '180 degrees';

counter = counter +1;

% %check bouts
% col = jet(13)
% 
% for xx = 1 : 13
% %     xx =1
%     thisInds = indStructure(xx).thisInds;
%     
%     
%     %make plot
%     figure
%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.','color',col(xx,:))
%     axis([-10 13 -5 10])
% %     hold on
%   
% 
% end
% 

%%
%%%%%%%%%%%%%%%%%%%%%%% OMRSpeed5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueStimNumberOMRSpeed5 =  unique(stimNumber(indOMRSpeed5));

uniqueStimNumberOMRSpeed5(1) = [];
indStimStructInds = uniqueStimNumberOMRSpeed5 +1;


for xx = 1 : length(indStimStructInds)
%     xx =1
    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    thisStimNumber =   stimIndStructure(indStimStructInds(xx)).thisStimNumber;

    thisInds = intersect(thisStimInd,indOMRSpeed5);
    
    
%     %make plot
%     figure
%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
%     axis([-10 13 -5 10])
    
    %save data in structure
    indStructure(counter).thisInds = thisInds;
    indStructure(counter).dataSet = 'OMRSpeed5';
    indStructure(counter).stimNumb = thisStimNumber;
    
    counter = counter + 1;

end





%%
%%%%%%%%%%%%% spont swimming in light and dark %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


indNot1stBouts = find(numberOfBoutInStim >= 2 );

uniqueStimNumberLightDark3min2 =  unique(stimNumber(indLightDark3min2));

uniqueStimNumberLightDark3min2(1) = [];
indStimStructInds = uniqueStimNumberLightDark3min2 +1;


for xx = 1 : length(indStimStructInds)
%     xx =1
    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    thisStimNumber =   stimIndStructure(indStimStructInds(xx)).thisStimNumber;

    ind1 = intersect(thisStimInd,indLightDark3min2);
    
    thisInds = intersect(indNot1stBouts,ind1);
    
%     %make plot
%     figure
%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
%     axis([-10 13 -5 10])
    
    %save data in structure
    indStructure(counter).thisInds = thisInds;
    indStructure(counter).dataSet = 'LightDark3min2';
    indStructure(counter).stimNumb = thisStimNumber;
    
    counter = counter + 1;

end

%%
%%%%%%%%%%%%% trans light and dark %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueStimNumberLightDark3min2 =  unique(stimNumber(indLightDark3min2));

uniqueStimNumberLightDark3min2(1) = [];
indStimStructInds = uniqueStimNumberLightDark3min2 +1;


for xx = 1 : length(indStimStructInds)
%     xx =1
    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    thisStimNumber =   stimIndStructure(indStimStructInds(xx)).thisStimNumber;

    ind1 = intersect(thisStimInd,indLightDark3min2);
    
    thisInds = intersect(indFirstBouts,ind1);
    
%     %make plot
%     figure
%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
%     axis([-10 13 -5 10])
    
    %save data in structure
    indStructure(counter).thisInds = thisInds;
    indStructure(counter).dataSet = 'LightDark3min2';
    indStructure(counter).stimNumb = thisStimNumber;
    
    counter = counter + 1;

end


%%
%%%%%%%%%%%%%% Dark flahes indMultiFlash3min1sManyInt%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueStimNumberDarkFlashes = [13, 25 , 27, 37, 39, 41, 49, 51, 53, 55, 61, 63, 65, 67, 69];


indStimStructInds = uniqueStimNumberDarkFlashes +1;
thisStimIndAll = [];
for xx = 1 : length(indStimStructInds)
%     xx =1
    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    
    thisStimIndAll = [ thisStimIndAll' thisStimInd']';
    
end

    ind1 = intersect(thisStimIndAll,indMultiFlash3min1sManyInt);
    
    thisInds = intersect(indFirstBouts,ind1);

    
 indStructure(counter).thisInds = thisInds;
 indStructure(counter).dataSet = 'indMultiFlash3min1sManyInt';
 indStructure(counter).stimNumb = 'darkFlashs';
        
    
    

%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
%     axis([-10 13 -5 10])

%%
%%%%%%%%%%%%%% Light flahes indMultiFlash3min1sManyInt%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% uniqueStimNumberDarkFlashes = [13, 25 , 27, 37, 39, 41, 49, 51, 53, 55, 61, 63, 65, 67, 69];

 uniqueStimNumberDarkFlashes = [3 5 7 9 11  17 19  21  23  31 33 35  45  47  59];


counter = counter +1;

indStimStructInds = uniqueStimNumberDarkFlashes +1;
thisStimIndAll = [];
for xx = 1 : length(indStimStructInds)
%     xx =1
    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    
    thisStimIndAll = [ thisStimIndAll' thisStimInd']';
    
end

    ind1 = intersect(thisStimIndAll,indMultiFlash3min1sManyInt);
    
    thisInds = intersect(indFirstBouts,ind1);

    
 indStructure(counter).thisInds = thisInds;
    indStructure(counter).dataSet = 'indMultiFlash3min1sManyInt';
    indStructure(counter).stimNumb = 'LightFlashs';

%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
%     axis([-10 13 -5 10])



%%
%%%%%%%%%%%%%% Dark flahes indMultiFlash3min1sManyInt3%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


uniqueStimNumberDarkFlashes = [13, 25 , 27, 37, 39, 41, 49, 51, 53, 55, 61, 63, 65, 67, 69];

counter = counter +1;

indStimStructInds = uniqueStimNumberDarkFlashes +1;
thisStimIndAll = [];
for xx = 1 : length(indStimStructInds)
%     xx =1
    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    
    thisStimIndAll = [ thisStimIndAll' thisStimInd']';
    
end

    ind1 = intersect(thisStimIndAll,indMultiFlash3min1sManyInt3);
    
    thisInds = intersect(indFirstBouts,ind1);

    
 indStructure(counter).thisInds = thisInds;
 indStructure(counter).dataSet = 'indMultiFlash3min1sManyInt3';
 indStructure(counter).stimNumb = 'darkFlashs';
        
    
    

%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
%     axis([-10 13 -5 10])





%%
%%%%%%%%%%%%%% Light flahes indMultiFlash3min1sManyInt3%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueStimNumberDarkFlashes = [3 5 7 9 11  17 19  21  23  31 33 35  45  47  59];

counter = counter +1;

indStimStructInds = uniqueStimNumberDarkFlashes +1;
thisStimIndAll = [];
for xx = 1 : length(indStimStructInds)
%     xx =1
    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    
    thisStimIndAll = [ thisStimIndAll' thisStimInd']';
    
end

ind1 = intersect(thisStimIndAll,indMultiFlash3min1sManyInt3);
    
thisInds = intersect(indFirstBouts,ind1);

    
indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'indMultiFlash3min1sManyInt3';
indStructure(counter).stimNumb = 'LightFlashs';

%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
%     axis([-10 13 -5 10])



%%
%%%%%%%%%%% Beeps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


indStimStructure = [];
indStimStructure2 = [];

dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
numberOfBoutInStim  = BoutInf(:,EnumeratorBoutInf.numberOfBoutInStim); 
stimNumber  = BoutInf(:,EnumeratorBoutInf.stimNumber); 

indStimStructure(1).ind  = indmultiBeap200Hz100ms3min;
indStimStructure(2).ind  = indmultiBeap400Hz100ms3min;
indStimStructure(3).ind  = indmultiBeap600Hz100ms3min;
indStimStructure(4).ind  = indmultiBeap800Hz100ms3min;
indStimStructure(5).ind  = indmultiBeap1000Hz100ms3min;
indStimStructure(6).ind  = indmultiBeap1200Hz100ms3min;
indStimStructure(7).ind  = indmultiBeap1400Hz100ms3min;
indStimStructure(8).ind  = indmultiBeap1600Hz100ms3min;
indStimStructure(9).ind  = indmultiBeap1800Hz100ms3min;
indStimStructure(10).ind  = indmultiBeap2000Hz100ms3min;

indStimStructure(11).ind = indmultiBeapFlash200Hz100ms3min;
indStimStructure(12).ind = indmultiBeapFlash400Hz100ms3min;
indStimStructure(13).ind = indmultiBeapFlash600Hz100ms3min;
indStimStructure(14).ind = indmultiBeapFlash800Hz100ms3min;
indStimStructure(15).ind = indmultiBeapFlash1000Hz100ms3min;
indStimStructure(16).ind = indmultiBeapFlash1200Hz100ms3min;
indStimStructure(17).ind = indmultiBeapFlash1400Hz100ms3min;
% indStimStructure(18).ind = indmultiBeapFlash1600Hz100ms3min;
indStimStructure(18).ind = [];
indStimStructure(19).ind = indmultiBeapFlash1800Hz100ms3min;
indStimStructure(20).ind = indmultiBeapFlash2000Hz100ms3min;

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
    
   
counter = counter +1;

for t = 1 : 20
    indThisStim1 = allStimSctrut(t).ind;
    indThisStim2 = allStimSctrut(20 + t).ind;
    
    indThisStim = [indThisStim1' indThisStim2']';

    
    
    indStructure(counter).thisInds = indThisStim;
    indStructure(counter).dataSet = 'Beeps';
    indStructure(counter).stimNumb = dataSetName2{t};

   
    counter = counter + 1;
end   


% %look at beeps
% for h = 32:length(indStructure)
% 
%     thisInds = indStructure(h).thisInds;
%     stimNumb = indStructure(h).stimNumb;
% 
%     clf
%     plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), 'k.')
%     axis([-20 20, -15 15])
%     title(stimNumb)
%     pause
% end


% disp('done')
% pause
%%
%%%%%%%%%%%%%%%% phototaxis with Obends %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indFirst3Bouts = find(numberOfBoutInStim <= 3 );

% indPhotoStim = 1:2:71;
indPhotoStim = [7 9 11 19 21 23 31 33 35 43 45];

indStimStructInds = indPhotoStim +1;


thisStimIndAll = [];

for xx = 1 : length(indStimStructInds)

    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    
    thisStimIndAll = [thisStimIndAll' thisStimInd']';
    
    
end

ind1 = intersect(thisStimIndAll,indPhototaxis4);
thisInds = intersect(indFirst3Bouts,ind1);





indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'indPhototaxis4';
indStructure(counter).stimNumb = 'photo with Obends';
    

% figure
% plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
% axis([-10 13 -5 10])
% title(length(thisInds))






%%
%%%%%%%%%%%%%%%% phototaxis no Obends %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indFirst3Bouts = find(numberOfBoutInStim <= 3 );

 indPhotoStim = 1:2:71;
excludeThisStimsInd = find(indPhotoStim == 7 | indPhotoStim == 9 | indPhotoStim == 11 | indPhotoStim == 19 | indPhotoStim == 21 | indPhotoStim == 23 | indPhotoStim == 31 | indPhotoStim == 33 | indPhotoStim == 35 | indPhotoStim == 43 | indPhotoStim == 45);
indPhotoStim(excludeThisStimsInd) = [];

indStimStructInds = indPhotoStim +1;


thisStimIndAll = [];

for xx = 1 : length(indStimStructInds)

    thisStimInd = stimIndStructure(indStimStructInds(xx)).thisInd;
    
    thisStimIndAll = [thisStimIndAll' thisStimInd']';
    
    
end

ind1 = intersect(thisStimIndAll,indPhototaxis4);
thisInds = intersect(indFirst3Bouts,ind1);




counter = counter +1;

indStructure(counter).thisInds = thisInds;
indStructure(counter).dataSet = 'indPhototaxis4';
indStructure(counter).stimNumb = 'photo no Obends';
    
   
% figure
% plot(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2), '.')
% axis([-10 13 -5 10])
% title(length(thisInds))
% 




%%
%%%%%%%%%%%%%%%%%%%%%%%%  prey capture %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 indThisStim1 = find(eyeConv == 2);%eye conv
 indThisStim2 = find(eyeConv == 1);%no eye conv
 %save data in structure
 
    
     

 
indPreyCaptureEyeConv = intersect(indPreyCapture,indThisStim1);

counter = counter +1;

indStructure(counter).thisInds = indPreyCaptureEyeConv;
indStructure(counter).dataSet = 'indPreyCaptureEyeConv';
indStructure(counter).stimNumb = 'NaN';


indPreyCaptureSpont = intersect(indPreyCapture,indThisStim2);

counter = counter + 1;
indStructure(counter).thisInds = indPreyCaptureSpont;
indStructure(counter).dataSet = 'indPreyCaptureSpont';
indStructure(counter).stimNumb = 'NaN';

indPreyCaptureNaiveEyeConv = intersect(indPreyCaptureNaive,indThisStim1);
counter = counter + 1;
indStructure(counter).thisInds = indPreyCaptureNaiveEyeConv;
indStructure(counter).dataSet = 'indPreyCaptureNaiveEyeConv';
indStructure(counter).stimNumb = 'NaN';

indPreyCaptureNaiveSpont = intersect(indPreyCaptureNaive,indThisStim2);
counter = counter + 1;
indStructure(counter).thisInds = indPreyCaptureNaiveSpont;
indStructure(counter).dataSet = 'indPreyCaptureNaiveSpont';
indStructure(counter).stimNumb = 'NaN';

indSpontanousEyeTrackingEyeConv = intersect(indSpontanousEyeTracking,indThisStim1);
counter = counter + 1;
indStructure(counter).thisInds = indSpontanousEyeTrackingEyeConv;
indStructure(counter).dataSet = 'indSpontanousEyeTrackingEyeConv';
indStructure(counter).stimNumb = 'NaN';

indSpontanousEyeTrackingSpont = intersect(indSpontanousEyeTracking,indThisStim2);
counter = counter + 1;
indStructure(counter).thisInds = indSpontanousEyeTrackingSpont;
indStructure(counter).dataSet = 'indSpontanousEyeTrackingSpont';
indStructure(counter).stimNumb = 'NaN';



%%
%%%%%%%%%%%%%%%%%% BeepsLightDarkEyeConv %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ind200HzLight = stimIndStructure(2).thisInd;
indDarkFlash1 = stimIndStructure(4).thisInd;
ind200HzDark = stimIndStructure(5).thisInd;
ind800HzLight = stimIndStructure(8).thisInd;
indDarkFlash2 = stimIndStructure(10).thisInd;
ind800HzDark = stimIndStructure(11).thisInd;

indDarkFlash = [indDarkFlash1' indDarkFlash2']';

%indBeepsLightDarkEyeConv = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.BeepsLightDarkEyeConv))';%


counter = counter + 1;%60
ind200HzLightFinal = intersect(ind1stBout,intersect(ind200HzLight,indBeepsLightDarkEyeConv));
indStructure(counter).thisInds = ind200HzLightFinal;
indStructure(counter).dataSet = '200HzLightSmallRig';
indStructure(counter).stimNumb = 'NaN';

counter = counter + 1;%61
indDarkFlashFinal = intersect(ind1stBout,intersect(indDarkFlash,indBeepsLightDarkEyeConv));
indStructure(counter).thisInds = indDarkFlashFinal;
indStructure(counter).dataSet = 'DarkFlashSmallRig';
indStructure(counter).stimNumb = 'NaN';

counter = counter + 1;%62
ind200HzDarkFinal = intersect(ind1stBout,intersect(ind200HzDark,indBeepsLightDarkEyeConv));
indStructure(counter).thisInds = ind200HzDarkFinal;
indStructure(counter).dataSet = '200HzDarkSmallRig';
indStructure(counter).stimNumb = 'NaN';

counter = counter + 1;%63
ind800HzLightFinal = intersect(ind1stBout,intersect(ind800HzLight,indBeepsLightDarkEyeConv));
indStructure(counter).thisInds = ind800HzLightFinal;
indStructure(counter).dataSet = '800HzLightSmallRig';
indStructure(counter).stimNumb = 'NaN';

counter = counter + 1;%64
ind800HzDarkFinal = intersect(ind1stBout,intersect(ind800HzDark,indBeepsLightDarkEyeConv));
indStructure(counter).thisInds = ind800HzDarkFinal;
indStructure(counter).dataSet = '800HzDarkSmallRig';
indStructure(counter).stimNumb = 'NaN';


%%
%%%%%%%%%%%%%%%%%% bigCircleDiferentDirections2 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indStimForBigCircle = 2 : 2: 16;
stimTitle = {'0 deg','315 deg','270 deg','225 deg','180 deg','135 deg','90 deg','45 deg'};

latencyOfBoutAfterStim = BoutInf(:,EnumeratorBoutInf.latencyOfBoutAfterStim);

indBeforeLoom = find(latencyOfBoutAfterStim <= 2500);

 counter = counter +1;
for h  = 1 : length(indStimForBigCircle)%loop through each stim
    
%get inds from stims
thisStimInds =  stimIndStructure( indStimForBigCircle(h)).thisInd;
    
indThisStimBigCircle = intersect(thisStimInds,indBigCircleDiferentDirections2);
indThisStimFinal =  intersect(indThisStimBigCircle,indBeforeLoom);

indStructure(counter).thisInds = indThisStimFinal;
indStructure(counter).dataSet = 'bigCircleDiferentDirections2';
indStructure(counter).stimNumb = stimTitle{h};

counter = counter +1;

end
% pause
%should end in 72

%%
%%%%%%%%%%%%%%%%%% pick looming 0.25 cm/s %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


indLoomingDiferentSpeeds = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LoomingDiferentSpeeds))';%1 to 8

indStimLoomingSpeeds = 1:2:47;

afterThres = 700;
%pick stims with shadows
indStimLoomingSpeed1 = indStimLoomingSpeeds(1:4);

%get lattency of this loom
lineValMs = 16.*1000;% in ms

indThisBoutsAll = [];
indThisBoutsAllAfter = [];
indThisBoutsAllAfterAfter = [];

for u = 1 : length(indStimLoomingSpeed1)
    
    
    indThisStim = find(stimNumber == indStimLoomingSpeed1(u));
    
    indThisStimInLoomDataSet = intersect(indLoomingDiferentSpeeds,indThisStim);
    
    indInLatency = find(latencyOfBoutAfterStim < lineValMs);
    indInLatencyAfter = find(latencyOfBoutAfterStim > lineValMs & latencyOfBoutAfterStim < lineValMs + afterThres);
    indInLatencyAfterAfter = find(latencyOfBoutAfterStim > lineValMs + afterThres);

    
    
    indThisBoutsFinal = intersect(indThisStimInLoomDataSet,indInLatency);
    indThisBoutsFinalAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfter);
    indThisBoutsFinalAfterAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfterAfter);

    indThisBoutsAll = [indThisBoutsAll' indThisBoutsFinal']';
    indThisBoutsAllAfter = [indThisBoutsAllAfter' indThisBoutsFinalAfter']';
    indThisBoutsAllAfterAfter = [indThisBoutsAllAfterAfter' indThisBoutsFinalAfterAfter']';

end



% figure
% % plot3(boutDataPCASample(indLoomingDiferentSpeeds,1),boutDataPCASample(indLoomingDiferentSpeeds,2),boutDataPCASample(indLoomingDiferentSpeeds,3),'k.')
% hold on
% plot3(boutDataPCASample(indThisBoutsAll,1),boutDataPCASample(indThisBoutsAll,2),boutDataPCASample(indThisBoutsAll,3),'r.')
%   plot3(boutDataPCASample(indThisBoutsAllAfter,1),boutDataPCASample(indThisBoutsAllAfter,2),boutDataPCASample(indThisBoutsAllAfter,3),'g.')
% %  plot3(boutDataPCASample(indThisBoutsAllAfterAfter,1),boutDataPCASample(indThisBoutsAllAfterAfter,2),boutDataPCASample(indThisBoutsAllAfterAfter,3),'c.')
% 
% axis square

indStructure(counter).thisInds = indThisBoutsAll;
indStructure(counter).dataSet = '0.25cm/s';
indStructure(counter).stimNumb = 'NaN';
counter = counter +1;
%should end in 73
%%
%%%%%%%%%%%%%%%%%% pick looming 0.5 cm/s %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pick stims with shadows
% indStimLoomingSpeeds = 1:2:47;
indStimLoomingSpeed1 = indStimLoomingSpeeds(5:8);

%get lattency of this loom
lineValMs = 8.*1000;% in ms

indThisBoutsAll = [];
indThisBoutsAllAfter = [];
indThisBoutsAllAfterAfter = [];

for u = 1 : length(indStimLoomingSpeed1)
    
    
    indThisStim = find(stimNumber == indStimLoomingSpeed1(u));
    
    indThisStimInLoomDataSet = intersect(indLoomingDiferentSpeeds,indThisStim);
    
    indInLatency = find(latencyOfBoutAfterStim < lineValMs);
    indInLatencyAfter = find(latencyOfBoutAfterStim > lineValMs & latencyOfBoutAfterStim < lineValMs + afterThres);
    indInLatencyAfterAfter = find(latencyOfBoutAfterStim > lineValMs + afterThres);

    
    
    indThisBoutsFinal = intersect(indThisStimInLoomDataSet,indInLatency);
    indThisBoutsFinalAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfter);
    indThisBoutsFinalAfterAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfterAfter);

    indThisBoutsAll = [indThisBoutsAll' indThisBoutsFinal']';
    indThisBoutsAllAfter = [indThisBoutsAllAfter' indThisBoutsFinalAfter']';
    indThisBoutsAllAfterAfter = [indThisBoutsAllAfterAfter' indThisBoutsFinalAfterAfter']';

end



% figure
% % plot3(boutDataPCASample(indLoomingDiferentSpeeds,1),boutDataPCASample(indLoomingDiferentSpeeds,2),boutDataPCASample(indLoomingDiferentSpeeds,3),'k.')
% hold on
% plot3(boutDataPCASample(indThisBoutsAll,1),boutDataPCASample(indThisBoutsAll,2),boutDataPCASample(indThisBoutsAll,3),'r.')
%  plot3(boutDataPCASample(indThisBoutsAllAfter,1),boutDataPCASample(indThisBoutsAllAfter,2),boutDataPCASample(indThisBoutsAllAfter,3),'g.')
% %  plot3(boutDataPCASample(indThisBoutsAllAfterAfter,1),boutDataPCASample(indThisBoutsAllAfterAfter,2),boutDataPCASample(indThisBoutsAllAfterAfter,3),'c.')

% axis square

indStructure(counter).thisInds = indThisBoutsAll;
indStructure(counter).dataSet = '0.5cm/s';
indStructure(counter).stimNumb = 'NaN';
counter = counter + 1;
%should end in 74

%%
%%%%%%%%%%%%%%%%%% pick looming 1 cm/s %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pick stims with shadows
% indStimLoomingSpeeds = 1:2:47;
indStimLoomingSpeed1 = indStimLoomingSpeeds(9:12);

%get lattency of this loom
lineValMs = 4.*1000;% in ms

indThisBoutsAll = [];
indThisBoutsAllAfter = [];
indThisBoutsAllAfterAfter = [];

for u = 1 : length(indStimLoomingSpeed1)
    
    
    indThisStim = find(stimNumber == indStimLoomingSpeed1(u));
    
    indThisStimInLoomDataSet = intersect(indLoomingDiferentSpeeds,indThisStim);
    
    indInLatency = find(latencyOfBoutAfterStim < lineValMs);
    indInLatencyAfter = find(latencyOfBoutAfterStim > lineValMs & latencyOfBoutAfterStim < lineValMs + afterThres);
    indInLatencyAfterAfter = find(latencyOfBoutAfterStim > lineValMs + afterThres);

    
    
    indThisBoutsFinal = intersect(indThisStimInLoomDataSet,indInLatency);
    indThisBoutsFinalAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfter);
    indThisBoutsFinalAfterAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfterAfter);

    indThisBoutsAll = [indThisBoutsAll' indThisBoutsFinal']';
    indThisBoutsAllAfter = [indThisBoutsAllAfter' indThisBoutsFinalAfter']';
    indThisBoutsAllAfterAfter = [indThisBoutsAllAfterAfter' indThisBoutsFinalAfterAfter']';

end



% figure
% % plot3(boutDataPCASample(indLoomingDiferentSpeeds,1),boutDataPCASample(indLoomingDiferentSpeeds,2),boutDataPCASample(indLoomingDiferentSpeeds,3),'k.')
% hold on
% plot3(boutDataPCASample(indThisBoutsAll,1),boutDataPCASample(indThisBoutsAll,2),boutDataPCASample(indThisBoutsAll,3),'r.')
%  plot3(boutDataPCASample(indThisBoutsAllAfter,1),boutDataPCASample(indThisBoutsAllAfter,2),boutDataPCASample(indThisBoutsAllAfter,3),'g.')
% %  plot3(boutDataPCASample(indThisBoutsAllAfterAfter,1),boutDataPCASample(indThisBoutsAllAfterAfter,2),boutDataPCASample(indThisBoutsAllAfterAfter,3),'c.')

% axis square
indStructure(counter).thisInds = indThisBoutsAll;
indStructure(counter).dataSet = '1cm/s';
indStructure(counter).stimNumb = 'NaN';
counter = counter + 1;
%should end in 75

%%
%%%%%%%%%%%%%%%%%% pick looming 1.5 cm/s %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pick stims with shadows
% indStimLoomingSpeeds = 1:2:47;
indStimLoomingSpeed1 = indStimLoomingSpeeds(13:16);

%get lattency of this loom
lineValMs = 2.67.*1000;% in ms

indThisBoutsAll = [];
indThisBoutsAllAfter = [];
indThisBoutsAllAfterAfter = [];

for u = 1 : length(indStimLoomingSpeed1)
    
    
    indThisStim = find(stimNumber == indStimLoomingSpeed1(u));
    
    indThisStimInLoomDataSet = intersect(indLoomingDiferentSpeeds,indThisStim);
    
    indInLatency = find(latencyOfBoutAfterStim < lineValMs);
    indInLatencyAfter = find(latencyOfBoutAfterStim > lineValMs & latencyOfBoutAfterStim < lineValMs + afterThres);
    indInLatencyAfterAfter = find(latencyOfBoutAfterStim > lineValMs + afterThres);

    
    
    indThisBoutsFinal = intersect(indThisStimInLoomDataSet,indInLatency);
    indThisBoutsFinalAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfter);
    indThisBoutsFinalAfterAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfterAfter);

    indThisBoutsAll = [indThisBoutsAll' indThisBoutsFinal']';
    indThisBoutsAllAfter = [indThisBoutsAllAfter' indThisBoutsFinalAfter']';
    indThisBoutsAllAfterAfter = [indThisBoutsAllAfterAfter' indThisBoutsFinalAfterAfter']';

end



% figure
% % plot3(boutDataPCASample(indLoomingDiferentSpeeds,1),boutDataPCASample(indLoomingDiferentSpeeds,2),boutDataPCASample(indLoomingDiferentSpeeds,3),'k.')
% hold on
% plot3(boutDataPCASample(indThisBoutsAll,1),boutDataPCASample(indThisBoutsAll,2),boutDataPCASample(indThisBoutsAll,3),'r.')
%  plot3(boutDataPCASample(indThisBoutsAllAfter,1),boutDataPCASample(indThisBoutsAllAfter,2),boutDataPCASample(indThisBoutsAllAfter,3),'g.')
% %  plot3(boutDataPCASample(indThisBoutsAllAfterAfter,1),boutDataPCASample(indThisBoutsAllAfterAfter,2),boutDataPCASample(indThisBoutsAllAfterAfter,3),'c.')
% 
% axis square

indStructure(counter).thisInds = indThisBoutsAll;
indStructure(counter).dataSet = '1.5cm/s';
indStructure(counter).stimNumb = 'NaN';
counter = counter + 1;
%should end in 76

%%
%%%%%%%%%%%%%%%%%% pick looming 2 cm/s %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pick stims with shadows
% indStimLoomingSpeeds = 1:2:47;
indStimLoomingSpeed1 = indStimLoomingSpeeds(17:20);

%get lattency of this loom
lineValMs = 2.*1000;% in ms

indThisBoutsAll = [];
indThisBoutsAllAfter = [];
indThisBoutsAllAfterAfter = [];

for u = 1 : length(indStimLoomingSpeed1)
    
    
    indThisStim = find(stimNumber == indStimLoomingSpeed1(u));
    
    indThisStimInLoomDataSet = intersect(indLoomingDiferentSpeeds,indThisStim);
    
    indInLatency = find(latencyOfBoutAfterStim < lineValMs);
    indInLatencyAfter = find(latencyOfBoutAfterStim > lineValMs & latencyOfBoutAfterStim < lineValMs + afterThres);
    indInLatencyAfterAfter = find(latencyOfBoutAfterStim > lineValMs + afterThres);

    
    
    indThisBoutsFinal = intersect(indThisStimInLoomDataSet,indInLatency);
    indThisBoutsFinalAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfter);
    indThisBoutsFinalAfterAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfterAfter);

    indThisBoutsAll = [indThisBoutsAll' indThisBoutsFinal']';
    indThisBoutsAllAfter = [indThisBoutsAllAfter' indThisBoutsFinalAfter']';
    indThisBoutsAllAfterAfter = [indThisBoutsAllAfterAfter' indThisBoutsFinalAfterAfter']';

end



% figure
% % plot3(boutDataPCASample(indLoomingDiferentSpeeds,1),boutDataPCASample(indLoomingDiferentSpeeds,2),boutDataPCASample(indLoomingDiferentSpeeds,3),'k.')
% hold on
% plot3(boutDataPCASample(indThisBoutsAll,1),boutDataPCASample(indThisBoutsAll,2),boutDataPCASample(indThisBoutsAll,3),'r.')
%  plot3(boutDataPCASample(indThisBoutsAllAfter,1),boutDataPCASample(indThisBoutsAllAfter,2),boutDataPCASample(indThisBoutsAllAfter,3),'g.')
% %  plot3(boutDataPCASample(indThisBoutsAllAfterAfter,1),boutDataPCASample(indThisBoutsAllAfterAfter,2),boutDataPCASample(indThisBoutsAllAfterAfter,3),'c.')
% 
%axis square
indStructure(counter).thisInds = indThisBoutsAll;
indStructure(counter).dataSet = '2cm/s';
indStructure(counter).stimNumb = 'NaN';
counter = counter + 1;
%should end in 77


%%
%%%%%%%%%%%%%%%%%% pick looming 2.5 cm/s %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pick stims with shadows
% indStimLoomingSpeeds = 1:2:47;
indStimLoomingSpeed1 = indStimLoomingSpeeds(21:24);

%get lattency of this loom
lineValMs = 1.6666.*1000;% in ms

indThisBoutsAll = [];
indThisBoutsAllAfter = [];
indThisBoutsAllAfterAfter = [];

for u = 1 : length(indStimLoomingSpeed1)
    
    
    indThisStim = find(stimNumber == indStimLoomingSpeed1(u));
    
    indThisStimInLoomDataSet = intersect(indLoomingDiferentSpeeds,indThisStim);
    
    indInLatency = find(latencyOfBoutAfterStim < lineValMs);
    indInLatencyAfter = find(latencyOfBoutAfterStim > lineValMs & latencyOfBoutAfterStim < lineValMs + afterThres);
    indInLatencyAfterAfter = find(latencyOfBoutAfterStim > lineValMs + afterThres);

    
    
    indThisBoutsFinal = intersect(indThisStimInLoomDataSet,indInLatency);
    indThisBoutsFinalAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfter);
    indThisBoutsFinalAfterAfter = intersect(indThisStimInLoomDataSet,indInLatencyAfterAfter);

    indThisBoutsAll = [indThisBoutsAll' indThisBoutsFinal']';
    indThisBoutsAllAfter = [indThisBoutsAllAfter' indThisBoutsFinalAfter']';
    indThisBoutsAllAfterAfter = [indThisBoutsAllAfterAfter' indThisBoutsFinalAfterAfter']';

end



% figure
% % plot3(boutDataPCASample(indLoomingDiferentSpeeds,1),boutDataPCASample(indLoomingDiferentSpeeds,2),boutDataPCASample(indLoomingDiferentSpeeds,3),'k.')
% hold on
% plot3(boutDataPCASample(indThisBoutsAll,1),boutDataPCASample(indThisBoutsAll,2),boutDataPCASample(indThisBoutsAll,3),'r.')
%  plot3(boutDataPCASample(indThisBoutsAllAfter,1),boutDataPCASample(indThisBoutsAllAfter,2),boutDataPCASample(indThisBoutsAllAfter,3),'g.')
% %  plot3(boutDataPCASample(indThisBoutsAllAfterAfter,1),boutDataPCASample(indThisBoutsAllAfterAfter,2),boutDataPCASample(indThisBoutsAllAfterAfter,3),'c.')

%axis square

indStructure(counter).thisInds = indThisBoutsAll;
indStructure(counter).dataSet = '2.5cm/s';
indStructure(counter).stimNumb = 'NaN';

%should end in 78


%%
%%%%%%%%%%%%%% multifish Gray %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%79 - 82
rotatedPositionAtSartOfBoutX = BoutInf(: ,EnumeratorBoutInf.rotatedPositionAtSartOfBoutX);
rotatedPositionAtSartOfBoutY = BoutInf(: ,EnumeratorBoutInf.rotatedPositionAtSartOfBoutY);

%take out zeros
indZero = find(rotatedPositionAtSartOfBoutX == 0);
rotatedPositionAtSartOfBoutX(indZero) = 10000;

indZero = find(rotatedPositionAtSartOfBoutY == 0);
rotatedPositionAtSartOfBoutY(indZero) = 10000;


squareThres = 150;

%take out zeros
indZero = find(rotatedPositionAtSartOfBoutX == 0);
rotatedPositionAtSartOfBoutX(indZero) = 10000;

%open vectors
boutsInSquare1 = zeros(1,size(rotatedPositionAtSartOfBoutX),1);
boutsInSquare2 = zeros(1,size(rotatedPositionAtSartOfBoutX),1);
boutsInSquare3 = zeros(1,size(rotatedPositionAtSartOfBoutX),1);
boutsInSquare4 = zeros(1,size(rotatedPositionAtSartOfBoutX),1);


%loop trough each fish 
for i = 1 : size(rotatedPositionAtSartOfBoutX,2)
    
    rotPosThisFishX = rotatedPositionAtSartOfBoutX(:,i);
    rotPosThisFishY = rotatedPositionAtSartOfBoutY(:,i);
    
    ind1 = find(rotPosThisFishX > -squareThres &  rotPosThisFishX < 0 & rotPosThisFishY > -squareThres & rotPosThisFishY < 0);
    indInSquare1 = intersect(ind1,indSpontaneousMultiFishGray);
    boutsInSquare1(indInSquare1) = 1;

    ind2 = find(rotPosThisFishX > 0 &  rotPosThisFishX < squareThres & rotPosThisFishY > -squareThres & rotPosThisFishY < 0);
    indInSquare2 = intersect(ind2,indSpontaneousMultiFishGray);
    boutsInSquare2(indInSquare2) = 1;

    ind3 = find(rotPosThisFishX > -squareThres &  rotPosThisFishX < 0 & rotPosThisFishY > 0 & rotPosThisFishY < squareThres);
    indInSquare3 = intersect(ind3,indSpontaneousMultiFishGray);
    boutsInSquare3(indInSquare3) = 1;

    ind4 = find(rotPosThisFishX > 0 &  rotPosThisFishX < squareThres & rotPosThisFishY > 0 & rotPosThisFishY < squareThres);
    indInSquare4 = intersect(ind4,indSpontaneousMultiFishGray);
    boutsInSquare4(indInSquare4) = 1;

end


indInSquare1 = find(boutsInSquare1 == 1);
indInSquare2 = find(boutsInSquare2 == 1);
indInSquare3 = find(boutsInSquare3 == 1);
indInSquare4 = find(boutsInSquare4 == 1);

counter = counter +1;
indStructure(counter).thisInds = indInSquare1;
indStructure(counter).dataSet = 'SpontaneousMultiFishGray';
indStructure(counter).stimNumb = 'square1';

counter = counter +1;
indStructure(counter).thisInds = indInSquare2;
indStructure(counter).dataSet = 'SpontaneousMultiFishGray';
indStructure(counter).stimNumb = 'square2';

counter = counter +1;
indStructure(counter).thisInds = indInSquare3;
indStructure(counter).dataSet = 'SpontaneousMultiFishGray';
indStructure(counter).stimNumb = 'square3';

counter = counter +1;
indStructure(counter).thisInds = indInSquare4;
indStructure(counter).dataSet = 'SpontaneousMultiFishGray';
indStructure(counter).stimNumb = 'square4';

%should end in 82
% pause


%%
%%%%%%%%%%%%%%% multiFish Dark %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%83 to 86

squareThres = 150;



%open vectors
boutsInSquare1 = zeros(1,size(rotatedPositionAtSartOfBoutX),1);
boutsInSquare2 = zeros(1,size(rotatedPositionAtSartOfBoutX),1);
boutsInSquare3 = zeros(1,size(rotatedPositionAtSartOfBoutX),1);
boutsInSquare4 = zeros(1,size(rotatedPositionAtSartOfBoutX),1);


%loop trough each fish 
for i = 1 : size(rotatedPositionAtSartOfBoutX,2)
    
    rotPosThisFishX = rotatedPositionAtSartOfBoutX(:,i);
    rotPosThisFishY = rotatedPositionAtSartOfBoutY(:,i);
    
    ind1 = find(rotPosThisFishX > -squareThres &  rotPosThisFishX < 0 & rotPosThisFishY > -squareThres & rotPosThisFishY < 0);
    indInSquare1 = intersect(ind1,indSpontaneousMultiFishBlack2);
    boutsInSquare1(indInSquare1) = 1;

    ind2 = find(rotPosThisFishX > 0 &  rotPosThisFishX < squareThres & rotPosThisFishY > -squareThres & rotPosThisFishY < 0);
    indInSquare2 = intersect(ind2,indSpontaneousMultiFishBlack2);
    boutsInSquare2(indInSquare2) = 1;

    ind3 = find(rotPosThisFishX > -squareThres &  rotPosThisFishX < 0 & rotPosThisFishY > 0 & rotPosThisFishY < squareThres);
    indInSquare3 = intersect(ind3,indSpontaneousMultiFishBlack2);
    boutsInSquare3(indInSquare3) = 1;

    ind4 = find(rotPosThisFishX > 0 &  rotPosThisFishX < squareThres & rotPosThisFishY > 0 & rotPosThisFishY < squareThres);
    indInSquare4 = intersect(ind4,indSpontaneousMultiFishBlack2);
    boutsInSquare4(indInSquare4) = 1;

end


indInSquare1 = find(boutsInSquare1 == 1);
indInSquare2 = find(boutsInSquare2 == 1);
indInSquare3 = find(boutsInSquare3 == 1);
indInSquare4 = find(boutsInSquare4 == 1);

counter = counter +1;
indStructure(counter).thisInds = indInSquare1;
indStructure(counter).dataSet = 'SpontaneousMultiFishBlack2';
indStructure(counter).stimNumb = 'square1';

counter = counter +1;
indStructure(counter).thisInds = indInSquare2;
indStructure(counter).dataSet = 'SpontaneousMultiFishBlack2';
indStructure(counter).stimNumb = 'square2';

counter = counter +1;
indStructure(counter).thisInds = indInSquare3;
indStructure(counter).dataSet = 'SpontaneousMultiFishBlack2';
indStructure(counter).stimNumb = 'square3';

counter = counter +1;
indStructure(counter).thisInds = indInSquare4;
indStructure(counter).dataSet = 'SpontaneousMultiFishBlack2';
indStructure(counter).stimNumb = 'square4';

%should end in 86
% pause

counter = counter +1;



%%
%%%%%%%%%%% get inds for prey capture data  sets %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trueUniqueFishNumber = BoutInf(:,EnumeratorBoutInf.trueUniqueFishNumber);
eyeConv = BoutInf(:,EnumeratorBoutInf.eyeConv);

indThisStim1 = find(eyeConv == 2);%eye conv
indThisStim2 = find(eyeConv == 1);%no eye conv

% indPreyCapture = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCapture))';%54-55
% indPreyCaptureNaive = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCaptureNaive))';%56-57










%%
%%%%%%%%%%%%%%%%%%%%% devide data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbToChunk = 1500;
counter2 = 1;

for i = 1:length(indStructure)
    
    
    thisInds = indStructure(i).thisInds;
    dataSet = indStructure(i).dataSet;
    stimNumb = indStructure(i).stimNumb;
    
    
    if length(thisInds) < numbToChunk
        
        
        indStructure2(counter2).thisInds = thisInds;
        indStructure2(counter2).thisIndRand = thisInds;
        indStructure2(counter2).dataSet = dataSet;
        indStructure2(counter2).stimNumb = stimNumb;

      counter2 = counter2 +1;

    else
      
        indPerm = randperm(length(thisInds));
       
       indThisBeatRand = thisInds(indPerm);
       
       numbOfChunks = ceil(length(indThisBeatRand)/numbToChunk);
       
       starts = 1 : numbToChunk: length(indThisBeatRand);
       ends = [starts(2:end)-1, length(indThisBeatRand)];
       
       
       for ii = 1 : numbOfChunks
     
      indStructure2(counter2).thisInds = indThisBeatRand(starts(ii) : ends(ii));
      indStructure2(counter2).thisIndRand = indThisBeatRand(starts(ii) : ends(ii));

      indStructure2(counter2).dataSet = dataSet;
      indStructure2(counter2).stimNumb = stimNumb;

      counter2 = counter2 +1;
       end
        
        
        
    end
    
    
    
    
    
    
end




%% 
%%%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 if makeplot == 1
    figure 
     
 end
for n = 1 : length(indStructure2)
clf
   
   thisIndRand = indStructure2(n).thisIndRand;
      dataSet =  indStructure2(n).dataSet;

if makeplot == 1
%     subplot(ceil(sqrt(length(indStructure2))),ceil(sqrt(length(indStructure2))),n)
   plot(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), '.k');
 axis([-15 20, -10 10])
 axis square
   
   title(dataSet)
   pause
end




    
end



