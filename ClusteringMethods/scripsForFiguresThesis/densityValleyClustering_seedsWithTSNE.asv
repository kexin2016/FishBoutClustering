% AddFunctionToPath
% 
% close all
% clear all

%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat file format
%2) applies density valley clustering
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
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick main folder where data set subfolders and fishMap are
[FileName,PathName] =  uigetfile('*.*');

data = load(strcat(PathName,FileName));
% data = data.data
% data3 = data2.artifitialDataSet(:,1:2);

   groundTruth = data.groudTruth;
%    groundTruth = data.groundTruth;

data = data.data;


% % data = nanZScore_parOutput(data);
% 
%   [COEFF,SCORE,latent] = princomp(data);
%   
%   
% data = SCORE(:,1:4);

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
% groundTruth(unique(indRepeatedAll)) = [];

%%
%%%%%%%%%%%%% use tsne %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


numbDims = 2;
% initial_dims = length(olivettiDistancesSq);
perplexity = 40;
% landmarks = 1;


 
tic
dataTSNE = tsne(data, [],numbDims, 4, perplexity);
toc

figure
 plot(dataTSNE(:,1),dataTSNE(:,2), 'k.')

%  plot3(dataTSNE(:,1),dataTSNE(:,2),dataTSNE(:,3), 'k.')
axis square

dataStructure.data = data;
dataStructure.groundTruth = groundTruth;
dataStructure.dataTSNE = dataTSNE;
dataStructure.perplexity = perplexity;
dataStructure.numbDims = numbDims;

save('seedsTSNE.mat', 'dataStructure')


data = dataStructure.data;
groundTruth = dataStructure.groundTruth;
dataTSNE = dataStructure.dataTSNE;



