clear all
close all

%%
%%%%%%%%%%%%%%%%%% load bout cat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folderName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\';
filename = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated3.mat';

path1 = strcat(folderName,filename);

 load(path1,'finalClustering');


%%
%%%%%%%%%%%%%%%%%% load boutFile %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get folder name where the folders with each dataset are
[filename,folderName] =  uigetfile;

load(strcat(folderName,filename))

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
%%%%%%%%%%%%%%%%%%% look at bouts in raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure
for nn = 1 : length(allBoutStructure)

BoutKinematicParameters = allBoutStructure(nn).BoutKinematicParameters;
BoutInf = allBoutStructure(nn).BoutInf;

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);

boutAmplitude8Max = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutAmplitude8Max);
maxBoutFreqCorr = BoutKinematicParameters(:,EnumeratorBoutKinPar.maxBoutFreqCorr);





for n = 1 : length(uniqueBoutCat)
    
   indThisBoutType = find(boutCat == uniqueBoutCat(idx(n)));
   
     

   plot(boutAmplitude8Max(indThisBoutType),maxBoutFreqCorr(indThisBoutType), '.', 'color', col(n,:))
    
    hold on
    axis square
    axis([-300 300, 20 60])
%     title(n)
%       pause
end


end

