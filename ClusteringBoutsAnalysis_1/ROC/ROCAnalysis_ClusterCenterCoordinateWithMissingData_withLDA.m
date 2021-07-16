%%%%%%%%%%%%% what this function does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) import data with assigned clusters: ex: ClusterAssignmentPreliminaryData74Kins3dimWithCutOffMedium_moreDevided.mat
%2) organize data by each cluster


 %%

% AddFunctionToPath

 close all
clear all


 %%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));

%3d
%  load('C:\Joao analysis\FreeData\clusteringData\assignAllData\final\BoutCat_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto_final.mat');

% %4d
   load('C:\Joao analysis\FreeData\clusteringData\assignAllData\final\BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc.mat');
% 
%%
%%%%%%%%%%%%%%% exclude repeated datasets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%exclude simone light dark and eye beeps
% indExclude = [24 25 26 60 61 62 63 64];

% %exclude simone light dark and eye beeps and prey capture single fish
% indExclude1 = [24 25 26 60 61 62 63 64];
% %  indExclude2 = 87:1:103;
% %  indExclude3 = 104:1:115;
% 
%  indExclude = [indExclude1 indExclude2 indExclude3];
% 
% indStructure(indExclude) = [];


%%
% %%%%%%%%%%%%%%%%%%%% look at clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% for nn = 1 : length(indStructure)
%    nn = 10;
% clusterAssignment = indStructure(nn).clusterAssignment;
% indChoosenClusterCenters = indStructure(nn).indChoosenClusterCenters;
% 
% 
% thisIndRand = indStructure(nn).thisIndRand;
% realRho = indStructure(nn).realRho;
% uniqueClusterAssignment = unique(clusterAssignment);
% thisInds = indStructure(nn).thisInds;
% 
% col = jet(length(uniqueClusterAssignment));
% 
%  clf
% for n  = 1 : length(uniqueClusterAssignment)
% 
%     
%     indThisCluster = find(clusterAssignment == uniqueClusterAssignment(n));
%     
%     
% plot3(boutDataPCASample(thisIndRand(indThisCluster),1),boutDataPCASample(thisIndRand(indThisCluster),2),realRho(indThisCluster), '.', 'color',col(n,:))
% hold on
% plot3(boutDataPCASample(thisIndRand(indChoosenClusterCenters(n)),1),boutDataPCASample(thisIndRand(indChoosenClusterCenters(n)),2),realRho(indChoosenClusterCenters(n)),'o','MarkerSize',10,'MarkerFaceColor',col(n,:),'MarkerEdgeColor','k')
% 
% axis square
%     axis([-17 22 -10 20 0 max(realRho)])     
% 
% %  pause
% end
% 
% 
% 
% pause
% end


%%
%%%%%%%%%%%% determine number of dims of data set %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandWidthsScalled2 = indStructure(1).bandWidthsScalled;

numbOfDims =  size(bandWidthsScalled2,1);
%  numbOfDims =  3;




%%
%%%%%%%%%%%%%%%%% fix this ind rand %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for u = 1 : length(indStructure)
    
%     u =78
   thisIndRand =  indStructure(u).thisIndRand;
    
    if size(thisIndRand,2) > 1
        
        thisIndRand = thisIndRand';
        
    end
    
     indStructure(u).thisIndRand = thisIndRand;
    
end


%%
%%%%%%%%%%%%calculate percentage of each cluster in data set %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for n = 1 : length(indStructure)%loop through each data set
    
   thisIndRand = indStructure(n).thisIndRand;
    thisInds = indStructure(n).thisInds;
    
    funnymeasure = indStructure(n).funnymeasure;
    realRho = indStructure(n).realRho;
    indChoosenClusterCenters = indStructure(n).indChoosenClusterCenters;
    clusterAssignment =  indStructure(n).clusterAssignment;
    rho = indStructure(n).rho;
    maxjump = indStructure(n).maxjump;

    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbOfDims);

    uniqueClusterAssignment = unique(clusterAssignment);
    
    
    %%
    %%%%%%%%%%%%%%%% loop through each cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    percentageOfClusters = zeros(1,length(indChoosenClusterCenters));
    numbOfClusters = zeros(1,length(indChoosenClusterCenters));
    
      for nn = 1 : length(indChoosenClusterCenters)
          
          
        indThisCluster = find(clusterAssignment == uniqueClusterAssignment(nn)); 
        
        percentageOfClusters(nn) = length(indThisCluster)./length(thisIndRand);
        numbOfClusters(nn) = length(indThisCluster);
          
      end

    
    
