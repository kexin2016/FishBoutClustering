function [indStructure] = indStructureCreator_MK801_3000(BoutInf,indGoodBouts,boutDataPCASample,makeplot)




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
numbToChunk = 3000;
uniqueDataSetNumber = unique(dataSetNumber);
% numberOfBouts2 = 3000;
counter = 1;
for n  = 1 : length(uniqueDataSetNumber)
%     n =1
   thisIndsThisDataSet = intersect(indGoodBouts, find(dataSetNumber == uniqueDataSetNumber(n)));
    
   uniqueStimNumber = unique(stimNumber(thisIndsThisDataSet));
   
   
   for nn = 1: length(uniqueStimNumber)
%    nn =2
   thisInds = intersect(thisIndsThisDataSet,find(stimNumber == uniqueStimNumber(nn)));
       
       
%    if length(thisInds) < numbToChunk
    
      indStructure(counter).thisInds = thisInds;
%       indStructure(counter).thisIndRand = thisInds;

      indStructure(counter).dataSet = uniqueDataSetNumber(n);
      indStructure(counter).stimNumb = uniqueStimNumber(nn);

      counter = counter +1;


   
   end

end



%%
%%%%%%%%%%%%%%%%%% pick random bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfBouts2 = 500;

for j = 1 : length(indStructure)

    thisInds = indStructure(counter).thisInds;
    
 if length(thisInds) > numberOfBouts2
     
    indPerm = randperm(length(thisInds));
    thisIndRand = thisInds(indPerm(1:numberOfBouts2));
    
    indStructure(n).thisIndRand = thisIndRand;
    
    
 else
    indStructure(n).thisIndRand = thisInds;
    
 end
    
 
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


