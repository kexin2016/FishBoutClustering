% clear all
% close all

%%
% %%%%%%%%%%%%%%% import BoutCat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');
% 

%%
% %%%%%%%%%%%% plot dark transition heat map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% indDataSetDark = 81:88;
% 
% titleName = {'Dark 12','Dark 44','Dark 104','Dark 232','Dark 447', 'Dark 790', 'Dark 1890','Daerk 4700'};
% 
% subplotRow = 3;
% subplotCol = 3;
% 
% % makeHeatPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetDark,axisVector,titleName,subplotRow,subplotCol)
% 
% makeContourPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetDark,axisVector,titleName,subplotRow,subplotCol,nBins,contourEdge)


%%
%%%%%%%%%%%% plot slow bouts in pairs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indDataSetSlows = [81:88,54, 89:96,53];

% titleName = {'Dark 12','Light 12','Dark 44','Light 44','Dark 104','Light 104','dark 232','Light 232',...
%     'dark 447','Light 447','dark 790', 'Light 790', 'Dark1890','Light 1890','Dark 4700','Light 4700'};

%correct names
titleName = {'Dark 12','Dark 44','Dark 104','Dark 232','Dark 447', 'Dark 790', 'Dark 1890','Dark 4700','Prey Capture Naive non eye conv ',...
    'Light 12','Light 44','Light 104','Light 232','Light 447', 'Light 790', 'Light 1890','Light 4700','Prey Capture Naive eye conv '};

% %plot names
% titleName = {'Dark 12','Dark 44','Dark 104','Dark 232','Dark 447', 'Dark 790', 'Dark 1890','Dark 4700','Prey Capture Naive non eye conv ',...
%     'Light 12','Light 44','Light 104','Light 232','Light 447', 'Light 790', 'Light 1890','Light 4700','Prey Capture Naive eye conv '};

axisVector = [-15 2 -5 5];

nBins = 17;
contourEdge = 5;    


subplotRow = 2;
subplotCol = 9;
contourLevels = 5;
% makeHeatPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetPrey,axisVector,titleName,subplotRow,subplotCol)

makeContourPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetSlows,axisVector,titleName,subplotRow,subplotCol,nBins,contourEdge,contourLevels)

%%
% %%%%%%%%%%%% plot sars and Obends %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


