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
load('H:\Joao\Clustering_161402\finalDataSetsToAnalyse\dataSetStructure_1.mat')

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
%%%%%%%%%%%%%%%%%% parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

densityTypeAll = {'local','local','local','local','local','local','local','local','local','local','local','local','local','local','local','local','local','local','local'};
densityTypeAll{7} = 'localp';
densityTypeAll{12} = 'localp';
densityTypeAll{13} = 'localp';

maxNumbOfClusterCentersAll = [21 36 51 50 17 17  17  17  17  17  17  17  17  17  17  17  17  17  17];


%%
%%%%%%%%%%%%% excluded repeated numbers  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makePlot1 = 0;
makePlot2 = 1;



for ii = 1 : length(dataSetStructure)
ii
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
%%%%%%%%%%%%% apply density peak clustering with gauss %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kdedens = [];
densityType = densityTypeAll{ii};
distAlreadyCalc = 0;
percOrdc = 1;
percent = 1;
resampleMethod = 'onion'; 
multirep = 10;
makePlot = 1;
numbPointsToShow = 30;

[indClusterCenters,clusterCore,clusterHalo,idx,distanceSquare,rho,delta,gama,gamaSorted,dc,kdedens,distanceSquareRand,rhoRand,deltaRand,gamaRand,kdedensRand,gamaSortedRand,difference,Jump] = densityPeakClusteringWithKde_1(data,kdedens,densityType,resampleMethod,percent,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot1);



dataSetStructure(ii).densityType = densityType;
dataSetStructure(ii).percent = percent;
dataSetStructure(ii).resampleMethod = resampleMethod;
dataSetStructure(ii).multirep = multirep;

dataSetStructure(ii).distanceSquare = distanceSquare;
dataSetStructure(ii).rho = rho;
dataSetStructure(ii).delta = delta;
dataSetStructure(ii).gama = gama;
dataSetStructure(ii).gamaSorted = gamaSorted;
dataSetStructure(ii).dc = dc;
dataSetStructure(ii).kdedens = kdedens;
dataSetStructure(ii).distanceSquareRand = distanceSquareRand;
dataSetStructure(ii).rhoRand = rhoRand;
dataSetStructure(ii).deltaRand = deltaRand;
dataSetStructure(ii).gamaRand = gamaRand;
dataSetStructure(ii).kdedensRand = kdedensRand;
dataSetStructure(ii).gamaSortedRand = gamaSortedRand;
dataSetStructure(ii).difference = difference;
dataSetStructure(ii).Jump = Jump;

%%
%%%%%%%%%%%%%%%% make dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maxNumbOfClusterCenters = 15;
maxNumbOfClusterCentersAll = maxNumbOfClusterCenters(ii);

% makePlot = 0;

pointAssignmentMethod = 'distance';
lowDensityCutOff = 0;
maxjump = [];
realRho = rho*length(data);

 [~,clusterCentersSortedIdx] = sort(gama,'descend');
%  [~,idx] = sort(delta,'descend');

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_3(data,delta,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot2);

dataSetStructure(ii).maxNumbOfClusterCenters = maxNumbOfClusterCenters;
dataSetStructure(ii).pointAssignmentMethod = pointAssignmentMethod;
dataSetStructure(ii).lowDensityCutOff = lowDensityCutOff;
dataSetStructure(ii).realRho = realRho;
dataSetStructure(ii).clusterCentersSortedIdx = clusterCentersSortedIdx;




dataSetStructure(ii).tree = tree;
dataSetStructure(ii).clusterAssignmentAll = clusterAssignmentAll;
dataSetStructure(ii).perm = perm;


end


save('dataSetStructureDensityPeakWithKde.mat','dataSetStructure','-v7.3')