
function [indChoosenClusterCenters] = decideClusterCentersAll_2(data,tree,clusterCentersSortedIdx,realRho,funnymeasure,decisionMethod)
%%
%%%%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this function decides cluster centers by choosing a level on the
%dendrogram of clusters

%%
%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% decisionMethod = 'square';
% decisionMethod = 'dendrogram';



%%
%%%%%%%%%%%%% switch 2 methods %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch decisionMethod
    
    case 'dendrogram'

if isempty(tree)%if dendrogram was not made do square anyway
    
    [indChoosenClusterCenters] = decideClusterCentersSquare_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
    
else
    
    [indChoosenClusterCenters] = decideClusterCentersByDendrogramGap_2(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
    
end



    case 'square'

     [indChoosenClusterCenters] = decideClusterCentersSquare_2(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
    
   
     
    case 'allClusterCenters'  
        
        indChoosenClusterCenters = clusterCentersSortedIdx;
        
    case 'allExcludeOutliers'
        
        
     [indChoosenClusterCenters] = decideClusterCentersLine_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);
end