%%
%%%%%%%%%%%% save cluster centers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indStructure(n).percentageOfClusters = percentageOfClusters;
indStructure(n).numbOfClusters = numbOfClusters;




end



%%
%%%%%%%%%% make structure with clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clusterStructure = [];
counter = 1;
clusterSizes = [];
percentageOfClustersAll = [];

for nn = 2 : length(indStructure)
    counter
    
%     nn =78
    clusterAssignment = indStructure(nn).clusterAssignment;
    indChoosenClusterCenters = indStructure(nn).indChoosenClusterCenters;
    
    thisIndRand = indStructure(nn).thisIndRand;
    percentageOfClusters = indStructure(nn).percentageOfClusters;
    numbOfClusters = indStructure(nn).numbOfClusters;
    
%     realRho = indStructure(nn).realRho;
    uniqueClusterAssignment = unique(clusterAssignment);
    
    for n  = 1 : length(uniqueClusterAssignment)
%         n =1
        indThisCluster = find(clusterAssignment == uniqueClusterAssignment(n));
        
        
        thisClusterOriginalInds = thisIndRand(indThisCluster);
        indChoosenClusterCentersOrigianlInds = thisIndRand(indChoosenClusterCenters(n));
        
        
        
        %%
        %%%%%%%%%% calculate cluster core by densities %%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if length(thisClusterOriginalInds) > 2%avoid cluster with 1 point
       densityType = 'rot';
       
       tic
       kdedensThisCluster = kde( boutDataPCASample(thisClusterOriginalInds,1:numbOfDims)',densityType);
       
       densitiesThisCluster = evaluate(kdedensThisCluster,boutDataPCASample(thisClusterOriginalInds,1:numbOfDims)');
       toc
       percentile = prctile(densitiesThisCluster,15);%15 works fine
    
       indsCore = find(densitiesThisCluster > percentile);
       
       indsCore2 = thisClusterOriginalInds(indsCore);
       
       else
    
       indsCore2 = thisClusterOriginalInds;
        end
       
        
        
%     figure
%         plot3(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2),boutDataPCASample(thisClusterOriginalInds,3), '.k')
%         hold on   
%          plot3(boutDataPCASample(indsCore2,1),boutDataPCASample(indsCore2,2),boutDataPCASample(indsCore2,3), '.r')
% %         plot3(boutDataPCASample(thisClusterOriginalInds(indsCore),1),boutDataPCASample(thisClusterOriginalInds(indsCore),2),boutDataPCASample(thisClusterOriginalInds(indsCore),3), '.r')
% 
%         
        
        
        %%
        %%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         if counter == 27
%            pause 
%         end
        
        clusterStructure(counter).thisClusterOriginalInds = thisClusterOriginalInds;
        clusterStructure(counter).indsCore = indsCore2;
        clusterStructure(counter).indChoosenClusterCentersOrigianlInds =  indChoosenClusterCentersOrigianlInds;
         
        clusterSizes(counter) = numbOfClusters(n);
        
        percentageOfClustersAll(counter) = percentageOfClusters(n);
        
        
        
        clusterCoreSizes(counter) = length(indsCore);
        clusterStructure(counter).bigDataSetNumber = nn;
        clusterStructure(counter).ClusterOfClusterCat =  0;
        counter = counter + 1;

    end
    
    
    
end

figure
subplot(1,2,1)
plot(sort(clusterSizes,'descend'), '.')
hold on
plot(sort(clusterCoreSizes,'descend'), 'r.')
axis square

subplot(1,2,2)
plot(sort(percentageOfClustersAll,'descend'), '.')
axis square

% pause


%%
%%%%%%%%%%%%% look at clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

thisClusterOriginalIndsAll = [];

for nn = 1 : length(clusterStructure)
    
        thisClusterOriginalInds = clusterStructure(nn).thisClusterOriginalInds;
        thisClusterOriginalIndsAll = [thisClusterOriginalIndsAll' thisClusterOriginalInds']';
        
    
end

% figure
% for nn = 1 : length(clusterStructure)
% 
%             thisClusterOriginalInds = clusterStructure(nn).thisClusterOriginalInds;
% clf 
%         plot(boutDataPCASample(thisClusterOriginalIndsAll,1),boutDataPCASample(thisClusterOriginalIndsAll,2), '.k')
%         hold on
%         plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.r')
% title(nn)
%     
%     pause
% end


%%
%%%%%%%%%%%%%%%%%%%%%%%%%% exclude small clusters   %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = jet(length(clusterStructure));
minNumbClusterPoints = 40;
% clusterStructure = [];
percClusterThres = 0.10;

counter = 1;

% figure
for n = 1 : length(clusterStructure)
n

    thisClusterOriginalInds = clusterStructure(n).thisClusterOriginalInds;
    indChoosenClusterCentersOrigianlInds = clusterStructure(n).indChoosenClusterCentersOrigianlInds;

    indsCore = clusterStructure(n).indsCore;
    bigDataSetNumber = clusterStructure(n).bigDataSetNumber;

    %%
    %%%%%%%%%%%%% Add escapes even if small %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %escapes

%escapes + obends and good fast bouts
% %       if n == 59 || n == 61 || n == 65 || n == 69 || n == 73 ||n == 79 || n == 92 || n == 96 || n == 102 || n == 110 || n == 113 || n == 116 || n == 118 || n == 121 || n == 126 || n == 131 || n == 133 || n == 137 || n == 139 || n == 142 || n == 144 || n == 147 || n == 150 || n == 152 || n == 155 || n == 158 || n == 161 || n == 166 || n == 171 || n == 173 || n == 180
% 
%           indPerm = randperm(length(indsCore));
%     thisIndRand = indsCore(indPerm(1:length(indsCore)));
%     
% %      plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),boutDataPCASample(thisIndRand,3), '.', 'color',col(n,:))
%          plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),boutDataPCASample(thisIndRand,3), '.', 'color','k')
% %  plot(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), '.', 'color',col(n,:))
% 
%     hold on
%     axis square
% axis([-17 22 -10 20 -6 8])     
% title(n)
%         
%         clusterStructure(n).BigCluster = 1;

        
        
