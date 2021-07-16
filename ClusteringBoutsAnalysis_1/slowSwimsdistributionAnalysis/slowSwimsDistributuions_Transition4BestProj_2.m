




% clear all
% close all

%%
% %%%%%%%%%%%%%%% import BoutCat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');
% 

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
xlabel('PC 1')
ylabel('PC 2')
zlabel('PC 3')

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
%%%%%%%%% project points in to axis emperically measured %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indSlowSwims = find(boutCat <=3);
indBoutsForPCA = intersect(indSlowSwims,indTransitions4);
% BoutKinematicParametersGood = boutDataPCASample(indTransitions4,:);


point1 = [-10,0.5,3];
point2 = [3,3,-4];

joinvector=point2-point1;
joinvector=joinvector/sqrt(sum(power(joinvector,2)));

boutDataPCASampleNew=boutDataPCASample*joinvector';
% clusterPorj2=cluster2*joinvector';


% hist(clusterProj1,1000)
%%
%%%%%%%%%% plot bout type per stim  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;


boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);

indTransitions4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.DarkLightTransitions4));

uniqueBoutCat = unique(boutCat);

xVector = -15:1:10;

colJet = jet(length(indStructureTransitions)-10);

figure
% subplot(1,2,1)  
counter = 1;
for nn = 11 : length(indStructureTransitions)
   thisIndsStim =  indStructureTransitions(nn).thisInds;
   stimNumb = indStructureTransitions(nn).stimNumb;
   
   indThisBoutTypeAll = [];
for n = 1 : 3

    thisBoutType = find(boutCat == uniqueBoutCat(n));
    indThisBoutType = intersect(thisBoutType,thisIndsStim);
    
    indThisBoutTypeAll = [indThisBoutTypeAll indThisBoutType];
end   
% plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));
% plot(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2), '.','color',col(n,:));
% 
% hold on
% axis square
% title(stimNumb)
% pause
  subplot(2,4,counter)
[nout,xout] = hist(boutDataPCASampleNew(indThisBoutTypeAll,1), xVector);

plot(xVector,nout/sum(nout),'-', 'color', colJet(counter,:),'linewidth',2)

hold on
axis square

counter = counter +1;

end


 figure
% subplot(1,2,2)  
counter = 1;

indThisBoutTypeAllAll = [];
for nn = 3 : 10
   thisIndsStim =  indStructureTransitions(nn).thisInds;
   stimNumb = indStructureTransitions(nn).stimNumb;
   
   indThisBoutTypeAll = [];
for n = 1 : 3

    thisBoutType = find(boutCat == uniqueBoutCat(n));
    indThisBoutType = intersect(thisBoutType,thisIndsStim);
    
    indThisBoutTypeAll = [indThisBoutTypeAll indThisBoutType];
end   

indThisBoutTypeAllAll = [indThisBoutTypeAllAll indThisBoutTypeAll];
% plot3(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2),boutDataPCASample(indThisBoutType,3), '.','color',col(n,:));
% plot(boutDataPCASample(indThisBoutType,1),boutDataPCASample(indThisBoutType,2), '.','color',col(n,:));
% 
% hold on
% axis square
% title(stimNumb)
% pause
  subplot(2,4,counter)
[nout,xout] = hist(boutDataPCASampleNew(indThisBoutTypeAll,1), xVector);

plot(xVector,nout/sum(nout),'-', 'color', colJet(counter,:),'linewidth',2)

hold on
axis square

counter = counter +1;

end

figure
xVector2 = -15:0.5:10;

[nout,xout] = hist(boutDataPCASampleNew(indThisBoutTypeAllAll,1), xVector2);

plot(xVector2,nout/sum(nout),'-', 'color', 'k','linewidth',2)
title('all dark together')
hold on
axis square

%%
% %%%%%%%%%%%% make slow swims histogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %pick slow swims
% indSlowSwims = find(boutCat <=3);
% 
% figure
% subplot(1,3,1)
% hist(boutDataPCASample(indSlowSwims,1),1000)
% subplot(1,3,2)
% hist(boutDataPCASample(indSlowSwims,2),1000)
% subplot(1,3,3)
% hist(boutDataPCASample(indSlowSwims,3),1000)
% 
% 
% 
% plot3(boutDataPCASample(indSlowSwims,1),boutDataPCASample(indSlowSwims,2),boutDataPCASample(indSlowSwims,3), '.','color',col(n,:));


