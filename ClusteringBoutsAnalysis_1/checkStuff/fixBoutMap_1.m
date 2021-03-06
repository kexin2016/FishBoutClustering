clear all
 close all

%%
%%%%%%%%%%%%%%%%%% load bout Map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folderName = 'C:\Joao analysis\FreeData\clusteringData\boutMap\finalMerged11\';
%folderName = 'C:\Joao analysis\BehaviorDataAnalysis_161111\FreelyMovingBehaviorAnalysis_11\assignBoutTypesUsingMap\BoutMap\';

filename = 'BoutMap_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';
filename = 'BoutMapCenters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';%BoutInfFinalArray old cat
  filename = 'BoutMapWithRawCenters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';%BoutInfFinalArray old cat
 
% filename = 'BoutMapWithRaw_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_corr.mat';%col broken



load(strcat(folderName,filename))

BoutInfFinalArray(:,EnumeratorBoutInf.boutCat) = boutCatFinalArray;

%%
%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars filename folderName col idx

folderName = 'C:\Joao analysis\FreeData\clusteringData\boutMap\finalMerged11\';
filename = 'BoutMapWithRawCenters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_corr.mat';%BoutInfFinalArray old cat

% % save
% save(strcat(folderName,filename),)
save(strcat(folderName,filename)) 

