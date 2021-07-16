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

% data = data.data;

% figure
% plot(data())


%%
%%%%%%%%%%%%% calcualte densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kdedens = [];
densityType = 'localp';
tic
kdedens = kde(data',densityType);
toc

originalBandWidths = getBW(kdedens);


%make density plot
% rho = evaluate(kdedens,data');

%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

adjustBW(kdedens,originalBandWidths);


% densityType = 'localp';
makeplot = 0;
scallingFactor =1.0000000000000001;

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBW_1(data,kdedens,scallingFactor,densityType,makeplot);

%%
%%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kdedens = [];
% densityType = 'local';
linedensityMethod = 'slow';
%  linedensityMethod = 'fast';
% linedensityMethod = 'medium';

numextra = sqrt(length(data));
nsamps = 10;
multirep = 0;
makeplot = 1;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

[rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);

%%
%%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxNumbOfClusterCenters = length(clusterCentersSortedIdx);
makePlot = 1;
%  pointAssignmentMethod = 'distance2';

   pointAssignmentMethod = 'pooledDensity2';
%   pointAssignmentMethod = 'distance';

lowDensityCutOff = 0;

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_1(data,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot);

%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [indChoosenClusterCenters] = decideClusterCenters_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
  decisionMethod = 'square';
  decisionMethod = 'dendrogram';

[indChoosenClusterCenters] = decideClusterCentersAll_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure,decisionMethod);

% [indChoosenClusterCenters] = decideClusterCentersByDendrogramGap_2(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   pointAssignmentMethod = 'pooledDensity2';
%  pointAssignmentMethod = 'distance';

makeplot = 1;
[clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);

%%
 %%%%%%%%%%%%%%%%% calcualte rTrue and rFalse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 A = exist('groundTruth','var');
 
 
 if A == 1
 
 
 if size(groundTruth,2) ~= size(clusterAssignment,2)
 
     groundTruth = groundTruth';
 
     
 end
      makeplot = 1;

 [rTrue,rFalse] = rTrue_rFalse_Estimator_2(groundTruth,clusterAssignment,makeplot);
 
 end

 
 %%
 %%%%%%%%%%%%%%%%% compare groundTruth with clustering %%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 uniqueGroundTruth = unique(groundTruth);
 
 col = jet(length(unique(groundTruth)));
 figure
%  subplot(1,2,1)
%  plot3(data(:,2),data(:,3),data(:,6), '.')

 for n = 1 : length(unique(groundTruth))
 
     indThisLabel = find(groundTruth == uniqueGroundTruth(n));

 plot3(data(indThisLabel,2),data(indThisLabel,3),data(indThisLabel,6), 'o','color',col(n,:))
 
 hold on
 
 end
 axis square
 
 uniqueClusterAssignment = unique(clusterAssignment);
 
 col = jet(length(unique(clusterAssignment)));

%  subplot(1,2,2)
%  plot3(data(:,2),data(:,3),data(:,6), '.')

 for n = 1 : length(uniqueClusterAssignment)
 
     indThisCluster = find(clusterAssignment == uniqueClusterAssignment(n));

 plot3(data(indThisCluster,2),data(indThisCluster,3),data(indThisCluster,6), '.','color',col(n,:))
 
 hold on
 
 end
 
 xlabel('C2')
 ylabel('C3')
 zlabel('C6')

 axis square