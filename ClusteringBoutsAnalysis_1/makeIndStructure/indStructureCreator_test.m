function [indStructure] = indStructureCreator_test(BoutInf,indGoodBouts)



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


%should end in 86
% pause

