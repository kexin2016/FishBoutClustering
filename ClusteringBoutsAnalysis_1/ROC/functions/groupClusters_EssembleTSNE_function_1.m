
 function [groupClusterSctructure] = groupClusters_EssembleTSNE_function_1(ROCareaNormDimProjtestNoNans,boutDataPCASample,clusterStructure,numbOfTimes,numbDims,perplexity,densityType,scallingFactorGroupClusters,linedensityMethod,cutThreshold,makeplotFinal)

%  save('GroupsClusters_kNN4_39HeadKins3dims_1.75Smooth_slow_3000_auto_NoRef.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNansGood','groupClusterSctructure','clusterStructure','-v7.3')


%%
%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% numbOfTimes = 1;
% numbDims = 3;
% perplexity = 30;
% makeplotFinal = 1;
% densityType = 'local';
% scallingFactorGroupClusters = 2.2;
% linedensityMethod = 'slowPar';
% cutThreshold = 13;

%%
% %%%%%%%%%%%%%%%% exclude bad cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% groupClusterSctructure = [];
% 
  ROCareaNormDimProjtestNoNansGood = ROCareaNormDimProjtestNoNans;
% 
% indExclude = 122;
% 
% ROCareaNormDimProjtestNoNansGood(indExclude,:) = [];
% ROCareaNormDimProjtestNoNansGood(:,indExclude) = [];
% 
% bigClusterVector = find([clusterStructureGood.BigCluster]);
% 
% 
% 
% clusterStructureGood = clusterStructure;
% clusterStructureGood(bigClusterVector(indExclude)).BigCluster = 0;



%%
%%%%%%%%%%%%% do essemble tsne %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
groupClusterSctructure = [];
groupClusterSctructureThis = [];

 essembleMatrix = zeros(length(ROCareaNormDimProjtestNoNansGood),length(ROCareaNormDimProjtestNoNansGood));

for h = 1 : numbOfTimes
h

%%
%%%%%%%%%%%% tsne fast %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
initial_dims = length(ROCareaNormDimProjtestNoNansGood);
%  perplexity = 30;
landmarks = 1;

% tic
% [mappedX, landmarks, costs] = fast_tsne(ROCareaNormDimProjtest, numbDims, initial_dims, landmarks, perplexity);
% toc

ROCareaNormDimProjtest2 = ROCareaNormDimProjtestNoNansGood;


tic
mappedX = tsne_d(ROCareaNormDimProjtestNoNansGood, [], numbDims, perplexity);
toc

%reorder mappedX
mappedX2 = mappedX(landmarks,:);

% groupClusterSctructure.GroupClusyersMethod = 'tsne_d';
% groupClusterSctructure.perplexity = perplexity;
% groupClusterSctructure.mappedX = mappedX;

