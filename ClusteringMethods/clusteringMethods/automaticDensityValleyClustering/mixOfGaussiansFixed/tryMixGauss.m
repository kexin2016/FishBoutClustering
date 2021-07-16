
%init: k (1 x 1) or label (1 x n, 1<=label(i)<=k) or center (d x k)

data = x;

%%
%%%%%%%%%%%% calculate local densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

densityType = 'local';
tic
    kdedens = kde(data',densityType);
    toc

     densities = evaluate(kdedens,data');

figure
plot3(data(:,1),data(:,2),densities, 'k.')
  axis square  
kdedensCutOff = kdedens;
%%
%%%%%%%%%%%% find cluster centers with density valley %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

densityType = 'local';
linedensityMethod = 'medium';
numextra = sqrt(length(data));
nsamps = 10;
multirep = 0;
makeplot = 0;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

tic
[rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_1(data,kdedensCutOff,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
toc


%%
%%%%%%%%%%%%% choose at cluster centers by square  %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tree = [];
[indChoosenClusterCenters] = decideClusterCenters_1(data,tree,clusterCentersSortedIdx,realRho,funnymeasure);

figure
plot3(data(:,1),data(:,2),realRho,'.')
hold on
plot3(data(indChoosenClusterCenters,1),data(indChoosenClusterCenters,2),realRho(indChoosenClusterCenters),'ro')
    axis([-17 22 -10 20 0 max(realRho)])


clusterCentersValues = data(indChoosenClusterCenters,:);




%%
%%%%%%%%%%%% Assign points using mixture of gaussians %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%defining cluster centers
% init = [-1,-4;1,-4;5,-4];
% [label, model, llh] = EMGaussianMIxFixCenters_1(data',clusterCentersValues');
makeplot = 0;
fixCenterClusters = 1;
[label, model, llh] = EMGaussianMixFixCenters_1(data',clusterCentersValues',fixCenterClusters,makeplot);





%%
%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueLabel = unique(label);
col = jet(length(uniqueLabel));
sizeOfClusters = zeros(1, length(uniqueLabel));


figure
for n = 1 : length(uniqueLabel)
    
  indThisCluster = find(label == uniqueLabel(n));
  
  plot3(data(indThisCluster,1),data(indThisCluster,2),realRho(indThisCluster), '.', 'color', col(n,:))
  axis square  
    hold on
    
    sizeOfClusters(n) = length(indThisCluster);  
    
end



   plot3(mu(1,:),mu(2,:),realRho(indChoosenClusterCenters), 'o', 'color', 'red') 
   
  
%%
%%%%%%%%%%%%% make matlab misture of gaussisn obj %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu = model.mu;
sigma = model.Sigma;
p = model.weight;
   
obj = gmdistribution(mu',sigma,p);



%%
%%%%%%%%% do soft clustering  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get pprobability of each data point to belong to clusters
[hardlabels,~,probOfCluster] = cluster(obj,data);


%drw data points to cluster according the probability of belonging to cluster
for n = 1 : length(data)
%    n =1 
    draw = rand;
    
    
  cp =cumsum( probOfCluster(n,:));
    
  higher = find(cp >= draw==1,1);
  
  softLabels(n) =  higher;
    
end



%
uniqueLabel = unique(softLabels);
col = jet(length(uniqueLabel));

figure
for n = 1 : length(uniqueLabel)
    
  indThisCluster = find(softLabels == uniqueLabel(n));
  
% %   T = cluster(Z,'cutoff',c)
%   
%   indPerm = randperm(length(indThisCluster));
%   thisIndRand = indThisCluster(indPerm(1:numbPoints));
  
  
  plot3(data(indThisCluster,1),data(indThisCluster,2),realRho(indThisCluster), '.', 'color', col(n,:))
  axis square  
    hold on
    
end

   plot3(mu(1,:),mu(2,:),realRho(indChoosenClusterCenters), 'o', 'color', 'red') 


