close all


numbDim =3;

%%
% %%%%%%%%%%%% calaculate percentage of bout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numbDim = 3;
% 
% for i = 1 : length(indStructure)%loop through each data set
%     
%    thisIndRand = indStructure(i).thisIndRand;
%     thisInds = indStructure(i).thisInds;
%     
%     funnymeasure = indStructure(i).funnymeasure;
%     realRho = indStructure(i).realRho;
%     indChoosenClusterCenters = indStructure(i).indChoosenClusterCenters;
%     clusterAssignment =  indStructure(i).clusterAssignment;
%     rho = indStructure(i).rho;
%     maxjump = indStructure(i).maxjump;
% 
%     dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbDim);
% 
%     uniqueClusterAssignment = unique(clusterAssignment);
%     
%     
%     %%
%     %%%%%%%%%%%%%%%% loop through each cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     percentageOfClusters = zeros(1,length(indChoosenClusterCenters));
%     numbOfClusters = zeros(1,length(indChoosenClusterCenters));
%     
%       for nn = 1 : length(indChoosenClusterCenters)
%           
%           
%         indThisCluster = find(clusterAssignment == uniqueClusterAssignment(nn)); 
%         
%         percentageOfClusters(nn) = length(indThisCluster)./length(thisIndRand);
%         numbOfClusters(nn) = length(indThisCluster);
%           
%       end
% 
%     
%     
% %%
% %%%%%%%%%%%% save cluster centers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% indStructure(i).percentageOfClusters = percentageOfClusters;
% indStructure(i).numbOfClusters = numbOfClusters;
% 
% 
% 
% 
% end

%%
%%%%%%%% indStructure map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indOMRTurns2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.OMRTurns2))';%1-13
% indOMRSpeed5 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.OMRSpeed5))';%14-23
% 
% indLightDark3min2 =  intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LightDark3min2))';%24-27
% 
% indMultiFlash3min1sManyInt = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt))';%28 dark; 29 light
% indMultiFlash3min1sManyInt3 =  intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt3))';%30 dark; 31 light
% 
% indmultiBeap200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap200Hz100ms3min))';%32
% indmultiBeap400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap400Hz100ms3min))';%33
% indmultiBeap600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap600Hz100ms3min))';%34
% indmultiBeap800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap800Hz100ms3min))';%35
% indmultiBeap1000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1000Hz100ms3min))';%36
% indmultiBeap1200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1200Hz100ms3min))'; %37
% indmultiBeap1400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1400Hz100ms3min))';%38
% indmultiBeap1600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1600Hz100ms3min))'; %39
% indmultiBeap1800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1800Hz100ms3min))';%40
% indmultiBeap2000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap2000Hz100ms3min))'; %41
% indmultiBeapFlash200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash200Hz100ms3min))'; %42
% indmultiBeapFlash400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash400Hz100ms3min))';%43
% indmultiBeapFlash600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash600Hz100ms3min))'; %44
% indmultiBeapFlash800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash800Hz100ms3min))';%45
% indmultiBeapFlash1000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1000Hz100ms3min))';%46
% indmultiBeapFlash1200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1200Hz100ms3min))';%47
% indmultiBeapFlash1400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1400Hz100ms3min))';%48
% indmultiBeapFlash1600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1600Hz100ms3min))';%49
% indmultiBeapFlash1800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1800Hz100ms3min))';%50
% indmultiBeapFlash2000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash2000Hz100ms3min))';%51
% 
% indBeeps200to2000 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.Beeps200to2000))';%32 - 51
% indFlashBeeps200to2000 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.FlashBeeps200to2000))';%32 - 51
% 
% indPhototaxis4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.Phototaxis4))';%52 with obends; 53 no obends
% 
% indPreyCapture = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCapture))';%54-55
% indPreyCaptureNaive = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCaptureNaive))';%56-57
% indSpontanousEyeTracking = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontanousEyeTracking))';%58-59
% 
% indBeepsLightDarkEyeConv = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.BeepsLightDarkEyeConv))';%60 - 64
% indBigCircleDiferentDirections2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.bigCircleDiferentDirections2))';%65 to 72
% indLoomingDiferentSpeeds = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LoomingDiferentSpeeds))';%73 to 78

% %multiFish data
% indSpontaneousMultiFishGray = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishGray))';%79 - 82
% indSpontaneousMultiFishBlack2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontaneousMultiFishBlack2))';%83 to 86




%% omr turns
%                   indDataSet = [1 2 3 4 5 6 7 8 9 10 11 12 13];

%% omr speed
%                         indDataSet = [14 15 16 17 18 19 20 21 22 23];

%% simone 3 min light dark
%            indDataSet = [24 25 26 27 28];
% exclude 26

%% beeps
%      indDataSet = [29:38];   

%% flash beeps
             indDataSet =  [39:48];   
    
%% phototaxis
%          indDataSet =  [49 50];   

%% prey capture all fish 
%                 indDataSet =  [51 53  55]; 

%% prey capture spont
%  indDataSet =  [52 54 56];

%% looming directions

%     indDataSet =  [57:63];

%% looming speeds
%         indDataSet =  [65:70];

%% spont multifish gray
%        indDataSet =  [71:74];

%% spont multifish dark
%          indDataSet =  [75:78];

%% light transitions Dark
%           indDataSet =  [79:88];

%% light transitions light
%     indDataSet =  [89:96];


