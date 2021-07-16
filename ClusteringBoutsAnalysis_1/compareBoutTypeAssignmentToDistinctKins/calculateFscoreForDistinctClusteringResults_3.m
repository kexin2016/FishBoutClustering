


clear all
close all


AddFunctionToPath

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
DataFiles(1) = [];%erase first file 


%%
%%%%%%%%%%%%%%%%%%%%% load 3d all kins %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 load(char(strcat(dataPath, '\', DataFiles(4).name)),'BoutInf','-mat');%!!! it should break in uni fish debug

%%
%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);
indMistakesIn74KinSpace = find(mistakesIn74KinSpace);

indBoutsToExclude = [indBadBouts' indMistakesIn74KinSpace']';
indGoodBouts = 1 : length(BoutInf);
indGoodBouts(indBoutsToExclude) = [];

 
%%
%%%%%%%%%%%%%%% make binary original matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbInt = 100;
boutCatOrig = BoutInf(:, EnumeratorBoutInf.boutCat);
uniqueBoutcatOrig = unique(boutCatOrig(indGoodBouts));


indGoodBoutsPart = indGoodBouts(1:numbInt:length(indGoodBouts));

boutCatOrigPart = boutCatOrig(indGoodBoutsPart);

binaryOrigianlMatrix = zeros(length(indGoodBoutsPart),length(indGoodBoutsPart));


for i = 1 : length(uniqueBoutcatOrig)
    
    
   indThisCluster = find(boutCatOrigPart == uniqueBoutcatOrig(i));
   
   binaryOrigianlMatrix(indThisCluster,indThisCluster) = 1;
   
    
end



%%
% %%%%%%%%%%%%%%%%%%% check if assignemnt is correct %%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% binaryOrigianlMatrixSmall = binaryOrigianlMatrix(1:10:length(binaryOrigianlMatrix),1:10:length(binaryOrigianlMatrix));
% [~,idx] = sort(boutCatOrigPart(1:10:length(binaryOrigianlMatrix)));
% 
% imagesc(binaryOrigianlMatrixSmall(idx,idx))
% axis square
% colormap('gray')


%%
%%%%%%%%%%%%%%% calculate F1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F1All = zeros(1, length(DataFiles));

for nn = 1 : length(DataFiles)
% n = 7

nn

   load(char(strcat(dataPath, '\', DataFiles(nn).name)),'BoutInf','-mat');%!!! it should break in uni fish debug


   boutCat = BoutInf(:, EnumeratorBoutInf.boutCat);

 
 
    boutCatThisPart = boutCat(indGoodBoutsPart);
uniqueBoutCatThis = unique(boutCat);

binaryMatrixThis = zeros(length(indGoodBoutsPart),length(indGoodBoutsPart));

%%
%%%%%%%%%%%%%%%%%%% make binary matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1 : length(uniqueBoutCatThis)
    
    
   indThisCluster2 = find(boutCatThisPart == uniqueBoutCatThis(i));
   
   binaryMatrixThis(indThisCluster2,indThisCluster2) = 1;
   
    
end


% % check if assignemnt is correct 
%
%
% binaryMatrixThisSmall = binaryMatrixThis(1:5:length(binaryMatrixThis),1:5:length(binaryMatrixThis));
% [~,idx] = sort(boutCatThisPart(1:5:length(binaryMatrixThis)));
% 
% imagesc(binaryMatrixThisSmall(idx,idx))
% axis square
% colormap('gray')
% 


%%
%%%%%%%%%%%%%%%%%%%%%% calculate F score %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F1 = F1ScoreCalculator_2(binaryOrigianlMatrix,binaryMatrixThis);



F1All(nn) = F1; 

end

