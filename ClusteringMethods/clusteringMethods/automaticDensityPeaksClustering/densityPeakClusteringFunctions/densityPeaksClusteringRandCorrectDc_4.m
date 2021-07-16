function [indClusterCenters,clusterCore,clusterHalo,diffDiviation,diffDiviationReg,diffDiviationNorm,difference,deviationNorm,idx,distanceSquare,rho,delta,gama,rhoRand,deltaRand,gamaRand,dc] = densityPeaksClusteringRandCorrectDc_4(data,percent,percOrdc,multirep,distAlreadyCalc,numbPointsToShow,makePlot)
%%
%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% makePlot =1;
% numbPointsToShow = 50;
% percent = 5;
% distAlreadyCalc = 0;
% percOrdc = 1;
% multirep = 1;

% data = cwssimForOlivetiInvVector;

%%
%%%%%%%%%%%%% calculate pair wise distances data %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if distAlreadyCalc == 0
distances = pdist(data,'euclidean');



% %find inds of distances vector
% [i,j] = find(tril(ones(size(data, 1)), -1));
% 
% distancesWithInds = [i,j, distances'];

else
  
    
    distances = data;
% %find inds of distances vector
% [i,j] = find(tril(ones(size(data, 1)), -1));
% 
% distancesWithInds = [i,j, data'];    
    

end

distanceSquare = squareform(distances);



%%
%%%%%%%%%%%%%%% determine cut off distance (dc)%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if percOrdc == 1 
% percent = 1;

%find ind of percent of data
position = round(length(distances)*percent/100);

sda = sort(distances);

dc = sda(position);
else
    
dc = percent;   
 
end

%%
%%%%%%%%%%%%%%%%%% calcualte rho and delta data %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [rho, delta,ordrho,nneigh] =  calculateRhoAndDelta_2Mike(distanceSquare,dc);
[rho, delta,ordrho,nneigh] = calculateRhoAndDelta_2Mike(distanceSquare,dc);

% makePlot = 1;
% [numbClusters,indClusterCenters,clusterCore,clusterHalo,rhoRand, deltaRand] = densityPeaksClustering_7(data,percent,makePlot,alpha,distAlreadyCalc,robust,percOrdc);
% [numbClusters,indClusterCenters,clusterCore,clusterHalo,rhoRand, deltaRand] = densityPeaksClustering_7(dataRand,percent,makePlot,alpha,distAlreadyCalc,robust,percOrdc);

%%
%%%%%%%%%%%%%%%%% calculate gama data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gama = rho(:).*delta(:);


[gamaSorted, idx] = sort(gama,'descend');



% plot(gamaSorted, '.')
% hold on
% plot(gamaSortedRand, 'r.')



%%
%%%%%%%%%%%%%%%% resampled distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if multirep ~= 0
randDistHas1Cluster = 0;
whileCount = 0;

%while randDistHas1Cluster ~= 1

for multi=1:multirep
multi

plotMaker = 0;

[dataRand] = resampleDistribution_3(data,length(data),plotMaker);
 
%%
%%%%%%%%%%%%% calculate pair wise distances dataRand %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if distAlreadyCalc == 0
distancesRand = pdist(dataRand,'euclidean');

%find inds of distances vector
[iRand,jRand] = find(tril(ones(size(dataRand, 1)), -1));

distancesWithIndsRand = [iRand,jRand, distancesRand'];
end

distanceSquareRand = squareform(distancesWithIndsRand(:,3));

%%
%%%%%%%%%%%%%%%%%% calcualte rho and delta rand data %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[rhoRand, deltaRand,~,~] = calculateRhoAndDelta_2Mike(distanceSquareRand,dc);

%%
%%%%%%%%%%%%%%%%% calculate gama rand data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gamaRand(multi,:) = rhoRand(:).*deltaRand(:);



% plot(gamaSorted, '.')
% hold on
% plot(gamaSortedRand, 'r.')

%%
%%%%%%%%%%%%%% chack if rand dist has 1 cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [~, randDistmaxGapInd] = min(diff(gamaSortedRand(1:end)));
% 
% if randDistmaxGapInd == 1
    
    randDistHas1Cluster = 1;
    
% end

%whileCount = whileCount + 1;

end

if multirep >1
gamaSortedRand = sort(mean(gamaRand)','descend');
else
gamaSortedRand =   sort((gamaRand)','descend');
end

else
    
gamaSortedRand = zeros(1, length(gamaSorted))';
gamaRand = zeros(1, length(gamaSorted))';
rhoRand = zeros(1, length(gamaSorted))';
deltaRand = zeros(1, length(gamaSorted))';

end

%%
%%%%%%%%%%%% calculate number of clusters by diviation %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if multirep ~= 0

difference = gamaSorted'-gamaSortedRand';
deviation = difference./(gamaSorted');

%make all values positive
deviationNorm = deviation(1:end/2) - min(deviation(1:end/2));

diffDiviation = diff(deviationNorm);
diffDiviationReg = diff(difference);
diffDiviationNorm = diff(difference)./abs(gamaSorted(1:end-1)');


%1 cluster case - if first cluster is higher in ref
indPosDeviation = find(deviation(1:end/2) > 0,1);
if isempty(indPosDeviation)
    
 indClusterCenters = idx(1);
 numbClusters = 1;   
 
else
  
  [~,indMaxDiffDiviation] = min(diffDiviation);

indClusterCenters = idx(1:indMaxDiffDiviation(end));
numbClusters = indMaxDiffDiviation(end);

  
end

%%
%%%%%%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

% numbPointsToShow = 50;
if makePlot == 1


    
figure
subplot(2,3,1)
plot(rho(:),delta(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on
plot(rhoRand(:),deltaRand(:),'o','MarkerSize',5,'MarkerFaceColor','g','MarkerEdgeColor','g');
plot(rho(indClusterCenters),delta(indClusterCenters),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');
title(numbClusters)
box off
axis square
xlabel('\rho')
ylabel('\delta')

% subplot(2,3,2)
% plot(magDiff(1:numbPointsToShow),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
% hold on
% plot(magDiff(1:numbClusters),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');
% title(dc)
% box off
% axis square

subplot(2,3,2)
plot(gamaSorted(1:numbPointsToShow), 'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on
plot(gamaSorted(1:numbClusters), 'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');
plot(gamaSortedRand(1:numbPointsToShow), 'o','MarkerSize',5,'MarkerFaceColor','g','MarkerEdgeColor','g');
box off
axis square
ylabel('\gamma')
xlabel('#')


subplot(2,3,3)
hold on
plot(difference(1:numbPointsToShow), 'o','MarkerSize',5,'MarkerFaceColor','c','MarkerEdgeColor','c');
plot(difference(1:numbClusters), 'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');
box off
axis square
ylabel('Differences of \gamma')
xlabel('#')

subplot(2,3,4)
hold on
plot(deviationNorm(1:numbPointsToShow), 'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
plot(deviationNorm(1:numbClusters), 'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');
box off
axis square
% title('deviation from ref Norm')
ylabel('Norm diviation of \gamma')
xlabel('#')

subplot(2,3,5)
hold on
plot(diffDiviation(1:numbPointsToShow), 'o','MarkerSize',5,'MarkerFaceColor','c','MarkerEdgeColor','c');
plot(diffDiviation(1:numbClusters), 'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');
% title(' diff deviation from ref')
box off
axis square
ylabel('Jump')
xlabel('#')

end


%%
%%%%%%%%%%%%%% Assign points to clusters data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [clusterCore,clusterHalo] = assignPointsToClusters_1(distanceSquare,indClusterCenters,ordrho,nneigh,dc,rho);





%%
%%%%%%%%%%%%%%%%%%%% plot clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indClusterCenters  = find(cl > -1);
if makePlot == 1
    
figure
 subplot(1,3,1)
%   plot(data(:,1),data(:,2), 'k.')

 plot(data(:,1),data(:,2), 'k.')
 title(dc)
axis square
box off
  subplot(1,3,2)

scatter(data(:,1),data(:,2),5,rho,'filled')
 title(dc)
axis square
box off


 col =  jet(numbClusters);
 subplot(1,3,3)
 for n = 1 :  numbClusters% loop through each cluster
     hold on 
%       %cluster core + halo
%       indThisCluster = find(cl == n);
      
      %cluster core
      indThisClusterCore = find(clusterCore == n);
      
      %cluster halo
      indThisClusterHalo = find(clusterHalo == n);
     
%       %plot cluster centers
%       plot3(data(indClusterCenters(n),1),data(indClusterCenters(n),2),data(indClusterCenters(n),3), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',10,'lineWidth',3)
% 
%       %plot cluster core
%       plot3(data(indThisClusterCore,1),data(indThisClusterCore,2),data(indThisClusterCore,3), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',6,'lineWidth',1)
%      
%       %plot cluster core
% %       plot3(data(indThisClusterHalo,1),data(indThisClusterHalo,2),data(indThisClusterHalo,4), '.','MarkerFaceColor', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)
%       plot3(data(indThisClusterHalo,1),data(indThisClusterHalo,2),data(indThisClusterHalo,3), '.','color', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)

 %plot cluster centers
      plot(data(indClusterCenters(n),1),data(indClusterCenters(n),2), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',10,'lineWidth',3)

      %plot cluster core
      plot(data(indThisClusterCore,1),data(indThisClusterCore,2), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',6,'lineWidth',1)
     
      %plot cluster core
%       plot3(data(indThisClusterHalo,1),data(indThisClusterHalo,2),data(indThisClusterHalo,4), '.','MarkerFaceColor', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)
      plot(data(indThisClusterHalo,1),data(indThisClusterHalo,2), '.','color', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)
box off
title(numbClusters)
      
 end
 axis square
 hold off
end  






else
    %%
    %%%%%%%%%makes square %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %specifically for thesis...
%     indClusterCenters = idx(1:3);
%     numbClusters = 3;

    diffDiviation = nan;
    diffDiviationReg = nan;
    diffDiviationNorm = nan;
    difference = nan;
    deviationNorm = nan;
    
    tree = [];
    
    deltaNorm = delta/max(delta);
    funnymeasureRandThreshold = [];
    [indClusterCenters] = decideClusterCentersSquare_2(data,tree,idx,rho,deltaNorm,funnymeasureRandThreshold);

    numbClusters = length(indClusterCenters);
    
    %%
%%%%%%%%%%%%%% Assign points to clusters data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [clusterCore,clusterHalo] = assignPointsToClusters_1(distanceSquare,indClusterCenters,ordrho,nneigh,dc,rho);


    
end
