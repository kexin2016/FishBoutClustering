% AddFunctionToPath
% 
%  close all
% clear all
% 
% 
 %%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse
% %FinalClustering_AllData_74Kins3dims_1.75Smooth_medium_100thres_tsne_1.mat
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));

%%
%%%%%%%%%%%%% clear variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clearvars clusterStructure indStructure

%%
%%%%%%%%%%%%% get data from final clustering struct%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

thisIndRandFinalAll = finalClustering.indsBoutMapInAllData;

originalBandWidths = finalClustering.originalBandWidths;
kdedens = finalClustering.kdedens;

bandWidthsScalled = finalClustering.bandWidthsScalled;
scallingFactor = finalClustering.scallingFactor;

rho = finalClustering.rho;
realRho = finalClustering.realRho;
delta  = finalClustering.delta;
funnymeasure = finalClustering.funnymeasure;
funnymeasureSorted = finalClustering.funnymeasureSorted;
maxjump =  finalClustering.maxjump;

pointAssignmentMethod = finalClustering.pointAssignmentMethod;
clusterAssignment = finalClustering.clusterAssignment;
indChoosenClusterCenters = finalClustering.indChoosenClusterCenters;
percentOfHalo = finalClustering.percentOfHalo;
col = finalClustering.colorMap;
mapData = finalClustering.dataToDoMap;

%%
%%%%%%%%%%%% label broken bouts as part of halo %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataToAssign = boutDataPCASample(:,1:3);
coreVectorAllData = zeros(1,length(dataToAssign));  


brokenBouts = BoutInf(:,EnumeratorBoutInf.brokenBouts);
doubleBout = BoutInf(:,EnumeratorBoutInf.doubleBout);
firstSegmentWithAnyMistake = BoutInf(:,EnumeratorBoutInf.firstSegmentWithAnyMistake);
mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);


indBrokenBouts = find(brokenBouts == 1);
indDoubleBouts = find(doubleBout == 1);
indTailError = find(firstSegmentWithAnyMistake <=5);
indMistakesIn74KinSpace = find(mistakesIn74KinSpace == 1);

indAllErroes = [indBrokenBouts',indDoubleBouts',indTailError',indMistakesIn74KinSpace']';


% coreVectorAllData(indAllErroes) = 1;

% %plot all data
% figure
% plot3(dataToAssign(:,1),dataToAssign(:,2),dataToAssign(:,3),'k.')
% hold on
% plot3(dataToAssign(indAllErroes,1),dataToAssign(indAllErroes,2),dataToAssign(indAllErroes,3),'ro')

percentOfMistakes = length(indAllErroes)./length(dataToAssign)*100;



%%
%%%%%%%%%%%%% create core %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignment = unique(clusterAssignment);
coreVector = zeros(1,length(clusterAssignment));
haloPerc = 5;

% haloPerc = [5 17 14 14 5 5 5 5 5 14]
% haloPerc = [5 5 5 5 5 5 5 5 5 5]

figure
subplot(1,2,1)
plot3(mapData(:,1),mapData(:,2),mapData(:,3), 'k.')
hold on
axis square

subplot(1,2,2)
plot3(mapData(:,1),mapData(:,2),rho, 'k.')
hold on
axis square

  col = ([102 255 255; 255 170 0; 220 0 220;255 255 0; 255 0 50; 250 128 114;105 255 102;0 150 255; 0 0 200;0 153 0])./255;

for n = 1 : length(uniqueClusterAssignment)
% n =1
    indThisCluster = find(clusterAssignment == uniqueClusterAssignment(n));
    
