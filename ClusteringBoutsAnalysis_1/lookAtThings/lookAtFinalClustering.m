


%%
%%%%%%%%%%%%%%%% get things out structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


thisIndRandFinalAll = finalClustering.indsBoutMapInAllData;

originalBandWidths = finalClustering.originalBandWidths;
kdedens = finalClustering.kdedens;

bandWidthsScalled = finalClustering.bandWidthsScalled;
scallingFactor = finalClustering.scallingFactor;

rho = finalClustering.rho;
realRho = finalClustering.realRho;
delta = finalClustering.delta;
funnymeasure = finalClustering.funnymeasure;
funnymeasureSorted = finalClustering.funnymeasureSorted;
maxjump = finalClustering.maxjump;

pointAssignmentMethod = finalClustering.pointAssignmentMethod;
clusterAssignment = finalClustering.clusterAssignment;
indChoosenClusterCenters = finalClustering.indChoosenClusterCenters;


%%
%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%  col = ([ 0 0 255; 255 170 0;0 153 0; 255 255 0;255 0 50; 220 0 220;105 255 102;250 128 114; 0 200 200; 102 255 255])./255;

%  col = ([102 255 255; 255 170 0; 220 0 220; 255 0 50; 250 128 114;105 255 102; 0 0 255;0 200 200;0 153 0;255 255 0])./255;
% col = finalClustering.colorMap;
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

uniqueClusterAssignment = unique(clusterAssignment);

 figure
% subplot(1,3,1)
% plot(rho, funnymeasure, '.k')
% axis square
% hold on
% subplot(1,3,2)
% plot(rho, funnymeasure, '.k')
% axis square


for n = 1 : length(uniqueClusterAssignment)
    
    
   indThisCluster =  clusterAssignment == uniqueClusterAssignment(n);
   
%    subplot(1,3,1)
%    plot(rho(indChoosenClusterCenters(n)), funnymeasure(indChoosenClusterCenters(n)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',10)
%    hold on
%    xlabel('Local density')
%    ylabel('-minidip/\rho +1')
    subplot(1,3,1)
   plot3(boutDataPCASample(thisIndRandFinalAll(indThisCluster),1), boutDataPCASample(thisIndRandFinalAll(indThisCluster),2),boutDataPCASample(thisIndRandFinalAll(indThisCluster),3), '.k')
   hold on
   axis square
   xlabel('PC 1')
   ylabel('PC 2')
   zlabel('PC 3')

   
   subplot(1,3,2)
   plot3(boutDataPCASample(thisIndRandFinalAll(indThisCluster),1), boutDataPCASample(thisIndRandFinalAll(indThisCluster),2),boutDataPCASample(thisIndRandFinalAll(indThisCluster),3), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',5)
   hold on
   axis square
   xlabel('PC 1')
   ylabel('PC 2')
   zlabel('PC 3')

   subplot(1,3,3)
   plot3(boutDataPCASample(thisIndRandFinalAll(indThisCluster),1), boutDataPCASample(thisIndRandFinalAll(indThisCluster),2),rho((indThisCluster)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(n,:),'MarkerSize',5)
   hold on
   axis square
   xlabel('PC 1')
   ylabel('PC 2')
   zlabel('Local density')


%     pause
end