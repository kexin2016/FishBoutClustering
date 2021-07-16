


AddFunctionToPath

close all
clear all

%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat firle format
%2) applies automatic based density peak clustering for a range of dcs
%3) makes plot with detected numb of clusters for each dc


 %%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick main folder where data set subfolders and fishMap are
[FileName,PathName] =  uigetfile('*.*');

data = load(strcat(PathName,FileName));
% data = data.data
% data3 = data2.artifitialDataSet(:,1:2);

data = data.data;

% figure
% plot(data())



%%
%%%%%%%%%%%%% apply density peak clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makePlot = 0;
numbPointsToShow = 100;
distAlreadyCalc = 0;
percent = 1 : 1: 100;
percOrdc = 1;
multirep = 10;
clear var densityPeaksClusteringStruct

for n  = 1 : length(percent)

    tic
[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,dc(n)] = densityPeaksClusteringRandCorrectDc_3(data,percent(n),percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);
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
numbPointsToShow = 50;
distAlreadyCalc = 0;
percentThis = 5;
percOrdc = 1;
multirep = 10;
[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,dc(n)] = densityPeaksClusteringRandCorrectDc_3(data,percentThis,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);





figure
plot(data(:,1),data(:,2),'k.')
axis square
axis([-10 30 0 40 ])


makePlot = 15;
numbPointsToShow = 100;
distAlreadyCalc = 0;
percent = 1 : 1: 100;
percOrdc = 1;
multirep = 15;
[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,dc(n)] = densityPeaksClusteringRandCorrectDc_3(data,percent(n),percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);



