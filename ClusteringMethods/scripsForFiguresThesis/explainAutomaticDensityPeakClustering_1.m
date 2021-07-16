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
%%%%%%%%%%%%% apply density peak clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makePlot = 0;
numbPointsToShow = 100;
distAlreadyCalc = 0;
percent = 1 : 1: 100;
percOrdc = 1;
multirep = 5;
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

numbPointsToShow = 10;
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


makePlot2 = 1;
numbPointsToShow = 50;
distAlreadyCalc = 0;
percentThis = 5;
percOrdc = 1;
multirep = 10;
 [indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,rhoRand,deltaRand,gamaRand,dc(n)] = densityPeaksClusteringRandCorrectDc_4(data,percentThis,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);
% [rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure] = findClusterCentersDensityValley_5(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,resampleMethod,makeplot);

 
%%
%%%%%%%%%%%% calcuate random distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plotMaker = 1;

[dataRand] = resampleDistribution_3(data,length(data),plotMaker);


%%
%%%%%%%%%%%%%%%% make figure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbPointsToShow = 20;
numbClusters = length(indClusterCenters);
%raw data and reandom distribution
figure
% subplot(2,3,1)
plot(dataRand(:,1),dataRand(:,2),'.', 'color', [0 0.8 0])
hold on
plot(data(:,1),data(:,2), 'k.')
axis square
box off
axis([-7 7 -7 7])
xlabel('Dim 1') 
ylabel('Dim 2') 

%plot decision plot
% subplot(2,3,2)
figure
plot(rho,delta,'k.') 
hold on
plot(rho(indClusterCenters),delta(indClusterCenters), 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
plot(rhoRand,deltaRand,'.', 'color', [0 0.8 0]) 
axis square
box off
xlabel('\rho')
ylabel('\delta')

%plot gamma difference
% subplot(2,3,3)
figure
plot(difference(1:numbPointsToShow), 'k.');
hold on
plot(difference(1:numbClusters), 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
axis square
box off
xlabel('#')
ylabel('\gamma difference')


%plot nomr gamma difference
% subplot(2,3,4)
figure
plot(deviationNorm(1:numbPointsToShow), '.k');
hold on
plot(deviationNorm(1:numbClusters), 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
axis square
box off
xlabel('#')
ylabel('Normalized \gamma difference')

%plot gamma jump
% subplot(2,3,5)
figure
plot(diffDiviation(1:numbPointsToShow), '.k');
hold on
plot(diffDiviation(1:numbClusters), 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
axis square
box off
xlabel('#')
ylabel('\gamma difference jump')


%plot solution
% subplot(2,3,6)
figure
uniqueClustecentersNumb = unique(clusterCore);
uniqueClustecentersNumb(find(uniqueClustecentersNumb == 0)) = [];

col =  jet(length(uniqueClustecentersNumb));


 for n = 1 : length(uniqueClustecentersNumb)% loop through each cluster
%       n =1
      %cluster core
      indThisClusterCore = find(clusterCore == uniqueClustecentersNumb(n));
      
      %cluster halo
      indThisClusterHalo = find(clusterHalo == uniqueClustecentersNumb(n));
     

      %plot cluster core
      plot(data(indThisClusterCore,1),data(indThisClusterCore,2), '.','color', col(n,:))
      hold on
      
      plot(data(indThisClusterHalo,1),data(indThisClusterHalo,2), '.','color', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)
      
%       plot(data(indClusterCenters(n),1),data(indClusterCenters(n),2), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',10,'lineWidth',3)
      plot(data(indClusterCenters(n),1),data(indClusterCenters(n),2), 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
      box off
%       pause
 end
 axis square
 axis([-7 7 -7 7])
xlabel('Dim 1') 
ylabel('Dim 2') 
