AddFunctionToPath

%  close all
% clear all





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

PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
FileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged10.mat';

%  load(strcat(PathName,FileName));



%%
% %%%%%%%%%%%%%% defien number of workers to use %%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %matlabpool('close');
% 
% %close matlabpool if it is already opened
% if matlabpool('size') ~= 0 % checking to see if my pool is already open
%     
%     matlabpool close
% %     matlabpool open numberOfWorkers
%     
%     
% end
% 
% %start matlab pool with number of corrers
% matlabpool open 4

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
% ClusterOfClusterCatAll(302) = 0;%LLE that are in fast swims
% ClusterOfClusterCatAll(321) = 0;%LLE that are in fast swims
% ClusterOfClusterCatAll(325) = 0;%LLE that are in fast swims
% %  ClusterOfClusterCatAll(63) = 7;
% %  ClusterOfClusterCatAll(66) = 7;
uniqueClusterOfClusterCatAll = unique(ClusterOfClusterCatAll);

%%
%%%%%%%%%%%% make ind struct with types of cluster together %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueClusterOfClusterCatAll(uniqueClusterOfClusterCatAll == 0) =[];


sizeOfBigClusters = zeros(1,length(uniqueClusterOfClusterCatAll));
indGroupCluster = [];
indGroupClusterCat = [];
indGroupClusterVector = [];

for nn = 1:length(uniqueClusterOfClusterCatAll)
    
%      nn =13
   
         indsInclusterStructure = find(ClusterOfClusterCatAll == uniqueClusterOfClusterCatAll(idx(nn)));
         
         thisClusterOriginalIndsAll = [];
         
         for n = 1 : length(indsInclusterStructure)
%       n =1    

% if nn ~= 13
        thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).indsCore;
% else
%        thisClusterOriginalInds = clusterStructure(indsInclusterStructure(n)).thisClusterOriginalInds;
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
         
%             indGroupClusterCat = [indGroupClusterCat (zeros(1,length(thisClusterOriginalIndsAll)) + uniqueClusterOfClusterCatAll(nn))];
%             indGroupClusterVector = [indGroupClusterVector' thisClusterOriginalIndsAll']';  
            
          sizeOfBigClusters(nn) = length(thisClusterOriginalIndsAll2);
         sizeOfBigClustersminFreq(nn) = nanmean(BoutKinematicParameters(thisClusterOriginalIndsAll2, EnumeratorBoutKinPar.maxBoutFreqCorr));
         
         
        
end

%%
% %%%%%%%%%%% plot pca hist %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numbDivisions = 15;
% % xVectorAll = [-18:22/numbDivisions:22;-10:13/numbDivisions:13;-4:7/numbDivisions:7];
% xVectorAll{1} = {-18:22/numbDivisions:22};
% xVectorAll{2} = {-10:13/numbDivisions:13};
% xVectorAll{3} = {-10:7/numbDivisions:7};
% xVectorAll{4} = {-10:7/numbDivisions:7};
% 
% figure
% for nn = 1 : 4
%     
%    subplot(2,2,nn)
%      xVector = cell2mat(xVectorAll{nn});
% 
% for n = 1 : length(indGroupCluster)
%     
%     
%  indThisCluster = indGroupCluster(n).indsAll;
%  [nout,xout]= hist(boutDataPCASample(indThisCluster,nn),xVector);
% %  subplot(4,3,n)
%  plot(xVector,nout/sum(nout),'color',col(n,:),'linewidth',2)
% hold on
% axis square
% end
% 
% end



%%
%%%%%%%%%%%% determine number of dims of data set %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandWidthsScalled2 = indStructure(1).bandWidthsScalled;

 numbOfDims =  size(bandWidthsScalled2,1);
%  numbOfDims =  3;
%%
%%%%%%%%%%%%%% make data set to cluster by picking min number of points%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %ignora sizd of capture swims
%  sizeOfBigClusters(12) = sizeOfBigClusters(12)*2;



numbToSample = min(sizeOfBigClusters);
%  numbToSample = 500
% numbToSample*length(uniqueClusterOfClusterCatAll)
thisIndRandFinalAll = [];
finalDataCat = [];


figure
% col = jet(length(indGroupCluster));
 
for i = 1: length(indGroupCluster)
%     i =4
%   i =1  
    indsCore = indGroupCluster(i).indsAll;
    
    if length(indsCore) > numbToSample
    indPerm1 = randperm(length(indsCore));
    thisIndRand = indsCore(indPerm1(1:numbToSample));
    thisIndRand2 = thisIndRand;
    else
    thisIndRand2 = indsCore;
    
    end
    
    
    subplot(2,2,1)  
%     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), boutDataPCASample(thisIndRand,3),'.','color', 'k')
    hold on
    plot3(boutDataPCASample(thisIndRand2,1),boutDataPCASample(thisIndRand2,2), boutDataPCASample(thisIndRand2,3),'.','color', col(i,:))
    hold on
    axis square
    
%      subplot(1,2,2)    
%     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), boutDataPCASample(thisIndRand,3),'.','color', col(i,:))
%     hold on
%     axis square

%      subplot(1,2,2)    
%     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), boutDataPCASample(thisIndRand,3),'.','color', 'k')
%     
    
    
    
    %concatenate vectors
    thisIndRandFinalAll = [thisIndRandFinalAll' thisIndRand2']';
    finalDataCat =  [finalDataCat (zeros(1, length(thisIndRand2)) + i)];
    
     sizeOfBigClustersminFreq2(i) = min(BoutKinematicParameters(thisIndRand2, EnumeratorBoutKinPar.maxBoutFreqCorr));
     
%      pause
end
axis([-20 25 -10 20 -10 10])

