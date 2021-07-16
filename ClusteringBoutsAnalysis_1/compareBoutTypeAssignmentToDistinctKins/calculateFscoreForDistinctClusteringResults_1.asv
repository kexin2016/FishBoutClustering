


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

 load(char(strcat(dataPath, '\', DataFiles(4).name)),'-mat');%!!! it should break in uni fish debug

 boutCatAll3dim = BoutInf(:, EnumeratorBoutInf.boutCat);
 
 
  dataToDoMap = finalClustering.dataToDoMap;
   
  assignment = finalClustering.assignment;
   
   uniqueAssignment = unique(assignment);
   
   
   thisBoutCenter = zeros(length(uniqueAssignment),2);
   
   col = jet(length(uniqueAssignment));
   
   figure
   subplot(1,3,1)
   for i = 1 : length(uniqueAssignment)
       
      indThisCluster = find(assignment == uniqueAssignment(i));
      
      
      thisCluster = dataToDoMap(indThisCluster,1:2);
      
      thisBoutCenter(i,1) = nanmean(thisCluster(:,1));
      thisBoutCenter(i,2) = nanmean(thisCluster(:,2));

      
      plot(thisCluster(:,1),thisCluster(:,2), '.', 'color',col(i,:))
      hold on
      plot(thisBoutCenter(i,1),thisBoutCenter(i,2), 'o')
      hold on
   end
axis square
box off
%%
%%%%%%%%%%%%%%%%%%% get stuff I need for analysis %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutCatAll = [];
for n = 1 : length(DataFiles)
%     n =1

n = 5

   load(char(strcat(dataPath, '\', DataFiles(n).name)),'BoutInf','finalClustering','-mat');%!!! it should break in uni fish debug
        
    
   boutCat = BoutInf(:, EnumeratorBoutInf.boutCat);
    
   
   %%
   %%%%%%%%%%%%%%%% sort bout types %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   dataToDoMap = finalClustering.dataToDoMap;
   
   assignment = finalClustering.assignment;
    
   indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
    
   dataToDoMapThis = boutDataPCASample(indsBoutMapInAllData,:);
   
      uniqueAssignment = unique(assignment);

%    figure
   subplot(1,3,2)
   thisBoutCenterThis = zeros(length(uniqueAssignment),2);

   [accuracy, true_labels, CM] = calculateAccuracy(yte, y)
   
   
   for i = 1 : length(uniqueAssignment)
       
      indThisCluster = find(assignment == uniqueAssignment(i));
      
      
      thisCluster = dataToDoMapThis(indThisCluster,1:2);
      
      thisBoutCenterThis(i,1) = nanmean(thisCluster(:,1));
      thisBoutCenterThis(i,2) = nanmean(thisCluster(:,2));

      
      plot(thisCluster(:,1),thisCluster(:,2), '.', 'color',col(i,:))
      hold on
      plot(thisBoutCenterThis(i,1),thisBoutCenterThis(i,2), 'o')
      hold on
      pause
   end
axis square
box off
   
   %%
   boutCatAll = [boutCatAll boutCat];
    
    
    
    
    
    
end


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
%%%%%%%%%%%%%%% calculate F1 score %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% boutCatAll(:,4) = [];
FscoreAll = zeros(11,size(boutCatAll,2));


for nn = 1 : size(boutCatAll,2)
    

    
    
    stats = confusionmatStats(boutCatAll3dim(indGoodBouts),boutCatAll(indGoodBouts,nn));
   confusionMat = stats.confusionMat;
   C = confusionmat(group,grouphat,'order',grouporder) 
   %sort confucion matrix
       C = confusionmat(boutCatAll3dim(indGoodBouts),boutCatAll(indGoodBouts,nn))

   
   
   
    Fscore = stats.Fscore;
    FscoreAll(:,nn) = Fscore;

   
    
    
    
    
    
end






