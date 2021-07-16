% AddFunctionToPath
% 
% close all
% clear all

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
% matlabpool open 3
% 


%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) loads dataset - it has to be in correct mat file format
%2) applies density valley clustering

%%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%import olivettifaces.mat - faces
%import distances_olivetti.mat - distances calculate by Rodriguez paper...

 %data_distances = data(:,3);
%%
%%%%%%%%%%%%%% transform into square %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
olivettiDistancesSq = reshape(data_distances,[sqrt(length(data_distances)),sqrt(length(data_distances))]);

groundTruth = [];
for n = 1 : 40

    vectorNumb = zeros(1,10) + n;
    
    groundTruth = [groundTruth vectorNumb];


end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% do tsne %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbDims = 3;
% initial_dims = length(olivettiDistancesSq);
% perplexity = 7;
% perplexity = 7;
perplexity = 7;
% landmarksperplexity = 7; = 1;


 
tic
data = tsne_d(olivettiDistancesSq, [], numbDims, perplexity);
toc



if  size(data,2) == 2
    figure
 subplot(1,2,1)
scatter(data(:,1),data(:,2),10,'k')
axis square

 subplot(1,2,2)
scatter(data(:,1),data(:,2),10,groundTruth)
axis square
end

if  size(data,2) == 3
 figure


 subplot(1,2,1)
scatter3(data(:,1),data(:,2),data(:,3),10,'k')
axis square

 subplot(1,2,2)
scatter3(data(:,1),data(:,2),data(:,3),10,groundTruth)
axis square
end


data = data;

inf.Name = 'Olivetti_tsne_4.mat';
inf.numbPoints = 400;
inf.numbClusters = 40;
inf.NumberDim = numbDims;
inf.tSnePerplexity = perplexity;
inf.pictureSize =  4096;

%%
% %%%%%%%%%%%%%%%%%% sava data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%     save(inf.Name, 'data','data_distances','groundTruth','inf','faces','p','u','v')
%  
% 
%     data = data;
    

%%
%%%%%%%%%%%%%%%% load Olivetti_tsne_4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%
% %%%%%%%%%%%%% calcualte densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kdedens = [];
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
% %%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% adjustBW(kdedens,originalBandWidths);
% 
% 
% % densityType = 'localp';
% makeplot = 0;
% scallingFactor = 1.75;
% 
% [kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT(data,kdedens,scallingFactor,densityType,makeplot);

%%
%%%%%%%%%%%% calculate funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

densityType = 'localp';
kdedens = [];
linedensityMethod = 'slowPar';
%  linedensityMethod = 'fastPar';

numextra = sqrt(length(data));
nsamps = 10;
multirep = 100;
makeplot = 0;
numbPointsToShow = 100;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why
resampleMethod = 'onion';
% scallingFactor = 1.75;
scallingFactor = 1.75;

tic
% [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,...
    funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAllOnion,diffFunnymeasure,jumpFunymeasure] = ...
    findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,...
    clusterThreshold,resampleMethod,scallingFactor,makeplot);

toc

resampleMethod = 'simplex';