%%
% %%%%%%%%%% make core for each cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% percentOfHalo = 15;
% for n = 1:length(clusterStructureGood)
% 
%     
%     
%     thisClusterOriginalInds = clusterStructureGood(n).thisClusterOriginalInds;
%     
%      if length(thisClusterOriginalInds) > 2%avoid cluster with 1 point
%        densityType = 'rot';
%        
%        tic
%        kdedensThisCluster = kde( boutDataPCASample(thisClusterOriginalInds,1:3)',densityType);
%        
%        densitiesThisCluster = evaluate(kdedensThisCluster,boutDataPCASample(thisClusterOriginalInds,1:3)');
%        toc
%        percentile = prctile(densitiesThisCluster,percentOfHalo);%15 works fine
%     
%        indsCore = find(densitiesThisCluster > percentile);
%        
%        indsCore2 = thisClusterOriginalInds(indsCore);
%        
%        else
%     
%        indsCore2 = thisClusterOriginalInds;
%      end
%         
%      clusterStructureGood(n).indsCore = indsCore2;
%     
% end
% 
% 
% groupClusterSctructure.percentOfHaloClusters = percentOfHalo;

%%
%%%%%%%%% calculate densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kdedens = [];
tic
kdedens = kde(mappedX',densityType);
toc

originalBandWidthsGroupClusters = getBW(kdedens);


%make density plot
rho = evaluate(kdedens,mappedX');

% figure
%     plot3(mappedX(:,1),mappedX(:,2),rho, '.k')
% % hold on
% axis square
% % axis([-17 22 -10 20 0 max(rho)])  

% groupClusterSctructure.originalBandWidthsGroupClusters = originalBandWidthsGroupClusters;


%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

adjustBW(kdedens,originalBandWidthsGroupClusters);


% densityType = 'local';
makeplot = 0;

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT(mappedX,kdedens,scallingFactorGroupClusters,densityType,makeplot);

%make density plot
rho2 = evaluate(kdedensCutOff,mappedX');

% figure
%     plot3(mappedX(:,1),mappedX(:,2),rho2, '.k')
% hold on
%     plot3(mappedX(:,1),mappedX(:,2),rho, '.b')
% 
% axis square
% axis([-17 22 -10 20 0 max(rho2)])    
% disp('done')

% groupClusterSctructure.scallingFactorGroupClusters = scallingFactorGroupClusters;
% groupClusterSctructure.kdedensGroupClusters = kdedens;


%%
%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% densityType = 'local';
numextra = sqrt(length(mappedX));
nsamps = 50;
multirep = 0;
makeplot = 0;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
resampleMethod = 'onion';
tic
% [rhoGroupClusters,realRhoGroupClusters,deltaGroupClusters,funnymeasureGroupClusters,funnymeasureSortedGroupClusters,maxjumpGroupClusters,rhoRandGroupClusters,realRhoRandGroupClusters,deltaRandGroupClusters,funnymeasureRandGroupClusters,funnymeasureRandSorterAvrGroupClusters,clusterCentersSortedIdxGroupClusters] = findClusterCentersDensityValley_1(mappedX,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
[rhoGroupClusters,realRhoGroupClusters,deltaGroupClusters,funnymeasureGroupClusters,funnymeasureSortedGroupClusters,kdedensGroupClusters,kdedensRandGroupClusters,maxjumpGroupClusters,rhoRandGroupClusters,realRhoRandGroupClusters,deltaRandGroupClusters,funnymeasureRandGroupClusters,funnymeasureRandSorterAvrGroupClusters,clusterCentersSortedIdxGroupClusters,funnymeasureRandSortedAllGroupClusters,diffFunnymeasureGroupClusters,jumpFunymeasureGroupClustersGroupClusters] = findClusterCentersDensityValley_6(mappedX,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,resampleMethod,scallingFactorGroupClusters,makeplot);


toc

% groupClusterSctructure.densityTypeGroupClusters = densityType;
% groupClusterSctructure.rhoGroupClusters = rhoGroupClusters;
% groupClusterSctructure.realRhoGroupClusters = realRhoGroupClusters;
% groupClusterSctructure.deltaGroupClusters = deltaGroupClusters;
% groupClusterSctructure.funnymeasureGroupClusters = funnymeasureGroupClusters;
% groupClusterSctructure.funnymeasureSortedGroupClusters = funnymeasureSortedGroupClusters;
% groupClusterSctructure.maxjumpGroupClusters = maxjumpGroupClusters;


%%
%%%%%%%%%%%%%%%%% make dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
%                       pointAssignmentMethod = 'distance';
              pointAssignmentMethod = 'distance2';


makePlot =0;
maxNumbOfClusterCenters =50;
lowDensityCutOff =0;
[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_3(mappedX,funnymeasureGroupClusters,maxNumbOfClusterCenters,rhoGroupClusters,realRhoGroupClusters,maxjumpGroupClusters,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdxGroupClusters,makePlot);

    


%%
%%%%%%%%%%%%% look at cluster centers by square  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 tree = [];
% decisionMethod = 'square';
%  decisionMethod = 'dendrogram';
decisionMethod = 'allClusterCenters';


funnymeasureRandThreshold =[];
[indChoosenClusterCentersGroupClusters] = decideClusterCentersAll_4(mappedX,tree,clusterCentersSortedIdxGroupClusters,realRhoGroupClusters,funnymeasureGroupClusters,funnymeasureRandThreshold,decisionMethod);
% figure
% plot3(mappedX(:,1),mappedX(:,2),realRho,'.')
% hold on
% plot3(mappedX(indChoosenClusterCenters,1),mappedX(indChoosenClusterCenters,2),realRho(indChoosenClusterCenters),'ro')
% %     axis([-17 22 -10 20 0 max(realRho)])

% groupClusterSctructure.indChoosenClusterCentersGroupClusters = indChoosenClusterCentersGroupClusters;


%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            pointAssignmentMethod = 'pooledDensity2';
%                       pointAssignmentMethod = 'distance';
%              pointAssignmentMethod = 'distance2';

makeplot = 0;
tic
[clusterAssignmentGroupClusters] = assignDataPointsAllCases_1(mappedX,indChoosenClusterCentersGroupClusters,rhoGroupClusters,maxjumpGroupClusters,pointAssignmentMethod,makeplot);
toc 

% T2 = clusterAssignmentGroupClusters;

% groupClusterSctructure.clusterAssignmentGroupClusters = clusterAssignmentGroupClusters;
% groupClusterSctructure.pointAssignmentMethodGroupClusters = pointAssignmentMethod;

%%

%%
%%%%%%%%%%%%%%%%%% fill essemble matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);

for n = 1 : length(uniqueClusterAssignmentGroupClusters)
    
              indThisCluster = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(n));

              essembleMatrixThis = essembleMatrix*0;
              essembleMatrixThis(indThisCluster,indThisCluster) = 1;
              
              essembleMatrix = essembleMatrix + essembleMatrixThis;
end




%%
% %%%%%%%%%%%% look at group of clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);
%  col = jet(length(uniqueClusterAssignmentGroupClusters));
%  figure
%  for n = 1 : length(uniqueClusterAssignmentGroupClusters)
%      
%          indThisCluster = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(n));
%      
% %     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
% 
% if numbDims == 2
%     
%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),rhoGroupClusters(indThisCluster), '.k')
%     hold on
%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),rhoGroupClusters(indThisCluster), 'o', 'color', col(n,:))
% 
% else
%     
%     subplot(1,2,1)
%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),mappedX(indThisCluster,3), '.k')
%     hold on
%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),mappedX(indThisCluster,3), 'o', 'color', col(n,:))    
%     axis square
%     box off
%     xlabel('dim 1')
%     ylabel('dim 1')
%     
%     subplot(1,2,2)
%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),rhoGroupClusters(indThisCluster), '.k')
%     hold on
%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),rhoGroupClusters(indThisCluster), 'o', 'color', col(n,:))    
%     axis square
%     box off
%     xlabel('dim 1')
%     ylabel('dim 1')
%     
% end
% 
% 
% 
% 
% title(length(uniqueClusterAssignmentGroupClusters))
% 
%  end
%  
%  %%
% %%%%%%%%%%%%% look at group of clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% indAllDataPoints = [];
% 
% sizeOfClustersAll = zeros(1,length(clusterStructureGood));
% 
% for v = 1: length(clusterStructureGood)
%     
% clusterStructureGood(v).ClusterOfClusterCat = 0;
% 
% indThisCluster = clusterStructureGood(v).indsCore;
% 
% indAllDataPoints = [indAllDataPoints' indThisCluster']';
% 
% sizeOfClustersAll(v) = length(indThisCluster);
% 
% end
% 
% 
% bigClusterVector = find([clusterStructureGood.BigCluster]);
% 
%  indCoreGroupClusters = find(clusterAssignmentGroupClusters);
% % indCoreGroupClusters = 1:1:length(coreAssignmentGroupOfClusters);
% 
% figure
% for h = 1 : length(uniqueClusterAssignmentGroupClusters)
% 
%     
%     indThisCluster = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(h));
% %     indThisGroupClusters = intersect(indCoreGroupClusters,indThisCluster);
%     
%     indThisGroupClustersOriginal = bigClusterVector(indThisCluster);
%     
%     
%     
%     col = jet(length(indThisGroupClustersOriginal));
%     
%     subplot(4,4,h)
%     plot(boutDataPCASample(indAllDataPoints,1),boutDataPCASample(indAllDataPoints,2), '.k')
%     hold on
%     
%     for hh = 1 : length(indThisGroupClustersOriginal)
%     
%         
%     clusterStructureGood(indThisGroupClustersOriginal(hh)).ClusterOfClusterCat = uniqueClusterAssignmentGroupClusters(h);
% 
%         
%     thisClusterOriginalInds = clusterStructureGood(indThisGroupClustersOriginal(hh)).thisClusterOriginalInds;
%     
%    plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color', col(hh,:))
%     hold on
%     end
%     title(uniqueClusterAssignmentGroupClusters(h))
%     axis([-20 30 -10 20])
% 
% end
% 
 
