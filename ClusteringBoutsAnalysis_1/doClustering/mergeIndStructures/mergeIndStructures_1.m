% AddFunctionToPath

close all
clear all


% %3d all data 
% path1 = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\BoutCat_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto_final.mat';

%4d all data
folder = 'C:\Joao analysis\FreeData\clusteringData\ClusterAssignment\final\';
fileName = 'ClusterAssignment_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged6.mat';

path1 = strcat(folder,fileName);

%4d prey capture uncov bouts
folder = 'C:\Joao analysis\FreeData\preyCaptureData\ClusterAssignment\';
fileName = 'ClusterAssignment_PreyCaptureRita2_74Kins4dim_1.75Smooth_slow_3000_corr.mat';


path2 = strcat(folder,fileName);




% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %load all data 3d automatic clustering
% load(path1);
%  

%%
%%%%%%%%%%%%%%%%%%%%% merge boutInf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


T = load(path1,'BoutInf');
BoutInf = T.BoutInf;
clearvars T;

if size(BoutInf,2) < 157
    
    zeroVector = zeros(1,size(BoutInf,1))';

    while size(BoutInf,2) < 157
        
    BoutInf = [BoutInf zeroVector];
    
    end
    
end

T2 = load(path2,'BoutInf');
BoutInf1 = T2.BoutInf;
clearvars T2;

if size(BoutInf1,2) < 157
    
    zeroVector = zeros(1,size(BoutInf1,1))';

    while size(BoutInf1,2) < 157
        
    BoutInf1 = [BoutInf1 zeroVector];
    
    end
    
end



BoutInf = vertcat(BoutInf,BoutInf1);
clearvars BoutInf1;


%%
%%%%%%%%%%%%%%%%%%%%% merge BoutKinematicParameters %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


T = load(path1,'BoutKinematicParameters');
BoutKinematicParameters = T.BoutKinematicParameters;
clearvars T;



T2 = load(path2,'BoutKinematicParameters');
BoutKinematicParameters1 = T2.BoutKinematicParameters;
clearvars T2;



BoutKinematicParameters = vertcat(BoutKinematicParameters,BoutKinematicParameters1);
clearvars BoutKinematicParameters1;

%%
%%%%%%%%%%%%%% merge boutDataPCASample %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = load(path1,'boutDataPCASample');
boutDataPCASample = T.boutDataPCASample;
boutDataPCASample = boutDataPCASample(:,1:4);

clearvars T;



T2 = load(path2,'boutDataPCASample');
boutDataPCASample1 = T2.boutDataPCASample;
boutDataPCASample1 = boutDataPCASample1(:,1:4);

clearvars T2;

numbBoutsInOriginalDataset = length(boutDataPCASample);

boutDataPCASample = vertcat(boutDataPCASample,boutDataPCASample1);



clearvars boutDataPCASample1;

%%
%%%%%%%%%%%%%%%%%%%%%%% merge indStructure %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = load(path1,'indStructure');
indStructure = T.indStructure;
clearvars T;



T2 = load(path2,'indStructure');
indStructure1 = T2.indStructure;
clearvars T2;


if isfield(indStructure1, 'funnymeasureRandThreshold')
    
indStructure1 = rmfield(indStructure1,'funnymeasureRandThreshold');

end

if isfield(indStructure, 'funnymeasureRandThreshold')
    
indStructure = rmfield(indStructure,'funnymeasureRandThreshold');

end

%%
%%%%%%%%%%%%%% correct inds indStructure1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% indStructure2 = indStructure1;
for n = 1 : length(indStructure1)
    
  
    thisInds = indStructure1(n).thisInds;
    thisIndRand = indStructure1(n).thisIndRand;
    
    
    
    indStructure1(n).thisInds = numbBoutsInOriginalDataset + thisInds;
    indStructure1(n).thisIndRand = numbBoutsInOriginalDataset + thisIndRand;
    
end

%test ind correction
for n = 1 : length(indStructure1)
    
    
 thisInds = indStructure1(n).thisInds;
subplot(2,6,n)
   plot3(boutDataPCASample(thisInds,1),boutDataPCASample(thisInds,2),boutDataPCASample(thisInds,4), '.')
    
end

indStructure = [(indStructure), (indStructure1)];
clearvars indStructure1;

%%
%%%%%%%%%%%%%%%%%%%%%%%% load behavioralSpaceStructure %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = load(path1,'behavioralSpaceStructure');
behavioralSpaceStructure = T.behavioralSpaceStructure;
clearvars T;


%%
%%%%%%%%%%%%%%%% load eyeConvDiffAll %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T = load(path1,'eyeConvDiffAll');
% eyeConvDiffAll = T.eyeConvDiffAll;
% clearvars T;
% 
% T = load(path2,'eyeConvDiffAll');
% eyeConvDiffAll = T.eyeConvDiffAll;
% clearvars T;

%%
%%%%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



save('C:\Joao analysis\FreeData\clusteringData\ClusterAssignment\final\ClusterAssignment_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged7.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')





