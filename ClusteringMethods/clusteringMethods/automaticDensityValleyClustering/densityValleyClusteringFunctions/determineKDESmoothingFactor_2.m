%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this function calcualtes the number of clusters with increasing smoothing

 function [numbClusterCenters] = determineKDESmoothingFactor_2(finalData,kdedens,scallingFactorVector,originalBandWidths,densityType,linedensityMethod,clusterThreshold,densityThreshold,numbPoints,makeplot2)


%%
%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% scallingFactorVector = 1:0.1:3;
% 
% 
% densityType = 'local';
% linedensityMethod = 'fast';
% clusterThreshold = 0.05;
% densityThreshold = 25;
% numbPoints = 200;
% makeplot2 = 1;
%%
%%%%%%%%%% determine subset of data to pick %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%we wnat to get 200 data points so that this is quick

totalNumbOfDataPoints = size(finalData,1);
 dataInds = 1:1:totalNumbOfDataPoints;

  indPerm = randperm(length(dataInds));
  thisIndRand2 = dataInds(indPerm(1:numbPoints));
  
%%
%%%%%%%%%%%%% scallingFactor loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


numbClusterCenters = zeros(1,length(scallingFactorVector));

for n = 1 : length(scallingFactorVector)
n



%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% originalBandWidths = neuralDataStructure.originalBandWidths;



adjustBW(kdedens,originalBandWidths);

makeplot = 0;

    scallingFactor = scallingFactorVector(n);

% scallingFactor =2;
[kdedensCutOff,~] = calculateLocalDensitiesScallingBW_1(finalData,kdedens,scallingFactor,densityType,makeplot);



%%
%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% densityType = 'local';
% linedensityMethod = 'fast';
numextra = sqrt(length(finalData(thisIndRand2,:)));
nsamps = 10;
multirep = 0;
makeplot = 0;
numbPointsToShow = 40;
% clusterThreshold = 0.05;%sometimes is has really small numbers - don't know why

tic
[rho,~,~,funnymeasure,~,~,~,~,~,~,~,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(finalData(thisIndRand2,:),kdedensCutOff,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
toc
 

%%
%%%%%%%%%%%%% threshold density outliers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure
% hist(rho,25)

     percentile = prctile(rho,densityThreshold);%15 works fine

% percentile = max(rho)./densityThreshold;
    
    
indOutLiers = find(rho(clusterCentersSortedIdx) < percentile);

clusterCentersSortedIdx(indOutLiers) = [];

% clf
% plot(rho,funnymeasure, '.k')
% hold on
% line([percentile percentile],[0 max(funnymeasure)])
% hold on
% line([0 max(rho)],[clusterThreshold clusterThreshold])
% pause(0.1)


% figure
% subplot(1,2,1)
% plot3(finalData(thisIndRand,1),finalData(thisIndRand,2),finalData(thisIndRand,3), '.')
% axis square
% subplot(1,2,2)
% plot3(finalData(thisIndRand,1),finalData(thisIndRand,2),rho, '.')
% hold on
% plot3(finalData(thisIndRand(clusterCentersSortedIdx),1),finalData(thisIndRand(clusterCentersSortedIdx),2),rho(clusterCentersSortedIdx), 'or')
% 
% axis square

numbClusterCenters(n) = length(clusterCentersSortedIdx);




end



%%
%%%%%%%%%%%%%% determine best scallingFactor %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%!!!! not implemented
% diff(numbClusterCenters)



%%
%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if makeplot2 ==1
    
figure
plot(scallingFactorVector,numbClusterCenters, '-')
hold on
plot(scallingFactorVector,numbClusterCenters, 'o')
axis square


end
