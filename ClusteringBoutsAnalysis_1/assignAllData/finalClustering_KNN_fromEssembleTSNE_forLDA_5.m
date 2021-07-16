AddFunctionToPath

 close all
clear all





%%
% %%%%%%%%%%%%%%%%%%%%pick GroupsClusters data file with gui%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse
% % GroupsClusters_AllData_74Kins3dims_1.75Smooth_medium_150thres_tsne3
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));


%%
%%%%%%%%%%%%% pick GroupsClusters automatically %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PathName = 'C:\Joao analysis\FreeData\clusteringData\GroupOfClusters\';
FileName = 'GroupsClusters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged10.mat';

    load(strcat(PathName,FileName));
 
 %%
%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%% get stuff out of structure %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clusterAssignmentGroupClusters = groupClusterSctructure.essembleMatrixAssignment;
tsneDistributions = groupClusterSctructure.distributions;

mappedX = tsneDistributions(1).mappedX;

%get doimentions of data
bandWidthsScalled2 = indStructure(1).bandWidthsScalled;

 numbOfDims =  size(bandWidthsScalled2,1);
%  numbOfDims =  3;



%%
%%%%%%%%%%%%%%%% plot tsne space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% idx =[10 2 9 7 5 4 1 6 11 8 3];%
% idx =[7 1 9 3 2 4 8 5 10 11 6];%
% idx = 1:12;
% idx = 1:1:11;

% col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50;0 0 0])./255;
% 
% idx = [9  3 4 6 1 11 10 8 7 5 2 12];

col = jet(length(unique(clusterAssignmentGroupClusters)));

uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);
idx = 1:length(unique(clusterAssignmentGroupClusters));

%    col = jet(length(uniqueClusterAssignmentGroupClusters));
figure
for n = 1 : length(uniqueClusterAssignmentGroupClusters)

    
%     n =2
    indThisGroupOfClusters = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(idx(n)));
    
    
    
    plot3(mappedX(indThisGroupOfClusters,1),mappedX(indThisGroupOfClusters,2),mappedX(indThisGroupOfClusters,3),'.','color',col(n,:))
    hold on
%     plot3(mappedX(indsCore2,1),mappedX(indsCore2,2),mappedX(indsCore2,3),'o','color',col(n,:))
    
%       pause 
end

% axis([-20 20 -20 20 -20 20])
axis square


%%
%%%%%%%%%%%% get size of each small cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


indAllDataPoints = [];

sizeOfClustersAll = zeros(1,length(clusterStructure));

for v = 1: length(clusterStructure)
    

indThisCluster = clusterStructure(v).thisClusterOriginalInds;

indAllDataPoints = [indAllDataPoints' indThisCluster']';

sizeOfClustersAll(v) = length(indThisCluster);

end

%%
%%%%%%%%%%% exclude bad clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 ClusterOfClusterCatAll = [clusterStructure.ClusterOfClusterCat];
  ClusterOfClusterCatAll(418) = 0;%exclude bad CS
%   ClusterOfClusterCatAll(405) = 0;%exclude bad CS

uniqueClusterOfClusterCatAll = unique(ClusterOfClusterCatAll);



%%
%%%%%%%%%%%% make ind struct with types of cluster together %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueClusterOfClusterCatAll(uniqueClusterOfClusterCatAll == 0) =[];


sizeOfBigClusters = zeros(1,length(uniqueClusterOfClusterCatAll));
indGroupCluster = [];
indGroupCluster2 = [];
indGroupClusterCat = [];
indGroupClusterVector = [];
for nn = 1:length(uniqueClusterOfClusterCatAll)
    
%      nn =13
   
         indsInclusterStructure = find(ClusterOfClusterCatAll == uniqueClusterOfClusterCatAll(idx(nn)));
         
         thisClusterOriginalIndsAll = [];
         
         for n = 1 : length(indsInclusterStructure)
%       n =1    

% if nn ~= 13
%         thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).indsCore;
% else
       thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).thisClusterOriginalInds;
% end
%                thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).thisClusterOriginalInds;

       thisClusterOriginalIndsAll = [thisClusterOriginalIndsAll' thisClusterOriginalInds']';
       
       
       
       
         end
         
         %reassign bouts with maxBoutFreqCorr < 40 that are in fast bouts
            thisClusterOriginalIndsAll2 = thisClusterOriginalIndsAll;
%          if nn == 4
%              
%            indError =  find(BoutKinematicParameters(thisClusterOriginalIndsAll, EnumeratorBoutKinPar.maxBoutFreqCorr) < 40); 
%            thisClusterOriginalIndsAll2(indError) = [];
%            
%            indsAllSlow3 =  indGroupCluster(nn-1).indsAll;
%            indGroupCluster(nn-1).indsAll = [indsAllSlow3' indError']';
% 
%          end
%                   

         indGroupCluster(nn).indsAll = thisClusterOriginalIndsAll2;
         indGroupCluster2(nn).indsAll = thisClusterOriginalIndsAll2;
         indGroupCluster2(nn).indsAll2 = thisClusterOriginalIndsAll2;

