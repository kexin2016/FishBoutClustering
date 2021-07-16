%%
%%%%%%%%%%%%%% what does this do %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) choose number of cluster centers by choosing rectangle in gui


function [indChoosenClusterCenters] = decideClusterCenters_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure)

%%
%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tree = [];


%%
%%%%%%%%%%%% make decision plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(2,2,3)   
plot(data(:,1),data(:,2), 'k.')
axis square
xlabel('dim 1')
ylabel('dim 2')

% if makePlot == 1
  
    if ~isempty(tree)
    
   
subplot(2,2,4)
[~,~,perm] = dendrogram(tree);
axis square
axis([min(perm)-1 max(perm)+1 0 1]) 

    end

%make colors
col = jet(length(clusterCentersSortedIdx));
invCol = flipud(col);
    
subplot(2,2,2)
plot(realRho(:),funnymeasure(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k')
hold on


for n = 1 : length(clusterCentersSortedIdx)

plot(realRho(clusterCentersSortedIdx(n)),funnymeasure(clusterCentersSortedIdx(n)),'o','MarkerSize',5,'MarkerFaceColor',invCol(n,:),'MarkerEdgeColor',invCol(n,:))
% text(realRho(clusterCentersSortedIdx(n)),funnymeasure(clusterCentersSortedIdx(n))+0.02,num2str(n))
text(realRho(clusterCentersSortedIdx(n)),funnymeasure(clusterCentersSortedIdx(n))+0.02,num2str(clusterCentersSortedIdx(n)))

% pause

end

axis square
xlabel('\rho')
ylabel('-miniDipp/\rho + 1')
title('make square to choose cluster centers')    
axis([0 max(realRho), -0.1 1.1])   

subplot(2,2,1)
plot(realRho(:),funnymeasure(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k')
hold on
xlabel('\rho')
ylabel('-miniDipp/\rho + 1')
title('make square to choose cluster centers')    
axis([0 max(realRho), -0.1 1.1])   
axis square
% end

%%
%%%%%%%%%%%%% choose clusters by rect %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%choose rect with mouse
rect = getrect;   

xmin = rect(1);
ymin = rect(2);
width = rect(3);
height = rect(4);

%find cluster centers in rect
indChoosenClusterCenters = find(realRho > xmin & realRho < (xmin + width) & funnymeasure > ymin & funnymeasure < (ymin+height));

% figure
clf
subplot(2,2,3)   
plot(data(:,1),data(:,2), 'k.')
hold on
plot(data(indChoosenClusterCenters,1),data(indChoosenClusterCenters,2),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r')

axis square
xlabel('dim 1')
ylabel('dim 2')

subplot(2,2,1)
plot(realRho(:),funnymeasure(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k')
hold on
plot(realRho(indChoosenClusterCenters),funnymeasure(indChoosenClusterCenters),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r')
axis square
xlabel('\rho')
ylabel('-miniDipp/\rho + 1')
axis([0 max(realRho), -0.1 1.1]) 

subplot(2,2,2)
plot(realRho(:),funnymeasure(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k')
hold on


for n = 1 : length(indChoosenClusterCenters)
plot(realRho(indChoosenClusterCenters(n)),funnymeasure(indChoosenClusterCenters(n)),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r')

text(realRho(indChoosenClusterCenters(n)),funnymeasure(indChoosenClusterCenters(n))+0.02,num2str(n))
% pause

end
axis square
xlabel('\rho')
ylabel('-miniDipp/\rho + 1')
title('make square to choose cluster centers')    
axis([0 max(realRho), -0.1 1.1])   


if ~isempty(tree)
    
   
subplot(2,2,4)
[~,~,perm] = dendrogram(tree);
axis square
 axis([min(perm)-1 max(perm)+1 0 1]) 
hold on

%find dendrogram threshold
dendrogramThreshold = min(funnymeasure(indChoosenClusterCenters));

% line([0 dendrogramThreshold],[max(perm)+1 dendrogramThreshold])
line([0 max(perm)+1],[dendrogramThreshold dendrogramThreshold],'color','red')


end