%     else
    
    %% 
    %%%%%%%%%%% select big clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if length(indsCore) > minNumbClusterPoints && percentageOfClustersAll(n) > percClusterThres 
        
%      indPerm = randperm(length(indsCore));
%     thisIndRand = indsCore(indPerm(1:minNumbClusterPoints));
    
% %      plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),boutDataPCASample(thisIndRand,3), '.', 'color',col(n,:))
%          plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),boutDataPCASample(thisIndRand,3), '.', 'color','k')
% %  plot(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2), '.', 'color',col(n,:))
% 
%     hold on
%     axis square
% axis([-17 22 -10 20 -6 8])     
% title(n)
        
        clusterStructure(n).BigCluster = 1;


    else
        
        clusterStructure(n).BigCluster = 0;
 
%     end
%      pause
    end
end




%%
%%%%%%%%%%% Add small good clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for
% ClusterAssignment_AllDataWithTransitions_74Kins3dims_1.75Smooth_slow_3000_square_manySlow3.mat

% indObends = [92 98 99 126 131 397 453 477 489 490 491 494 496 499 501 505 507 514 519 521 532 535 536 540 542 550 554 555 559 609 610];

% for f = 1 : length(indFastBouts)
%     
% clusterStructure(indFastBouts(f)).BigCluster = 1;
% 
% end
% 
% for f = 1 : length(indObends)
%     
% clusterStructure(indObends(f)).BigCluster = 1;
% 
% end
% 
% 
% for f = 1 : length(indEscapes)
%     
% clusterStructure(indEscapes(f)).BigCluster = 1;
% 
% end
% 
% for f = 1 : length(indLLE)
%     
% clusterStructure(indLLE(f)).BigCluster = 1;
% 
% end

% indExclude = [10 125 247]; 
% for f = 1 : length(indExclude)
%     
% clusterStructure(indExclude(f)).BigCluster = 0;
% 
% end


%%
%%%%%%%%%%%%% look at small clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

thisClusterOriginalIndsAll = [];

for nn = 1 : length(clusterStructure)
    
        thisClusterOriginalInds = clusterStructure(nn).thisClusterOriginalInds;
        thisClusterOriginalIndsAll = [thisClusterOriginalIndsAll' thisClusterOriginalInds']';
        
    
end

% figure
bigClustersCount = zeros(1,length(clusterStructure));
for nn = 1 : length(clusterStructure)

    
        BigCluster = clusterStructure(nn).BigCluster;
        
        if BigCluster == 1

            thisClusterOriginalInds = clusterStructure(nn).thisClusterOriginalInds;
