




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