%     densityType = 'rot';
%        
%        tic
%        kdedensThisCluster = kde( mapData(indThisCluster,1:3)',densityType);
%        
%        densitiesThisCluster = evaluate(kdedensThisCluster,mapData(indThisCluster,1:3)');
%        toc


      densitiesThisCluster = rho(indThisCluster);
%     hist(rho(indThisCluster),30)
    percentile = prctile(densitiesThisCluster,haloPerc);%15 works fine
    
    
    
    indsCore = find(densitiesThisCluster > percentile);
    indsCoreOriginal = indThisCluster(indsCore);
    
    coreVector(indsCoreOriginal) = 1;
     
     
     %make plot
     subplot(1,2,1)
     plot3(mapData(indsCoreOriginal,1),mapData(indsCoreOriginal,2),mapData(indsCoreOriginal,3),  '.', 'color', col(n,:))
     hold on

     subplot(1,2,2)
    plot3(mapData(indsCoreOriginal,1),mapData(indsCoreOriginal,2),rho(indsCoreOriginal), '.', 'color', col(n,:))
    hold on
    axis square
%  pause

end


%%
%%%%%%%%%%%%%%%%% assign all data points batch %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clusterAssignmentAllData = zeros(1,length(dataToAssign));


numbBatch = 10000;
resto = rem(length(dataToAssign),numbBatch);


%start inds
indStart = 0 : numbBatch: (length(dataToAssign) - resto);
indStart(1) = 1;

%end inds
indEnd = indStart(2:end) + 1;
indEnd(length(indStart)) = size(boutDataPCASample,1); 

makeplot = 0;

for i = 1 : length(indStart) 
i
    dataToAssignBatch = dataToAssign(indStart(i):indEnd(i),1:3);

    %assign clusters
    [clusterAssignmentBatch] = assignAllDataPointsByDistance_4(dataToAssignBatch,mapData,clusterAssignment,makeplot);


    
    %assign core
    [coreVectorBatch] = assignAllDataPointsByDistance_4(dataToAssignBatch,mapData,coreVector,makeplot);

    
    %put assignment in vectors
    clusterAssignmentAllData(indStart(i):indEnd(i)) = clusterAssignmentBatch;
    coreVectorAllData(indStart(i):indEnd(i)) = coreVectorBatch;


end



%%
%%%%%%%%%%%% look at assigments %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueClusterAssignmentAllData = unique(clusterAssignmentAllData);

sizeClustersInAllData = zeros(1,length(uniqueClusterAssignmentAllData));
sizeClustersInAllDataCore = zeros(1,length(uniqueClusterAssignmentAllData));

%put mistakes as halo
coreVectorAllData(indAllErroes) = 0;
indCore = find(coreVectorAllData == 1);


 figure
% subplot(1,2,1)
% plot3(dataToAssign(:,1),dataToAssign(:,2),dataToAssign(:,3),'k.')
% hold on
% axis square
%  axis([-25 30 -10 25 -10 50])   
 

for nn = 1 : length(uniqueClusterAssignmentAllData)

indThisCluster = find(clusterAssignmentAllData == uniqueClusterAssignmentAllData(nn));

   numbBoutsToPick = length(indThisCluster);
%    numbBoutsToPick = 5000;

indPerm = randperm(length(indThisCluster));
indThisClusterRand = indThisCluster(indPerm(1:numbBoutsToPick));
    
   
   
indThisClusterRandCore = intersect(indCore,indThisClusterRand);
   

subplot(1,2,1)
plot3(dataToAssign(indThisClusterRand,1),dataToAssign(indThisClusterRand,2),dataToAssign(indThisClusterRand,3),'k.')

hold on
plot3(dataToAssign(indThisClusterRandCore,1),dataToAssign(indThisClusterRandCore,2),dataToAssign(indThisClusterRandCore,3),'.','color',col(nn,:))

axis square
 axis([-25 30 -10 25 -10 50])   

subplot(1,2,2)
hold on
plot3(dataToAssign(indThisClusterRandCore,1),dataToAssign(indThisClusterRandCore,2),dataToAssign(indThisClusterRandCore,3),'.','color',col(nn,:))
hold on
axis square
axis([-25 30 -10 25 -10 10])   

hold on

sizeClustersInAllData(nn) = length(indThisClusterRand);
sizeClustersInAllDataCore(nn) = length(indThisClusterRandCore);


end




percentageOfCore = (length(indCore)./length(dataToAssign))*100



%%
%%%%%%%%%%%%% Add data to boutInf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutInf(:,EnumeratorBoutInf.boutCat) = clusterAssignmentAllData;
BoutInf(:,EnumeratorBoutInf.coreBout) = coreVectorAllData;
finalClustering.haloPercInAllDataAssignment = haloPerc;

save('BoutCat_AllData_74Kins3dims_1.75Smooth_medium_100thres_tsne_4.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','clusterStructure','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNans','groupClusterSctructure','finalClustering','-v7.3')


