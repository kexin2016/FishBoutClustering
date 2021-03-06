
function [indChoosenClusterCenters] = decideClusterCentersByDendrogramGap_2(data,tree,clusterCentersSortedIdx,realRho,funnymeasure)
%%
%%%%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this function decides cluster centers by choosing a level on the
%dendrogram of clusters

%%
%%%%%%%%%%%%%% inputs
%clusterCentersSortedIdx
%data
%%
%%%%%%%%%%%%%%%%%%%%% calulate funnymeasure jumps %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%get funnymeasures of the possibe cluster centers
clusterFunnymeasure = funnymeasure(clusterCentersSortedIdx);

%calculate jumps - add zero at end to test possibility of all clusters to be true
clusterFunnymeasureDiff = [abs(diff([clusterFunnymeasure 0]))];

%%
%%%%%%%%%%%%%%%%%%% find jumps in dedrogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%threshold if there would be no levels in dedrogram - uniform distribution
normThreshold = sum(clusterFunnymeasureDiff)./length(clusterFunnymeasureDiff);

%find gaps in dendrogram
indGaps = find(clusterFunnymeasureDiff > normThreshold);
gapsVals = clusterFunnymeasureDiff(indGaps);

%%
%%%%%%%%%%%%%% caculate normalized gap %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

normalizedGap = (clusterFunnymeasureDiff - normThreshold) / ( max(clusterFunnymeasureDiff) - normThreshold );



%%
%%%%%%%%%%%%%%%%%%%%%% make initial plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%make decision plot 
figure
subplot(2,2,1)
plot(realRho(:),funnymeasure(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k')
hold on
xlabel('\rho')
ylabel('-miniDipp/\rho + 1')
axis([0 max(realRho), -0.1 1.1])   
axis square


%make funnymeasure plot

subplot(2,2,2)
hold on
plot(clusterFunnymeasure, '-k')
hold on
line([0 length(clusterFunnymeasure)+1],[normThreshold normThreshold],'color','green')
plot(1:length(clusterFunnymeasure),clusterFunnymeasure, 'k.')
plot(1:length(clusterFunnymeasureDiff),clusterFunnymeasureDiff, '-b.')

plot(1:length(clusterFunnymeasureDiff),clusterFunnymeasureDiff, 'b.')
axis square

%make 2D data plot
subplot(2,2,3)

if size(data,2) == 1%case of 1D data
    
  [nData, xData]= hist(data,size(data,1)./10) ;
  plot(xData,nData, '-k')
  axis square
  
else %more than 2d 
    
plot(data(:,1),data(:,2), 'k.')
axis square
xlabel('dim 1')
ylabel('dim 2')

end


subplot(2,2,4)
[~,~,perm] = dendrogram(tree, length(clusterFunnymeasure));
axis([min(perm)-1 max(perm)+1 0 1]) 

axis square
 for ii = 1 : length(indGaps)
 
     
     line([0, length(clusterFunnymeasure)+1],[clusterFunnymeasure(indGaps(ii)), clusterFunnymeasure(indGaps(ii))],'color',[normalizedGap(indGaps(ii)) 0 0])
% plot(indGaps,clusterFunnymeasure(indGaps), 'o','color',[fractionGap(ii),0,0])
%  plot(indGaps(ii),clusterFunnymeasure(indGaps(ii)), 'o','color',[gapsVals(indGaps(ii)),0,0])
% plot(indGaps(ii),clusterFunnymeasure(indGaps(ii)), 'o','color',col(idx(ii),:))

 end
 title('click on line to choose number of clusters')
% subplot(1,2,2)

%%
%%%%%%%%%%%%% choose clusters by clicking near correct line %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%click once
[~,yClick] = ginput(1);

[~,indGapsChoosen,~] = findnearest(yClick,clusterFunnymeasure(indGaps));

indChoosenClusterCenters = clusterCentersSortedIdx(1:indGaps(indGapsChoosen));


%%
%%%%%%%%%%%%%%%%% make plots after decisions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clf
%make decision plot 
subplot(2,2,1)
plot(realRho(:),funnymeasure(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k')
hold on
plot(realRho(indChoosenClusterCenters),funnymeasure(indChoosenClusterCenters),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r')
xlabel('\rho')
ylabel('-miniDipp/\rho + 1')
axis([0 max(realRho), -0.1 1.1])   
axis square


%make funnymeasure plot
subplot(2,2,2)
hold on
plot(clusterFunnymeasure, '-k')
hold on
line([0 length(clusterFunnymeasure)+1],[normThreshold normThreshold],'color','green')
plot(1:length(clusterFunnymeasure),clusterFunnymeasure, 'k.')
plot(1:indGaps(indGapsChoosen),clusterFunnymeasure(1:indGaps(indGapsChoosen)),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r')



plot(1:length(clusterFunnymeasureDiff),clusterFunnymeasureDiff, '-b.')
plot(1:length(clusterFunnymeasureDiff),clusterFunnymeasureDiff, 'b.')

plot(indGaps(indGapsChoosen),clusterFunnymeasureDiff(indGaps(indGapsChoosen)),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r')

axis square

%make 2D data plot
subplot(2,2,3)

if size(data,2) == 1%case of 1D data
    
  [nData, xData]= hist(data,size(data,1)./10) ;
  plot(xData,nData, '-k')
  hold on
%   line([],[],'color','red')
  axis square
  
else %more than 2d 
    
plot(data(:,1),data(:,2), 'k.')
hold on
plot(data(indChoosenClusterCenters,1),data(indChoosenClusterCenters,2),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r')

axis square
xlabel('dim 1')
ylabel('dim 2')

end

%make dendrogram with level lines
subplot(2,2,4)
[~,~,perm]  = dendrogram(tree, length(clusterFunnymeasure));
axis([min(perm)-1 max(perm)+1 0 1]) 

axis square
%  for ii = 1 : length(indGaps)
%  
%      
%      line([0, length(clusterFunnymeasure)+1],[clusterFunnymeasure(indGaps(ii)), clusterFunnymeasure(indGaps(ii))],'color',[normalizedGap(indGaps(ii)) 0 0])
% % plot(indGaps,clusterFunnymeasure(indGaps), 'o','color',[fractionGap(ii),0,0])
% %  plot(indGaps(ii),clusterFunnymeasure(indGaps(ii)), 'o','color',[gapsVals(indGaps(ii)),0,0])
% % plot(indGaps(ii),clusterFunnymeasure(indGaps(ii)), 'o','color',col(idx(ii),:))
% 
%  end
      line([0, length(clusterFunnymeasure)+1],[clusterFunnymeasure(indGaps(indGapsChoosen)), clusterFunnymeasure(indGaps(indGapsChoosen))],'color','red')


 title(length(indChoosenClusterCenters))
% subplot(1,2,2)