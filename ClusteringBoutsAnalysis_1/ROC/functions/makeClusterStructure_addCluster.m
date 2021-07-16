function [clusterStructure] = makeClusterStructure_addCluster(indStructure,minNumbClusterPoints,percClusterThres,corePerc,indToAddAllClusters,makeplot) 





%%
%%%%%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% minNumbClusterPoints = 100;
% percClusterThres = 0.10;
% corePerc = 15;


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
    dataThisDataSetRand = indStructure(n).boutDataPCASampleData;
%     dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbOfDims);

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

for nn = 1 : length(indStructure)
    counter
%       nn =2
%     nn =78
    clusterAssignment = indStructure(nn).clusterAssignment;
    indChoosenClusterCenters = indStructure(nn).indChoosenClusterCenters;
    
    percentageOfClusters = indStructure(nn).percentageOfClusters;
    numbOfClusters = indStructure(nn).numbOfClusters;
    boutDataPCASampleData = indStructure(nn).boutDataPCASampleData;
   
    
%     realRho = indStructure(nn).realRho;
    uniqueClusterAssignment = unique(clusterAssignment);
    
    clusterCenterVector = zeros(1,length(clusterAssignment));
    clusterCenterVector(indChoosenClusterCenters) = 1;
    
    
    for n  = 1 : length(uniqueClusterAssignment)
%          n =1
        indThisCluster = find(clusterAssignment == uniqueClusterAssignment(n));
        
        indChoosenClusterCentersInThisCluster = find(clusterCenterVector(indThisCluster) == 1);
        
        
        
%         indChoosenClusterCentersOrigianlInds = indChoosenClusterCenters(n);
        
        
        
        %%
        %%%%%%%%%% calculate cluster core by densities %%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if length(indThisCluster) > 2%avoid cluster with 1 point
       densityType = 'rot';
       
       
       kdedensThisCluster = kde( boutDataPCASampleData(indThisCluster,1:numbOfDims)',densityType);
       
       densitiesThisCluster = evaluate(kdedensThisCluster,boutDataPCASampleData(indThisCluster,1:numbOfDims)');
      
       percentile = prctile(densitiesThisCluster,corePerc);%15 works fine
    
       indsCore = find(densitiesThisCluster > percentile);
      
       indsCore2 = indThisCluster(indsCore);

       else
    
       indsCore2 = 1 : length(indThisCluster);

       end
       
       indChoosenClusterCentersInThisCore = find(clusterCenterVector(indsCore2) == 1);

        %%
        %%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        clusterStructure(counter).thisClusterOriginalInds = indThisCluster;
        clusterStructure(counter).indsCore = indsCore2;
        clusterStructure(counter).indsCoreInThisCluster = indsCore;

        clusterStructure(counter).indChoosenClusterCentersInThisCluster =  indChoosenClusterCentersInThisCluster;
        clusterStructure(counter).indChoosenClusterCentersInThisCore =  indChoosenClusterCentersInThisCore;

        clusterStructure(counter).boutDataPCASampleDataThisCluster = boutDataPCASampleData(indThisCluster,1:numbOfDims);
        clusterSizes(counter) = numbOfClusters(n);
        
        percentageOfClustersAll(counter) = percentageOfClusters(n);
        
        
        
        clusterCoreSizes(counter) = length(indsCore);
        clusterStructure(counter).bigDataSetNumber = nn;
        clusterStructure(counter).ClusterOfClusterCat =  0;
        
        %check if this dataset size rule should be not used
        TF = 0;
        for j = 1 : length(indToAddAllClusters)
            
            if counter == indToAddAllClusters(j)
                
               TF = 1; 
               
            end
            
        end
        
        
        if TF == 1
        clusterStructure(counter).ingnoreSizeClusterRule =  1;

        else
        clusterStructure(counter).ingnoreSizeClusterRule =  0;
 
        end
        counter = counter + 1;

    end
    
    
    
end




%%
%%%%%%%%%%%%% look at clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

thisClusterOriginalIndsAll = [];

for nn = 1 : length(clusterStructure)
    
        thisClusterOriginalInds = clusterStructure(nn).thisClusterOriginalInds;
        thisClusterOriginalIndsAll = [thisClusterOriginalIndsAll thisClusterOriginalInds];
        
    
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%% exclude small clusters   %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% counter = 1;

% figure
for n = 1 : length(clusterStructure)
n

    thisClusterOriginalInds = clusterStructure(n).thisClusterOriginalInds;

    indsCore = clusterStructure(n).indsCore;
    bigDataSetNumber = clusterStructure(n).bigDataSetNumber;
    ingnoreSizeClusterRule = clusterStructure(n).ingnoreSizeClusterRule;
  
    
    %% 
    %%%%%%%%%%% select big clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if length(indsCore) > minNumbClusterPoints && percentageOfClustersAll(n) > percClusterThres 
        
        
        clusterStructure(n).BigCluster = 1;


    else
        
        clusterStructure(n).BigCluster = 0;
 
%     end
%      pause
    end
    
    
    if  ingnoreSizeClusterRule == 1
        
         clusterStructure(n).BigCluster = 1;
    end
    
    
    
    
end



%%
%%%%%%%%%%%%%%%%%%%%%%% look at data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if makeplot == 1

figure
indAllDataPoints = [];
for n = 1 : length(clusterStructure)
   
  %get inds of cluster 1
%    thisClusterOriginalInds = clusterStructure((n)).indsCore;  
   BigCluster = clusterStructure((n)).BigCluster; 
   boutDataPCASampleDataThisCluster = clusterStructure((n)).boutDataPCASampleDataThisCluster;
%       indsCore = clusterStructure((n)).indsCore;


  if BigCluster == 1
  
       subplot(1,2,1)
  else
      
       subplot(1,2,2)

  end
  
  
%     plot3(boutDataPCASampleDataThisCluster(:,1),boutDataPCASampleDataThisCluster(:,2),boutDataPCASampleDataThisCluster(:,3), '.', 'color','k')
    plot3(boutDataPCASampleDataThisCluster(:,1),boutDataPCASampleDataThisCluster(:,2),boutDataPCASampleDataThisCluster(:,4), '.', 'color','k')
    hold on
    
    axis square
    
    if BigCluster == 1
        
       title('big clusters')
axis([-17 23 -10 15])
    else
        title('small clusters')
axis([-17 23 -10 15])

    end
    
end
end
