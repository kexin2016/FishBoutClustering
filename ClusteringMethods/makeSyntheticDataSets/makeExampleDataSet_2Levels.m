% clear all
% close all
% 

%%
%%%%%%%%%%%%%%%%%%%%% parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MakePlot2 = 1;
rad = 0.1;
% clusterDensityAvr = 2:1:10;% 1 to 10
% densityBetweenClusters = 0.1:0.1:1;% 0.1 to 1
%  numberOfClusters = 1:1:20;% 1 to 15
clusterDensityAvr = 6;% 1 to 10
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
% points(:,1) = [0,1,3,-10,-9,-8,-4,-3,-2];
% points(:,2) = [-6,-4,-6,-6,-4,-6,0,2,0];

% points(:,1) = [-10 -8 -6,-3 -1 1 5 7 9];
% points(:,2) = [-10 -7 -10 0 5 0 -10 -7 -10];
% 
% points(:,1) = [-10 -9 -8,-3 -2 -1 5 6 7];
% points(:,2) = [-10 -8 -10 0 2 0 -10 -8 -10];

% points(:,1) = [-8 -7 -6,-3 -2 -1 3 4 5];
% points(:,2) = [-10 -8 -10 -2 0 -2 -10 -8 -10];

points(:,1) = [-7 -6 -5,-3 -2 -1 2 3 4];
points(:,2) = [-10 -8 -10 -3 -1 -3 -10 -8 -10];

makeEqualNumber = 1;
makeGaussian = 1;
% [data,groundTruth] = clusterMaker_2(clusterDensityAvr,densityBetweenClusters,numberOfClusters,minNumberOfPointsPerCluster,totalNumberOfPoints,rad, MakePlot2);
[data,groundTruth] = clusterMaker_4(clusterDensityAvr,densityBetweenClusters,numberOfClusters,minNumberOfPointsPerCluster,totalNumberOfPoints,rad,points,makeEqualNumber,makeGaussian, MakePlot2);


      save('twoLevelCluster_4', 'data', 'groundTruth')

