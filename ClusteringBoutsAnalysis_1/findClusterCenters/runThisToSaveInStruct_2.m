%%
%%%%%%%%%%%% find number of dimentions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandWidthsScalled2 = indStructure(1).bandWidthsScalled;

numbOfDims =  size(bandWidthsScalled2,1);



%%

close all

%   n =     indDataSet
indStructure(n).indChoosenClusterCenters = indChoosenClusterCenters;

indStructure(n).clusterAssignment = clusterAssignment;


indStructure(n).pointAssignmentMethod = pointAssignmentMethod;


%%
%%%%%%%%%%%%calculate percentage of each cluster in data set %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numbOfDims = 3;
for nnn = 1 : length(indStructure)%loop through each data set
    
   thisIndRand = indStructure(nnn).thisIndRand;
    thisInds = indStructure(nnn).thisInds;
    
    funnymeasure = indStructure(nnn).funnymeasure;
    realRho = indStructure(nnn).realRho;
    indChoosenClusterCenters = indStructure(nnn).indChoosenClusterCenters;
    clusterAssignment =  indStructure(nnn).clusterAssignment;
    rho = indStructure(nnn).rho;
    maxjump = indStructure(nnn).maxjump;

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

    
    

%%%%%%%%%%%% save cluster centers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indStructure(nnn).percentageOfClusters = percentageOfClusters;
indStructure(nnn).numbOfClusters = numbOfClusters;




end


%%
% %%%%%%%%%%%%%%%% if densities hwere changed %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% indStructure(n).kdedens =  kdedens;
% indStructure(n).originalBandWidths = originalBandWidths;
% indStructure(n).densities = densities;
% indStructure(n).thisIndRand = thisIndRand;
% 
% indStructure(n).kdedensCutOff = kdedensCutOff;
% indStructure(n).bandWidthsScalled = bandWidthsScalled;
% indStructure(n).densitiesScalled = densitiesScalled;
% indStructure(n).scallingFactor = scallingFactor;    
%     
% indStructure(n).rho = rho;
% indStructure(n).realRho = realRho;
% indStructure(n).delta = delta;
% indStructure(n).maxjump = maxjump;
% indStructure(n).funnymeasure = funnymeasure;
% indStructure(n).clusterCentersSortedIdx = clusterCentersSortedIdx;
% indStructure(n).funnymeasureRandThreshold = funnymeasureRandThreshold;
    

%%
%%%%%%%%%%%%%%% save choosen cluster centers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        save('C:\Joao analysis\FreeData\preyCaptureData\ClusterAssignment\ClusterAssignment_preyCatureRot_74Kins3dim_slow_3000_auto_withDiffEyeConv_corr.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')



%%
%%%%%%%%%%%%%% check if I skipped any data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = length(indStructure)
    
    indChoosenClusterCenters = indStructure(i).indChoosenClusterCenters;
    
    if isempty(indChoosenClusterCenters)
    
    disp(i)
    end
    
    
end