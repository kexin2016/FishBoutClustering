function [indStructure] = indStructureCreator_Antonia_AllData(BoutInf,indGoodBouts,boutDataPCASample,makeplot)




%%
%%%%%%%%%%%%%%%% pick data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
numberOfBoutInStim = BoutInf(:,EnumeratorBoutInf.numberOfBoutInStim);
stimNumber = BoutInf(:,EnumeratorBoutInf.stimNumber);
eyeConv = BoutInf(:,EnumeratorBoutInf.eyeConv);

indFirstBouts = find(numberOfBoutInStim == 1);
indNotFirstBouts = find(numberOfBoutInStim > 1);

latencyOfBoutAfterStim = BoutInf(:,EnumeratorBoutInf.latencyOfBoutAfterStim);
indThisDataSet = find(dataSetNumber == EnumeratorDataSet.DarkLightTransitions4);%1-13
indDarkLightTransitions4 = intersect(indGoodBouts,indThisDataSet)';%1-13

indStructure =[];

%%
%%%%%%%%%%%%%%% make indStructure for each data set %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueDataSetNumber = unique(dataSetNumber);
numberOfBouts2 = 3000;

for n  = 1 : length(uniqueDataSetNumber)
    
   thisInds = intersect(indGoodBouts, find(dataSetNumber == uniqueDataSetNumber(n)));
    
    
    %pick random bouts
    indPerm = randperm(length(thisInds));
    thisIndRand = thisInds(indPerm(1:numberOfBouts2));
   
   
    indStructure(n).thisInds = thisInds;
    indStructure(n).thisIndRand = thisIndRand;

    indStructure(n).dataSet = uniqueDataSetNumber(n);
    indStructure(n).stimNumb = 0;
    
    
end



 








%%
%%%%%%%%%%%%%%%%% make ind structure antonias different data sets %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 if makeplot == 1
    figure 
     
 end
for n = 1 : length(indStructure)

   
   thisIndRand = indStructure(n).thisIndRand;
      dataSet =  indStructure(n).dataSet;

if makeplot == 1
    subplot(ceil(sqrt(length(indStructure))),ceil(sqrt(length(indStructure))),n)
   plot(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), '.k');
 axis([-15 20, -10 10])
 axis square
   
   title(dataSet)
end




    
end


