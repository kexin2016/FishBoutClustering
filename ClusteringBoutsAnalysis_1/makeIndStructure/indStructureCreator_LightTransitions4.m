function [indStructure] = indStructureCreator_LightTransitions4(BoutInf,indGoodBouts,boutDataPCASample,makeplot)




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
indDarkLightTransitions4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.DarkLightTransitions4))';%1-13

indStructure =[];
%%
%%%%%%%%%%%%%% determine latencies %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
latencyThresholdLight =30.*700;
  
indLatencyLight = find( latencyOfBoutAfterStim > latencyThresholdLight);

latencyThresholdDark = 30.*1000;
 
indLatencyDark = find( latencyOfBoutAfterStim > latencyThresholdDark);
%  titleName = {'6','16','32','50','80','129','175','243','339','454','600','820','1500','1880','3120','4500'};
 
 titleName = {'7','17','34','54','83','126','190','275','390','505','680','901','1583','2200','3836','5617'};

 
 
%%
%%%%%%%%%%%%%%%%% make ind structure for first bouts Dark %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 darkStim = 2:2:32;


indThisBoutsAll = [];
for n = 1 : length(darkStim)

    indThisStim = find(stimNumber == darkStim(n));
    indThisBouts = intersect(intersect(intersect(indThisStim,indGoodBouts),indDarkLightTransitions4),indFirstBouts);
    indThisBoutsAll = [indThisBoutsAll indThisBouts];
    
end



if makeplot == 1
        subplot(1,2,1)

   plot(boutDataPCASample(indThisBoutsAll,1),boutDataPCASample(indThisBoutsAll,2), 'k.');
   axis([-15 20, -10 15])
   axis square
   
   
end


indStructure(1).thisInds = indThisBoutsAll;
indStructure(1).dataSet = 'lightTransitions1stBoutsDark';
indStructure(1).stimNumb = 'NaN';

%%
%%%%%%%%%%%%%%%%% make ind structure for first bouts light %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lightStim = 1:2:31;

indThisBoutsAll = [];
for n = 1 : length(lightStim)

    indThisStim = find(stimNumber == lightStim(n));
    indThisBouts = intersect(intersect(intersect(indThisStim,indGoodBouts),indDarkLightTransitions4),indFirstBouts);
    indThisBoutsAll = [indThisBoutsAll indThisBouts];
end


makeplot = 1;
if makeplot == 1
    subplot(1,2,2)
   plot(boutDataPCASample(indThisBoutsAll,1),boutDataPCASample(indThisBoutsAll,2), '.k');
   axis([-15 20, -10 15])
   axis square
   
   
end


indStructure(2).thisInds = indThisBoutsAll;
indStructure(2).dataSet = 'lightTransitions1stBoutsLight';
indStructure(2).stimNumb = 'NaN';



%%
%%%%%%%%%%%%%%%%% make ind structure for different darks %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 darkStim = 2:2:32;

 if makeplot == 1
    figure 
     
 end
 counter = 3;
for n = 1 : length(darkStim)

    indThisStim = find(stimNumber == darkStim(n));
    indThisBouts = intersect(intersect(intersect(intersect(indThisStim,indGoodBouts),indDarkLightTransitions4),indNotFirstBouts),indLatencyDark);
    
    
indStructure(counter).thisInds = indThisBouts;
indStructure(counter).dataSet = 'lightTransitionsDark';
indStructure(counter).stimNumb = titleName{n};

if makeplot == 1
    subplot(4,4,n)
   plot(boutDataPCASample(indThisBouts,1),boutDataPCASample(indThisBouts,2), '.k');
 axis([-15 10, -10 5])
 axis square
   
   
end

 counter = counter +1;


    
end







%%
%%%%%%%%%%%%%%%%% make ind structure for different lights %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 lightStim = 1:2:31;

 
 if makeplot == 1
    figure 
     
 end
for n = 1 : length(lightStim)

    indThisStim = find(stimNumber == lightStim(n));
    indThisBouts = intersect(intersect(intersect(intersect(indThisStim,indGoodBouts),indDarkLightTransitions4),indNotFirstBouts),indLatencyLight);
    
    
indStructure(counter).thisInds = indThisBouts;
indStructure(counter).dataSet = 'lightTransitionsLight';
indStructure(counter).stimNumb = titleName{n};

if makeplot == 1
    subplot(4,4,n)
   plot(boutDataPCASample(indThisBouts,1),boutDataPCASample(indThisBouts,2), '.k');
 axis([-15 10, -10 5])
 axis square
   
   
end

 counter = counter +1;


    
end