% [rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
[rho,realRho,delta,funnymeasure,funnymeasureSorted,kdedens,kdedensRand,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,...
    funnymeasureRandSorterAvr,clusterCentersSortedIdx,funnymeasureRandSortedAllSimplex,diffFunnymeasure,jumpFunymeasure] = ...
    findClusterCentersDensityValley_6(data,kdedens,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,...
    clusterThreshold,resampleMethod,scallingFactor,makeplot);

toc



%%
%%%%%%%%%%%%%%% calculate threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[val, ind] = min(diff(funnymeasureSorted(1:100)));
    
    if ind == 1
       ind = 2 ;
    end


funnymeasureBigDiffThreshold1 = funnymeasureSorted(ind);

ICSimplex = prctile(funnymeasureRandSortedAllSimplex(:,2),99);
ICOnion = prctile(funnymeasureRandSortedAllOnion(:,2),99);


% figure
% hist(funnymeasureRandSortedAllSimplex(:,2),15)

%%
%%%%%%%%%%%%%% do dendrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxNumbOfClusterCenters = length(clusterCentersSortedIdx)+1;
%   maxNumbOfClusterCenters=50
makePlot = 0;
pointAssignmentMethod = 'distance2';
lowDensityCutOff = 0;

[tree,clusterAssignmentAll,perm] = makeDendrogramByCenterExclusion_2(data,funnymeasure,maxNumbOfClusterCenters,rho,realRho,maxjump,pointAssignmentMethod,lowDensityCutOff,clusterCentersSortedIdx,makePlot);


% clusterFunnymeasure  = tree(:,3);
% figure
% [n,xout] = hist(diff(clusterFunnymeasure));
% plot(xout, n)
% axis square
% % pause



%%
%%%%%%%%%%%%%%% no halo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

haloVector = zeros(1,length(groundTruth));

%%
%%%%%%%%%%%%%% calculate rTrue rFalse for all numbers of clusters %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clusterAssignmentAll = zeros(1,length(data),length(clusterCentersSortedIdx));
groundTruthAll = zeros(1,length(data),length(clusterCentersSortedIdx));
rTrue = zeros(1,length(clusterCentersSortedIdx));
rFalse = zeros(1,length(clusterCentersSortedIdx));

%  pointAssignmentMethod = 'distance';
 pointAssignmentMethod = 'distance2';
% pointAssignmentMethod = 'pooledDensity2';

for i = 1 : length(clusterCentersSortedIdx)

    indChoosenClusterCenters = clusterCentersSortedIdx(1:i);
    
% %%
% %%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %             pointAssignmentMethod = 'pooledDensity2';
% %                      pointAssignmentMethod = 'distance';
%                pointAssignmentMethod = 'distance2';
% 
% makeplot = 0;
% % tic
% [clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);
% % toc 

%%
%%%%%%%%%%% make point assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             pointAssignmentMethod = 'pooledDensity2';
%                      pointAssignmentMethod = 'distance';

makeplot = 0;
% tic
[clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);
% toc 

clusterAssignmentAll(:,:,i) = clusterAssignment;
groundTruthAll(:,:,i) = groundTruth;


%%
%%%%%%%%%%%%%%%%% calcualte rTrue and rFalse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 makeplot = 0;
%  [rTrue,rFalse] = rTrue_rFalse_Estimator_1(groundTruthAll(:,:,54),clusterAssignmentAll(:,:,54),makeplot);
 
 [rTrue(i),rFalse(i)] = rTrue_rFalse_Estimator_3(groundTruthAll(:,:,i),clusterAssignmentAll(:,:,i),haloVector,makeplot);


%%
%%%%%%%%%%%%%%%%%%%%%%%%check choosing inds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot(realRho(:),funnymeasure(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k')
% hold on
% plot(realRho(indChoosenClusterCenters),funnymeasure(indChoosenClusterCenters),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r')
% 
% xlabel('\rho')
% ylabel('-miniDipp/\rho + 1')
% title('make square to choose cluster centers')    
% axis([0 max(realRho), -0.1 1.1])   
% axis square
% % end
%     pause
 


    
end


%%
%%%%%%%%%%%%%%%%%% 26 clusters case %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 40;

%determine only correct clusters 
    indChoosenClusterCenters = clusterCentersSortedIdx(1:i);

%                pointAssignmentMethod = 'distance2';

makeplot = 0;
% tic
[clusterAssignment] = assignDataPointsAllCases_1(data,indChoosenClusterCenters,rho,maxjump,pointAssignmentMethod,makeplot);






%%
%%%%%%%%%%%%%%%%%% make Figure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ICSimplex = 0
indClusterCentersHogherThanThres = find(funnymeasure(clusterCentersSortedIdx)> ICSimplex);

figure
subplot(1,3,1)
plot(rho,funnymeasure, 'ko','markerfacecolor','k','markersize',5)
hold on
plot(rho(clusterCentersSortedIdx(indClusterCentersHogherThanThres)),funnymeasure(clusterCentersSortedIdx(indClusterCentersHogherThanThres)), 'go','markerfacecolor','g','markersize',5)
plot(rho(clusterCentersSortedIdx(1:40)),funnymeasure(clusterCentersSortedIdx(1:40)), 'ro','markerfacecolor','r','markersize',5)
plot(rho(clusterCentersSortedIdx(1:30)),funnymeasure(clusterCentersSortedIdx(1:30)), 'bo','markerfacecolor','b','markersize',5)

line([0 max(rho)],[ICOnion ICOnion], 'color','g')
line([0 max(rho)],[ICSimplex ICSimplex], 'color',[255 204 0]/255)

axis square
ylabel('Separability index')
xlabel('\rho')
box off


subplot(1,3,2)
H = dendrogram(tree,maxNumbOfClusterCenters);
set(H,'color','k')
hold on
line([0 size(tree,1)+10],[ICOnion ICOnion], 'color','g')
line([0 size(tree,1)+10],[ICSimplex ICSimplex], 'color',[255 204 0]/255)

axis square
ylabel('Separability index')
box off


rFalseInv = wrev(rFalse);
rTrueInv = wrev(rTrue);

subplot(1,3,3)
% plot(rFalseInv,rTrueInv, 'ko','markerfacecolor','k','markersize',5)
hold on
plot(rFalse,rTrue, 'ko','markerfacecolor','k','markersize',5)

plot(rFalseInv(length(indClusterCentersHogherThanThres)),rTrueInv(length(indClusterCentersHogherThanThres)),'o','MarkerSize',10,'MarkerFaceColor','g','MarkerEdgeColor','g')
plot(rFalseInv(40),rTrueInv(40),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r')
plot(rFalseInv(30),rTrueInv(30),'o','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','b')

xlabel('rFalse')
ylabel('rTrue')

axis([0 5 0 100])
axis square
% title([rFalse(40),rTrue(40)])
xlabel('rFalse')
ylabel('rTrue')
box off

%%
%%%%%%%%%%%%%%%% plot faces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%nake colors for faces
col = jet(length(indChoosenClusterCenters));
inperm = randperm(length(col));
col = col(inperm,:);

colorFaceAll = zeros(20*64,20*64,3);
counterStart1 = 1;
counterStart2 = 1;
counterEnd1 = 64;
counterEnd2 = 64;
counter = 1;

for n = 1 :20% size(faces,2)
    n
    
    counterStart1 = 1;
    counterEnd1 = 64;

for nn = 1 :20% size(faces,2)

thisFace = reshape(faces(:,counter),64,64);

 thisAssignment = clusterAssignment(counter);
% thisAssignment = groundTruth(counter);

thisColor = col(thisAssignment,:);

%give color to face
colorFace = cat(3,thisFace*thisColor(1)/255,thisFace*thisColor(2)/255,thisFace*thisColor(3)/255);


colorFaceAll(counterStart2:counterEnd2,counterStart1:counterEnd1,:) = colorFace;

counter = counter +1;
counterStart1 = counterStart1 + 64;
counterEnd1 = counterEnd1 + 64;
end

counterStart2 = counterStart2 + 64;
counterEnd2 = counterEnd2 + 64;


end



figure
imagesc(colorFaceAll)
colormap gray
axis square

% figure
% imagesc(facesSquare)
% colormap gray
% axis square

