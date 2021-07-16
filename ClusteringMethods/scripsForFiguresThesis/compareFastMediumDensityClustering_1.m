


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


%%
%%%%%%%%%%%%%%%% calcualte densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
densityType = 'local';
kdedens = kde(data',densityType);

rho = evaluate(kdedens,data');


%%
%%%%%%%%%%%%%%%% compare slow fast medium %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
whichMethod = 'both';
doplot = 1;
nsamps = 10;
% doplot = 1;
distfun = pdist(data);



% [densityLineMap] = slowDensityLinesCalc_4(data,kdedens,rho,distfun,whichMethod,nsamps,doplot);

figure
plot(data(:,1),data(:,2),'o', 'color','k','markerfacecolor','k','markersize', 4)
box off    
axis square  
axis off



[densityLineMap] = fastDensityLinesCalc_3(data,kdedens,rho,distfun,whichMethod,nsamps,doplot);

numextra = sqrt(length(data));


[densityLineMap] = mediumDensityLinesCalc_2(data,kdedens,rho,distfun,whichMethod,nsamps,numextra,doplot);

numextra = length(data)-1;

[densityLineMap] = mediumDensityLinesCalc_2(data,kdedens,rho,distfun,whichMethod,nsamps,numextra,doplot);