%%
%%%%%%%%%%%%% calcualte densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % kdedens = [];
% densityType = 'local';
% tic
% kdedens = kde(data',densityType);
% toc
% 
% originalBandWidths = getBW(kdedens);
% 
% 
% %make density plot
% rho = evaluate(kdedens,data');

%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % adjustBW(kdedens,originalBandWidths);
% 
% 
% % densityType = 'localp';
% makeplot = 0;
% % scallingFactor = size(data,2)-3;
% scallingFactor = 1;
% 
% [kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT(data,kdedens,scallingFactor,densityType,makeplot);

%%
%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% densityType = 'localp';
  kdedens = [];
%   scallingFactor = sqrt(size(data,2)-1);

linedensityMethod = 'fastPar';
numextra = sqrt(length(data));
nsamps = 10;
multirep = 50;
makeplot = 1;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
resampleMethod = 'simplex';
densityType = 'local';
scallingFactor = 3;

tic
% [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,...
    realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,...
    diffFunnymeasure,jumpFunymeasure] = findClusterCentersDensityValley_6(dataTSNE,kdedens,densityType,linedensityMethod,numextra,...
    nsamps,multirep,numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);

toc







 %%
%%%%%%%%%%%%%% calcualte rand threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[val, ind] = min(diff(funnymeasureSorted(1:100)));
    
    if ind == 1
       ind = 2 ;
    end


funnymeasureBigDiffThreshold1 = funnymeasureSorted(ind);


ICSimplex = prctile(funnymeasureRandSortedAll(:,2),95);


%%
%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% densityType = 'localp';
  kdedens = [];
%   scallingFactor = sqrt(size(data,2)-1);

linedensityMethod = 'fastPar';
numextra = sqrt(length(data));
nsamps = 10;
multirep = 50;
makeplot = 1;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
resampleMethod = 'onion';
densityType = 'local';
% scallingFactor = 1;

tic
% [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,...
    realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,...
    diffFunnymeasure,jumpFunymeasure] = findClusterCentersDensityValley_6(dataTSNE,kdedens,densityType,linedensityMethod,numextra,...
    nsamps,multirep,numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);

toc

[val, ind] = min(diff(funnymeasureSorted(1:100)));
    
    if ind == 1
       ind = 2 ;
    end
    
funnymeasureBigDiffThreshold = funnymeasureSorted(ind);

ICOnion = prctile(funnymeasureRandSortedAll(:,2),95);

%%
% %%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% kdedens = [];
% densityType = 'local';
% linedensityMethod = 'slowPar';
% numextra = sqrt(length(data));
% nsamps = 10;
% multirep = 10;
% makeplot = 1;
% numbPointsToShow = 40;
% clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
% 
% 
% %  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll] = findClusterCentersDensityValley_4(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
% 

%%
%%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxNumbOfClusterCenters = 30;
makePlot = 1;
pointAssignmentMethod = 'distance';
lowDensityCutOff = 0;

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_1(dataTSNE,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot);

%%
%%%%%%%%%%%%% decide correct number of cluster centers %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [indChoosenClusterCenters] = decideClusterCenters_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
%  funnymeasureRandThreshold = funnymeasureRandSorterAvr(2);
 funnymeasureRandThreshold =[];


decisionMethod = 'square';
[indChoosenClusterCenters] = decideClusterCentersAll_3(dataTSNE,tree,clusterCentersSortedIdx,realRho,funnymeasure,funnymeasureRandThreshold,decisionMethod);

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pointAssignmentMethod = 'pooledDensity2';
pointAssignmentMethod = 'distance';

makeplot = 1;
[clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);


%%
%%%%%%%%%%%%%% determine points that are correct %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

correctPoint = zeros(1,length(clusterAssignment));

for i = 1 : length(clusterAssignment)
    
ind = intersect(clusterAssignment(i), groundTruth(i));

if ~isempty(ind)

correctPoint(i) = 1; 
    
end


end

indCorrect = find(correctPoint == 1);

%%
%%%%%%%%%%%% make final plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(1,2,1)
plot(dataTSNE(:,1),dataTSNE(:,2), 'ok', 'markerfacecolor','w','markersize',10)
hold on
axis square
xlabel('Dim 1')
ylabel('Dim 2')

uniqueClusterNumb = unique(clusterAssignment);
col = jet(length(uniqueClusterNumb));

for n  = 1 : length(uniqueClusterNumb)
    
    indThisCluster = find(clusterAssignment == uniqueClusterNumb(n));
    indThisClusterCorr = intersect(indThisCluster,indCorrect);
    
    length(indThisCluster)
    
    plot(dataTSNE(indThisClusterCorr,1),dataTSNE(indThisClusterCorr,2), 'ok', 'markerfacecolor',col(n,:),'markersize',10)
    hold on
    box off
%     axis([-27.5 27.5 -5 50])
    axis square
%     axis off
    
end

% subplot(1,3,2)
% plot(rho,funnymeasure, 'ok', 'markerfacecolor','k','markersize',3)
% hold on
% plot(rhoRand,funnymeasureRand, 'og', 'markerfacecolor','g','markersize',3)
% 
% for n = 1 : length(indChoosenClusterCenters)
% plot(rho(indChoosenClusterCenters(n)),funnymeasure(indChoosenClusterCenters(n)), 'ok', 'markerfacecolor',col(n,:))
% end
% line([0 max(rho)],[randThreshold randThreshold], 'color','r')
% 
% axis square
% ylabel('Separability index')
% xlabel('local density' )
% box off
% xlabel('\rho')
% ylabel('Separability index')

subplot(1,2,2)
dendrogramBlack(tree,0)
hold on
line([0 size(tree,1)+2],[funnymeasureBigDiffThreshold funnymeasureBigDiffThreshold], 'color','r')
line([0 size(tree,1)+2],[ICSimplex ICSimplex], 'color',[255 177 100]/255)
line([0 size(tree,1)+2],[ICOnion ICOnion], 'color','g')

% ICOnion
% ICSimplex
% 
% funnymeasureBigDiffThreshold
% 
axis square
ylabel('Separability index')