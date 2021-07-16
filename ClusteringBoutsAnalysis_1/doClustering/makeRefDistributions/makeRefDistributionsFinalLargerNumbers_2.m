clear all
close all

%%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick file of data set to analyse
%% resampleDist_Onion_Fast_1.75.mat


[FileName,PathName] =  uigetfile('*.*');

load(strcat(PathName,FileName));


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
matlabpool open 8

%%
%%%%%%%%%%%% clculate number of points in datasets %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbForDesities = zeros(1,length(indStructure));
numbForClustering = zeros(1,length(indStructure));

for n = 1 : length(indStructure)
    
    numbForDesities(n) =  length(indStructure(n).thisInds);
    numbForClustering(n) = length(indStructure(n).thisIndRand);
    
    
    
    
end


xVector1 = (1:100:80000);
xVector2 = (1:100:4000);

[NDensities] = hist(numbForDesities,xVector1);
[NClustering] = hist(numbForClustering,xVector2);

figure
hold on
plot(xVector2,NClustering, 'r-')

plot(xVector1,NDensities, '-')

%%
%%%%%%%%%%%%%%pick random number of points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% resampleNumberAll = [50000 5000 1000 500];
% resampleNumberAll = [500 1000 5000 50000];
 resampleNumberAll = [100 500 1000 1500 5000];
% resampleNumberAll = 5000;

clusteringResamplingNumber = 3000;

numbOfRepetitions = 100;
densityType = 'local';
scallingFactor = 1.75;
linedensityMethod = 'slowPar';
thisInds = 1 :1: length(boutDataPCASample);
 resampleMethod = 'onion' ;
%   resampleMethod = 'simplex' ;

% pause
clearvars referenceDistributionInf referenceDistributions
for i = 1: length(resampleNumberAll)


resampleNumber = resampleNumberAll(i);

clearvars referenceDistributions;

for n = 1 : numbOfRepetitions
i
% n =1
n

tic
%%
%%%%%%%%% pick random bouts from all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    indPerm = randperm(length(thisInds));
    thisIndRand = thisInds(indPerm(1:resampleNumber));
    
    
    boutDataPCASampleThis = boutDataPCASample(thisIndRand,:);
    

    
    %%
    %%%%%%%%%%%%%%%% calculate densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clearvars kdedensRand kdedensRandScalled kdedens

    kdedens = kde(boutDataPCASampleThis',densityType);
      
    originalBandWidths = getBW(kdedens);
    
    densities = evaluate(kdedens,boutDataPCASampleThis');
    
    clearvars kdedens
    %%
%     %%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % adjustBW(kdedens,originalBandWidths);
% 
% 
% % densityType = 'local';
% makeplot = 0;
% % densityType = 'local';
% 
% [kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT(boutDataPCASampleThis,kdedens,scallingFactor,densityType,makeplot);
% 
% 
% densitiesScalled = evaluate(kdedensCutOff,boutDataPCASampleThis');

%%
%%%%%%%%%%%%% resample data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch resampleMethod
    
    case 'onion' 

[resampledData] = resampleDensityMatching(densities,size(boutDataPCASampleThis,2));


    case 'simplex' 

doPlot = 0;
[resampledData] = resampleDistribution_3(boutDataPCASampleThis,size(boutDataPCASampleThis,1),doPlot);

end

%%
%%%%%%%%%%%%%%%%%% calculate densities of resampled data%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 kdedensRand = kde(resampledData',densityType);
      
    originalBandWidthsRand = getBW(kdedensRand);
    
    densitiesRand = evaluate(kdedensRand,resampledData');

    makeplot = 0;
% densityType = 'local';

[kdedensRandScalled,bandWidthsScalledRand] = calculateLocalDensitiesScallingBWCORRECT(resampledData,kdedensRand,scallingFactor,densityType,makeplot);


densitiesScalledRand = evaluate(kdedensRandScalled,resampledData');
    
    
%%
%%%%%%%%%%%%%%% resample data  again %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if resampleNumber <= clusteringResamplingNumber

%     thisIndRandRand = thisIndRand;
    resampledDataFinal = resampledData;
    thisIndRandRand = thisIndRand;
else
    
    thisInds = 1 : length(boutDataPCASampleThis);
    indPerm = randperm(length(thisInds));
    thisIndRandRand = thisInds(indPerm(1:clusteringResamplingNumber));
    
    resampledDataFinal = resampledData(thisIndRandRand,:);
end



   
% boutDataPCASampleThis2 = boutDataPCASample(thisIndRandRand,:);
% 
% 
% densitiesScalled = evaluate(kdedensCutOff,boutDataPCASampleThis2');
%     
%     


%%
%%%%%%%%%%%%% calculate  funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kdedensResampleDist = [];
numextra = sqrt(length(resampledDataFinal));
nsamps = 10;
multirep = 0;
makeplot = 0;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

    
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,...
    funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure]...
    = findClusterCentersDensityValley_6(resampledDataFinal,kdedensRandScalled,densityType,linedensityMethod,numextra,nsamps,...
    multirep,numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);

%%
%%%%%%%%%%%%%%%%% save stuff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

referenceDistributions(n).thisIndRandOriginal = thisIndRand;
referenceDistributions(n).thisIndRandClustering = thisIndRandRand;
referenceDistributions(n).originalBandWidths = originalBandWidthsRand;
referenceDistributions(n).kdedens = kdedensRand;
referenceDistributions(n).kdedensScalled = kdedensRandScalled;
referenceDistributions(n).bandWidthsScalled = bandWidthsScalledRand;
referenceDistributions(n).originalDataDensities = densities;
referenceDistributions(n).resampledData = resampledDataFinal;
referenceDistributions(n).rho = rho;
referenceDistributions(n).funnymeasureSorted = funnymeasureSorted;
referenceDistributions(n).funnymeasure = funnymeasure;
referenceDistributions(n).secondClusterFunnymwasure = funnymeasureSorted(2);
funnymeasureSorted(2)
toc

end



%%
%%% save information that was used to do this reference distributions %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

funnymeasureRandThresholdDist = [referenceDistributions.secondClusterFunnymwasure];
funnymeasureRandThreshold = prctile(funnymeasureRandThresholdDist,95);


referenceDistributionInf(i).resampleNumber = resampleNumber;
referenceDistributionInf(i).resampleMethod = resampleMethod;
referenceDistributionInf(i).clusteringResamplingNumber = clusteringResamplingNumber;
referenceDistributionInf(i).numbOfRepetitions = numbOfRepetitions;
referenceDistributionInf(i).densityType = densityType;
referenceDistributionInf(i).scallingFactor = scallingFactor;
referenceDistributionInf(i).linedensityMethod = linedensityMethod;
referenceDistributionInf(i).clusteringResamplingNumber = clusteringResamplingNumber;
referenceDistributionInf(i).nsamps = nsamps;
referenceDistributionInf(i).clusterThreshold = clusterThreshold;
referenceDistributionInf(i).funnymeasureRandThreshold = funnymeasureRandThreshold;
referenceDistributionInf(i).funnymeasureRandThresholdDist = funnymeasureRandThresholdDist;
referenceDistributionInf(i).All = referenceDistributions;

end

%%
%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('resampleDist_onion_slow_1.75_100to5000.mat','referenceDistributionInf','-v7.3')
