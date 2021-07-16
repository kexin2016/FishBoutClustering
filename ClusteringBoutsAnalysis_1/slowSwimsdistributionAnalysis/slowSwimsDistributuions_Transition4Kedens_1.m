




% clear all
% close all

%%
%%%%%%%%%%%%%%% import BoutCat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');


%%
%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);
indMistakesIn74KinSpace = find(mistakesIn74KinSpace);

indBoutsToExclude = [indBadBouts' indMistakesIn74KinSpace']';
indGoodBouts = 1 : length(BoutInf);
indGoodBouts(indBoutsToExclude) = [];

%%
%%%%%%%%%%% make structure with transition4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makeplot = 0;

[indStructureTransitions] = indStructureCreator_LightTransitions4_2(BoutInf,indGoodBouts,boutDataPCASample,makeplot);

%get inds of bouts

thisIndsStimAll = [];
for h = 3 : length(indStructureTransitions)
    
%     thisIndsStim =  indStructureTransitions(nn).thisInds;
         thisIndsStim =  intersect(indGoodBouts, indStructureTransitions(h).thisInds);

    thisIndsStimAll = [thisIndsStimAll thisIndsStim];

end
size(thisIndsStimAll)
 %%
%%%%%%%%%% plot bout type per stim  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);

%  indTransitions4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.DarkLightTransitions4));
indTransitions4 = intersect(indGoodBouts,thisIndsStimAll);
uniqueBoutCat = unique(boutCat);



figure
numbEachBoutType = zeros(1,length(uniqueBoutCat));
   
for n = 1 : length(uniqueBoutCat)
% n =1

    thisBoutType = find(boutCat == uniqueBoutCat(n));
    indThisBoutType = intersect(thisBoutType,indTransitions4);
    
    
% plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));
plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));

hold on
axis square
% title(stimNumb)
% pause
numbEachBoutType(n) = length(indThisBoutType);
end



% for nn = 1 : length(indStructureTransitions)
%    thisIndsStim =  indStructureTransitions(nn).thisInds;
%    stimNumb = indStructureTransitions(nn).stimNumb;
%    
%    figure
% for n = 1 : length(uniqueBoutCat)
% 
%     thisBoutType = find(boutCat == uniqueBoutCat(n));
%     indThisBoutType = intersect(thisBoutType,thisIndsStim);
%     
%     
% % plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));
% plot(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2), '.','color',col(n,:));
% 
% hold on
% axis square
% title(stimNumb)
% % pause
% 
% end
% end




%%
%%%%%%%%%% plot bout type per stim  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutDataPCASampleNew=boutDataPCASample;

densityType = 'local';
numbOfDims = 1;
% scallingFactor =1.75;
scallingFactor = 1;
kdedens = [];

col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);

indTransitions4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.DarkLightTransitions4));

uniqueBoutCat = unique(boutCat);

xVector = -15:1:20;

colJet = jet(length(indStructureTransitions)-10);

figure
% subplot(1,2,1)  
counter = 1;
for nn = 11 : length(indStructureTransitions)
   thisIndsStim =  indStructureTransitions(nn).thisInds;
   stimNumb = indStructureTransitions(nn).stimNumb;
   
   indThisBoutTypeAll = [];
for n = 1 : 4

    thisBoutType = find(boutCat == uniqueBoutCat(n));
    indThisBoutType = intersect(thisBoutType,thisIndsStim);
    
    indThisBoutTypeAll = [indThisBoutTypeAll indThisBoutType];
end   


%calcualte densities
kdedens = [];
 kdedens = kde(boutDataPCASampleNew(indThisBoutTypeAll,1:numbOfDims)',densityType);
 originalBandWidths = getBW(kdedens);
 densities = evaluate(kdedens,boutDataPCASampleNew(indThisBoutTypeAll,1:numbOfDims)');

 makeplot = 0;

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBW_1(boutDataPCASampleNew(indThisBoutTypeAll,1:numbOfDims)',kdedens,scallingFactor,densityType,makeplot);

densitiesScalled = evaluate(kdedensCutOff,boutDataPCASampleNew(indThisBoutTypeAll,1:numbOfDims)');

 
   subplot(2,4,counter)

% plot3(boutDataPCASample(indThisBoutTypeAll,1),boutDataPCASample(indThisBoutTypeAll,2),densitiesScalled, 'k.');
% scatter(boutDataPCASample(indThisBoutTypeAll,1),boutDataPCASample(indThisBoutTypeAll,2),3,densitiesScalled);
% 
% axis square
% axis([-15 5 -5 5 ])

  subplot(2,4,counter)
[nout,xout] = hist(boutDataPCASampleNew(indThisBoutTypeAll,1), xVector);

hold on

plot(boutDataPCASampleNew(indThisBoutTypeAll,1),bandWidthsScalled,'.', 'color', colJet(counter,:),'linewidth',2)


plot(xVector,nout/sum(nout),'-', 'color', 'k','linewidth',2)


hold on
axis square

counter = counter +1;


end

%%
%%%%%%%%%%%%%%%%5 plot dark %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
counter = 1;
indThisBoutTypeAllAll = [];

xVector = -15:1:10;
colJet = jet(length(indStructureTransitions)-10);


figure
% subplot(1,2,1)  
counter = 1;
for nn = 3 : 10
   thisIndsStim =  indStructureTransitions(nn).thisInds;
   stimNumb = indStructureTransitions(nn).stimNumb;
   
   indThisBoutTypeAll = [];
for n = 1 : 4

    thisBoutType = find(boutCat == uniqueBoutCat(n));
    indThisBoutType = intersect(thisBoutType,thisIndsStim);
    
    indThisBoutTypeAll = [indThisBoutTypeAll indThisBoutType];
end   


%calcualte densities
 kdedens = kde(boutDataPCASample(indThisBoutTypeAll,1:numbOfDims)',densityType);
 originalBandWidths = getBW(kdedens);
 densities = evaluate(kdedens,boutDataPCASample(indThisBoutTypeAll,1:numbOfDims)');

 makeplot = 0;

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBW_1(boutDataPCASample(indThisBoutTypeAll,1:numbOfDims)',kdedens,scallingFactor,densityType,makeplot);

densitiesScalled = evaluate(kdedensCutOff,boutDataPCASample(indThisBoutTypeAll,1:numbOfDims)');

 
  

% plot3(boutDataPCASample(indThisBoutTypeAll,1),boutDataPCASample(indThisBoutTypeAll,2),densitiesScalled, 'k.');
% scatter(boutDataPCASample(indThisBoutTypeAll,1),boutDataPCASample(indThisBoutTypeAll,2),3,densitiesScalled);
% 
% axis square
% axis([-15 5 -5 5 ])
 subplot(2,4,counter)
 hold on

plot(boutDataPCASampleNew(indThisBoutTypeAll,1),densitiesScalled,'.', 'color', colJet(counter,:),'linewidth',2)


 
 
 [nout,xout] = hist(boutDataPCASampleNew(indThisBoutTypeAll,1), xVector);
plot(xVector,nout/sum(nout),'-', 'color', 'k','linewidth',2)

axis square


counter = counter +1;

end




%%
%%%%%%%%%%%% calcualte debsity by kedens %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%