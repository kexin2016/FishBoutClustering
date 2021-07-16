%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) Calculates local densities with mixture of gaussians - if kdedens is
%empty it calcualtes if kdedens is density obj it uses it as input

%2) Calculates local density rho and delta (density paths using matlab simple linakage)

%3) Calculates funnymeasure:  -miniDipp./rho + 1

%4) does same thing for resampled distribution - resempled distribution
%method does not work for density valleys - put multirep = [] to skip this



%%
%%%%%%%%%%%%%%% inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) data - data to find cluster centers
%2) kdedens * density obj - if it is empty function calcualtes it
%3) densityType - to calcualte kdedens: local, localp, ROT, ...
%4) linedensityMethod - method used to calcualte density lines: may use slow, medium or fast line density method 
%5)numextra - for medium linedensityMethod there is the need to define the
%number of points to use - ROT: sqrt(length(data))
%6) nsamps - number of devisions in density line - 10 is enough
%7) multirep - number of times to repeat rand distribution - if 0 does not do it
%8) makeplot - make decision plots

%%
%%%%%%%%%%%%%%%%%%%%%%%%% outputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%
  function [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_3(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot)



%%
% %%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kdedens = [];
% densityType = 'localp';
% linedensityMethod = 'slow';
% numextra = sqrt(length(data));
% nsamps = 10;
% multirep = 0;
% makeplot = 1;
% numbPointsToShow = 40;

%%
%%%%%%%%%%%%%%%%%%%%% calculate density kernel %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(kdedens) 
    
kdedens = kde(data',densityType);

    
end

numbPointsUsedToCalcualateKde = length(getPoints(kdedens));

%%
%%%%%%%%%%%%%% calcualte rho delta by max jump %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
doplot = 0;

[rho,delta,maxjump,densityNorm] = calculateRhoAndDeltaMaxDensityJumpLinkage_5(data,nsamps,densityType,kdedens,linedensityMethod,numextra,doplot);

%calculate real rho
realRho = rho.*numbPointsUsedToCalcualateKde;

%%
%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%funny measure is (-minidipp/rho) + 1

maxrho = max(rho);

miniDipp = maxrho - delta;

funnymeasure = -miniDipp./rho + 1;


funnymeasureRandSortedAll = zeros(multirep,length(data));

%%
%%% calcualte rho delta and funnymeasure for resampled distribution %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if multirep ~=0%put zero in multirep not to do random dist
for multi = 1 : multirep

%%
%%%%%%%%%%%%%%%% resampled distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nDims = size(data,2);
[dataRand] = resampleDensityMatching(rho,nDims);


% doPlot = 0;
% [dataRand] = resampleDistribution_3(data,size(data,1),doPlot);
% % 
% 
%%
%%%%%%%%%%%%%% calcualte rho delta by max jump %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 kdedensRand = kde(dataRand',densityType);

 
 
doplot = 0;
[rhoRand,deltaRand,maxjumpRand,densityNormRand] = calculateRhoAndDeltaMaxDensityJumpLinkage_5(dataRand,nsamps,densityType,kdedensRand,linedensityMethod,numextra,doplot);
% size(dataRand)
%%
%%%%%%%%%%%%% calculate real rho %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbPointsUsedToCalcualateKdeRand = length(getPoints(kdedensRand));

%calculate real rho
realRhoRand = rhoRand.*numbPointsUsedToCalcualateKdeRand;

%%
%%%%%%%%%%% calculate funnymeasure for rand distribution %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


maxrhoRand = max(rhoRand);

miniDippRand = maxrhoRand - deltaRand;

funnymeasureRand = -miniDippRand./rhoRand + 1;

[funnymeasureRandSorted funnymeasureRandIdx] = sort(funnymeasureRand, 'descend');
funnymeasureRandSortedAll(multi,:) = funnymeasureRandSorted;

end


 funnymeasureRandSorterAvr = nanmean(funnymeasureRandSortedAll,1);


else% not doing resampled distribution
    
rhoRand = [];   
realRhoRand = [];
deltaRand = []; 
miniDippRand = [];
funnymeasureRand = [];
funnymeasureRandSorterAvr = [];

end

%sort funny measure
[funnymeasureSorted, funnymeasureIdx] = sort(funnymeasure, 'descend');

% funnymeasureRandSorterAvr(1) = funnymeasureRandSorterAvr(2);
diffFunnymeasure = funnymeasureSorted - funnymeasureRandSorterAvr;


diffFunnymeasure2 = diffFunnymeasure;
% diffFunnymeasure2(1) = 1;
jumpFunymeasure = diff(diffFunnymeasure2);

diffFunnymeasureDiv = diffFunnymeasure./funnymeasureSorted;
diffdiffFunnymeasureDiv = diff(diffFunnymeasureDiv);

%%
%%%%%%%%%%%%%% find all cluster centers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%find cluster centers
indClusterCenters = find(funnymeasure > clusterThreshold);



%order cluster centers by funnymeasure
[~, funnymeasureIdx] = sort(funnymeasure, 'descend');
clusterCentersSortedIdx = funnymeasureIdx(1:(length(indClusterCenters)));







%%
%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if makeplot == 1

figure
subplot(2,5,1)
plot(realRho(:),delta(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on
if multirep ~= 0
     plot(realRhoRand(:),deltaRand(:),'o','MarkerSize',5,'MarkerFaceColor','g','MarkerEdgeColor','g');
end
box off
axis square
xlabel('\rho')
ylabel('\delta')


subplot(2,5,2)
plot(realRho(:),miniDipp(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); 
hold on
if multirep ~= 0
     plot(realRhoRand(:),miniDippRand(:),'o','MarkerSize',5,'MarkerFaceColor','g','MarkerEdgeColor','g');
end
box off
axis square
xlabel('\rho')
ylabel('miniDipp')

subplot(2,5,3)
plot(realRho(:),funnymeasure(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on
if multirep ~= 0
plot(realRhoRand(:),funnymeasureRand(:),'o','MarkerSize',5,'MarkerFaceColor','g','MarkerEdgeColor','g');
end

col = jet(length(clusterCentersSortedIdx));
invCol = flipud(col);

for n = 1 : length(clusterCentersSortedIdx)

plot(realRho(clusterCentersSortedIdx(n)),funnymeasure(clusterCentersSortedIdx(n)),'o','MarkerSize',5,'MarkerFaceColor',invCol(n,:),'MarkerEdgeColor',invCol(n,:))
end

axis square
xlabel('\rho')
ylabel('-miniDipp/\rho + 1')

subplot(2,5,4)
plot(funnymeasureSorted(1:numbPointsToShow),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on
if multirep ~= 0
 plot(funnymeasureRandSorterAvr(1:numbPointsToShow),'o','MarkerSize',5,'MarkerFaceColor','g','MarkerEdgeColor','g');   
end
box off
axis square
xlabel('Sorted points')
ylabel('-miniDipp/\rho + 1')

if multirep ~= 0
subplot(2,5,5)
plot(diffFunnymeasure(1:numbPointsToShow),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on

box off
axis square
xlabel('Sorted points')
ylabel('-miniDipp/\rho + 1')

subplot(2,5,6)
plot(diffFunnymeasureDiv(1:numbPointsToShow),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on

box off
axis square
xlabel('Sorted points')
ylabel('-miniDipp/\rho + 1')

subplot(2,5,7)
plot(diffdiffFunnymeasureDiv(1:numbPointsToShow),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on

box off
axis square
xlabel('Sorted points')
ylabel('-miniDipp/\rho + 1')



subplot(2,5,8)
plot(jumpFunymeasure(1:numbPointsToShow),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on

box off
axis square
xlabel('Sorted points')
ylabel('-miniDipp/\rho + 1')

subplot(2,5,9)

scatter(data(:,1),data(:,2),5,rho,'filled')
axis square


subplot(2,5,10)
% plot3(dataRand(:,1),dataRand(:,2),dataRand(:,3),'.')
 scatter(dataRand(:,1),dataRand(:,2),5,rhoRand,'filled')
axis square



end

end