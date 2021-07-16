function [data,groundTruth] = clusterMaker_3(clusterDensityAvr,densityBetweenClusters,numberOfClusters,minNumberOfPointsPerCluster,totalNumberOfPoints,rad,points, MakePlot2)

%%
% %%%%%%%%%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% MakePlot2 = 1;
% rad = 0.2;
% clusterDensityAvr = 5;
% densityBetweenClusters = 0.1;
% numberOfClusters = 3;
% minNumberOfPointsPerCluster = 50;
% totalNumberOfPoints = 3000;



%%
%%%%%%%%%%%%% make sure all points are in screen %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pointsOutOfScreen = 1;
counter1 = 1;
while pointsOutOfScreen == 1 
% counter1

%%
%%%%%%%%%%%%%%%%%%%%%% define centers of clusters %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gridSize = 100;
MakePlot = 0;

if isempty(points)
% [pointX,pointY] = randPointsAtFixedDensity2D_2(densityBetweenClusters,gridSize,numberOfClusters,rad,MakePlot);
 [pointX,pointY] = randPointsAtFixedDensity2D_5(densityBetweenClusters,gridSize,numberOfClusters,rad,MakePlot);
 
else

pointX = points(:,1);
pointY = points(:,2);
end
% %plot cluster centers
% figure
% plot(pointX,pointY, '.')
% axis([0 1 0 1])
% axis square

%%
% %%%%%%%%%%%%%%%% test density between clusters %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [convexHullInd,densityClusterVoltest] = convhull(pointX,pointY);
% 
% 
% densityClusterTest = length(pointX)/densityClusterVoltest;
% 
% 


%%
%%%%%%%%%%%%%%% define number of points per cluster %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


numberPointsAll = 1;
counter2 = 1;

if numberOfClusters == 1

 numberPointsAll = totalNumberOfPoints; 
else
    
while sum(numberPointsAll) ~= totalNumberOfPoints
    
avrNumnerOfPointsPerCluster = round(2*totalNumberOfPoints/numberOfClusters);
%create random int 
numberPointsAll = randi([minNumberOfPointsPerCluster avrNumnerOfPointsPerCluster],[1,numberOfClusters]);
% sum(randomNumbers)

counter2 = counter2 + 1;

%break if it is stuck in while loop
if counter2 == 100000
   
    disp('Unable to reach correct number of total points')
    break
    
    
end

end

end



%%
%%%%%%%%%%%% make clusters using beta distribution %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%make # numberOfClusters using beta distributions
Xtotal = [ ];
Ytotal = [ ];

% col = jet(numberOfClusters);
% figure
KsizeOfCluster = 2;
parameterScalingFactor = 100;    
groundTruth = [];

 for n = 1 : numberOfClusters %loop through number of clusters
% n = 1;    
    


%%
%%%%%%%%%%%%%%%%% make random 2d beta pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha1 = rand(1)*parameterScalingFactor;
beta1 = rand(1)*parameterScalingFactor;
alpha2 = rand(1)*parameterScalingFactor;
beta2 = rand(1)*parameterScalingFactor;

alpha1 = 1*parameterScalingFactor;
beta1 = 1*parameterScalingFactor;
alpha2 = 1*parameterScalingFactor;
beta2 = 1*parameterScalingFactor;

%%
%%%%%%%%%%%%%% make random number of points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% numberOfPoints = 1;
% while numberOfPoints < 50%avoid not having any points
% 
% numberOfPoints = rand(1)*maxNumberOfPointsPerCluster; 
% 
% end

numberOfPointsThisCuster = numberPointsAll(n);

%%
%%%%%%%%%%%%%%%%%% create b distributions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
XBeta = betarnd(alpha1,beta1,[numberOfPointsThisCuster,1]);
YBeta = betarnd(alpha2,beta2,[numberOfPointsThisCuster,1]);

%%
%%%%%%%%%%%%%%%%%%%%%% rotate cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

angleindegrees = rand(1)*360;%make rand angles to rotate

[XBetaRot,YBetaRot] = rotate_matrix(XBeta,YBeta,angleindegrees);

%%
%%%%%%%%%%%%%%%%%%% center cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clusterAvrX = nanmean(XBetaRot);
clusterAvrY = nanmean(YBetaRot);

XBetaCentered = XBetaRot - clusterAvrX;
YBetaCentered = YBetaRot - clusterAvrY;

