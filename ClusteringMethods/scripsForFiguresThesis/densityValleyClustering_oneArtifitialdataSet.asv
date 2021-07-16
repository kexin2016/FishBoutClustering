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
% %%%%%%%%%%%%%% defien number of workers to use %%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %matlabpool('close');
% 
% %close matlabpool if it is already opened
% if matlabpool('size') ~= 0 % checking to see if my pool is already open
%     
%     matlabpool close
% %     matlabpool open numberOfWorkers
%     
%     
% end
% 
% %start matlab pool with number of corrers
% matlabpool open 4


%%
%%%%%%%%%%%%%%%%%%%% calculate local densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% densityType = 'local';
% kdedens = kde(data',densityType);
% 
% rho = evaluate(kdedens,data');
% 

% %look at densities
% plot3(data(:,2),data(:,3),data(:,6), '.')
% 
% plot3(data(:,2),data(:,6),rho, '.')


%%
%%%%%%%%%%%%% excluded repeated numbers  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distances = pdist(data);

distancesSq = squareform(distances);
indRepeatedAll = [];
for n = 1 : length(distancesSq)
    
    indZeros = find(distancesSq(:,n) ==0);
    
    if length(indZeros)>1
       indRepeatedThis =  indZeros(2:end);
       
       indRepeatedAll = [indRepeatedAll' indRepeatedThis']';
    end
end

data(unique(indRepeatedAll),:) = [];

%%
%%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kdedens = [];
densityType = 'local';
linedensityMethod = 'fastPar';
 linedensityMethod = 'mediumPar';
 linedensityMethod = 'slowPar';

% resampleMethod = 'onion' ;
resampleMethod = 'onion' ;

numextra = sqrt(length(data));
nsamps = 10;
multirep = 0;
makeplot = 1;
numbPointsToShow = 33;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
scallingFactor = 1;

%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll] = findClusterCentersDensityValley_4(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
% [rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure] = findClusterCentersDensityValley_5(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,resampleMethod,makeplot);
% data = data(:,1:3);
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAllOnion,...
     diffFunnymeasure,jumpFunymeasure] = ...
     findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,...
     numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);

 resampleMethod = 'simplex' ;

 
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAllSimplex,...
     diffFunnymeasure,jumpFunymeasure] = ...
     findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,...
     numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);


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

makePlot2 = 1;
maxNumbOfClusterCenters = 50;
pointAssignmentMethod = 'distance2';
% pointAssignmentMethod ='pooledDensity2';

lowDensityCutOff = 0;
maxjump = [];
realRho = rho*length(data);



[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_3(data,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot2);

%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [indChoosenClusterCenters] = decideClusterCenters_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
%  funnymeasureRandThreshold = funnymeasureRandSorterAvr(2);
%  funnymeasureRandThreshold =[];
%  [val, ind] = min(diff(funnymeasureSorted(1:100)));
%     funnymeasureBigFiffThreshold = funnymeasureSorted(ind);
% 
%     funnymeasureRandThreshold = funnymeasureBigFiffThreshold;
    
decisionMethod = 'allClusterCenters';
 decisionCutOff = SIJump;
 decisionCutOff = CISimplex;

[indChoosenClusterCenters] = decideClusterCentersAll_3(data,tree,clusterCentersSortedIdx,realRho,funnymeasure,decisionCutOff,decisionMethod);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance';

makeplot = 1;
[clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);


%%
%%%%%%%%%%%% make final plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(1,2,1)

uniqueClusterNumb = unique(clusterAssignment);
col = jet(length(uniqueClusterNumb));

for n  = 1 : length(uniqueClusterNumb)
    
    indThisCluster = find(clusterAssignment == uniqueClusterNumb(n));
    hold on
    plot(data(indThisCluster,1),data(indThisCluster,2),'o','color',col(n,:),'markerfacecolor',col(n,:),'markersize',3)
    box off
%     axis([-27.5 27.5 -5 50])

    axis square
    box off
    
end

subplot(1,2,2)
dendrogramBlack(tree,0)
hold on
line([0 size(tree,1)+2],[CIOnion CIOnion], 'color','g')
line([0 size(tree,1)+2],[SIJump SIJump], 'color','r')
line([0 size(tree,1)+2],[CISimplex CISimplex], 'color',[255,165,0]/255)

axis([0  size(tree,1)+2 0 1 ])
  

ylabel('Separability index')
box off
axis square
