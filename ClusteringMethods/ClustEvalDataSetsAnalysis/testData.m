close all
clear all



%%
%%%%%%%%%%%%%%%%%%%%%% get dir %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PathName =  uigetdir;

DataFiles = dir(PathName);

DataFiles(1) = [];
DataFiles(1) = [];


for n = 1 ; length(DataFiles)
    n =1
    %load data set
    load(strcat(PathName,'\',DataFiles(n).name));

    
  dataToAnalyse = data.data;
    
    
    
  
    
    
end