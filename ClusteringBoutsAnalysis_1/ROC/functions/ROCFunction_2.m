function [ROCareaNormDimProjtestNoNans] = ROCFunction_2(clusterStructure)




%%
%%%%%%%%%%%%%%%%%%%%5 determine number of dimentions %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutDataPCASampleDataThisCluster = clusterStructure(1).boutDataPCASampleDataThisCluster;

numbOfDims = size(boutDataPCASampleDataThisCluster,2);


%%
%%%%%%%%% calculated Projected ROC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BigCluster = [clusterStructure.BigCluster];
indBigClusters = find(BigCluster == 1);
sizeOfROCMatrix = length(indBigClusters);


ROCareaNormDimProj = zeros(sizeOfROCMatrix,sizeOfROCMatrix);
ROCareaNormDimProjInd1 = zeros(sizeOfROCMatrix,sizeOfROCMatrix);
ROCareaNormDimProjInd2 = zeros(sizeOfROCMatrix,sizeOfROCMatrix);

for n = 1 : length(indBigClusters)
    
    n
    
% n = 1
    thisClusterOriginalInds1 = clusterStructure(indBigClusters(n)).indsCoreInThisCluster;

     bigDataSetNumber1 = clusterStructure(indBigClusters(n)).bigDataSetNumber;

    indChoosenClusterCentersInThisCore1 = clusterStructure(indBigClusters(n)).indChoosenClusterCentersInThisCore;
    
    boutDataPCASampleDataThisCluster1 = clusterStructure(indBigClusters(n)).boutDataPCASampleDataThisCluster;
    boutDataPCASampleDataThisClusterCore1 = boutDataPCASampleDataThisCluster1(thisClusterOriginalInds1,1:numbOfDims);
    
    
    tic
for nn = (n+1) : length(indBigClusters)
%       nn =4
     thisClusterOriginalInds2 = clusterStructure(indBigClusters(nn)).indsCoreInThisCluster;

     bigDataSetNumber2 = clusterStructure(indBigClusters(nn)).bigDataSetNumber;

    indChoosenClusterCentersInThisCore2 = clusterStructure(indBigClusters(nn)).indChoosenClusterCentersInThisCore;
    
     boutDataPCASampleDataThisCluster2 = clusterStructure(indBigClusters(nn)).boutDataPCASampleDataThisCluster;
    boutDataPCASampleDataThisClusterCore2 = boutDataPCASampleDataThisCluster2(thisClusterOriginalInds2,1:numbOfDims);
    

    if bigDataSetNumber1 ~= bigDataSetNumber2
        
        %make joint vector unit
point1 = [];
point2 = [];

for y = 1:numbOfDims
    
    point1 = [point1' boutDataPCASampleDataThisClusterCore1(indChoosenClusterCentersInThisCore1,y)']';
    point2 = [point2' boutDataPCASampleDataThisClusterCore2(indChoosenClusterCentersInThisCore2,y)']';

    
end

point1 = point1';
point2 = point2';

joinvector=point2-point1;
joinvector=joinvector/sqrt(sum(power(joinvector,2)));

%%
%%%%%%%%%%% pick same amount of bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbOfPoints = min(length(thisClusterOriginalInds1),length(thisClusterOriginalInds2));

 %pick random bouts
    indPerm1 = randperm(length(thisClusterOriginalInds1));
    thisIndRand1 = thisClusterOriginalInds1(indPerm1(1:numbOfPoints));
    
    indPerm2 = randperm(length(thisClusterOriginalInds2));
    thisIndRand2 = thisClusterOriginalInds2(indPerm2(1:numbOfPoints));
    
    cluster1 = boutDataPCASampleDataThisCluster1(thisIndRand1,1:numbOfDims);
    cluster2 = boutDataPCASampleDataThisCluster2(thisIndRand2,1:numbOfDims);
        
    %%
clusterProj1 = cluster1*joinvector';
clusterPorj2 = cluster2*joinvector';
    
bothClusteraTogetherProj = [clusterProj1' clusterPorj2']';

indsClusters = [(zeros(1,length(cluster1))-1) (zeros(1,length(cluster2))+1)];

if unique(isnan(bothClusteraTogetherProj)) ~= 1%avoid same point bug...

[ROCareaDimProj,~,~,~,~,~,~,~,~] = roc_sv(bothClusteraTogetherProj,indsClusters,'nofigure');

% ROCareaNormDim1 = abs(ROCareaDim1 - 0.5) + 0.5;
% ROCareaNormDim2 = abs(ROCareaDim2 - 0.5) + 0.5;
% ROCareaNormDim3 = abs(ROCareaDim3 - 0.5) + 0.5;
ROCareaNormDimProj(n,nn) = abs(ROCareaDimProj - 0.5) + 0.5;

ROCareaNormDimProjInd1(n,nn) = indBigClusters(n);
ROCareaNormDimProjInd2(n,nn) = indBigClusters(nn);

else
   
ROCareaNormDimProj(n,nn) = nan;

ROCareaNormDimProjInd1(n,nn) = nan;
ROCareaNormDimProjInd2(n,nn) = nan;    
    
end

    else

ROCareaNormDimProj(n,nn) = NaN;

ROCareaNormDimProjInd1(n,nn) = indBigClusters(n);
ROCareaNormDimProjInd2(n,nn) = indBigClusters(nn);
    
    
  
    end
end
toc    

end


%%
%%%%%%%%%%% reconstruct ROC matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ROCareaNormDimProjtest = ROCareaNormDimProj;
ROCareaNormDimProjInd1test = ROCareaNormDimProjInd1;
ROCareaNormDimProjInd2test = ROCareaNormDimProjInd2;

for  i = 1 : length(ROCareaNormDimProjtest)
    
    thisRow = ROCareaNormDimProjtest(i,i:end);
    thisRow1 = ROCareaNormDimProjInd1test(i,i:end);
    thisRow2 = ROCareaNormDimProjInd2test(i,i:end);
    
    ROCareaNormDimProjtest(i:end,i) = thisRow;
    ROCareaNormDimProjInd1test(i:end,i) = thisRow1;
    ROCareaNormDimProjInd2test(i:end,i) = thisRow2;



end 

for h = 1:length(ROCareaNormDimProjtest)
    
    ROCareaNormDimProjtest(h,h) = 0.5;
    
end

%%
%%%%%%%%%%% deal with missing values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ROCareaNormDimProjtest2 = ROCareaNormDimProjtest;

% ROCareaNormDimProjtest2(137,:) = [];
% ROCareaNormDimProjtest2(:,137) = [];
% 
ROCareaNormDimProjtestNoNans = knnimpute(ROCareaNormDimProjtest2,15);

% ROCareaNormDimProjtestNoNans = knnimpute(ROCareaNormDimProjtest,50);