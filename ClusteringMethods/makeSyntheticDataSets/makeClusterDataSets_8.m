close all
clear all

AddFunctionToPath

directory_name = uigetdir;



%%
%%%%%%%%%%%%%%%%%%%%% parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MakePlot2 = 0;
rad = 0.2;
clusterDensityAvr = 2:1:10;% 1 to 10
densityBetweenClusters = 0.1:0.1:1;% 0.1 to 1
 numberOfClusters = 1:1:20;% 1 to 15
% numberOfClusters = 10;% 1 to 20
minNumberOfPointsPerCluster = 50;
totalNumberOfPoints = 3000;
repeat = 1:1:5;

%%

MakePlot2 = 0;
rad = 0.2;
clusterDensityAvr = 5;
densityBetweenClusters = 0.05:0.05:0.5;
minNumberOfPointsPerCluster = 50;
totalNumberOfPoints = 3000;
repeat = 1:1:5;

numberOfClusters = randi([1 15],length(clusterDensityAvr)*length(densityBetweenClusters)*length(repeat),1);

%%
%%%%%%%%%%%%%%% loop through pstsmrters
count = 1;
for n = 1 : length(clusterDensityAvr)
n
for nn = 1 : length(densityBetweenClusters)
    
    for nnn = 1 : length(numberOfClusters)
        
        
        for nnnn = 1 : length(repeat)

%%
%%%%%%%%%%%%%%%% make cluster data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[data,groundTruth] = clusterMaker_2(clusterDensityAvr(n),densityBetweenClusters(nn),numberOfClusters(nnn),minNumberOfPointsPerCluster,totalNumberOfPoints,rad, MakePlot2);



%%
%%%%%%%%%%%%%% make file name %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataSetStruct(count).data = data;
dataSetStruct(count).groundTruth = groundTruth;
dataSetStruct(count).rad = rad;
dataSetStruct(count).clusterDensityAvr = clusterDensityAvr(n);
dataSetStruct(count).densityBetweenClusters = densityBetweenClusters(nn);
dataSetStruct(count).numberOfClusters = numberOfClusters(nnn);
dataSetStruct(count).minNumberOfPointsPerCluster = minNumberOfPointsPerCluster;
dataSetStruct(count).totalNumberOfPoints = totalNumberOfPoints;
dataSetStruct(count).repeat = repeat(nnnn);

count = count +1
        end
    end
end
end

%%
%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% dataSetName = strcat('clusterDataSet','_',num2str(totalNumberOfPoints),'_',num2str(numberOfClusters(nnn)),'.mat');
dataSetName = strcat('clusterDataSet','_',num2str(totalNumberOfPoints),'_','.mat');
save(strcat(directory_name,'\',dataSetName), 'dataSetStruct')