%             indGroupClusterCat = [indGroupClusterCat (zeros(1,length(thisClusterOriginalIndsAll)) + uniqueClusterOfClusterCatAll(nn))];
%             indGroupClusterVector = [indGroupClusterVector' thisClusterOriginalIndsAll']';  
            
          sizeOfBigClusters(nn) = length(thisClusterOriginalIndsAll2);
         sizeOfBigClustersminFreq(nn) = nanmean(BoutKinematicParameters(thisClusterOriginalIndsAll2, EnumeratorBoutKinPar.maxBoutFreqCorr));
         
         
        
end

%%
%%%%%%%%%%%%%%%% do KNN in sequence %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sizeOfBigClustersSorted indSizeClusters] = sort(sizeOfBigClusters, 'descend');

% figure
col4 = jet(13);
indGroupClusterKnn = [];
numbOfK = 50;
distanceMethod = 'euclidean';


for h = 2 : length(sizeOfBigClustersSorted)
    
%          numbToSample = sizeOfBigClustersSorted(h);

         sizeOfCluster = zeros(1,h);
     for hh = 1 : h
         
         indsCore = indGroupCluster2(indSizeClusters(hh)).indsAll2;
         sizeOfCluster(hh) = length(indsCore);
         
     end
         
         numbToSample = min(sizeOfCluster);
         

     thisIndRandFinalAll = [];
     finalDataCat = [];
     for hh = 1 : h
         
          indsCore = indGroupCluster2(indSizeClusters(hh)).indsAll2;

          indPerm = randperm(length(indsCore));
          thisIndRand = indsCore(indPerm(1:numbToSample));
          
          indGroupCluster(indSizeClusters(hh)).thisIndRand = thisIndRand;
          
     
          thisIndRandFinalAll = [thisIndRandFinalAll' thisIndRand']';
          finalDataCat =  [finalDataCat (zeros(1, length(thisIndRand)) + hh)];

