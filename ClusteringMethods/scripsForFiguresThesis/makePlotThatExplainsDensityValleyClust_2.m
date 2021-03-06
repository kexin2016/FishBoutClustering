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
scallingFactor = 1;
kdedens = [];
densityType = 'local';
linedensityMethod = 'slowPar';
numextra = sqrt(length(data));
nsamps = 10;
multirep = 10;
makeplot = 1;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
resampleMethod = 'onion';

[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRandOnions,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAllOnion,...
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
%%%%%%%%%%%%%%% calculate threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 [val, ind] = min(diff(funnymeasureSorted(1:100)));
    
    if ind == 1
       ind = 2 ;
    end
    
    SIJump = funnymeasureSorted(ind);
    CIOnion = prctile(funnymeasureRandSortedAllOnion(:,2),95);
    CISimplex = prctile(funnymeasureRandSortedAllSimplex(:,2),95);


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
%  funnymeasureRandThreshold =[];


decisionMethod = 'square';
[indChoosenClusterCenters] = decideClusterCentersAll_3(data,tree,clusterCentersSortedIdx,realRho,funnymeasure,SIJump,decisionMethod);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance';

makeplot = 0;
[clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);

 


%%
%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col(2,:)= [1 0 0];
col(1,:) = [0 0.8 0];
uniqueClusterAssignment = unique(clusterAssignment);

col = jet(length(uniqueClusterAssignment));

col = flipud(col);

figure
subplot(1,3,1)
plot(data(:,1),data(:,2), '.k')
axis square
xlabel('Dim 1')
ylabel('Dim 2')
box off

subplot(1,3,2)
scatter(data(:,1),data(:,2),5,rho,'filled')
axis square
xlabel('Dim 1')
ylabel('Dim 2')
box off


subplot(1,3,3)

plot(rho,funnymeasure, 'ko','MarkerFaceColor','k','MarkerSize',5)
hold on
plot(rhoRandOnions,funnymeasureRand, 'go','MarkerFaceColor','g','MarkerSize',5)

hold on


for n = 1 : length(uniqueClusterAssignment)
   
    
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
    plot(rho(clusterCentersSortedIdx(n)),funnymeasure(clusterCentersSortedIdx(n)), 'ko','MarkerFaceColor',col(n,:),'MarkerSize',10)

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

line([0 max(rho)],[CIOnion CIOnion], 'color','g')
line([0 max(rho)],[SIJump SIJump], 'color','r')
line([0 max(rho)],[CISimplex CISimplex], 'color',[255,165,0]/255)


figure
subplot(1,3,1)
dendrogram(tree);
axis square
ylabel('Separability index')
box off
% axis([0 max(rho) -2 max(funnymeasure)])
hold on
line([0 size(tree,1)+2],[CIOnion CIOnion], 'color','g')
line([0 size(tree,1)+2],[SIJump SIJump], 'color','r')
line([0 size(tree,1)+2],[CISimplex CISimplex], 'color',[255,165,0]/255)
axis([0 11 0 1])


subplot(1,3,2)
diffFunnymeasure = diff(funnymeasureSorted);

plot(diffFunnymeasure(1:length(clusterCentersSortedIdx)),'k-')
hold on

plot(diffFunnymeasure(1:length(clusterCentersSortedIdx)),'ko','markersize',3,'MarkerFaceColor', 'k')
axis square
for n = 1 : length(uniqueClusterAssignment)
   
    
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
    plot(n,diffFunnymeasure(n), 'ok','markerfacecolor',col(n,:),'markersize',10)

    axis square
    box off
    xlabel('Dim 1')
    ylabel('Dim 2')

    
end




subplot(1,3,3)
% plot3(data(:,1),data(:,2),rho, 'k.')
hold on
% col = jet(length(uniqueClusterAssignment));
for n = 1 : length(uniqueClusterAssignment)
   
    indThisCluster = find(clusterAssignment == uniqueClusterAssignment(n));
    
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
    plot3(data(indThisCluster,1),data(indThisCluster,2),rho(indThisCluster), 'o','MarkerEdgeColor',col(n,:),'MarkerFaceColor',col(n,:),'MarkerSize',3)

    axis square
    box off
    xlabel('Dim 1')
    ylabel('Dim 2')

    
end
