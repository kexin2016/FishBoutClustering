% clear all
% close all

%%
% %%%%%%%%%%%%%%% import BoutCat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');


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


% %names
% titleNameSlows = {'Dark 12','Dark 44','Dark 104','Dark 232','Dark 447', 'Dark 790', 'Dark 1890','Dark 4700','Prey Capture Naive non eye conv ',...
%     'Light 12','Light 44','Light 104','Light 232','Light 447', 'Light 790', 'Light 1890','Light 4700','Prey Capture Naive eye conv '};

%correct names
titleNameSlows = {'12 lux','44 lux','104 lux','232 lux','447 lux', '790 lux', '1890 lux','4700 lux','Prey Capture eyes not converged',...
    '12 lux','44 lux','104 lux','232 lux','447 lux', '790 lux', '1890 lux','4700 lux','Prey Capture eyes converged '};



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

makeContourPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetSlows,axisVector,titleNameSlows,subplotRow,subplotCol,nBins,contourEdge,contourLevels)

%%
% %%%%%%%%%%%% plot SARS and Obends %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% indDataSetObends = [24 25 27 0 0 57 64 59 62 61 66:70];
% %  indDataSetObends = [24 25 27 0 0 57 58 59 60 61 66:70];
% 
% titleNameObends = {'Dark response 1','Dark response 2','Dark response 2','nothing','nothing'...
%     '0 °', '45 °', '90 °','135 °', '180 °', '0.5 cm/s', '1.0 cm/s', '1.5 cm/s', '2.0 cm/s', '2.5 cm/s'};
% 
% axisVector = [8 20 -10 10];
% 
% nBins = 15;
% contourEdge = 5;    
% 
% 
% subplotRow = 3;
% subplotCol = 5;
% contourLevels = 5;
% % makeHeatPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetPrey,axisVector,titleName,subplotRow,subplotCol)
% 
% makeContourPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetObends,axisVector,titleNameObends,subplotRow,subplotCol,nBins,contourEdge,contourLevels)
% 

%%
%%%%%%%%%%%%% final plot Obends %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indDataSetObends = [66:70 27 ];


titleNameObends = {'Loom at 0.5 cm/s', 'Loom at 1.0 cm/s', 'Loom at 1.5 cm/s', 'Loom at 2.0 cm/s', 'Loom at 2.5 cm/s','1st bout in dark'};

axisVector = [8 20 -10 10];

nBins = 15;
contourEdge = 5;    

subplotRow = 2;
subplotCol = 3;
contourLevels = 5;
% makeHeatPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetPrey,axisVector,titleName,subplotRow,subplotCol)

makeContourPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetObends,axisVector,titleNameObends,subplotRow,subplotCol,nBins,contourEdge,contourLevels)

%%
%%%%%%%%%%%%%%%%%%%%% HAT plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indDataSetObends = [ 12 13 89:96];
indDataSetObends = [ 12 13  95 96];

axisVector = [0 10 -10 0];
nBins = 13;
contourEdge = 5;    

subplotRow = 2;
subplotCol = 2;
contourLevels = 5;

titleNameObends = {'165', '180', 'light ', 'light ', 'light ', 'light ', 'light ', 'light ', 'light ', 'light '};


makeContourPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSetObends,axisVector,titleNameObends,subplotRow,subplotCol,nBins,contourEdge,contourLevels)
