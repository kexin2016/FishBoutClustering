AddFunctionToPath

 close all
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

PathName = 'C:\Joao analysis\FreeData\clusteringData\GroupOfClusters\';
FileName = 'GroupsClusters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged10.mat';

%     load(strcat(PathName,FileName));
 
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
% figure
% for n = 1 : length(uniqueClusterAssignmentGroupClusters)
% 
%     
% %     n =2
%     indThisGroupOfClusters = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(idx(n)));
%     
%     
%     
%     plot3(mappedX(indThisGroupOfClusters,1),mappedX(indThisGroupOfClusters,2),mappedX(indThisGroupOfClusters,3),'.','color',col(n,:))
%     hold on
% %     plot3(mappedX(indsCore2,1),mappedX(indsCore2,2),mappedX(indsCore2,3),'o','color',col(n,:))
%     
% %       pause 
% end
% 
% % axis([-20 20 -20 20 -20 20])
% axis square


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
% %%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clearvars boutDataPCASample 
% 
% %get vars out of structure
% meanAllVar = behavioralSpaceStructure.meanAllVar;
% stdAllVar = behavioralSpaceStructure.stdAllVar;
% COEFF = behavioralSpaceStructure.COEFF;
% latent = behavioralSpaceStructure.latent;
% maxKinPars = behavioralSpaceStructure.maxKinPars;
% indKinPars = behavioralSpaceStructure.indKinPars;
% meanPCASpace = behavioralSpaceStructure.meanPCASpace;
% 
% 
% 
% [boutDataPCASample] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParameters,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);
% 

%%
%%%%%%%%%%%%%%%%% look at histograms in many dimentions %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bin = 0.5;

xvectorStruct(1).xvector = -20:bin:25;
xvectorStruct(2).xvector = -15:bin:15;
xvectorStruct(3).xvector = -10:bin:10;
xvectorStruct(4).xvector = -10:bin:7.5;
xvectorStruct(5).xvector = -7.5:bin:7.5;
xvectorStruct(6).xvector = -5:bin:7.5;
xvectorStruct(7).xvector = -5:bin:7.5;
xvectorStruct(8).xvector = -5:bin:7.5;
xvectorStruct(9).xvector = -5:bin:6;
xvectorStruct(10).xvector = -4:bin:5;
xvectorStruct(11).xvector = -4:bin:5;
xvectorStruct(12).xvector = -4:bin:5;
xvectorStruct(13).xvector = -4:bin:5;
xvectorStruct(14).xvector = -4:bin:5;
xvectorStruct(15).xvector = -4:bin:5;
xvectorStruct(16).xvector = -4:bin:5;
xvectorStruct(17).xvector = -4:bin:5;
xvectorStruct(18).xvector = -4:bin:5;
xvectorStruct(19).xvector = -4:bin:5;
xvectorStruct(20).xvector = -4:bin:5;
xvectorStruct(21).xvector = -4:bin:5;
xvectorStruct(22).xvector = -4:bin:5;
xvectorStruct(23).xvector = -4:bin:5;
xvectorStruct(24).xvector = -4:bin:5;
xvectorStruct(25).xvector = -4:bin:5;
xvectorStruct(26).xvector = -4:bin:5;

% indClusterToShow = [9, 11,3,4,5];
%indClusterToShow = [ 11,3,4];

indClusterToShow = 1:13;

col3 = jet(length(uniqueClusterOfClusterCatAll(indClusterToShow)));
for ii = 1 : length(xvectorStruct)
    
xvector = xvectorStruct(ii).xvector;
    
    
    figure
for i = 1 : length(indClusterToShow)
    
    
    
     indsAll2 = indGroupCluster2(indClusterToShow(i)).indsAll2;
             
             

    
    NThis = hist(boutDataPCASample(indsAll2,ii),xvector);
    
    
    plot(xvector,NThis/sum(NThis), '-', 'color', col3(i,:), 'linewidth', 3)
    hold on
    axis square
    
    
    
    
    
    
    
    
    
    
    
end  
end