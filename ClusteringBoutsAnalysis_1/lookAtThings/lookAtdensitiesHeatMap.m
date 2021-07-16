clear all
% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');
% 
load('C:\Joao analysis\FreeData\clusteringData\ClusterAssignment\ClusterAssignment_AllDataWithTransitions_74Kins3dims_1.75Smooth_slow_3000_square_manySlow3.mat')

%% omr turns
%    indDataSet = [1 2 3 4 5 6 7 8 9 10 11 12 13];

%% omr speed
%               indDataSet = [14 15 16 17 18 19 20 21 22 23];

%% simone 3 min light dark
%    indDataSet = [24 25 26 27];
% exclude 26

%% Flash data sets

%    indDataSet = [28 29 30 31];

%% beeps
%        indDataSet = [32:41];

%% flash beeps
%      indDataSet = [42:51];

%% phototaxis
%       indDataSet = [52:53];

%% prey capture all fish
%       indDataSet = [54 56 58];

%% prey capture spont
%      indDataSet = [55 57 59];

%% small rig beeps
%    indDataSet = [60 61 62 63 64];

%% looming different directions
%        indDataSet = 65:72;

%% looming different speeds
%     indDataSet = 73:78;

%% spont multifish 1000 lux
%       indDataSet = 79:82;

%% spont multifish 0 lux
%          indDataSet = 83:86;

%%
% single fish prey capture
%  indDataSet = 87:103;

%%
% single fish prey capture naive
%  indDataSet = 104:115;

%%
%dark light from Light transitions4
%   indDataSet = 116:117;

%%
%dark 3min from dark transitions4
%     indDataSet = 118:125;

%%
% % %light 3min from Light transitions4
%    indDataSet = 126:133;


%%
% %look at o bends/sars
%   indDataSet = [27 28 30 65 66 67 68 69 70 71 72 74 75 76 77 78];

%%
%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbDim = 3;
%  indDataSet =1:18;
%  n = indDataSet;

%    indDataSet = [79 :1: 86,[118 133]];
%  n = indDataSet


% titleName = {'12','44','104','232','447', '790', '1890','4700'};

% titleName = {'Dark transitions','Dark transitions','Dark transitions','0 degrees','0 degrees','45 degrees','90 degrees','135 degrees','180 degrees','225 degrees','270 degrees',...
%     '0.5 cm/s','1 cm/s','1.5 cm/s','2 cm/s','2.5 cm/s' };

%%
%%%%%%%%%%%%%% make plot light transitions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 indDataSet = [ 126:133 118:125];
 titleName = {'Light 12','Light 44','Light 104','Light 232','Light 447', 'Light 790', '1890','4700','12','44','104','232','447', '790', '1890','4700'};


for i = 1:length(indDataSet)%length(indStructure)%loop through each data set
    
%      figure
% 
%       clf
subplot(4,4,i)

    thisIndRand = indStructure(indDataSet(i)).thisIndRand;
    thisInds = indStructure(indDataSet(i)).thisInds;
    
    funnymeasure = indStructure(indDataSet(i)).funnymeasure;
    realRho = indStructure(indDataSet(i)).realRho;
    indChoosenClusterCenters = indStructure(indDataSet(i)).indChoosenClusterCenters;
    clusterAssignment =  indStructure(indDataSet(i)).clusterAssignment;
    rho = indStructure(indDataSet(i)).rho;
    maxjump = indStructure(indDataSet(i)).maxjump;
    pointAssignmentMethod = indStructure(indDataSet(i)).pointAssignmentMethod;
     percentageOfClusters = indStructure(indDataSet(i)).percentageOfClusters;
      numbOfClusters = indStructure(indDataSet(i)).numbOfClusters;
    
    
    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbDim);

    uniqueClusterAssignment = unique(clusterAssignment);
    col = jet(length(indChoosenClusterCenters));
    
%     subplot(2,4,i)
    scatter(dataThisDataSetRand(:,1),dataThisDataSetRand(:,2),3,realRho,'filled')
    axis square
%     axis([6 20 -6 8]) 
    axis([6 20 -6 8]) 
     title(titleName{i});

    box off
    xlabel('dim 1')
    ylabel('dim 2')
   %%
    
end
indChoosenClusterCenters

