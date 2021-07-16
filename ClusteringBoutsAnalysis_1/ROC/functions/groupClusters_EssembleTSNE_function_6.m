
 function [groupClusterSctructureThis,essembleMatrix,essembleMatrixRand] = groupClusters_EssembleTSNE_function_6...
     (ROCareaNormDimProjtestNoNans,numbOfTimes,numbDims,initial_dims,perplexity,densityType,scallingFactorGroupClusters,...
     linedensityMethod,distanceTsne,groupClusterSctructureThis,essembleMatrix,essembleMatrixRand)

%  save('GroupsClusters_kNN4_39HeadKins3dims_1.75Smooth_slow_3000_auto_NoRef.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNans','groupClusterSctructure','clusterStructure','-v7.3')


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
if isempty(groupClusterSctructureThis) 


% groupClusterSctructure = [];
groupClusterSctructureThis = [];

 essembleMatrix = zeros(size(ROCareaNormDimProjtestNoNans,1),size(ROCareaNormDimProjtestNoNans,1));
 essembleMatrixRand = zeros(size(ROCareaNormDimProjtestNoNans,1),size(ROCareaNormDimProjtestNoNans,1));
pastIteratioons = 0;
else
    
 pastIteratioons = length(groupClusterSctructureThis);
 
% groupClusterSctructureThis
% essembleMatrix
% essembleMatrixRand
% 
    
end

%%
%%%%%%%%%%%%% do essemble tsne %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



for h = 1 : numbOfTimes
h

%%
%%%%%%%%%%%% tsne fast %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initial_dims = length(ROCareaNormDimProjtestNoNans);
%  perplexity = 30;
landmarks = 1;

% tic
% [mappedX, landmarks, costs] = fast_tsne(ROCareaNormDimProjtest, numbDims, initial_dims, landmarks, perplexity);
% toc

%  ROCareaNormDimProjtest2 = ROCareaNormDimProjtestNoNans;


tic
if distanceTsne == 1
    
mappedX = tsne_d(ROCareaNormDimProjtestNoNans, [], numbDims,initial_dims, perplexity);

else
    
mappedX = tsne(ROCareaNormDimProjtestNoNans, [], numbDims,initial_dims, perplexity);



end
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
%%%%%%%%%%%%% do random essemble matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignmentGroupClusters = unique(clusterAssignmentGroupClusters);

indperm = randperm(length(clusterAssignmentGroupClusters));

clusterAssignmentGroupClustersRand = clusterAssignmentGroupClusters(indperm);

for n = 1 : length(uniqueClusterAssignmentGroupClusters)
    
              indThisCluster = find(clusterAssignmentGroupClustersRand == uniqueClusterAssignmentGroupClusters(n));

              essembleMatrixThisRand = essembleMatrix*0;
              essembleMatrixThisRand(indThisCluster,indThisCluster) = 1;
              
              essembleMatrixRand = essembleMatrixRand + essembleMatrixThisRand;
              
              
end




 
groupClusterSctructureThis(pastIteratioons + h).mappedX = mappedX;
groupClusterSctructureThis(pastIteratioons + h).kdedensGroupClusters = kdedens;

groupClusterSctructureThis(pastIteratioons + h).rhoGroupClusters = rhoGroupClusters;
groupClusterSctructureThis(pastIteratioons + h).realRhoGroupClusters = realRhoGroupClusters;
groupClusterSctructureThis(pastIteratioons + h).deltaGroupClusters = deltaGroupClusters;
groupClusterSctructureThis(pastIteratioons + h).funnymeasureGroupClusters = funnymeasureGroupClusters;
groupClusterSctructureThis(pastIteratioons + h).funnymeasureSortedGroupClusters = funnymeasureSortedGroupClusters;
groupClusterSctructureThis(pastIteratioons + h).maxjumpGroupClusters = maxjumpGroupClusters;
groupClusterSctructureThis(pastIteratioons + h).clusterAssignmentGroupClusters = clusterAssignmentGroupClusters;




 
 %%
%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% disp('done')
% pause
%   save('GroupsClusters_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','clusterStructureGood','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNans','groupClusterSctructure','-v7.3')
% 
% 

end



%  save('GroupsClusters_kNN4_39HeadKins3dims_1.75Smooth_slow_3000_auto_NoRef.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNans','groupClusterSctructure','clusterStructure','-v7.3')

