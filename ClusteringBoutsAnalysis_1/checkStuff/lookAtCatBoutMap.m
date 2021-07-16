 clear all
 close all

%%
%%%%%%%%%%%%%%%%%% load bout Map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folderName = 'C:\Joao analysis\FreeData\clusteringData\boutMap\finalMerged11\';
%folderName = 'C:\Joao analysis\BehaviorDataAnalysis_161111\FreelyMovingBehaviorAnalysis_11\assignBoutTypesUsingMap\BoutMap\';

filename = 'BoutMap_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';
% filename = 'BoutMapCenters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';%BoutInfFinalArray old cat
%  filename = 'BoutMapWithRawCenters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';%BoutInfFinalArray old cat

% folderName = 'C:\Joao analysis\FreeData\halfBeatClustering\BeatCat\Final\';
% filename = 'BeatCat_HalfBeatFromMerged11_20Kins_6dim_1.55d_5.mat';
% 

load(strcat(folderName,filename))



%%
%%%%%%%%%%%%%%% look at map in finalClustering %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

idx = finalClustering.idx;

col = finalClustering.col;


 clusterAssignmentInMap = finalClustering.clusterAssignmentInMap;
 dataToDoMap = finalClustering.dataToDoMap;


% clusterAssignmentInMap = boutCatFinalArray;

uniqueBoutCat = unique(clusterAssignmentInMap);

figure
%  col = jet(13);
plot3(dataToDoMap(:,1),dataToDoMap(:,2),dataToDoMap(:,3), 'k.')
hold on

for n = 1 : length(uniqueBoutCat)
    
   indThisBoutType = find(clusterAssignmentInMap == uniqueBoutCat(idx(n)));
   
     

   plot3(dataToDoMap(indThisBoutType,1),dataToDoMap(indThisBoutType,2),dataToDoMap(indThisBoutType,3), '.', 'color', col(n,:))
    
    hold on
    axis square
    axis([-20 25, -15 15, -7 10])
%     title(n)
%       pause
end


%%
%%%%%%%%%%%%%%%%%%% look at bouts in raw data BoutInfFinalArray %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BoutInfFinalArray(:,EnumeratorBoutInf.boutCat) = boutCatFinalArray;


boutCat = BoutInfFinalArray(:,EnumeratorBoutInf.boutCat);

boutAmplitude8Max = BoutKinematicParametersFinalArray(:,EnumeratorBoutKinPar.boutAmplitude8Max);
maxBoutFreqCorr = BoutKinematicParametersFinalArray(:,EnumeratorBoutKinPar.maxBoutFreqCorr);



figure

for n = 1 : length(uniqueBoutCat)
    
   indThisBoutType = find(boutCat == uniqueBoutCat(idx(n)));
   
     

   plot(boutAmplitude8Max(indThisBoutType),maxBoutFreqCorr(indThisBoutType), '.', 'color', col(n,:))
    
    hold on
    axis square
    axis([-300 300, 20 60])
%     title(n)
%       pause
end



%%
%%%%%%%%%%%%%%%%%%% look at bouts in raw data boutCatFinalArray %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


boutAmplitude8Max = BoutKinematicParametersFinalArray(:,EnumeratorBoutKinPar.boutAmplitude8Max);
maxBoutFreqCorr = BoutKinematicParametersFinalArray(:,EnumeratorBoutKinPar.maxBoutFreqCorr);



figure

for n = 1 : length(uniqueBoutCat)
    
   indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(idx(n)));
   
     

   plot(boutAmplitude8Max(indThisBoutType),maxBoutFreqCorr(indThisBoutType), '.', 'color', col(n,:))
    
    hold on
    axis square
    axis([-300 300, 20 60])
%     title(n)
%       pause
end





