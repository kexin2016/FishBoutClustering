% function [indChoosenClusterCenters] = decideClusterCentersByDendrogramGap_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure)

%decideClusterCentersByDendrogramGap_1

%%
%%%%%%%%%%%%%%%% data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clusterFunnymeasure  = tree(:,3);
clusterFunnymeasure = funnymeasure(clusterCentersSortedIdx);
% clusterFunnymeasure = [clusterFunnymeasure' 1]';

[n,xout] = hist(clusterFunnymeasure,25);
clusterFunnymeasureDiff = diff(clusterFunnymeasure);


[nDiff,xoutDiff] = hist(clusterFunnymeasureDiff,25);

normThreshold = sum(clusterFunnymeasureDiff)./length(clusterFunnymeasureDiff);

%find gaps in dendrogram
indGaps = find(clusterFunnymeasureDiff > normThreshold);
gapsVals = clusterFunnymeasureDiff(indGaps);

%calcuale fraction of Gap
fractionGap = (clusterFunnymeasureDiff./sum(clusterFunnymeasureDiff));
fractionGap2 = (clusterFunnymeasureDiff(indGaps)./sum(clusterFunnymeasureDiff(indGaps)));

%normalize gap fraction
fractionGap3 = (clusterFunnymeasureDiff - normThreshold) / ( max(clusterFunnymeasureDiff) - normThreshold );


% fractionGap3(1) = 1

[fractionGap3Sorted,idx]= sort(fractionGap3);

 col = jet(length(indGaps));
figure
subplot(1,2,1)
plot(clusterFunnymeasure)
hold on
 plot(1:length(clusterFunnymeasure),clusterFunnymeasure, 'g.')
 
 for ii = 1 : length(indGaps)
 
% plot(indGaps,clusterFunnymeasure(indGaps), 'o','color',[fractionGap(ii),0,0])
 plot(indGaps(ii),clusterFunnymeasure(indGaps(ii)), 'o','color',[fractionGap3(indGaps(ii)),0,0])
% plot(indGaps(ii),clusterFunnymeasure(indGaps(ii)), 'o','color',col(idx(ii),:))

 end
axis square

% subplot(2,2,2)
% plot(xout, n)
% hold on
% % line([normThreshold normThreshold],[min(n), max(n)])
% axis square

% subplot(2,2,3)
% plot(xoutDiff, nDiff)
% hold on
% line([normThreshold, normThreshold],[min(nDiff), max(nDiff)], 'color','red')
% axis square

subplot(1,2,2)
dendrogram(tree, length(clusterFunnymeasure))
hold on

for ii = 1 : length(indGaps)
 
% line([0, length(clusterFunnymeasure)],[clusterFunnymeasure(indGaps(ii)), clusterFunnymeasure(indGaps(ii))],'color',col(idx(ii),: ))
line([0, length(clusterFunnymeasure)],[clusterFunnymeasure(indGaps(ii)), clusterFunnymeasure(indGaps(ii))],'color',[fractionGap3(indGaps(ii)),0,0])

 end
axis square

axis square
%%
% %%%%%%%%%%%%%% make random distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clusterFunnymeasureRand = zeros(1000,length(clusterFunnymeasure));
% clusterFunnymeasureRandDiff = zeros(1000,(length(clusterFunnymeasure)-1));
% 
% for i = 1 : 10000
% i
% clusterFunnymeasureRand(i,:) = sort(rand([1,length(clusterFunnymeasure)]));
% clusterFunnymeasureRandDiff(i,:) = diff(clusterFunnymeasureRand(i,:));
% 
% % [nRand,xoutRand] = hist(clusterFunnymeasureRand,25);
% 
% end
% 
% 
% clusterFunnymeasureRandAvr = nanmean(clusterFunnymeasureRand,1);
% clusterFunnymeasureRandDiffAvr = nanmean(clusterFunnymeasureRandDiff,1);
% %%
% 
% 
% 
% 
% [nRand,xoutRand] = hist(clusterFunnymeasureRandAvr,25);
% 
% [nRandDiff,xoutRandDiff] = hist(clusterFunnymeasureRandDiffAvr,25);
% 
% 
% figure
% subplot(1,3,1)
% plot(clusterFunnymeasure)
% hold on
% plot(clusterFunnymeasureRandAvr,'-','color','g')
% axis square
% 
% subplot(1,3,2)
% plot(xout, n)
% hold on
% plot(xoutRand, nRand,'-','color','g')
% axis square
% 
% subplot(1,3,3)
% plot(xoutDiff, nDiff)
% hold on
% plot(xoutRandDiff, nRandDiff,'-','color','g')
% axis square
