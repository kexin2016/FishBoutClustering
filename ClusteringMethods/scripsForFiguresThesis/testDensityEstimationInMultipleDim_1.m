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
% %%%%%%%%%%%%% excluded repeated numbers  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% distances = pdist(data);
% 
% distancesSq = squareform(distances);
% indRepeatedAll = [];
% for n = 1 : length(distancesSq)
%     
%     indZeros = find(distancesSq(:,n) ==0);
%     
%     if length(indZeros)>1
%        indRepeatedThis =  indZeros(2:end);
%        
%        indRepeatedAll = [indRepeatedAll' indRepeatedThis']';
%     end
% end
% 
% data(unique(indRepeatedAll),:) = [];


%%
%%%%%%%%%%%%%%%%%%%% calculate local densities in 2D%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars  kdedensScalled  kdedens

thisDimentions = 2;
dataThisDimentions = data(:,1:thisDimentions);

densityType = 'local';
kdedens = kde(dataThisDimentions',densityType);

origianlBandWidths = getBW(kdedens);


rho = evaluate(kdedens,dataThisDimentions');

kdedens = kde(dataThisDimentions',densityType);

makeplot4 = 0;
scallingFactor = 1;
[kdedensScalled,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT(dataThisDimentions,kdedens,scallingFactor,densityType,makeplot4);

rhoScalled2D = evaluate(kdedensScalled,dataThisDimentions');



%%
%%%%%%%%%%%% calculate local densities in other dimentions %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars  kdedensScalled  kdedens

thisDimentions = 7;
dataThisDimentions = data(:,1:thisDimentions);

kdedens = kde(dataThisDimentions',densityType);

origianlBandWidths2 = getBW(kdedens);

rho6d = evaluate(kdedens,dataThisDimentions');


% rho = evaluate(kdedens,dataThisDimentions');

% kdedens = kde(dataThisDimentions',densityType);

makeplot4 = 0;
%   scallingFactor = 21.277;
  scallingFactor = 1

[kdedensScalled,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT_2(dataThisDimentions,kdedens,scallingFactor,densityType,makeplot4);

rhoScalled = evaluate(kdedensScalled,dataThisDimentions');

[xcoords,ycoords]=meshgrid(-2:0.1:2,-2:0.1:2);
xcoords=xcoords(:);
ycoords=ycoords(:);

rhoScalledGrid = evaluate(kdedensScalled,[xcoords ycoords xcoords*0 xcoords*0 xcoords*0 xcoords*0 xcoords*0]');

%%
%%%%%%%%%%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kdedens = [];
densityType = 'local';
linedensityMethod = 'fastPar';
% resampleMethod = 'onion' ;
resampleMethod = 'onion' ;

numextra = sqrt(length(data));
nsamps = 10;
multirep = 0;
makeplot = 1;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
% scallingFactor = 1;

%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
%  [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll] = findClusterCentersDensityValley_4(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
% [rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAll,diffFunnymeasure,jumpFunymeasure] = findClusterCentersDensityValley_5(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,resampleMethod,makeplot);

[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,...
     deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAllOnion,...
     diffFunnymeasure,jumpFunymeasure] = ...
     findClusterCentersDensityValley_6(dataThisDimentions,kdedensScalled,densityType,linedensityMethod,numextra,nsamps,multirep,...
     numbPointsToShow,clusterThreshold,resampleMethod,scallingFactor,makeplot);



%%
%%%%%%%%%%%% scale difference dimentions independently %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars  kdedensScalled  kdedens

% thisDimentions = 5;
dataThisDimentions = data(:,1:thisDimentions);


kdedens = kde(dataThisDimentions',densityType);

bandWidths = getBW(kdedens);



% scallingFactorAll = [1 1.27 1.90,3.24,6.08,12.38,27.09];
scallingFactorAll = [0.78 1 1.5 2.54 4.77 9.72 21.28];
%  scallingFactorAll = [0.78 2.54  1.5 1 1.5 21.28 2.54 4.77 9.72 ];

% scallingFactorAll = 10;
  [kdedensScalled,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT_2(dataThisDimentions,kdedens,scallingFactorAll,densityType,makeplot4);


% ndz = size(bandWidths,1);
% npz = size(bandWidths,2);
%   
% testbandwidths = repmat(1:npz,ndz,1);
% adjustBW(kdedens,testbandwidths);
% changedBandWidths = getBW(kdedens);
% 
% for j = 1 : size(dataThisDimentions,2)
%     
% bandWidthsScalled(j,:) = bandWidths(j,:).*scallingFactorAll(j);
% 
% end
% 
% bandWidthsScalled(:,changedBandWidths(1,:)) = bandWidthsScalled;
% 
% kdedensScalled = kdedens;
% adjustBW(kdedensScalled,bandWidthsScalled);


rhoScalled2 = evaluate(kdedensScalled,dataThisDimentions');



%%
%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%look at densities
figure
subplot(2,2,1)
scatter(data(:,1),data(:,2),5,rhoScalled2D, 'filled')
axis square
title('2D without any scalling')

subplot(2,2,2)
scatter(data(:,1),data(:,2),5,rho6d, 'filled')
axis square
title('7D without any scalling')

subplot(2,2,3)
scatter(xcoords,ycoords,5,rhoScalledGrid, 'filled')
axis square
title('7D with scallling to 2D ')

subplot(2,2,4)
scatter(data(:,1),data(:,2),5,rhoScalled2, 'filled')
axis square
title('7D where each dimension is scalled independently')
