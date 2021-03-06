AddFunctionToPath

close all
clear all

%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat file format
%2) applies density valley clustering

%%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick main folder where data set subfolders and fishMap are
% [FileName,PathName] =  uigetfile('*.*');
% 
% data = load(strcat(PathName,FileName));
% % data = data.data
% % data3 = data2.artifitialDataSet(:,1:2);
% 
% data = data.data;
% 
% % figure
% % plot(data())
load('E:\Joao\Clustering_161402\finalDataSetsToAnalyse\dataSetStructure_1.mat')

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
%%%%%%%%%%%%%% defien number of workers to use %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%matlabpool('close');

%close matlabpool if it is already opened
if matlabpool('size') ~= 0 % checking to see if my pool is already open
    
    matlabpool close
%     matlabpool open numberOfWorkers
    
    
end

%start matlab pool with number of corrers
matlabpool open 4


%%
%%%%%%%%%%%%%%%%%% parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

densityTypeAll = {'local','local','local','local','local','local','local','local','local','local','local','local','local','local','local','local','local','local','local'};
densityTypeAll{7} = 'local';
densityTypeAll{12} = 'localp';
densityTypeAll{13} = 'localp';

linedensityMethodAll = {'slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow','slow',};
linedensityMethodAll{1} = 'medium';
linedensityMethodAll{2} = 'medium';
linedensityMethodAll{3} = 'medium';
linedensityMethodAll{5} = 'medium';
linedensityMethodAll{14} = 'medium';


maxNumbOfClusterCentersAll = [21 36 51 50 17 17  17  17  17  17  17  17  17  17  17  17  17  17  17];

%%
%%%%%%%%%%%%% excluded repeated numbers  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makePlot1 = 0;
makePlot2 = 0;



for ii = 1 : length(dataSetStructure)
% ii = 7
tic
dataSetName = dataSetStructure(ii).dataSetName;
data = dataSetStructure(ii).data;
groundTruth = dataSetStructure(ii).groundTruth;

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
% densityType = 'local';
% linedensityMethod = 'slow';
densityType = char(densityTypeAll{ii});

% linedensityMethod =  char(linedensityMethodAll{ii});
linedensityMethod =  'mediumPar';

numextra = sqrt(length(data));
nsamps = 10;
multirep = 50;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
scallingFactor = 1;
% resampleMethod = 'onion';
resampleMethod = 'fast';



% makePlot1 = 1
%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
 [rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,...
     diffFunnymeasure,jumpFunymeasure] = ...
     findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,...
     numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makePlot1);

 
 
%%
%%%%%%%%%%% calcualte dendrogram threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [val, ind] = min(diff(funnymeasureSorted(1:100)));
    
    if ind == 1
       ind = 2 ;
    end
    
    funnymeasureBigDiffThreshold = funnymeasureSorted(ind);
    funnymeasureRandThreshold = prctile(funnymeasureRandSortedAll(:,2),95);
 
 
  dataSetStructure(ii).densityType = densityType;
  dataSetStructure(ii).linedensityMethod = linedensityMethod;
  dataSetStructure(ii).numextra = numextra;
  dataSetStructure(ii).nsamps = nsamps;
  dataSetStructure(ii).multirep = multirep;
  dataSetStructure(ii).clusterThreshold = clusterThreshold;
  dataSetStructure(ii).rho = rho;
  dataSetStructure(ii).realRho = realRho;
  dataSetStructure(ii).delta = delta;
  dataSetStructure(ii).funnymeasure = funnymeasure;
  dataSetStructure(ii).funnymeasureSorted = funnymeasureSorted;
  dataSetStructure(ii).kdedens = kdedens;
  dataSetStructure(ii).kdedensRand = kdedensRand;
  dataSetStructure(ii).maxjump = maxjump;
  dataSetStructure(ii).rhoRand = rhoRand;
  dataSetStructure(ii).realRhoRand = realRhoRand;
  dataSetStructure(ii).deltaRand = deltaRand;
  dataSetStructure(ii).funnymeasureRand = funnymeasureRand;
  dataSetStructure(ii).funnymeasureRandSorterAvr = funnymeasureRandSorterAvr;
  dataSetStructure(ii).clusterCentersSortedIdx = clusterCentersSortedIdx;
  dataSetStructure(ii).funnymeasureRandSortedAll = funnymeasureRandSortedAll;
  dataSetStructure(ii).diffFunnymeasure = diffFunnymeasure;
  dataSetStructure(ii).jumpFunymeasure = jumpFunymeasure;
  
  dataSetStructure(ii).funnymeasureBigDiffThreshold = funnymeasureBigDiffThreshold;
  dataSetStructure(ii).funnymeasureRandThreshold = funnymeasureRandThreshold;
%%
% %%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% maxNumbOfClusterCenters = maxNumbOfClusterCentersAll(ii);
% pointAssignmentMethodDendogram = 'distance';
% lowDensityCutOff = 0;
% 
% 
% 
% [tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_1(data,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethodDendogram,lowDensityCutOff,clusterCentersSortedIdx,makePlot2);
% 
%   dataSetStructure(ii).maxNumbOfClusterCenters = maxNumbOfClusterCenters;
%   dataSetStructure(ii).pointAssignmentMethodDendogram = pointAssignmentMethodDendogram;
%   dataSetStructure(ii).lowDensityCutOff = lowDensityCutOff;
% 
% 
%   dataSetStructure(ii).tree = tree;
%   dataSetStructure(ii).clusterAssignmentAll = clusterAssignmentAll;
%   dataSetStructure(ii).perm = perm;


%%
% %%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % [indChoosenClusterCenters] = decideClusterCenters_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
% %  funnymeasureRandThreshold = funnymeasureRandSorterAvr(2);
%  funnymeasureRandThreshold =[];
% 
% 
% decisionMethod = 'square';
% [indChoosenClusterCenters] = decideClusterCentersAll_3(data,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);

%%
% %%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % pointAssignmentMethod = 'pooledDensity2';
% pointAssignmentMethod = 'distance';
% 
% makeplot = 1;
% [clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);


%%
% %%%%%%%%%%%% make final plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% figure
% subplot(1,2,1)
% 
% uniqueClusterNumb = unique(clusterAssignment);
% col = jet(length(uniqueClusterNumb));
% 
% for n  = 1 : length(uniqueClusterNumb)
%     
%     indThisCluster = find(clusterAssignment == uniqueClusterNumb(n));
%     
%     plot(data(indThisCluster,1),data(indThisCluster,2), '.', 'color',col(n,:))
%     hold on
%     box off
% %     axis([-27.5 27.5 -5 50])
%     axis square
%     axis off
%     
% end
% 
% subplot(1,2,2)
% dendrogram(tree)
% axis square

toc
end


save('dataSetStructureDensityValley_fastSimplex.mat','dataSetStructure','-v7.3')