% %            subplot(3,5,h)
%     plot(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),'.','color', col4(hh,:))
%    
%           hold on
%            axis square
     end
     
     %%
     %%%%%%%%%%%%%%%%%% do knn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     finalDataThis = boutDataPCASample(thisIndRandFinalAll,1:numbOfDims);

     tic
    [IDX,D] = knnsearch(finalDataThis,finalDataThis,'k',numbOfK,'Distance',distanceMethod);
    toc
     
     knnLabels = finalDataCat(IDX);
     clusterAssignmentThis = mode(knnLabels');

      
      %%
      %%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
       for hhh = 1 : h
           
           indCore = find(clusterAssignmentThis == hhh);
           
           indGroupCluster2(indSizeClusters(hhh)).indsAll2 = thisIndRandFinalAll(indCore);
           
           
           %      clf
%     subplot(2,7,h)
   
    plot3(boutDataPCASample(thisIndRandFinalAll(indCore),1),boutDataPCASample(thisIndRandFinalAll(indCore),2),boutDataPCASample(thisIndRandFinalAll(indCore),4),'.','color', col4(hhh,:))
    hold on
    %plot(boutDataPCASample(thisIndRandFinalAll(indCore),1),boutDataPCASample(thisIndRandFinalAll(indCore),2),'.','color', 'b')

    axis square
    axis([-20 25 -10 20 -10 10])
           
       end
      
      
     
%     indPerm1 = randperm(length(indsCore1));
%     thisIndRand1 = indsCore1(indPerm1(1:numbToSample));
%     
%      indPerm2 = randperm(length(indsCore2));
%     thisIndRand2 = indsCore2(indPerm2(1:numbToSample));
%      
%      
% pause
     
    
end

%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sizeOfClusters = zeros(1,length(indGroupCluster2));
figure
indThisClusterInAllDataAll = [];
clusterAssignmentInAllData = [];

for i = 1 : length(indGroupCluster2)
    
          indCore = indGroupCluster2(i).indsAll2;
    
          
       indThisClusterInAllDataAll = [indThisClusterInAllDataAll' indCore']';
    clusterAssignmentInAllData = [clusterAssignmentInAllData' (zeros(length(indCore),1) + i)' ]';         
          
          
    subplot(1,2,1)
    plot3(boutDataPCASample(indCore,1),boutDataPCASample(indCore,2),boutDataPCASample(indCore,3),'.','color', col4(i,:))
    hold on
    %plot(boutDataPCASample(thisIndRandFinalAll(indCore),1),boutDataPCASample(thisIndRandFinalAll(indCore),2),'.','color', 'b')

    axis square
    axis([-20 25 -10 20 -10 10])
          
    subplot(1,2,2)
    plot3(boutDataPCASample(indCore,1),boutDataPCASample(indCore,2),boutDataPCASample(indCore,4),'.','color', col4(i,:))
    hold on
    axis square
    axis([-20 25 -10 20 -10 10])
    
    sizeOfClusters(i) = length(indsCore);
    
    pause
end


%%
%%%%%%%%%%%%%%%%% make final clustering structure %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

finalData = boutDataPCASample(indThisClusterInAllDataAll,1:numbOfDims);

finalClustering.method = 'kNearestNeighbor';
finalClustering.numbOfK = numbOfK;
finalClustering.dataToDoMap = finalData;
finalClustering.distanceMethod = distanceMethod;
finalClustering.indsBoutMapInAllData = indThisClusterInAllDataAll;
finalClustering.clusterAssignmentInMap = clusterAssignmentInAllData;
finalClustering.boutUniqueNumbersUsedInMap = BoutInf(indThisClusterInAllDataAll,EnumeratorBoutInf.boutUniqueNumber);

%%
%%%%%%%%%%%%%%%%%%%%%%%%% assign all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% numbOfK = 50;
% distanceMethod = 'euclidean';
tic
 [IDX,D] = knnsearch(finalData,boutDataPCASample(:,1:numbOfDims),'k',numbOfK,'Distance',distanceMethod);
toc
% [IDX,D] = knnsearch(finalData,finalData,'k',numbOfK,'Distance',distanceMethod);

%find lables


knnLabels = clusterAssignmentInAllData(IDX);

%assing points by the most frequent label
 clusterAssignmentAllData = mode(knnLabels');
% dataAssign = knnLabels;

%%
%%%%%%%%%%%%%% plot assinged data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


uniqueDataAssing = unique(clusterAssignmentAllData);
countBouts = 0;
numbBouts = 1000;
figure
for n = 1 : length(uniqueDataAssing)
    
%   n =4
  indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing((n)));
    
    indThisClusterGood = intersect(indGoodBouts,indThisCluster);
   
    if length(indThisClusterGood) < numbBouts
        
        numbBouts2 = length(indThisClusterGood);
        
    else
        
        numbBouts2 = numbBouts;
        
    end
        
    
    
     indPerm1 = randperm(length(indThisClusterGood));
    indThisClusterGoodRand = indThisClusterGood(indPerm1(1:numbBouts2));
    
     subplot(1,2,1)


 plot3(boutDataPCASample(indThisClusterGoodRand,1),boutDataPCASample(indThisClusterGoodRand,2), boutDataPCASample(indThisClusterGoodRand,3), '.','color', col(n,:))
 hold on
 
      subplot(1,2,2)


 plot3(boutDataPCASample(indThisClusterGoodRand,1),boutDataPCASample(indThisClusterGoodRand,2), boutDataPCASample(indThisClusterGoodRand,4), '.','color', col(n,:))
 hold on
%      if n ==4
%         
%         
%     plot3(boutDataPCASample(indSlowBoutsThis,1),boutDataPCASample(indSlowBoutsThis,2), boutDataPCASample(indSlowBoutsThis,3), '.','color','b')
% 
%     end
    hold on
    
    axis square
    countBouts = countBouts + length(boutDataPCASample);
    
%     sizeOfBigClustersminFreq5(n) = nanmean(BoutKinematicParameters(indThisClusterGood, EnumeratorBoutKinPar.maxBoutFreqCorr));
%     distX(n) = nanmean(BoutKinematicParameters(indThisClusterGood, EnumeratorBoutKinPar.distBoutDistanceX));
% pause
end
axis([-20 25 -10 20 -10 10])




%save new assignment in all data
finalClustering.newAssignmentInAllData = clusterAssignmentAllData;
finalClustering.boutUniqueNumberInAllData = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);
finalClustering.idx = [1 9 11 3 4 5 2 10 8 6 13 12 7];


%%
%%%%%%%%%%%%%%% calculate percentage of cature swims %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
percPreyCature = zeros(1,13);

for k = 1 :length(unique(clusterAssignmentInAllData))
    
    
indThisCluster = find(clusterAssignmentInAllData == k);

datasetNumberInMap = BoutInf(indThisClusterInAllDataAll(indThisCluster),EnumeratorBoutInf.dataSetNumber);

ind1 = find(datasetNumberInMap == EnumeratorDataSet.PreyCapture);
ind2 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureNaive);
ind3 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureSmallRotTuNaive2);
ind4 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureSmallRotTuNaive);
ind5 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureSmallRotTuWithRot);
ind6 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureNaiveTu);
ind7 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureExpTu);
ind8 = find(datasetNumberInMap == EnumeratorDataSet.SpontanousEyeTracking);
ind9 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureExpTu2);
ind10 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureNaiveTu2);


indCapture = [ind1' ind2' ind3' ind4' ind5' ind6' ind7' ind8' ind9' ind10'];

    percPreyCature(k) = (length(indCapture)./length(indThisCluster))*100;
end




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
FileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged10.mat';


% save(strcat(PathName,FileName),'BoutInf','BoutKinematicParameters','ROCareaNormDimProjtestNoNans','behavioralSpaceStructure','boutDataPCASample','clusterStructure','groupClusterSctructure','indStructure','finalClustering','-v7.3')

 
%%
% %%%%%%%%%%% save cluster map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
FileName = 'BoutMap_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged10.mat';


% save(strcat(PathName,FileName),'behavioralSpaceStructure','finalClustering','-v7.3')