groupClusterSctructureThis(h).mappedX = mappedX;
groupClusterSctructureThis(h).kdedensGroupClusters = kdedens;

groupClusterSctructureThis(h).rhoGroupClusters = rhoGroupClusters;
groupClusterSctructureThis(h).realRhoGroupClusters = realRhoGroupClusters;
groupClusterSctructureThis(h).deltaGroupClusters = deltaGroupClusters;
groupClusterSctructureThis(h).funnymeasureGroupClusters = funnymeasureGroupClusters;
groupClusterSctructureThis(h).funnymeasureSortedGroupClusters = funnymeasureSortedGroupClusters;
groupClusterSctructureThis(h).maxjumpGroupClusters = maxjumpGroupClusters;
groupClusterSctructureThis(h).clusterAssignmentGroupClusters = clusterAssignmentGroupClusters;




 
 %%
%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% disp('done')
% pause
%   save('GroupsClusters_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','clusterStructureGood','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNansGood','groupClusterSctructure','-v7.3')
% 
% 

end

%%
%%%%%%%%%%%%%%%%%%%%%%%%% reorder essembleMatrix %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 Z2 = linkage(essembleMatrix,'average','seuclidean');
%  Z2 = linkage(essembleMatrix,'single','seuclidean');
    
figure
subplot(2,2,1)
[H,T,perm2] = dendrogram(Z2,0);
axis square