finalData = boutDataPCASample(thisIndRandFinalAll,1:numbOfDims);
size(finalData)
%  pause

%%
%%%%%%%%%%%%% do k nearest search for bout map %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %pick data to test
% numbToSample = 1000000;
% inds = 1 : 1 : length(boutDataPCASample);
% 
%  indPerm1 = randperm(length(inds));
%  thisIndRand = inds(indPerm1(1:numbToSample));
% 
% 
% boutDataPCASampleRand = boutDataPCASample(thisIndRand,:);

numbOfK = 50;
distanceMethod = 'euclidean';
tic
 [IDX,D] = knnsearch(finalData,finalData,'k',numbOfK,'Distance',distanceMethod);
toc

%find lables



knnLabels = finalDataCat(IDX);

%assing points by the most frequent label
 clusterAssignmentAllData = mode(knnLabels');
% dataAssign = knnLabels;

%%
%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueDataAssing = unique(clusterAssignmentAllData);

% figure

sizeOfClusters = zeros(1,length(uniqueDataAssing));

for n = 1 : length(uniqueDataAssing)

     indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing(n));
     
     indThisClusterInAllData = thisIndRandFinalAll(indThisCluster);
     
    subplot(2,2,3)
         
    plot3(boutDataPCASample(indThisClusterInAllData,1),boutDataPCASample(indThisClusterInAllData,2), boutDataPCASample(indThisClusterInAllData,3),'.','color', col(n,:))
    hold on
    axis square
     
     subplot(2,2,2)
    plot3(boutDataPCASample(indThisClusterInAllData,1),boutDataPCASample(indThisClusterInAllData,2), boutDataPCASample(indThisClusterInAllData,4),'.','color', col(n,:))
    hold on
    axis square
   

   
        
    sizeOfClusters(n) = length(indThisClusterInAllData);
      sizeOfBigClustersminFreq3(n) = min(BoutKinematicParameters(indThisClusterInAllData, EnumeratorBoutKinPar.maxBoutFreqCorr));

end
axis([-20 25 -10 20 -10 10])

%%
%%%%%%%%%%%%% put same number in bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %ignore size of capture swims
%   sizeOfClusters(12) = sizeOfClusters(12)*2;


minSizeOfCusters = min(sizeOfClusters);

sizeOfClusters2 = zeros(1,length(uniqueDataAssing));

% indThisClusterInAllDataAll = zeros(1,minSizeOfCusters*length(uniqueDataAssing));
% clusterAssignmentInAllData = zeros(1,minSizeOfCusters*length(uniqueDataAssing));

indThisClusterInAllDataAll = [];
clusterAssignmentInAllData = [];

for n = 1 : length(uniqueDataAssing)
    
   indThisCluster = find(clusterAssignmentAllData == uniqueDataAssing(n));

    
    if length(indThisCluster) > minSizeOfCusters
    indPerm1 = randperm(length(indThisCluster));
    thisIndRand = indThisCluster(indPerm1(1:minSizeOfCusters));
    
    else
     thisIndRand =   indThisCluster; 
    end
    
     indThisClusterInAllData = thisIndRandFinalAll(thisIndRand);
    subplot(2,2,4)
    plot3(boutDataPCASample(indThisClusterInAllData,1),boutDataPCASample(indThisClusterInAllData,2), boutDataPCASample(indThisClusterInAllData,4),'.','color', col(n,:))
    hold on
    axis square
    
         
    indThisClusterInAllDataAll = [indThisClusterInAllDataAll' indThisClusterInAllData']';
    clusterAssignmentInAllData = [clusterAssignmentInAllData (zeros(1,length(indThisClusterInAllData)) + uniqueDataAssing(n)) ];     
    sizeOfClusters2(n) = length(indThisClusterInAllData);
      sizeOfBigClustersminFreq4(n) = mean(BoutKinematicParameters(indThisClusterInAllData, EnumeratorBoutKinPar.maxBoutFreqCorr));

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
    
%     subplot(1,2,2)


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

end
axis([-20 25 -10 20 -10 10])




%save new assignment in all data
finalClustering.newAssignmentInAllData = clusterAssignmentAllData;
finalClustering.boutUniqueNumberInAllData = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);

%%
%%%%%%%%%%%%%%% calculate percentage of cature swims %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nn = 4;
indThisCluster = find(clusterAssignmentInAllData == nn);

datasetNumberInMap = BoutInf(indThisClusterInAllDataAll(indThisCluster),EnumeratorBoutInf.dataSetNumber);

ind1 = find(datasetNumberInMap == EnumeratorDataSet.PreyCapture);
ind2 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureNaive);
ind3 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureSmallRotTuNaive2);
ind4 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureSmallRotTuNaive);
ind5 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureSmallRotTuWithRot);
ind6 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureNaiveTu);
ind7 = find(datasetNumberInMap == EnumeratorDataSet.PreyCaptureExpTu);
ind8 = find(datasetNumberInMap == EnumeratorDataSet.SpontanousEyeTracking);


indCapture = [ind1' ind2' ind3' ind4' ind5' ind6' ind7' ind8'];

    length(indCapture)./length(indThisCluster)




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
FileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged10.mat';


%  save(strcat(PathName,FileName),'BoutInf','BoutKinematicParameters','ROCareaNormDimProjtestNoNans','behavioralSpaceStructure','boutDataPCASample','clusterStructure','groupClusterSctructure','indStructure','finalClustering','-v7.3')

 
%%
% %%%%%%%%%%% save cluster map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
FileName = 'BoutMap_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged10.mat';


%   save(strcat(PathName,FileName),'behavioralSpaceStructure','finalClustering','-v7.3')


