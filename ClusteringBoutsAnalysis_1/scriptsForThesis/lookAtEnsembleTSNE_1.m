
close all

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% make essemble t-SNE plot %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

essembleMatrix = groupClusterSctructure.essembleMatrix;

groupClusterSctructureThis = groupClusterSctructure.distributions;


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
%   col = ([102 255 255; 255 170 0; 220 0 220;255 255 0; 255 0 50; 250 128 114;105 255 102;0 150 255; 0 0 200;0 153 0])./255;


k = 199%choose tsne

mappedX = groupClusterSctructureThis(k).mappedX;
funnymeasureGroupClusters = groupClusterSctructureThis(k).funnymeasureGroupClusters;
realRhoGroupClusters = groupClusterSctructureThis(k).realRhoGroupClusters;
clusterAssignmentGroupClusters = groupClusterSctructureThis(k).clusterAssignmentGroupClusters;

[funnymeasureGroupClustersSorted,idx] = sort(funnymeasureGroupClusters,'descend');
realRhoGroupClustersSorted = realRhoGroupClusters(idx);


uniqueGroupOfClusters = unique(clusterAssignmentGroupClusters)
 col = jet(length(uniqueGroupOfClusters));


subplot(2,4,2)
plot(mappedX(:,1),mappedX(:,2), 'ko','markersize',3)
axis square
xlabel('Dim 1')
ylabel('Dim 2')
% zlabel('Dim 3')
box off

subplot(2,4,3)
for i = 1 : length(uniqueGroupOfClusters)
    
    
indThisCluster = find(clusterAssignmentGroupClusters == uniqueGroupOfClusters(i));
    
    
plot(mappedX(indThisCluster,1),mappedX(indThisCluster,2), 'ko','markersize',3,'markerfacecolor', col(i,:))
hold on
end
axis square
xlabel('Dim 1')
ylabel('Dim 2')
% zlabel('Dim 3')
box off


subplot(2,4,4)
plot(realRhoGroupClusters,funnymeasureGroupClusters, 'ok','markersize',3)
hold on
for i = 1 : length(uniqueGroupOfClusters)
    
    plot(realRhoGroupClustersSorted(i),funnymeasureGroupClustersSorted(i), 'o','markersize',10,'markerfacecolor', col(i,:))
    
end

axis square
xlabel('\rho')
ylabel('Separability matrix')
title(length(uniqueGroupOfClusters))

subplot(2,4,5)