%  clf 
%         plot(boutDataPCASample(thisClusterOriginalIndsAll,1),boutDataPCASample(thisClusterOriginalIndsAll,2), '.k')
%         hold on
%         plot(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2), '.r')
% title(nn)
%      pause
         bigClustersCount(nn) = 1; 

       end
end

indBigClusters = find(bigClustersCount == 1);
sizeOfROCMatrix = length(indBigClusters);

%%
%%%%%%%%%%% look at choosen data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure
indAllDataPoints = [];
for n = 1 : length(bigClustersCount)
   
  %get inds of cluster 1
   thisClusterOriginalInds = clusterStructure((n)).indsCore;  

  if bigClustersCount(n) == 1
  
    subplot(1,2,1)
  else
      
          subplot(1,2,2)

  end
  
  
    plot3(boutDataPCASample(thisClusterOriginalInds,1),boutDataPCASample(thisClusterOriginalInds,2),boutDataPCASample(thisClusterOriginalInds,3), '.', 'color','k')
    hold on
    indAllDataPoints = [indAllDataPoints' thisClusterOriginalInds']';
    axis square
    if bigClustersCount(n) == 1
        
       title('big clusters')

    else
        title('small clusters')

    end
    
end


disp('done')
length(indBigClusters)
pause

%%
%%%%%%%%% calculated Projected ROC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ROCareaNormDimProj = zeros(sizeOfROCMatrix,sizeOfROCMatrix);
ROCareaNormDimProjInd1 = zeros(sizeOfROCMatrix,sizeOfROCMatrix);
ROCareaNormDimProjInd2 = zeros(sizeOfROCMatrix,sizeOfROCMatrix);

counter1 = 1;
% counter2 = 1;

 for n = 1 : length(indBigClusters)
 
n  
% n =2



%get inds of cluster 1
 thisClusterOriginalInds1 = clusterStructure(indBigClusters(n)).indsCore;
 
 bigDataSetNumber1 = clusterStructure(indBigClusters(n)).bigDataSetNumber;
 
% thisClusterOriginalInds1 = clusterBigStructure(n).thisClusterOriginalInds;

indChoosenClusterCentersOrigianlInds1 = clusterStructure(indBigClusters(n)).indChoosenClusterCentersOrigianlInds;



tic
for nn = (n+1) : length(indBigClusters)
% nn =1
% nn
%get inds of cluster 2
 thisClusterOriginalInds2 = clusterStructure(indBigClusters(nn)).indsCore;
% thisClusterOriginalInds2 = clusterBigStructure(nn).thisClusterOriginalInds;

 bigDataSetNumber2 = clusterStructure(indBigClusters(nn)).bigDataSetNumber;


indChoosenClusterCentersOrigianlInds2 = clusterStructure(indBigClusters(nn)).indChoosenClusterCentersOrigianlInds;

if bigDataSetNumber1 ~= bigDataSetNumber2

    %%
    %%%%%% calculate proj vector by line between center of mass %%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% %make joint vector unit
% point1 = [];
% point2 = [];
% 
% for y = 1:numbOfDims
%     
%     point1 = [point1' boutDataPCASample(indChoosenClusterCentersOrigianlInds1,y)']';
%     point2 = [point2' boutDataPCASample(indChoosenClusterCentersOrigianlInds2,y)']';
% 
%     
% end
% 
% point1 = point1';
% point2 = point2';
% 
% 
% % point1 = [boutDataPCASample(indChoosenClusterCentersOrigianlInds1,1) boutDataPCASample(indChoosenClusterCentersOrigianlInds1,2) boutDataPCASample(indChoosenClusterCentersOrigianlInds1,3)];
% % point2 = [boutDataPCASample(indChoosenClusterCentersOrigianlInds2,1) boutDataPCASample(indChoosenClusterCentersOrigianlInds2,2) boutDataPCASample(indChoosenClusterCentersOrigianlInds2,3)];
% 
% joinvector=point2-point1;
% joinvector=joinvector/sqrt(sum(power(joinvector,2)));
% 
% % if unique(isnan(joinvector)) == 1
% %     
% % end

%%
%%%%%%%%%%% pick same amount of bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    numbOfPoints = min(length(thisClusterOriginalInds1),length(thisClusterOriginalInds2));

    %pick random bouts
    indPerm1 = randperm(length(thisClusterOriginalInds1));
    thisIndRand1 = thisClusterOriginalInds1(indPerm1(1:numbOfPoints));
    
    indPerm2 = randperm(length(thisClusterOriginalInds2));
    thisIndRand2 = thisClusterOriginalInds2(indPerm2(1:numbOfPoints));
    
    cluster1 = boutDataPCASample(thisIndRand1,1:numbOfDims);
    cluster2 = boutDataPCASample(thisIndRand2,1:numbOfDims);

