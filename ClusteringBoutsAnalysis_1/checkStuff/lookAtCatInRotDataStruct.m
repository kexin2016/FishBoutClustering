clear all
close all

%%
%%%%%%%%%%%%%%%%%% load bout cat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folderName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
 filename = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated3.mat';

path1 = strcat(folderName,filename);

 load(path1,'finalClustering');


%%
%%%%%%%%%%%%%%%%%% load boutFile %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folderName = 'C:\Joao analysis\FreeData\RotData\final\';
% filename = 'socialAvoid7fishLight_merged11BoutMap.mat';
  filename = 'rotAlldata_merged11BoutMap_update1.mat';

path1 = strcat(folderName,filename);

 load(path1);

%%
%%%%%%%%%%%%%%% look at map in final structure %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idx = finalClustering.idx;

col = finalClustering.col;
clusterAssignmentInMap = finalClustering.clusterAssignmentInMap;
dataToDoMap = finalClustering.dataToDoMap;


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
%      pause
end


%%
%%%%%%%%%%%%%%%% look at map in social data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutCat = BoutInfAll(:,EnumeratorBoutInf.boutCat);

% boutCat = newAssignmentSocialDataAll;
boutAmplitude8Max = BoutKinematicParametersAll(:,EnumeratorBoutKinPar.boutAmplitude8Max);
maxBoutFreqCorr = BoutKinematicParametersAll(:,EnumeratorBoutKinPar.maxBoutFreqCorr);



figure
for n = 1 : length(uniqueBoutCat)
    
   indThisBoutType = find(boutCat == uniqueBoutCat(idx(n)));
   
     

   plot(boutAmplitude8Max(indThisBoutType(1:500)),maxBoutFreqCorr(indThisBoutType(1:500)), '.', 'color', col(n,:))
    
    hold on
    axis square
    axis([-300 300, 20 60])
%     title(n)
%      pause
end




