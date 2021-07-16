


AddFunctionToPath

close all
clear all

%%
%%%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) gets name of all data sets
%2) loads dataset in loop
%3) saves data set in data set structure
%4) applies automatic based density peak clustering for a range of dcs
%5) saves clustering inf in structure for all data sets
%6) saves eveerything in one variable

%%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick main folder where data set subfolders and fishMap are
folderPath = uigetdir;

listing = dir(folderPath)

%erase dots
listing(1) = [];
listing(1) = [];

%%
%%%%%%%%%%%%%%%%%% loop through each file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for n = 1 : length(listing)
% n =1
    
%%
%%%%%%%%%%%%%% clear loadable vars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars data groudTruth fileName

%%
%%%%%%%%%%%%%%%% load data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fileName = listing(n).name;
    load(strcat(folderPath,'\',fileName));
    
%%
%%%%%%%%%% save data set in structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataSetStructure(n).name = fileName;
dataSetStructure(n).data = data;

if exist('groudTruth')

dataSetStructure(n).groundTruth = groudTruth;


else
    
dataSetStructure(n).groundTruth = [];    

end   
    
%     %look at data set
%     figure
%     plot(data(:,1),data(:,2), '.')
    
    
end

