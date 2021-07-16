% AddFunctionToPath
% 
% close all
% clear all

%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat file format
%2) applies density valley clustering

%%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick main folder where data set subfolders and fishMap are
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));
% % data = data.data
% % data3 = data2.artifitialDataSet(:,1:2);
% 
% 
% olivettiDistances = data(:,3);


% figure
% plot(data())


%%
%%%%%%%%%%%%%% transform into square %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
olivettiDistancesSq = reshape(olivettiDistances,[sqrt(length(olivettiDistances)),sqrt(length(olivettiDistances))]);

olivettiLabels = [];
for n = 1 : 40

    vectorNumb = zeros(1,10) + n;
    
olivettiLabels = [olivettiLabels vectorNumb];


end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% do tsne %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbDims = 2;
% initial_dims = length(olivettiDistancesSq);
perplexity = 25;
% landmarks = 1;


 
tic
mappedX = tsne_d(olivettiDistancesSq, [], numbDims, perplexity);
toc


figure
 subplot(1,2,1)
scatter(mappedX(:,1),mappedX(:,2),10,'k')
axis square

 subplot(1,2,2)
scatter(mappedX(:,1),mappedX(:,2),10,olivettiLabels)
axis square


%%
%%%%%%%%%%%%% apply density peak clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makePlot = 0;
numbPointsToShow = 100;
distAlreadyCalc = 0;
percent = 1 : 1: 100;
percOrdc = 1;
multirep = 1;
clear var densityPeaksClusteringStruct

for n  = 1 : length(percent)
n
    tic
[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,dc(n)] = densityPeaksClusteringRandCorrectDc_3(mappedX,percent(n),percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);
toc
clusterAssign = clusterCore + clusterHalo;

%%
%%%%%%%%%%%%%%%%%% save variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

densityPeaksClusteringStruct(n).indClusterCenters = indClusterCenters;
densityPeaksClusteringStruct(n).clusterCore = clusterCore;
densityPeaksClusteringStruct(n).clusterHalo = clusterHalo;
densityPeaksClusteringStruct(n).diffDiviation = diffDiviation;
densityPeaksClusteringStruct(n).diffDiviationReg = diffDiviationReg;
densityPeaksClusteringStruct(n).diffDiviationNorm = diffDiviationNorm;
densityPeaksClusteringStruct(n).difference = difference;
densityPeaksClusteringStruct(n).idx = idx;
% densityPeaksClusteringStruct(n).indClusterCenters = distanceSquare;
densityPeaksClusteringStruct(n).rho = rho;
densityPeaksClusteringStruct(n).delta = delta;
densityPeaksClusteringStruct(n).gama = gama;
densityPeaksClusteringStruct(n).clusterAssign = clusterAssign;
densityPeaksClusteringStruct(n).deviationNorm = deviationNorm;



end
%%
%%%%%%%%%%%%%% make found number of clusters matrix %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbPointsToShow = 50;
%make zero matrix with correct size
numbClustersMatrix = zeros( length(densityPeaksClusteringStruct), numbPointsToShow);

for nn = 1 : length(densityPeaksClusteringStruct)
    
    
numbClusters = length(densityPeaksClusteringStruct(nn).indClusterCenters);

numbClustersMatrix(nn,numbClusters) = 1;


end

figure
imagesc(numbClustersMatrix)
% axis off
axis square
colormap gray
xlabel('Number of clusters')
ylabel('dc (%)')

%%
%%%%%%%%%%%%% apply density peak clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makePlot = 1;
numbPointsToShow = 100;
distAlreadyCalc = 0;
percent = 24;
percOrdc = 1;
multirep = 10;


[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,dc(n)] = densityPeaksClusteringRandCorrectDc_3(mappedX,percent,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);

