clear all 
close all



%%
%%%%%%%%%%%%%%%%%%%%%%%% make sq %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbPointsFactor = 2;
% space = 0.2;
% xlength = 25*numbPointsFactor;
% ylength = 25*numbPointsFactor;

space = 0.1675;
xlength = 30*numbPointsFactor;
ylength = 30*numbPointsFactor;


dataSqAllX = [];
dataSqAllY = [];
counter1 = 0;

for n = 1 : xlength
    
    counter2 = 0;

    for nn = 1 : ylength
        
        dataSqX = counter1;
        dataSqY = counter2;

%         
%         plot(dataSqX,dataSqY,'.')
%         hold on
%         pause
        dataSqAllX = [dataSqAllX dataSqX];
        dataSqAllY = [dataSqAllY dataSqY];

    counter2 = counter2 + space;

    end
    counter1 = counter1 + space;

end

%%
%%%%%%%%%%%%%%% make elongated cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

space = 0.1;
xlength = 50*numbPointsFactor;
ylength = 150*numbPointsFactor;

dataSqAllX2 = [];
dataSqAllY2 = [];
counter1 = 0;

for n = 1 : xlength
    
    counter2 = 0;

    for nn = 1 : ylength
        
        dataSqX2 = counter1;
        dataSqY2 = counter2;

%         
%         plot(dataSqX2,dataSqY2,'.')
%         hold on
%          pause
        dataSqAllX2 = [dataSqAllX2 dataSqX2];
        dataSqAllY2 = [dataSqAllY2 dataSqY2];

    counter2 = counter2 + space;

    end
    counter1 = counter1 + space;

end




%%
%%%%%%%% assemble data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


dataAll1 = [];
dataAll1(:,1) = dataSqAllX;
dataAll1(:,2) = dataSqAllY;

dataAll2 = [];
dataAll2(:,1) = dataSqAllX2;
dataAll2(:,2) = dataSqAllY2 + 13;

% dataAll3 = [];
% dataAll3(:,1) = dataSqAllX + 0.5;
% dataAll3(:,2) = dataSqAllY + 45;



dataAll = [];
% dataAll = [dataAll1' dataAll2' dataAll3']';
dataAll = [dataAll1' dataAll2']';

%center in y


dataAll(:,2) = dataAll(:,2);
dataAll(:,1) = dataAll(:,1)-5;


%%
%%%%%%%%%%% pick rand numbers from distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indperm = randperm(length(dataAll));
data = dataAll(indperm(1:500),:);



figure
subplot(1,2,1)
plot(dataAll(:,1),dataAll(:,2), '.')
axis square
axis([-27.5 27.5 -5 50])


subplot(1,2,2)
plot(data(:,1),data(:,2), '.')
axis square
axis([-27.5 27.5 -5 50])

%%
%%%%%%%%%%%%%% save data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%save('exclamationMarkUnif_1.mat' ,'data')

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
xb = linspace(-27.5, 27.5,nBins);
yb = linspace(-5,50,nBins);

edges{1} = xb;
edges{2} = yb;

% hist3(X,'Edges',edges)
[N,C] = hist3(dataAll,'Edges',edges);


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