%%
%%%%%%%%%%%%%%%% make cluster of certain avr density %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clusterDensityAvr = 2;

%calculate conver hul of cluster
[~,convexHullVol] = convhull(XBetaCentered,YBetaCentered);

%calcualte density
% clusterDensity = numberOfPointsThisCuster/convexHullVol;

%scale cluster to be of this density
clusterVolume = numberOfPointsThisCuster/clusterDensityAvr;

kToScaleCluster = sqrt(clusterVolume/convexHullVol);

XBetaCenteredScaled = XBetaCentered.*kToScaleCluster/KsizeOfCluster;
YBetaCenteredScaled = YBetaCentered.*kToScaleCluster/KsizeOfCluster;

% % test scaling
% [convexHullInd2,convexHullVol2] = convhull(XBetaCenteredScaled,YBetaCenteredScaled);
% %calcualte density
% clusterDensity2 = numberOfPoints/convexHullVol2;

% %make plot
% subplot(2,2,1)
% plot(XBeta,YBeta,'.', 'color', col(n,:))
% hold on
% axis([0 1, 0 1])
% axis square
% 
% subplot(2,2,2)
% plot(XBetaRot,YBetaRot,'.', 'color', col(n,:))
% hold on
%  axis([-1 1, -1 1])
% axis square
% title(angleindegrees)
% 
% subplot(2,2,3)
% plot(XBetaCentered,YBetaCentered,'.', 'color', col(n,:))
% hold on
% plot(XBetaCentered(convexHullInd),YBetaCentered(convexHullInd),'-', 'color', col(n,:))
%  axis([-1 1, -1 1])
% axis square
% title(clusterDensity)
% 
% subplot(2,2,4)
% plot(XBetaCenteredScaled,YBetaCenteredScaled,'.', 'color', col(n,:))
% hold on
% plot(XBetaCenteredScaled(convexHullInd2),YBetaCenteredScaled(convexHullInd2),'-', 'color', col(n,:))
%   axis([-1 1, -1 1])
% axis square
% title(clusterDensity2)


%%
%%%%%%%%%%%%%% put cluster in plot space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

XBetaInSpace = (XBetaCenteredScaled + pointX(n));
YBetaInSpace = (YBetaCenteredScaled + pointY(n));



%%
%%%%%%%%%%%%%% test scaling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% subplot(1,2,1)
% plot(XBetaInSpace,YBetaInSpace, 'k.')
% hold on
% % plot(pointX(n),pointY(n), 'ro')
% axis square
% axis([-12 12,-12 12])
% 
% 
% subplot(1,2,2)
% plot(XBetaInSpace,YBetaInSpace, '.', 'color', col(n,:))
% hold on
% plot(pointX(n),pointY(n), 'ro')
% axis square
% axis([-12 12,-12 12])
% % title(densityClusterTest)
% 
% % % axis off
% % 
%%
%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Xtotal = [Xtotal' XBetaInSpace']';
Ytotal = [Ytotal' YBetaInSpace']';

%save ground truth
thisClusterNumber = zeros(1,length(XBetaInSpace)) + n;
groundTruth = [groundTruth thisClusterNumber];

end %loop through number of clusters





%%
%%%%%%%%%%% check if all points are in screen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxX = max(Xtotal);
maxY = max(Ytotal);
minX = min(Xtotal);
minY = min(Ytotal);


if maxX > 12 || maxY > 12 || minX < -12 || minY < -12
    
    pointsOutOfScreen = 1;
    counter1 = counter1 + 1;
    
else
    
    pointsOutOfScreen = 0;
    
end

%break if it is stuck in while loop
if counter1 == 1000
   
    break
    
end



end

%%

%%%%%%%%%%%%% test ground truth assignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = [Xtotal,Ytotal];

realClusterNumbers = unique(groundTruth);

if MakePlot2 == 1

col = jet(length(realClusterNumbers));
figure
subplot(1,2,1)
plot(data(:,1),data(:,2), 'k.')
axis square
axis([-12 12,-12 12])
box off

subplot(1,2,2)
for nn = 1 : length(realClusterNumbers)
%     nn
    
    indThisCluster = find(groundTruth == nn);
    hold on
    plot(data(indThisCluster,1),data(indThisCluster,2),'.','color',col(nn,:))
    
    axis square
    axis([-12 12,-12 12])
%     pause
end

end
