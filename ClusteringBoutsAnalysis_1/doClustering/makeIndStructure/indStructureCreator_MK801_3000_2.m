function [indStructure] = indStructureCreator_MK801_3000_2(BoutInf,indGoodBouts,boutDataPCASample,makeplot)




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

indFirstBouts = find(numberOfBoutInStim == 1);
indNotFirstBouts = find(numberOfBoutInStim > 1);


indStructure =[];

%%
%%%%%%%%%%%%%%% make indStructure for each data set 1st bout %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numbToChunk = 3000;
uniqueDataSetNumber = unique(dataSetNumber);
% numberOfBouts2 = 3000;
counter = 1;
for n  = 1 : length(uniqueDataSetNumber)
%     n =1
   thisIndsThisDataSet = intersect(indGoodBouts, find(dataSetNumber == uniqueDataSetNumber(n)));
    
   uniqueStimNumber = unique(stimNumber(thisIndsThisDataSet));
   
   
   for nn = 1: length(uniqueStimNumber)
%    nn =2
   thisInds = intersect(indFirstBouts, intersect(thisIndsThisDataSet,find(stimNumber == uniqueStimNumber(nn))));
       if length(thisInds) > 100
       
%    if length(thisInds) < numbToChunk
    
      indStructure(counter).thisInds = thisInds;
%       indStructure(counter).thisIndRand = thisInds;

      indStructure(counter).dataSet = uniqueDataSetNumber(n);
      indStructure(counter).stimNumb = uniqueStimNumber(nn);

      counter = counter +1;

       end
   
   end

end



%%
%%%%%%%%%%%%%%% make indStructure for each data set other bouts %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numbToChunk = 3000;
uniqueDataSetNumber = unique(dataSetNumber);
% numberOfBouts2 = 3000;

for n  = 1 : length(uniqueDataSetNumber)
%     n =1
   thisIndsThisDataSet = intersect(indGoodBouts, find(dataSetNumber == uniqueDataSetNumber(n)));
    
   uniqueStimNumber = unique(stimNumber(thisIndsThisDataSet));
   
   
   for nn = 1: length(uniqueStimNumber)
%    nn =2
   thisInds = intersect(indNotFirstBouts, intersect(thisIndsThisDataSet,find(stimNumber == uniqueStimNumber(nn))));
       
       
%    if length(thisInds) < numbToChunk
     if length(thisInds) > 100
      indStructure(counter).thisInds = thisInds;
%       indStructure(counter).thisIndRand = thisInds;

      indStructure(counter).dataSet = uniqueDataSetNumber(n);
      indStructure(counter).stimNumb = uniqueStimNumber(nn);

      counter = counter +1;

     end
   
   end

end



%%
%%%%%%%%%%%%%%%%%% pick random bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfBouts2 = 3000;

for j = 1 : length(indStructure)

    thisInds = indStructure(j).thisInds;
    
 if length(thisInds) > numberOfBouts2
     
    indPerm = randperm(length(thisInds));
    thisIndRand = thisInds(indPerm(1:numberOfBouts2));
    
    indStructure(j).thisIndRand = thisIndRand;
    
    
 else
    indStructure(j).thisIndRand = thisInds;
    
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
%     subplot(ceil(sqrt(length(indStructure))),ceil(sqrt(length(indStructure))),n)
    figure
    
    if length(thisIndRand) > 500
    
   plot(boutDataPCASample(thisIndRand(1:500),1),boutDataPCASample(thisIndRand(1:500),2), '.k');
 axis([-15 20, -10 10])
 axis square
 
    else
        
      plot(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), '.k');
 axis([-15 20, -10 10])
 axis square
    end
   
   title(dataSet)
end




    
end


