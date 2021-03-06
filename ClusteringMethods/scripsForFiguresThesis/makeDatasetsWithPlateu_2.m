AddFunctionToPath

% close all
clear all

%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat file format
%2) applies automatic based density peak clustering for a determined dc


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

numbPointsToShow = 5;
%make zero matrix with correct size
numbClustersMatrix = zeros( length(densityPeaksClusteringStruct), numbPointsToShow);

for nn = 1 : length(densityPeaksClusteringStruct)
    
    
numbClusters = length(densityPeaksClusteringStruct(nn).indClusterCenters);

numbClustersMatrix(nn,numbClusters) = 1;


end

% figure
% imagesc(numbClustersMatrix)
% % axis off
% axis square
% colormap gray
% xlabel('Number of clusters')
% ylabel('dc (%)')



%%
%%%%%%%%%%%%%  make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcualte density for 
nBins = 30;
xb = linspace(0, 45,nBins);
yb = linspace(0,30,nBins);

edges{1} = xb;
edges{2} = yb;

% hist3(X,'Edges',edges)
[N,C] = hist3(data,'Edges',edges);


figure
subplot(1,3,1)
% plot(dataAll(:,1),dataAll(:,2), 'k.')
% figure
contourf(xb,yb, (N/(max(max(N))))',6)
axis square
axis([0 45 0 30])
xlabel('Dim 1')
ylabel('Dim 2')

subplot(1,3,2)
plot(data(:,1),data(:,2), 'k.')
axis square
axis([0 45 0 30])
box off
xlabel('Dim 1')
ylabel('Dim 2')

subplot(1,3,3)
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
numbPointsToShow = 30;
distAlreadyCalc = 0;
percentThis = 50;
percOrdc = 1;
multirep = 0;
[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,rhoRand,deltaRand,gamaRand,dc] = densityPeaksClusteringRandCorrectDc_4(data,percentThis,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);


clusterAssign = clusterCore + clusterHalo;


%%
%%%%%%%%%%%%%%%% make figure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(1,3,2)
imagesc(numbClustersMatrix)
% axis off
axis square
colormap gray
xlabel('Number of clusters')
ylabel('dc (%)')




subplot(1,3,1)
scatter(data(:,1),data(:,2),5,rho,'filled')
axis square
axis([0 45 0 30])
box off
xlabel('Dim 1')
ylabel('Dim 2')
colormap jet


subplot(1,3,3)
uniqueClustecentersNumb = unique(clusterAssign);
uniqueClustecentersNumb(find(uniqueClustecentersNumb == 0)) = [];

col =  jet(length(uniqueClustecentersNumb));

for n = 1 : length(uniqueClustecentersNumb)% loop through each cluster
%       n =1
      %cluster core
      indThisClusterCore = find(clusterAssign == uniqueClustecentersNumb(n));
      
      %cluster halo
%       indThisClusterHalo = find(clusterHalo == uniqueClustecentersNumb(n));
     

      %plot cluster core
      plot(data(indThisClusterCore,1),data(indThisClusterCore,2), '.','color', col(n,:))
      hold on
      
%       plot(data(indThisClusterHalo,1),data(indThisClusterHalo,2), '.','color', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)
      
%       plot(data(indClusterCenters(n),1),data(indClusterCenters(n),2), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',10,'lineWidth',3)
      plot(data(indClusterCenters(n),1),data(indClusterCenters(n),2), 'o','MarkerSize',10,'MarkerFaceColor',col(n,:),'MarkerEdgeColor','k');
      box off
%       pause
 end
 axis square
axis([0 50 0 30])
xlabel('Dim 1') 
ylabel('Dim 2') 
