AddFunctionToPath

close all
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
%%%%%%%%%%%%% apply density peak clustering with gauss %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kdedens = [];
densityType = 'localp';
distAlreadyCalc = 0;
percOrdc = 1;
percent = 1;
resampleMethod = 'onion'; 
multirep = 5;
makePlot = 1;
numbPointsToShow = 30;

% [indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,dc,kdedens] = densityPeakClusteringWithKde_1(data,kdedens,densityType,resampleMethod,percent,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);
[indClusterCenters,clusterCore,clusterHalo,idx,distanceSquare,rho,delta,gama,gamaSorted,dc,kdedens,distanceSquareRand,rhoRand,deltaRand,gamaRand,kdedensRand,gamaSortedRand,difference,Jump] = densityPeakClusteringWithKde_1(data,kdedens,densityType,resampleMethod,percent,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot);


%%
%%%%%%%%%%%%%%%% make dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxNumbOfClusterCenters = 15;
makePlot = 1;
pointAssignmentMethod = 'distance';
lowDensityCutOff = 0;
maxjump = [];
realRho = rho*length(data);

 [~,idx] = sort(gama,'descend');
%  [~,idx] = sort(delta,'descend');

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_3(data,delta,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,idx,makePlot);


