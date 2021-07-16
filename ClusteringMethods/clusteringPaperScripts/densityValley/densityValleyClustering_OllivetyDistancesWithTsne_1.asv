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

load(strcat(PathName,FileName));
% data = data.data
% data3 = data2.artifitialDataSet(:,1:2);


olivettiDistances = data(:,3);


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
%%%%%%%%%%%%% calcualte densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kdedens = [];
densityType = 'local';
tic
kdedens = kde(mappedX',densityType);
toc

originalBandWidths = getBW(kdedens);


%make density plot
rho = evaluate(kdedens,mappedX');

%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

adjustBW(kdedens,originalBandWidths);


densityType = 'localp';
makeplot = 0;
scallingFactor =1;

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBW_1(mappedX,kdedens,scallingFactor,densityType,makeplot);

%%
%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
densityType = 'localp';
linedensityMethod = 'slow';
numextra = sqrt(length(mappedX));
nsamps = 10;
multirep = 0;
makeplot = 0;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

tic
[rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(mappedX,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);

toc

%%
%%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxNumbOfClusterCenters = length(clusterCentersSortedIdx);
makePlot = 1;
pointAssignmentMethod = 'distance2';
lowDensityCutOff = 0;

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_2(mappedX,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot);


% clusterFunnymeasure  = tree(:,3);
% figure
% [n,xout] = hist(diff(clusterFunnymeasure));
% plot(xout, n)
% axis square
% % pause

%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  decisionMethod = 'square';
  decisionMethod = 'dendrogram';

[indChoosenClusterCenters] = decideClusterCentersAll_1(mappedX,tree,clusterCentersSortedIdx,realRho,funnymeasure,decisionMethod);

% [indChoosenClusterCenters] = decideClusterCentersByDendrogramGap_2(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            pointAssignmentMethod = 'pooledDensity2';
%                      pointAssignmentMethod = 'distance';
             pointAssignmentMethod = 'distance2';

makeplot = 0;
tic
[clusterAssignment] = assignDataPointsAllCases_1(mappedX,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);
toc 

%%
%%%%%%%%%%%% look at group of clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignment = unique(clusterAssignment);

 col = jet(length(uniqueClusterAssignment));
 figure
 subplot(1,2,1)
 for n = 1 : length(uniqueClusterAssignment)
  n   
         indThisCluster = find(clusterAssignment == uniqueClusterAssignment(n));
     
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color', col(n,:))
%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),rho(indThisCluster), '.k')
%     hold on
%     plot3(mappedX(indThisCluster,1),mappedX(indThisCluster,2),rho(indThisCluster), 'o', 'color', col(n,:))

%  plot(mappedX(indThisCluster,1),mappedX(indThisCluster,2), '.k')
    hold on
    plot(mappedX(indThisCluster,1),mappedX(indThisCluster,2), 'o', 'color', col(n,:))


    axis square
    box off
    xlabel('dim 1')
    ylabel('dim 1')
    
    title(length(indChoosenClusterCenters))
%     indDataSetNames{indThisCluster}
% clusterNamesStrucct(n).name = [indDataSetNames{indThisCluster}]
%  pause
 end
 
 
 subplot(1,2,2)
  col2 = jet(40);

 for nn = 1 : 40
     
 indThisCluster = find(olivettiLabels == nn);
 
    plot(mappedX(indThisCluster,1),mappedX(indThisCluster,2), 'o', 'color', col2(nn,:))
axis square
hold on
 end
 
 %%
 %%%%%%%%%%%%%%%%% calcualte rTrue and rFalse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 makeplot = 1;
 [rTrue,rFalse] = rTrue_rFalse_Estimator_1(olivettiLabels,clusterAssignment,makeplot);
 
 
 