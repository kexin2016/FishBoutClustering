
close all

%%
% %%%%%%%%%%%%%%%%%%%%%%%% load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% folder = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\';
% filename = 'BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4_correct.mat';
% 
% load(strcat(folder,filename),'groupClusterSctructure','ROCareaNormDimProjtestNoNans','finalClustering')


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% make essemble t-SNE plot %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cutThreshold = 20


essembleMatrix = groupClusterSctructure.essembleMatrix;
T2 = groupClusterSctructure.essembleMatrixAssignment;
Z2 = groupClusterSctructure.essembleMatrixLinkageResult;
groupClusterSctructureThis = groupClusterSctructure.distributions;
essembleMatrixPerm = groupClusterSctructure.essembleMatrixPerm;

essembleMatrixRand = groupClusterSctructure.essembleMatrixRand;
T2Rand = groupClusterSctructure.essembleMatrixAssignmentRand;
Z2Rand = groupClusterSctructure.essembleMatrixLinkageResultRand ;

% cutThreshold = 20;
% 
% [T2,Z2,essembleMatrixPerm] = essemble_tSne_plot_1(essembleMatrix,boutDataPCASample,clusterStructure,groupClusterSctructureThis,cutThreshold);


%%
%%%%%%%%%%%%%%%%% make figure for thesis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(2,4,1)
imagesc(ROCareaNormDimProjtestNoNans)
axis square
colormap gray

%%
%%%%%%%%%%%%%% example tsne plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%105 255 102  - HAT
% 220 0 220 - obends
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

col = ([;255 170 0])./255;

% col = jet(length(uniqueGroupOfClusters));
col = ([0 153 0;255 0 50;  0 0 200;147 112 219;105 255 102;255 255 0;220 0 220;250 128 114;102 255 255;0 150 255;255 170 0])./255;


k = 199%choose tsne

mappedX = groupClusterSctructureThis(k).mappedX;
funnymeasureGroupClusters = groupClusterSctructureThis(k).funnymeasureGroupClusters;
realRhoGroupClusters = groupClusterSctructureThis(k).realRhoGroupClusters;
clusterAssignmentGroupClusters = groupClusterSctructureThis(k).clusterAssignmentGroupClusters;

[funnymeasureGroupClustersSorted,idx] = sort(funnymeasureGroupClusters,'descend');
realRhoGroupClustersSorted = realRhoGroupClusters(idx);


uniqueGroupOfClusters = unique(clusterAssignmentGroupClusters);
%  col = jet(length(uniqueGroupOfClusters));


subplot(2,4,2)
plot(mappedX(:,1),mappedX(:,2), 'ko','markersize',3)
axis square
xlabel('Dim 1')
ylabel('Dim 2')
% zlabel('Dim 3')
box off

subplot(2,4,3)
plot(mappedX(:,1),mappedX(:,2), 'ko')
hold on
for i = 1 : length(uniqueGroupOfClusters)
    
    
indThisCluster = find(clusterAssignmentGroupClusters == uniqueGroupOfClusters(i));
    
    
plot(mappedX(indThisCluster,1),mappedX(indThisCluster,2), 'ko','markersize',5,'markerfacecolor', col(i,:))
hold on
% pause
end

axis square
xlabel('Dim 1')
ylabel('Dim 2')
% zlabel('Dim 3')
box off


subplot(2,4,4)
plot(realRhoGroupClusters,funnymeasureGroupClusters, 'ko','markersize',4)
hold on
for i = 1 : length(uniqueGroupOfClusters)
    
    plot(realRhoGroupClustersSorted(i),funnymeasureGroupClustersSorted(i), 'ko','markersize',6,'markerfacecolor', col(i,:))
    
end

axis square
xlabel('\rho')
ylabel('Separability matrix')
box off

subplot(2,4,5)
imagesc(essembleMatrixPerm./max(max(essembleMatrixPerm)))
axis square
colormap gray


subplot(2,4,6)
% [H,T,~] = dendrogramBlack(Z2,0,'colorthreshold',cutThreshold);

[H,T,~] = dendrogramBlack(Z2,0);
set(H,'LineWidth',2)
axis square

subplot(2,4,7)
imagesc(essembleMatrixPermRand./max(max(essembleMatrixPermRand)))
axis square
colormap gray

subplot(2,4,8)
[H,T,~] = dendrogramBlack(Z2Rand,0,'colorthreshold',cutThreshold);
axis square