%%
% %%%%%%%%%%% use all bouts  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     cluster1 = boutDataPCASample(thisClusterOriginalInds1,1:numbOfDims);
%     cluster2 = boutDataPCASample(thisClusterOriginalInds2,1:numbOfDims);
% 
    
    
%%
%%%%%%%%%%%%%% calcualte proj vector by LDA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



groundTruth = [zeros(size(cluster1,1),1);ones(size(cluster2,1),1)];
clusterAll = [cluster1' cluster2']';


[joinvector] = fisher_training(clusterAll,groundTruth);



%%
% %%%%%%%%%% use all distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %make cluster projections
% cluster1 = boutDataPCASample(thisClusterOriginalInds1,1:3);
% cluster2 = boutDataPCASample(thisClusterOriginalInds2,1:3);

%%
%%%%%%%%%%%%%%% make proj cluster norm number of  points%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%use equal amount of points to do ROC
clusterProj1 = cluster1*joinvector;
clusterPorj2 = cluster2*joinvector;

bothClusteraTogetherProj = [clusterProj1' clusterPorj2']';

indsClusters = [(zeros(1,length(clusterProj1))-1) (zeros(1,length(clusterPorj2))+1)];

%%
%%%%%%%%%%%%%%% make proj cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %use all points to do ROC
% clusterAll1 = boutDataPCASample(thisClusterOriginalInds1,1:numbOfDims);
% clusterAll2 = boutDataPCASample(thisClusterOriginalInds2,1:numbOfDims);
% 
% clusterProj1 = clusterAll1*joinvector;
% clusterPorj2 = clusterAll1*joinvector;


%%
if unique(isnan(bothClusteraTogetherProj)) ~= 1%avoid same point bug...

[ROCareaDimProj,~,~,~,~,~,~,~,~] = roc_sv(bothClusteraTogetherProj,indsClusters,'nofigure');

% ROCareaNormDim1 = abs(ROCareaDim1 - 0.5) + 0.5;
% ROCareaNormDim2 = abs(ROCareaDim2 - 0.5) + 0.5;
% ROCareaNormDim3 = abs(ROCareaDim3 - 0.5) + 0.5;
ROCareaNormDimProj(n,nn) = abs(ROCareaDimProj - 0.5) + 0.5;

ROCareaNormDimProjInd1(n,nn) = indBigClusters(n);
ROCareaNormDimProjInd2(n,nn) = indBigClusters(nn);

else
   
ROCareaNormDimProj(n,nn) = nan;

ROCareaNormDimProjInd1(n,nn) = nan;
ROCareaNormDimProjInd2(n,nn) = nan;    
    
end

%%
% %%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clf
% 
% histClusterProj1 = hist(clusterProj1,-40:0.5:40);
% histClusterProj2 = hist(clusterPorj2,-40:0.5:40);
% 
% 
% subplot(1,2,1)
% plot3(cluster1(:,1),cluster1(:,2),cluster1(:,3), '.', 'color','b')
% hold on
% plot3(point1(:,1),point1(:,2),point1(:,3),'o','MarkerSize',10,'MarkerFaceColor','w','MarkerEdgeColor','k')
% plot3(cluster2(:,1),cluster2(:,2),cluster2(:,3), '.', 'color','r')
% plot3(point2(:,1),point2(:,2),point2(:,3),'o','MarkerSize',10,'MarkerFaceColor','w','MarkerEdgeColor','k')
% axis square
% xlabel('dim1')
% ylabel('dim2')
% zlabel('dim3')
% 
% subplot(1,2,2)
% plot(histClusterProj1,'-b')
% hold on
% plot(histClusterProj2,'-r')
% xlabel('project dim')
% title(ROCareaNormDimProj)
% axis square
% title(ROCareaNormDimProj(n,nn))
% pause

else

ROCareaNormDimProj(n,nn) = NaN;

ROCareaNormDimProjInd1(n,nn) = indBigClusters(n);
ROCareaNormDimProjInd2(n,nn) = indBigClusters(nn);
    
    
end


end
toc

end

%%
%%%%%%%%%%% reconstruct ROC matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ROCareaNormDimProjtest = ROCareaNormDimProj;
ROCareaNormDimProjInd1test = ROCareaNormDimProjInd1;
ROCareaNormDimProjInd2test = ROCareaNormDimProjInd2;

