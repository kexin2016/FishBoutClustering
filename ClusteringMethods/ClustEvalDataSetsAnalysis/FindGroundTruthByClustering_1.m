% AddFunctionToPath

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

dataToAnalyse = data.data;

%%
%%%%%%%%%%%%% excluded repeated numbers  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distances = pdist(dataToAnalyse);

distancesSq = squareform(distances);
indRepeatedAll = [];
for n = 1 : length(distancesSq)
    
    indZeros = find(distancesSq(:,n) ==0);
    
    if length(indZeros)>1
       indRepeatedThis =  indZeros(2:end);
       
       indRepeatedAll = [indRepeatedAll' indRepeatedThis']';
    end
end

dataToAnalyse(unique(indRepeatedAll),:) = [];


%%
%%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kdedens = [];
densityType = 'local';
linedensityMethod = 'fast';
%  resampleMethod = 'onion' ;
 resampleMethod = 'simplex' ;

numextra = sqrt(length(dataToAnalyse));
nsamps = 10;
multirep = 0;
makeplot = 1;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
scallingFactor = 1;

%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(dataToAnalyse,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll] = findClusterCentersDensityValley_4(dataToAnalyse,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
% [rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure] = findClusterCentersDensityValley_5(dataToAnalyse,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,resampleMethod,makeplot);

[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,...
     diffFunnymeasure,jumpFunymeasure] = ...
     findClusterCentersDensityValley_6(dataToAnalyse,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,...
     numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);

 
 
 
 %%
% %%%%%%%%%%%%%%% calculate threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% funnymeasureRandThreshold = prctile(funnymeasureRandSortedAll(:,2),95);
% 
%  [val, ind] = min(diff(funnymeasureSorted(1:100)));
%     
%     if ind == 1
%        ind = 2 ;
%     end
%     
%     funnymeasureBigDiffThreshold = funnymeasureSorted(ind);
 
    funnymeasureRandThreshold = [];
    funnymeasureBigDiffThreshold = [];
    
%%
%%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makePlot2 = 1;
maxNumbOfClusterCenters= 15;
pointAssignmentMethod = 'distance';
lowDensityCutOff = 0;
maxjump = [];
realRho = rho*length(dataToAnalyse);



[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_3(dataToAnalyse,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot2);



%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [indChoosenClusterCenters] = decideClusterCenters_1(dataToAnalyse,tree,clusterCentersSortedIdx,realRho,funnymeasure);
%  funnymeasureRandThreshold = funnymeasureRandSorterAvr(2);
%  funnymeasureRandThreshold =[];
%  [val, ind] = min(diff(funnymeasureSorted(1:100)));
%     funnymeasureBigFiffThreshold = funnymeasureSorted(ind);
% 
%     funnymeasureRandThreshold = funnymeasureBigFiffThreshold;
    
% decisionMethod = 'allClusterCenters';
 decisionMethod = 'square';

[indChoosenClusterCenters] = decideClusterCentersAll_3(dataToAnalyse,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);



%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance';

makeplot = 1;
[clusterAssignment] = assignDataPointsAllCases_1(dataToAnalyse,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);

%%
%%%%%%%%%%%% make final plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dataToAnalyse = data.data;
% clusterAssignment = data.groundTruth;

data.data = dataToAnalyse;
data.groundTruth = groundTruth;


figure
% subplot(1,2,1)

uniqueClusterNumb = unique(clusterAssignment);
col = jet(length(uniqueClusterNumb));

for n  = 1 : length(uniqueClusterNumb)
    
    indThisCluster = find(clusterAssignment == uniqueClusterNumb(n));
    
    if size(dataToAnalyse,2) == 2
    hold on
    plot(dataToAnalyse(indThisCluster,1),dataToAnalyse(indThisCluster,2),'o','color',col(n,:),'markerfacecolor',col(n,:),'markersize',3)
    box off
%     axis([-27.5 27.5 -5 50])

    axis square
    box off
    
    else
        
     hold on
    plot3(dataToAnalyse(indThisCluster,1),dataToAnalyse(indThisCluster,2),dataToAnalyse(indThisCluster,3),'o','color',col(n,:),'markerfacecolor',col(n,:),'markersize',3)
    box off
%     axis([-27.5 27.5 -5 50])

    axis square
    box off    
    end
    
end

% subplot(1,2,2)
% dendrogramBlack(tree,0)
% hold on
% line([0 15],[funnymeasureRandThreshold funnymeasureRandThreshold], 'color','g')
% line([0 15],[funnymeasureBigDiffThreshold funnymeasureBigDiffThreshold], 'color','r')
% 
% ylabel('Separability index')
% box off
% axis square

%%
%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data = [];
% data.dataToAnalyse = dataToAnalyse;
% data.groundTruth = clusterAssignment;
% 
% [pathstr,name,ext] = fileparts(FileName) ;
% 
% 
% 
% save(char(strcat(PathName,'withGT\', name,'_withGT',ext)),'data')






