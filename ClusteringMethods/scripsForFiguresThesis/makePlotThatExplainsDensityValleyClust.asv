AddFunctionToPath

close all
clear all

%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat file format
%2) applies density valley clustering

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
%%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kdedens = [];
densityType = 'local';
linedensityMethod = 'medium';
numextra = sqrt(length(data));
nsamps = 10;
multirep = 10;
makeplot = 1;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
resampleMethod = 'onion';
scallingFactor = 1;
%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll] = findClusterCentersDensityValley_4(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
% [rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure] = findClusterCentersDensityValley_5(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,resampleMethod,makeplot);


 [rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvrOnion,clusterCentersSortedIdx,funnymeasureRandSortedAllOnion,...
     diffFunnymeasure,jumpFunymeasure] = ...
     findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,...
     numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);

resampleMethod = 'simplex';

[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAllSimplex,...
     diffFunnymeasure,jumpFunymeasure] = ...
     findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,...
     numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);

 
 miniDipp = max(rho) - delta;
 miniDippRand = max(rho) - deltaRand;

 
 
 
 %%
 %%%%%%%%%%%%% calcualte cut offs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  [val, ind] = min(diff(funnymeasureSorted(1:100)));
    
    if ind == 1
       ind = 2 ;
    end
    
    SIjump = funnymeasureSorted(ind);
    ICSimplex = prctile(funnymeasureRandSortedAllSimplex(:,2),95);
    ICOnion = prctile(funnymeasureRandSortedAllOnion(:,2),95);

%%
%%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxNumbOfClusterCenters = 15;
makePlot = 1;
pointAssignmentMethod = 'distance';
lowDensityCutOff = 0;

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_1(data,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot);

%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [indChoosenClusterCenters] = decideClusterCenters_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
%  funnymeasureRandThreshold = funnymeasureRandSorterAvr(2);
 funnymeasureRandThreshold =[];


decisionMethod = 'square';
[indChoosenClusterCenters] = decideClusterCentersAll_3(data,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance2';

makeplot = 0;
[clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);

 


%%
%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col(2,:)= [1 0 0];
col(1,:) = [0 0.8 0];

figure
subplot(1,4,1)
plot(data(:,1),data(:,2), '.k')
axis square
xlabel('Dim 1')
ylabel('Dim 2')
box off

subplot(1,4,2)
scatter(data(:,1),data(:,2),5,rho,'filled')
axis square
xlabel('Dim 1')
ylabel('Dim 2')
box off


subplot(1,4,3)
scatter(data(:,1),data(:,2),5,rho,'filled')



hold on
for n = 1 : length(indChoosenClusterCenters)
   
    
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
    plot(data(indChoosenClusterCenters(n),1),data(indChoosenClusterCenters(n),2), 'o', 'color', 'k','MarkerFaceColor',col(n,:),'MarkerSize',10)

    axis square
    box off
    xlabel('Dim 1')
    ylabel('Dim 2')

    
end

axis square
xlabel('Dim 1')
ylabel('Dim 2')
box off

subplot(1,4,4)
scatter(data(:,1),data(:,2),5,rho,'filled')

hold on
for n = 1 : length(indChoosenClusterCenters)
   
    
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
    plot(data(indChoosenClusterCenters(n),1),data(indChoosenClusterCenters(n),2), 'o', 'color', 'k','MarkerFaceColor',col(n,:),'MarkerSize',10)

    axis square
    box off
    xlabel('Dim 1')
    ylabel('Dim 2')

    
end


axis square
xlabel('Dim 1')
ylabel('Dim 2')
box off
col2 = [0.5 0.5 0.5];


figure
subplot(1,4,1)
plot(rho,miniDipp, 'ko','MarkerFaceColor','k','MarkerSize',5)

hold on
plot(rhoRand,miniDippRand, 'go','MarkerFaceColor','g','MarkerSize',5)

for n = 1 : length(clusterCentersSortedIdx)
   
    
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
    plot(rho(clusterCentersSortedIdx(n)),miniDipp(clusterCentersSortedIdx(n)), 'o', 'color', 'k','MarkerFaceColor',col2,'MarkerSize',10)

    axis square
    box off
    xlabel('Dim 1')
    ylabel('Dim 2')

    
end

axis square
ylabel('Minimum density valley')
xlabel('\rho')
box off
axis([0 max(rho) 0 max(miniDipp)])







subplot(1,4,2)
plot(rho,funnymeasure, 'ko','MarkerFaceColor','k','MarkerSize',5)
hold on
plot(rhoRand,funnymeasureRand, 'go','MarkerFaceColor','g','MarkerSize',5)

hold on
for n = 1 : length(clusterCentersSortedIdx)
   
    
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
    plot(rho(clusterCentersSortedIdx(n)),funnymeasure(clusterCentersSortedIdx(n)), 'o', 'color', 'k','MarkerFaceColor',col2,'MarkerSize',10)

    axis square
    box off
    xlabel('Dim 1')
    ylabel('Dim 2')

    
end

axis square
ylabel('Separability index')
xlabel('\rho')
box off
axis([0 max(rho) -2 max(funnymeasure)])
line([0 8],[ICOnion ICOnion], 'color','g')
line([0 8],[SIjump SIjump], 'color','r')
line([0 8],[ICSimplex ICSimplex], 'color',[255 99 71]/255)



subplot(1,4,3)
dendrogram(tree);
axis square
ylabel('Separability index')
box off
% axis([0 max(rho) -2 max(funnymeasure)])
hold on
line([0 8],[ICOnion ICOnion], 'color','g')
line([0 8],[SIjump SIjump], 'color','r')
line([0 8],[ICSimplex ICSimplex], 'color',[255 99 71]/255)

 


subplot(1,4,4)
uniqueClusterAssignment = unique(clusterAssignment);
% plot3(data(:,1),data(:,2),rho, 'k.')
hold on
for n = 1 : length(uniqueClusterAssignment)
   
    indThisCluster = find(clusterAssignment == uniqueClusterAssignment(n));
    
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
    plot3(data(indThisCluster,1),data(indThisCluster,2),rho(indThisCluster), 'o', 'color', col(n,:),'MarkerFaceColor',col(n,:),'MarkerSize',5)

    axis square
    box off
    xlabel('Dim 1')
    ylabel('Dim 2')

    
end