%% rot data unconv - not conv
%     indDataSet =  [97 101 105];


%% rot data unconv - conv bouts
%      indDataSet =  [98 99 100 102 103 104 106 107 108];

%% rot data tu naive Rita -  not conv
% indDataSet = [109];

%% rot data tu naive Rita - conv  bouts
% indDataSet = [110 111 112];


%% rot data strain - not conv
%       indDataSet =  [113 117 121 125 129];

%% rot data strain -  conv bouts
%      indDataSet =  [114 115 116 118 119 120 122 123 124 126 127 128 130 131 132];



%%
%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  indDataSet =1:18;
%  n = indDataSet;

%   indDataSet = [79 :1: 86,[118 133]];
%  n = indDataSet


%          indDataSet = 129;

for i = 1:length(indDataSet)%length(indStructure)%loop through each data set
         figure

%       clf
    thisIndRand = indStructure(indDataSet(i)).thisIndRand;
    thisInds = indStructure(indDataSet(i)).thisInds;
    
    funnymeasure = indStructure(indDataSet(i)).funnymeasure;
    realRho = indStructure(indDataSet(i)).realRho;
    indChoosenClusterCenters = indStructure(indDataSet(i)).indChoosenClusterCenters;
    clusterAssignment =  indStructure(indDataSet(i)).clusterAssignment;
    rho = indStructure(indDataSet(i)).rho;
    maxjump = indStructure(indDataSet(i)).maxjump;
    pointAssignmentMethod = indStructure(indDataSet(i)).pointAssignmentMethod;
    percentageOfClusters = indStructure(indDataSet(i)).percentageOfClusters;
    numbOfClusters = indStructure(indDataSet(i)).numbOfClusters;
    
    
    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbDim);

    uniqueClusterAssignment = unique(clusterAssignment);
    col = jet(length(indChoosenClusterCenters));

   %%
   %%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   numberOfBouts2 =500;
   thisDatasetInds = 1:length(dataThisDataSetRand);
   if size(thisDatasetInds,2) >  numberOfBouts2
      %pick random bouts
    indPerm = randperm(length(thisDatasetInds));
    thisIndRandThis = thisDatasetInds(indPerm(1:numberOfBouts2));
   
   else
       thisIndRandThis = thisDatasetInds;
   end
    
    clf
    subplot(1,3,1)
    plot(realRho,funnymeasure, '.k')
    hold on
    
    subplot(1,3,3)
    plot(dataThisDataSetRand(thisIndRandThis,1),dataThisDataSetRand(thisIndRandThis,2), '.k')
    axis square
    box off
    xlabel('dim 1')
    ylabel('dim 1')
%     title(indDataSet(i))
    axis([-17 22 -10 20])
    hold on
 
    for nn = 1 : length(indChoosenClusterCenters)
       
    indThisCluster = find(clusterAssignment == uniqueClusterAssignment(nn));    
        
    subplot(1,3,1)
    plot(realRho(indChoosenClusterCenters(nn)),funnymeasure(indChoosenClusterCenters(nn)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(nn,:),'MarkerSize',10) 
    axis square
    hold on
    line([0 max(realRho)],[0 0],'color','r')
    text(realRho(indChoosenClusterCenters(nn)),funnymeasure(indChoosenClusterCenters(nn))+0.02,num2str(indChoosenClusterCenters(nn)))
    axis([0 max(realRho) -0.1 1])
%     title(percentageOfClusters)
    
    subplot(1,3,2)
%     plot3(dataThisDataSetRand(indThisCluster,1),dataThisDataSetRand(indThisCluster,2),realRho(indThisCluster), '.', 'color', col(nn,:))
%     plot(dataThisDataSetRand(indThisCluster,1),realRho(indThisCluster), '.', 'color', col(nn,:))
    plot(dataThisDataSetRand(indThisCluster,1),dataThisDataSetRand(indThisCluster,2), '.', 'color', col(nn,:))

    
    hold on
%     plot3(dataThisDataSetRand(indChoosenClusterCenters(nn),1),dataThisDataSetRand(indChoosenClusterCenters(nn),2),realRho(indChoosenClusterCenters(nn)),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',col(nn,:))
    
%     plot(dataThisDataSetRand(indChoosenClusterCenters(nn),1),realRho(indChoosenClusterCenters(nn)),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',col(nn,:))
    plot(dataThisDataSetRand(indChoosenClusterCenters(nn),1),dataThisDataSetRand(indChoosenClusterCenters(nn),2),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',col(nn,:))

    axis square
    box off
    xlabel('dim 1')
    ylabel('dim 1')
%     title(indDataSet(i))
%     axis([-17 22 -10 20 0 max(realRho)]) 
%          axis([-17 22 0 max(realRho)]) 
     axis([-17 22 -10 20 ]) 


    
    
    end
%     title([indDataSet(i) numbOfClusters])
     title(indDataSet(i))
%     title(length(thisInds))
               pause
    
end

indChoosenClusterCenters


%%
% %%%%%%%%%%%%% choose only good data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  indDataSet = sort([1:23, 32:41, 42:51,52:53,[54 56 58],[27 28 30],[24 55 57 59],25,65:72,79:82,83:86]);
% 
%  indToExclude = setdiff(1:length(indStructure), indDataSet)
%  indStructure(indToExclude) = [];
%  
%              save('ClusterAssignment_AllData_74Kins3dims_1.75Smooth_slow_3000_square_until86_Good.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')
% 
