clear all
close all




%%
%%%%%%%%%%%%%%% choose folder with data to annalyse %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%get folder name where the folders with each dataset are
dataPath =  uigetdir;


%%
%%%%%%%%%%%%%%%%%%get names of all files of all data sets%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%test function


%creats structure with names of things inside folder
DataFiles = dir(dataPath);

DataFiles(1) = [];
DataFiles(1) = [];


%%
%%%%%%%%%%%%%% make dtaset structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for n = 1 : length(DataFiles)
%      n =1
    dataSetName = DataFiles(n).name;
    
    dataPathSubfolder = strcat(dataPath, '\', dataSetName);
    
    load(dataPathSubfolder)

    
    
    
    
    dataSetStructure(n).dataSetName = dataSetName;
    dataSetStructure(n).data = data;

    TF = exist('groudTruth', 'var');
    TF2 = exist('groundTruth', 'var');

    
    if TF == 1 || TF == 2
        if TF == 1
        dataSetStructure(n).groundTruth = groudTruth;
        end
        
         if TF == 2
        dataSetStructure(n).groundTruth = groundTruth;
        end
    
    else
    dataSetStructure(n).groundTruth = nan;    
    end
    
    clearvars groudTruth groundTruth data
     
    
    
    
end

