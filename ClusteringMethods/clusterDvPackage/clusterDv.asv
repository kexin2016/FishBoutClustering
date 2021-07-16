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
%%%%%%%%%%%%%%%%%% apply clusterDv %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kdedens = [];
densityType = 'local';%type of density estimation
linedensityMethod = 'fast';%line density method - can be slow, medium, fast
 resampleMethod = 'onion' ;
%resampleMethod = 'simplex' ;%simplex or onion

numextra = sqrt(length(data));
nsamps = 10;
multirep = 50;%times to repeat ref distribution
makeplot = 0;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
scallingFactor = 1;%no scalling


[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,...
     diffFunnymeasure,jumpFunymeasure] = ...
     findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,...
     numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);

 
 %%
%%%%%%%%%%%%%%% calculate threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
funnymeasureRandThreshold = prctile(funnymeasureRandSortedAll(:,2),99);

%  [val, ind] = min(diff(funnymeasureSorted(1:100)));
%     
%     if ind == 1
%        ind = 2 ;
%     end
%     
%     funnymeasureBigDiffThreshold = funnymeasureSorted(ind);
    
    
%%
%%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makePlot2 = 1;
maxNumbOfClusterCenters= 15;
pointAssignmentMethod = 'distance';
lowDensityCutOff = 0;
maxjump = [];
realRho = rho*length(data);



[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_3(data,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot2);



%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
decisionMethod = 'allClusterCenters';
% decisionMethod = 'square';

[indChoosenClusterCenters] = decideClusterCentersAll_3(data,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pointAssignmentMethod = 'distance';

makeplot = 1;
[clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);
