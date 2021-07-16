clear all
close all


%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat file format
%2) applies density valley clustering


%%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick main folder where data set is
[FileName,PathName] =  uigetfile('*.*');

load(strcat(PathName,FileName));

%%
%%%%%%%%%%%%% apply density peak clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


makePlot = 0;
numbPointsToShow = 0.1;
distAlreadyCalc = 0;
percentThis = 5;
percOrdc = 1;
multirep = 0;
[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,rhoRand,deltaRand,gamaRand,dc] = densityPeaksClusteringRandCorrectDc_4(data,percentThis,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);


clusterAssign = clusterCore + clusterHalo;


%%
%%%%%%%%%%% make density valley clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueClustecentersNumb = unique(clusterAssign);
uniqueClustecentersNumb(find(uniqueClustecentersNumb == 0)) = [];

col =  jet(length(uniqueClustecentersNumb));



figure


subplot(1,3,1)

for n = 1 : length(uniqueClustecentersNumb)% loop through each cluster

plot(rho,data(:,2), 'k.')
hold on
plot(rho(indClusterCenters(n)),data(indClusterCenters(n),2), 'o','MarkerSize',10,'MarkerFaceColor',col(n,:),'MarkerEdgeColor','k');

axis square
box off
ylabel('Dim 2')
xlabel('\rho')

end




subplot(1,3,2)
for n = 1 : length(uniqueClustecentersNumb)% loop through each cluster

plot(rho,delta,'k.') 
hold on
plot(rho(indClusterCenters(n)),delta(indClusterCenters(n)), 'o','MarkerSize',10,'MarkerFaceColor',col(n,:),'MarkerEdgeColor','k');
plot(rhoRand,deltaRand,'.', 'color', [0 0.8 0]) 
axis square
box off
xlabel('\rho')
ylabel('\delta')
end
%

%plot solution
% subplot(2,3,6)
subplot(1,3,3)




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
axis([-27.5 27.5 -5 50])
xlabel('Dim 1') 
ylabel('Dim 2') 


%%
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
% 


%%
%%%%%%%%%%%%%  make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcualte density for 
nBins = 30;
xb = linspace(-27.5, 27.5,nBins);
yb = linspace(-5,50,nBins);

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
axis([-27.5 27.5 -5 50])
xlabel('Dim 1')
ylabel('Dim 2')

subplot(1,3,2)
plot(data(:,1),data(:,2), 'k.')
axis square
axis([-27.5 27.5 -5 50])
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


makePlot = 0;
numbPointsToShow = 30;
distAlreadyCalc = 0;
percentThis = 17;
percOrdc = 1;
multirep = 0;
[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,rhoRand,deltaRand,gamaRand,dc] = densityPeaksClusteringRandCorrectDc_4(data,percentThis,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);


clusterAssign = clusterCore + clusterHalo;


%%
%%%%%%%%%%% make density valley clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueClustecentersNumb = unique(clusterAssign);
uniqueClustecentersNumb(find(uniqueClustecentersNumb == 0)) = [];

col =  jet(length(uniqueClustecentersNumb));



figure


subplot(1,3,1)

for n = 1 : length(uniqueClustecentersNumb)% loop through each cluster

plot(rho,data(:,2), 'k.')
hold on
plot(rho(indClusterCenters(n)),data(indClusterCenters(n),2), 'o','MarkerSize',10,'MarkerFaceColor',col(n,:),'MarkerEdgeColor','k');

axis square
box off
ylabel('Dim 2')
xlabel('\rho')

end




subplot(1,3,2)
for n = 1 : length(uniqueClustecentersNumb)% loop through each cluster

plot(rho,delta,'k.') 
hold on
plot(rho(indClusterCenters(n)),delta(indClusterCenters(n)), 'o','MarkerSize',10,'MarkerFaceColor',col(n,:),'MarkerEdgeColor','k');
plot(rhoRand,deltaRand,'.', 'color', [0 0.8 0]) 
axis square
box off
xlabel('\rho')
ylabel('\delta')
end
%

%plot solution
% subplot(2,3,6)
subplot(1,3,3)




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
axis([-27.5 27.5 -5 50])
xlabel('Dim 1') 
ylabel('Dim 2') 

