AddFunctionToPath

% close all
clear all

 %%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat file format
%2) applies automatic based density peak clustering for a determined dc


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
%%%%%%%%%%%% calcualte paarameters of data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcuate data densities
distancesData = pdist(data,'euclidean');
distanceSquare = squareform(distancesData);

% %find ind of percent of data
% percent = 1;
% position = round(length(distancesData)*percent/100);
% 
% sda = sort(distancesData);
% 
% dc = sda(position);
% 
% 
% [dataRho, delta,ordrho,nneigh] = calculateRhoAndDelta_2Mike(distanceSquare,dc);

densityType = 'local';

kdedens = kde(data',densityType);
dataRho = evaluate(kdedens,data');

densityDataAvr = nanmean(dataRho);


distancesDataSorted = sort(distancesData, 'descend');
dataRhoSorted = sort(dataRho, 'descend');
%%
%%%%%%%%%%%%%%%% resample distribution simplex method %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distancesData = pdist(data,'euclidean');

numbOfIterations = 5;


dataRandAll1 = zeros(size(data,1),size(data,2),numbOfIterations);
dataRandAll3 = zeros(size(data,1),size(data,2),numbOfIterations);

dataRhoRandAll1 = zeros(size(data,1),numbOfIterations);
dataRhoRandAll3 = zeros(size(data,1),numbOfIterations);

distancesRandAll1 = zeros(size(distancesData,2),numbOfIterations);
distancesRandAll3 = zeros(size(distancesData,2),numbOfIterations);

dataRhoRandAvr1 = zeros(1,numbOfIterations);
dataRhoRandAvr3 = zeros(1,numbOfIterations);

distancesRandAll1Sorted = zeros(size(distancesData,2),numbOfIterations);
distancesRandAll3Sorted = zeros(size(distancesData,2),numbOfIterations);

dataRhoRandAll1Sorted = zeros(size(data,1),numbOfIterations);
dataRhoRandAll3Sorted = zeros(size(data,1),numbOfIterations);

dataRhoRandAvr1Sorted = zeros(1,numbOfIterations);
dataRhoRandAvr3Sorted = zeros(1,numbOfIterations);




for n = 1 : numbOfIterations
tic
    n
    
doPlot = 0;

[dataRand1] = resampleDistribution_3(data,size(data,1),doPlot);

[dataRand2] = resampleDistribution_simplex2(data,size(data,1),dataRho,doPlot);


%%
%%%%%%%%%% resample distribution onion method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% scallingFactor = 1;



[dataRand3] = resampleDensityMatching(dataRho,size(data,2));

%not doing nothing at this point
% dataRand3 = dataRand2*scallingFactor;

% plot(dataRand2(:,1),dataRand2(:,2), '.g')
% hold on
% plot(data(:,1),data(:,2),'.k')
% axis square
% box off
% axis([-7 7 -7 7])

%%
%%%%%%%%%%%%%%% calulate distribution parameters %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %calulate local densities 
distancesRand1 = pdist(dataRand1,'euclidean');
distancesRand2 = pdist(dataRand2,'euclidean');
distancesRand3 = pdist(dataRand3,'euclidean');

%  distanceSquare1 = squareform(distancesRand1);
% distanceSquare3 = squareform(distancesRand3);
% 
% 
%  [dataRhoRand1, delta,ordrho,nneigh] = calculateRhoAndDelta_2Mike(distanceSquare1,dc);
% [dataRhoRand3, delta,ordrho,nneigh] = calculateRhoAndDelta_2Mike(distanceSquare3,dc);

clearvars kdedens
kdedensRand1 = kde(dataRand1',densityType);
dataRhoRand1 = evaluate(kdedensRand1,dataRand1');

clearvars kdedens kdedensRand1
kdedensRand2 = kde(dataRand2',densityType);
dataRhoRand2 = evaluate(kdedensRand2,dataRand2');

clearvars kdedens kdedensRand1 kdedensRand2
kdedensRand3 = kde(dataRand3',densityType);
dataRhoRand3 = evaluate(kdedensRand3,dataRand3');

clearvars kdedens kdedensRand1 kdedensRand2 kdedensRand3





dataRandAll1(:,:,n,:) = dataRand1;
dataRandAll2(:,:,n,:) = dataRand2;
dataRandAll3(:,:,n,:) = dataRand3;


dataRhoRandAll1(:,n) = dataRhoRand1;
dataRhoRandAll2(:,n) = dataRhoRand2;
dataRhoRandAll3(:,n) = dataRhoRand3;

distancesRandAll1(:,n) = distancesRand1;
distancesRandAll2(:,n) = distancesRand2;
distancesRandAll3(:,n) = distancesRand3;

dataRhoRandAll1Sorted(:,n) = sort(dataRhoRand1,'descend');
dataRhoRandAll2Sorted(:,n) = sort(dataRhoRand2,'descend');
dataRhoRandAll3Sorted(:,n) = sort(dataRhoRand3,'descend');

distancesRandAll1Sorted(:,n) = sort(distancesRand1,'descend');
distancesRandAll2Sorted(:,n) = sort(distancesRand2,'descend');
distancesRandAll3Sorted(:,n) = sort(distancesRand3,'descend');


dataRhoRandAvr1(n) = nanmean(dataRhoRand1);
dataRhoRandAvr2(n) = nanmean(dataRhoRand2);
dataRhoRandAvr3(n) = nanmean(dataRhoRand3);


% nanmean(dataRho)

toc
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 3;
maxBar = max(dataRho);


figure
subplot(1,4,1)
scatter(data(:,1),data(:,2),5,dataRho,'filled')
axis square
box off
axis([-7 7 -7 7])
caxis([0 maxBar])
xlabel('Dim 1')
ylabel('Dim 2')


subplot(1,4,2)
scatter(dataRandAll1(:,1,n),dataRandAll1(:,2,n),5,dataRhoRandAll1(:,n),'filled')
axis square
box off
axis([-7 7 -7 7])
caxis([0 maxBar])
xlabel('Dim 1')
ylabel('Dim 2')

subplot(1,4,3)
scatter(dataRandAll2(:,1,n),dataRandAll2(:,2,n),5,dataRhoRandAll2(:,n),'filled')
axis square
box off
axis([-7 7 -7 7])
caxis([0 maxBar])
xlabel('Dim 1')
ylabel('Dim 2')



subplot(1,4,4)
scatter(dataRandAll3(:,1,n),dataRandAll3(:,2,n),5,dataRhoRandAll3(:,n),'filled')
axis square
box off
axis([-7 7 -7 7])
caxis([0 maxBar])
xlabel('Dim 1')
ylabel('Dim 2')

%%
%%%%%%%%%%%%%% calcualte averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



dataRhoRandAll1SortedAvr = nanmean(dataRhoRandAll1Sorted,2);
dataRhoRandAll2SortedAvr = nanmean(dataRhoRandAll2Sorted,2);
dataRhoRandAll3SortedAvr = nanmean(dataRhoRandAll3Sorted,2);

distancesRandAll1SortedAvr = nanmean(distancesRandAll1Sorted,2);
distancesRandAll2SortedAvr = nanmean(distancesRandAll2Sorted,2);
distancesRandAll3SortedAvr = nanmean(distancesRandAll3Sorted,2);

dataRhoRandAvr1Avr = nanmean(dataRhoRandAvr1,2);
dataRhoRandAvr2Avr = nanmean(dataRhoRandAvr2,2);
dataRhoRandAvr3Avr = nanmean(dataRhoRandAvr3,2);

% 
% dataRhoRandAll1SortedAStd = nanstd(dataRhoRandAll1Sorted)./sqrt(length(dataRhoRandAll1Sorted));
% dataRhoRandAll3SortedStd = nanstd(dataRhoRandAll3Sorted)./sqrt(length(dataRhoRandAll3Sorted));
% 
% distancesRandAll1SortedStd = nanstd(distancesRandAll1Sorted)./sqrt(length(distancesRandAll1Sorted));
% distancesRandAll3SortedStd = nanstd(distancesRandAll3Sorted)./sqrt(length(distancesRandAll3Sorted));
% 
% 
% dataRhoRandAvr1Std = nanstd(dataRhoRandAvr1)./sqrt(length(dataRhoRandAvr1));
% dataRhoRandAvr3Std = nanstd(dataRhoRandAvr3)./sqrt(length(dataRhoRandAvr3));
% 



dataRhoRandAll1SortedAStd = nanstd(dataRhoRandAll1Sorted);
dataRhoRandAll2SortedAStd = nanstd(dataRhoRandAll2Sorted);
dataRhoRandAll3SortedStd = nanstd(dataRhoRandAll3Sorted);

distancesRandAll1SortedStd = nanstd(distancesRandAll1Sorted);
distancesRandAll12SortedStd = nanstd(distancesRandAll2Sorted);
distancesRandAll3SortedStd = nanstd(distancesRandAll3Sorted);


dataRhoRandAvr1Std = nanstd(dataRhoRandAvr1);
dataRhoRandAvr2Std = nanstd(dataRhoRandAvr2);
dataRhoRandAvr3Std = nanstd(dataRhoRandAvr3);



% bar(0,areaOfAvoidanceHaloDarkAvr,500, 'w')
% errorbar(1000,areaOfAvoidanceHaloGrayAvr,areaOfAvoidanceHaloGrayStd,'color','k')
% 
 figure
subplot(1,3,1)
bar(1,densityDataAvr, 'w')
hold on
bar(2, dataRhoRandAvr1Avr , 'w')
bar(3, dataRhoRandAvr2Avr, 'w')
bar(4, dataRhoRandAvr3Avr, 'w')
% errorbar([2 3],[dataRhoRandAvr1Avr dataRhoRandAvr3Avr],[dataRhoRandAvr1Std dataRhoRandAvr3Std],'color','k')
axis square
box off
ylabel('Average local density')

subplot(1,3,2)
plot(distancesDataSorted, 'k')
hold on
plot(distancesRandAll1SortedAvr, 'g')
plot(distancesRandAll2SortedAvr, 'c')

plot(distancesRandAll3SortedAvr, 'r')
ylabel('Distance between points')
xlabel('#')

axis square
box off

subplot(1,3,3)
plot(dataRhoSorted, 'k')
hold on
plot(dataRhoRandAll1SortedAvr, 'g')
plot(dataRhoRandAll2SortedAvr, 'c')

plot(dataRhoRandAll3SortedAvr, 'r')

axis square
box off
ylabel('Local density')
xlabel('#')
