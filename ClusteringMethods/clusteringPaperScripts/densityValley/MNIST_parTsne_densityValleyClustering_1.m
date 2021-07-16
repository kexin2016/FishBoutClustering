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
%%%%%%%%%%%%%%%%%%% calculate local densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

densityType = 'localp';
kdedens = kde(data',densityType);

rho = evaluate(kdedens,data');

originalBandWidths = getBW(kdedens);

% look at densities
figure
plot3(data(:,1),data(:,2),rho, '.')
axis square

%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

adjustBW(kdedens,originalBandWidths);


densityType = 'localp';
makeplot = 0;
scallingFactor =3.5;

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBW_1(data,kdedens,scallingFactor,densityType,makeplot);


%%
%%%%%%%%%%%%%% pick subset of data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfBouts = 5000;
 %pick random bouts
 
 thisInds = 1 : 1 : length(data);
 
 indPerm = randperm(length(thisInds));
 thisIndRand = thisInds(indPerm(1:numberOfBouts));

dataRand = data(thisIndRand,:);
groundTruthRand  = groundTruth(thisIndRand,:);
rhoRand = evaluate(kdedensCutOff,dataRand');

figure
plot3(dataRand(:,1),dataRand(:,2),rhoRand, '.')
axis square

pause
%%
%%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kdedens = [];
densityType = 'localp';
linedensityMethod = 'slow';
%  linedensityMethod = 'fast';
% linedensityMethod = 'medium';

numextra = sqrt(length(data));
nsamps = 10;
multirep = 0;
makeplot = 1;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

tic
[rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(dataRand,kdedensCutOff,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
toc


%%
%%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxNumbOfClusterCenters = length(clusterCentersSortedIdx);
makePlot = 1;
pointAssignmentMethod = 'distance2';
lowDensityCutOff = 0;

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_2(dataRand,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot);


% clusterFunnymeasure  = tree(:,3);
% figure
% [n,xout] = hist(diff(clusterFunnymeasure));
% plot(xout, n)
% axis square
% % pause

%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    decisionMethod = 'square';
%       decisionMethod = 'dendrogram';

[indChoosenClusterCenters] = decideClusterCentersAll_1(dataRand,tree,clusterCentersSortedIdx,realRho,funnymeasure,decisionMethod);

% [indChoosenClusterCenters] = decideClusterCentersByDendrogramGap_2(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    pointAssignmentMethod = 'pooledDensity2';

  pointAssignmentMethod = 'distance2';

makeplot = 1;
[clusterAssignment] = assignDataPointsAllCases_1(dataRand,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);

%%
%%%%%%%%%%%%%%%%% calcualte rTrue and rFalse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 A = exist('groundTruth','var');
 
 
 if A == 1
 
 
 if size(groundTruth,2) ~= size(clusterAssignment,2)
 
     groundTruth = groundTruth';
 
     
 end
      makeplot = 1;

 [rTrue,rFalse] = rTrue_rFalse_Estimator_1(groundTruthRand',clusterAssignment,makeplot);
 
 end
