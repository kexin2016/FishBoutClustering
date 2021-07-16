


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





makePlot = 1;
numbPointsToShow = 100;
distAlreadyCalc = 0;
percent = 5;
% percent = 0.13;

percOrdc = 1;

multirep = 1;

% data = data/10000;
[indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,rhoRand,deltaRand,gamaRand,dc] = densityPeaksClusteringRandCorrectDc_4(data,percent,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);

clusterAssign = clusterCore + clusterHalo;

%%
%%%%%%%%%%% make datasrt figure figure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure
%data set
subplot(1,3,1)
plot(data(:,1),data(:,2), 'k.')
axis square
box off
xlabel('Dim 1')
ylabel('Dim 2')
axis square
box off

%solution
subplot(1,3,2)

uniqueClustecentersNumb = unique(clusterAssign);
uniqueClustecentersNumb(find(uniqueClustecentersNumb == 0)) = [];

col =  jet(length(uniqueClustecentersNumb));

 for n = 1 : length(uniqueClustecentersNumb)% loop through each cluster
%       n =1
      %cluster core
      indThisClusterCore = find(clusterAssign == uniqueClustecentersNumb(n));
%       
%       %cluster halo
%       indThisClusterHalo = find(clusterHalo == uniqueClustecentersNumb(n));
%      

      %plot cluster core
      plot(data(indThisClusterCore,1),data(indThisClusterCore,2), '.','color', col(n,:))
      hold on
      
%       plot(data(indThisClusterHalo,1),data(indThisClusterHalo,2), '.','color', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)
      
%       plot(data(indClusterCenters(n),1),data(indClusterCenters(n),2), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',10,'lineWidth',3)
      plot(data(indClusterCenters(n),1),data(indClusterCenters(n),2), 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
      box off
%       pause
 end
 axis square
%  axis([-7 7 -7 7])
xlabel('Dim 1') 
ylabel('Dim 2') 



axis square
box off

%decision plot
subplot(1,3,3)
plot(rho,delta,'k.') 
hold on
plot(rho(indClusterCenters),delta(indClusterCenters), 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
plot(rhoRand,deltaRand,'.', 'color', [0 0.8 0]) 
axis square
box off
xlabel('\rho')
ylabel('\delta')
