function [indStructure] = indStructureCreator_OMRTurns2Test(BoutInf,indGoodBouts,boutDataPCASample,makeplot)



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




%% 
%%%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfBouts2 = 500;
if ~isempty(boutDataPCASample) && makeplot ==1
    
    for n = 1 : length(indStructure)
        
        thisInds = indStructure(n).thisInds;
        dataSetTitle = indStructure(n).dataSet;
        
         
    %pick random bouts
    if length(thisInds) > numberOfBouts2
    indPerm = randperm(length(thisInds));
    thisIndRand = thisInds(indPerm(1:numberOfBouts2));
    
    else
        thisIndRand = thisInds;
    end
    
        clf
        plot(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),'.k')
        axis square
        axis([-15 20 -15 15])
        title(dataSetTitle)
        pause
        
    end
    
end


