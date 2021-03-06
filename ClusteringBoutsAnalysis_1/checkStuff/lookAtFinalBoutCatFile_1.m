clear all
close all


%%
%%%%%%%%%%%%%%%%%% load bout cat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folderName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\';
filename = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated3.mat';

path1 = strcat(folderName,filename);

 load(path1,'BoutInf');
 load(path1,'boutDataPCASample');
 load(path1,'finalClustering');



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
%%%%%%%%%%%%%%%%%%% look at cat in all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%boutCat = BoutInf(:,EnumeratorBoutInf.boutCat)';
boutCat = finalClustering.newAssignmentInAllData;



figure
%  col = jet(13);
% plot3(dataToDoMap(:,1),dataToDoMap(:,2),dataToDoMap(:,3), 'k.')
hold on

for n = 1 : length(uniqueBoutCat)
    
   indThisBoutType = find(boutCat == uniqueBoutCat(idx(n)));
   
   indThisBoutTypeMap = intersect(indThisBoutType,indsBoutMapInAllData);

   plot3(boutDataPCASample(indThisBoutTypeMap,1),boutDataPCASample(indThisBoutTypeMap,2),boutDataPCASample(indThisBoutTypeMap,3), '.', 'color', col(n,:))
    
    hold on
    axis square
    axis([-20 25, -15 15, -7 10])
%     title(n)
%      pause
end



%%
%%%%%%%%%%%%%%%%%%% look at map bouts in raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%find good bouts 
mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);
brokenBouts = BoutInf(:,EnumeratorBoutInf.brokenBouts);
doubleBout = BoutInf(:,EnumeratorBoutInf.doubleBout);
firstSegmentWithMistakes = BoutInf(:,EnumeratorBoutInf.firstSegmentWithMistakes);

indGoodBouts1 = find(mistakesIn74KinSpace == 0);
indGoodBouts2 = find(brokenBouts == 0);
indGoodBouts3 = find(doubleBout == 0);
indGoodBouts4 = find(firstSegmentWithMistakes >= 8);


indGoodBouts = [indGoodBouts1' indGoodBouts2' indGoodBouts3' indGoodBouts4'];


indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;





%boutCat = BoutInf(:,EnumeratorBoutInf.boutCat)';
boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);



figure
%  col = jet(13);
% plot3(dataToDoMap(:,1),dataToDoMap(:,2),dataToDoMap(:,3), 'k.')
hold on
numbBouts = 500;
for n = 1 : length(uniqueBoutCat)
    
   indThisBoutType = find(boutCat == uniqueBoutCat(idx(n)));
   
   indPerm = randperm(length(indThisBoutType));
   indThisBoutTypeRand = indThisBoutType(indPerm(1:numbBouts));

   indThisBoutTypeRandGood = intersect(indGoodBouts,indThisBoutTypeRand);
   
   plot3(boutDataPCASample(indThisBoutTypeRandGood,1),boutDataPCASample(indThisBoutTypeRandGood,2),boutDataPCASample(indThisBoutTypeRandGood,3), '.', 'color', col(n,:))
    
    hold on
    axis square
    axis([-20 25, -15 15, -7 10])
%     title(n)
%      pause
end



