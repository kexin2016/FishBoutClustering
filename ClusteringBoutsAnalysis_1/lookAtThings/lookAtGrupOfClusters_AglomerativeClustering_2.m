% AddFunctionToPath
% 
% close all
% clear all


%%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse ROC_PreliminaryData74Kins3dimWithCutOffMedium_moreDivided
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));


%%
%%%%%%%%%% aglomarative clustering ROCareaNormMax %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cutThreshold = 16.5;

  Z1 = linkage(ROCareaNormDimProjtestNoNans,'average','seuclidean');
%    Z1 = linkage(ROCareaNormDimProjtest)

%  Z1 = linkage(ROCareaNormMax)

figure
imagesc(ROCareaNormDimProjtestNoNans)
axis square
colormap gray

%  subplot(1,3,1)
[H,T,perm1] = dendrogram(Z1,0)
axis square
% close figure

ROCareaNormMaxPerm = ROCareaNormDimProjtestNoNans(perm1,perm1);
% subplot(2,3,5)



 figure
% subplot(1,2,1)

%  subplot(1,3,1)
imagesc(ROCareaNormMaxPerm)
axis square
colormap gray
box off

figure
% subplot(1,2,2)
% [H,T,perm1] = dendrogram(Z1,0,'colorthreshold',cutThreshold);
myColors = [];
h = dendrogramWithMyColors(Z1,0,'colorthreshold',cutThreshold);

axis square

%choose number of clusters
% T = cluster(Z1,'maxclust',10)
% T = cluster(Z,'cutoff',c,'depth',d) 
T2 = cluster(Z1,'cutoff',cutThreshold,'criterion', 'distance');

clusterAssignmentGroupClusters = T2;
title(length(unique(T2)))