essembleMatrixPerm = essembleMatrix(perm2,perm2);
 if makeplotFinal == 1
subplot(2,2,1)
[H,T,~] = dendrogram(Z2,0,'colorthreshold',cutThreshold);
axis square
 end
%choose number of clusters
% T = cluster(Z1,'maxclust',10)
% T = cluster(Z,'cutoff',c,'depth',d) 
T2 = cluster(Z2,'cutoff',cutThreshold,'criterion', 'distance');

clusterAssignmentGroupClusters = T2;
title(length(unique(T2)))

if makeplotFinal == 1
subplot(2,2,2)

imagesc(essembleMatrixPerm./max(max(essembleMatrixPerm)))
axis square
colormap gray
end
%%
%%%%%%%%%%%%%%%%% plot tsne space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignmentGroupClusters = unique(T2);
col = jet(length(uniqueClusterAssignmentGroupClusters));
if makeplotFinal == 1
subplot(2,2,3)

for h = 1 : length(uniqueClusterAssignmentGroupClusters)

    
    indThisCluster = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(h));

    plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),mappedX(indThisCluster,3),'.','color',col(h,:))
    hold on
    
end
axis square
end

%%
%%%%%%%%%%%%%%%%%%%%% plot data points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignmentGroupClusters = unique(T2);

indAllDataPoints = [];

sizeOfClustersAll = zeros(1,length(clusterStructure));

for v = 1: length(clusterStructure)
    
clusterStructure(v).ClusterOfClusterCat = 0;

indThisCluster = clusterStructure(v).indsCore;

indAllDataPoints = [indAllDataPoints' indThisCluster']';

sizeOfClustersAll(v) = length(indThisCluster);

end



bigClusterVector = find([clusterStructure.BigCluster]);

if makeplotFinal == 1
figure
for h = 1 : length(uniqueClusterAssignmentGroupClusters)

    
    indThisCluster = find(clusterAssignmentGroupClusters == uniqueClusterAssignmentGroupClusters(h));
%     indThisGroupClusters = intersect(indCoreGroupClusters,indThisCluster);
    
    indThisGroupClustersOriginal = bigClusterVector(indThisCluster);
    
    
    
    col = jet(length(indThisGroupClustersOriginal));
    
    subplot(4,4,h)
    plot(boutDataPCASample(indAllDataPoints,1),boutDataPCASample(indAllDataPoints,2), '.k')
    hold on
%     axis square
    axis([-20 25 -10 15])
    axis([-20 25 -10 15])
    for hh = 1 : length(indThisGroupClustersOriginal)
    
        
    clusterStructure(indThisGroupClustersOriginal(hh)).ClusterOfClusterCat = uniqueClusterAssignmentGroupClusters(h);

        
    thisClusterOriginalInds = clusterStructure(indThisGroupClustersOriginal(hh)).thisClusterOriginalInds;
    
    plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.', 'color', col(hh,:))
    hold on
    end
    
    title(uniqueClusterAssignmentGroupClusters(h))
end

end

%%
%%%%%%%%%%%% save stuff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

groupClusterSctructure.GroupClusyersMethod = 'essemble tsne_d';
groupClusterSctructure.perplexity = perplexity;
groupClusterSctructure.pointAssignmentMethodGroupClusters = pointAssignmentMethod;
groupClusterSctructure.cutThresholdDendrogram = cutThreshold;
groupClusterSctructure.essembleMatrixPerm = essembleMatrixPerm;
groupClusterSctructure.essembleMatrix = essembleMatrix;
groupClusterSctructure.essembleMatrixReorderingMethod = 'average';
groupClusterSctructure.essembleMatrixReorderingDistance = 'seuclidean';
groupClusterSctructure.essembleMatrixAssignment = T2;
groupClusterSctructure.essembleMatrixLinkageResult = Z2;
groupClusterSctructure.distributions = groupClusterSctructureThis;

%  save('GroupsClusters_kNN4_39HeadKins3dims_1.75Smooth_slow_3000_auto_NoRef.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNansGood','groupClusterSctructure','clusterStructure','-v7.3')

