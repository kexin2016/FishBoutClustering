function [indClusterCenters,clusterCore,clusterHalo,idx,distanceSquare,rho,delta,gama,dc] = densityPeaksClusteringSquare_1(data,percent,percOrdc,distAlreadyCalc,makePlot)
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
%%%%%%%%%%%%%%%%% make plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

% numbPointsToShow = 50;


    
figure
plot(rho(:),delta(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
box off
axis square
xlabel('\rho')
ylabel('\delta')






%%
%%%%%%%%%%%%%%%%%% choose cluster centers by square %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%choose rect with mouse

rect = getrect;   

xmin = rect(1);
ymin = rect(2);
width = rect(3);
height = rect(4);

%find cluster centers in rect
indClusterCenters = find(rho > xmin & rho < (xmin + width) & delta > ymin & delta < (ymin+height));


%%

plot(rho(:),delta(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k')
hold on
plot(rho(indClusterCenters),delta(indClusterCenters),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');

box off
axis square
xlabel('\rho')
ylabel('\delta')

%%
%%%%%%%%%%%%%% Assign points to clusters data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [clusterCore,clusterHalo] = assignPointsToClusters_1(distanceSquare,indClusterCenters,ordrho,nneigh,dc,rho);




numbClusters = length(indClusterCenters);

%%
%%%%%%%%%%%%%%%%%%%% plot clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indClusterCenters  = find(cl > -1);
if makePlot == 1
    
figure
 subplot(2,2,1)
%   plot(data(:,1),data(:,2), 'k.')

 plot(data(:,1),data(:,2), 'k.')
 title(dc)
axis square
box off

  subplot(2,2,2)

scatter(data(:,1),data(:,2),5,rho,'filled')
 title(dc)
axis square
box off


 col =  jet(numbClusters);
 subplot(2,2,3)
 for n = 1 :  numbClusters% loop through each cluster
     hold on 
%       %cluster core + halo
%       indThisCluster = find(cl == n);
      
      %cluster core
      indThisClusterCore = find(clusterCore == n);
      
      %cluster halo
      indThisClusterHalo = find(clusterHalo == n);
     

 %plot cluster centers
      plot(data(indClusterCenters(n),1),data(indClusterCenters(n),2), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',10,'lineWidth',3)

      %plot cluster core
      plot(data(indThisClusterCore,1),data(indThisClusterCore,2), '.','MarkerFaceColor', col(n,:),'MarkerEdgeColor', col(n,:),'MarkerSize',6,'lineWidth',1)
     
      %plot cluster core
%       plot3(data(indThisClusterHalo,1),data(indThisClusterHalo,2),data(indThisClusterHalo,4), '.','MarkerFaceColor', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)
      plot(data(indThisClusterHalo,1),data(indThisClusterHalo,2), '.','color', col(n,:))%,'MarkerEdgeColor', col(n,:))%,'MarkerSize',2)
box off
title(numbClusters)
      
 end
 axis square
 hold off
 
 subplot(2,2,2)
  plot(rho,delta,'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on
 for n = 1 :  numbClusters% loop through each cluster
     
       plot(rho(indClusterCenters(n)),delta(indClusterCenters(n)), 'o','MarkerFaceColor', col(n,:),'MarkerEdgeColor', 'k','MarkerSize',10,'lineWidth',3)

 end
 
 axis square
 hold off
end  