for  i = 1 : length(ROCareaNormDimProjtest)
    
    thisRow = ROCareaNormDimProjtest(i,i:end);
    thisRow1 = ROCareaNormDimProjInd1test(i,i:end);
    thisRow2 = ROCareaNormDimProjInd2test(i,i:end);
    
    ROCareaNormDimProjtest(i:end,i) = thisRow;
    ROCareaNormDimProjInd1test(i:end,i) = thisRow1;
    ROCareaNormDimProjInd2test(i:end,i) = thisRow2;



end 

for h = 1:length(ROCareaNormDimProjtest)
    
    ROCareaNormDimProjtest(h,h) = 0.5;
    
end


%%
%%%%%%%%%%% deal with missing values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ROCareaNormDimProjtest2 = ROCareaNormDimProjtest;

% ROCareaNormDimProjtest2(137,:) = [];
% ROCareaNormDimProjtest2(:,137) = [];
% 
ROCareaNormDimProjtestNoNans = knnimpute(ROCareaNormDimProjtest2,15);

% ROCareaNormDimProjtestNoNans = knnimpute(ROCareaNormDimProjtest,50);







%%
%%%%%%%%%%%%%% make essemble t-SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


numbOfTimes = 5;

numbDimsTsne = 3;
perplexity = 80;%initially 30... increase to make everything rounder
makeplot = 1;
densityType = 'local';
% scallingFactorGroupClusters = 2.2;
scallingFactorGroupClusters = 2;

linedensityMethod = 'slowPar';
pointAssignmentMethod = 'distance2';
% [groupClusterSctructure] = groupClusters_EssembleTSNE_function_1(ROCareaNormDimProjtestNoNans,boutDataPCASample,clusterStructure,numbOfTimes,numbDims,...
%     perplexity,densityType,scallingFactorGroupClusters,linedensityMethod,cutThreshold,makeplot);
distanceTsne = 1;


[groupClusterSctructureThis,essembleMatrix,essembleMatrixRand] = groupClusters_EssembleTSNE_function_4(ROCareaNormDimProjtestNoNans,numbOfTimes,numbDimsTsne,perplexity,densityType,scallingFactorGroupClusters,linedensityMethod,distanceTsne);

%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% make essemble t-SNE plot %%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cutThreshold = 50;
% numbDist =1;
% axisLim = [-15 25 -10 15];
% 
% [T2Rand,Z2Rand,essembleMatrixPermRand] = essemble_tSne_plot_5(essembleMatrixRand,boutDataPCASample,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,makeplot,axisLim);

cutThreshold = 15;
numbDist =1;
axisLim = [-17 25 -10 15];

[T2,Z2,essembleMatrixPerm,clusterStructure] = essemble_tSne_plot_7(essembleMatrix,boutDataPCASample,clusterStructure,groupClusterSctructureThis,cutThreshold,numbDist,makeplot,axisLim);

groupClusterSctructure.GroupClusyersMethod = 'essemble tsne_d';
groupClusterSctructure.perplexity = perplexity;
groupClusterSctructure.pointAssignmentMethodGroupClusters = pointAssignmentMethod;
groupClusterSctructure.cutThresholdDendrogram = cutThreshold;
groupClusterSctructure.essembleMatrixPerm = essembleMatrixPerm;
groupClusterSctructure.essembleMatrix = essembleMatrix;
groupClusterSctructure.essembleMatrixReorderingMethod = 'average';
groupClusterSctructure.essembleMatrixReorderingDistance = 'seuclidean';
groupClusterSctructure.essembleMatrixAssignment = T2;
groupClusterSctructure.essembleMatrixLinkageResult = Z2;
groupClusterSctructure.distributions = groupClusterSctructureThis;

groupClusterSctructure.essembleMatrixRand = essembleMatrixRand;
groupClusterSctructure.essembleMatrixAssignmentRand = T2Rand;
groupClusterSctructure.essembleMatrixLinkageResultRand = Z2Rand;
groupClusterSctructure.scallingFactorGroupClusters = scallingFactorGroupClusters;
groupClusterSctructure.numbDimsTsne = numbDimsTsne;

%%
%%%%%%%%%%%%%%%%% save essemble t-SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('GroupsClusters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_LDAROC.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','ROCareaNormDimProjtest','ROCareaNormDimProjtestNoNans','groupClusterSctructure','clusterStructure','-v7.3')




