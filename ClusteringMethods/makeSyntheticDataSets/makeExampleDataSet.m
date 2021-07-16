clear all
close all


%%
%%%%%%%%%%%%%%%%%%%%% parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MakePlot2 = 1;
rad = 0.2;
% clusterDensityAvr = 2:1:10;% 1 to 10
% densityBetweenClusters = 0.1:0.1:1;% 0.1 to 1
%  numberOfClusters = 1:1:20;% 1 to 15
clusterDensityAvr = 7;% 1 to 10
densityBetweenClusters = 70;% 0.1 to 1
numberOfClusters = 9;% 1 to 15

% numberOfClusters = 10;% 1 to 20
minNumberOfPointsPerCluster = 50;
totalNumberOfPoints = 500;
repeat = 1:1:5;



%%
%%%%%%%%%%%% make data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
points = [];
points(:,1) = [0,1,3,-10,-9,-8,-4,-3,-2];
points(:,2) = [-6,-4,-6,-6,-4,-6,0,2,0];

points(:,1) = [-10 -8 -6,-3 -1 1 5 7 9];
points(:,2) = [-10 -7 -10 0 5 0 -10 -7 -10];


% [data,groundTruth] = clusterMaker_2(clusterDensityAvr,densityBetweenClusters,numberOfClusters,minNumberOfPointsPerCluster,totalNumberOfPoints,rad, MakePlot2);
[data,groundTruth] = clusterMaker_3(clusterDensityAvr,densityBetweenClusters,numberOfClusters,minNumberOfPointsPerCluster,totalNumberOfPoints,rad,points, MakePlot2);


%    save('twoLevelCluster_1', 'data', 'groundTruth')

