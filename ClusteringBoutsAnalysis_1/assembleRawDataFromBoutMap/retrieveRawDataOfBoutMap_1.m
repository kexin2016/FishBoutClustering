clear all
close all


%%
%%%%%%%%%%%%%%%%%%%%%pick Bout fish map%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick main folder where data set subfolders and fishMap are
dataPath =  uigetdir;

%get fishStimMap name and path
DataFiles = dir(dataPath);

%determine wich are folder
isFolderVector = [DataFiles(:).isdir];

%fins fishMap
nameFishMap = DataFiles(find(isFolderVector == 0)).name;


%make file of fish map
pathFishName = strcat(dataPath, '\',nameFishMap);

%load fish map
load(pathFishName)

%%
%%%%%%%%%%%%%%% load bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')


%%
%%%%%%%%%%%%%%%%%%%% get stuff out of boutmap %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50; 0 0 0])./255;
idx = [3 7 4 1 2 12 8 10 11 6 9 5];




indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
boutMapCat = finalClustering.assignment;
boutUniqueNumber = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);

boutUniqueNumberMap = boutUniqueNumber(indsBoutMapInAllData);
BoutInfMap = BoutInf(indsBoutMapInAllData,:);
BoutKinematicParametersMap = BoutKinematicParameters(indsBoutMapInAllData,:);
boutDataPCASampleMap = boutDataPCASample(indsBoutMapInAllData,:);

clearvars -except BoutInfMap BoutKinematicParametersMap boutDataPCASampleMap behavioralSpaceStructure finalClustering col boutUniqueNumberMap...
    allBoutStructure fishMap





%%
%%%%%%%%%%%%%%%%%pick data set%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataSetNumber = BoutInfMap(:,EnumeratorBoutInf.dataSetNumber);
uniqueDataSetNumber = unique(dataSetNumber);

indDataSet = [];
for n = 1 : length(uniqueDataSetNumber)
    
indDataSet1 = find([fishMap.dataSetNumber] == uniqueDataSetNumber(n));
indDataSet = [indDataSet indDataSet1];
    
end


%%
%%%%%%%%%%%%%%%%% loop through files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FishDataMap = [];          
indBoutStartAllDataInFinalArray = 0;
indBoutEndAllDataInFinalArray = 0;
boutCatFinalArray = [];     
BoutInfFinalArray = [];     
BoutKinematicParametersFinalArray = [];     

bouSpace = 20;

counter =1;
% allArrayLength = 0;
for n = 1 : length(fishMap(indDataSet))%file loop
   n 
%     n = 1
    
    %%
    %%%%%%%%%%%%%%load fish file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pathSelectedFish = fishMap(indDataSet(n)).fishPath;
    load(pathSelectedFish)
    
     for nn = 1 : length(allBoutStructure)%loop through each fish
       
   %get bout variables
   BoutInf = allBoutStructure(nn).BoutInf;
   BoutKinematicParameters = allBoutStructure(nn).BoutKinematicParameters;
   FishData = allBoutStructure(nn).FishData;

   boutUniqueNumberThisFish = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);
   
  [~,indsA,] = intersect(boutUniqueNumberThisFish,boutUniqueNumberMap);
  
   
  
  
  if ~isempty(indsA)
      
    %get start and end of bouts
    indBoutStartAllData = BoutInf(indsA,EnumeratorBoutInf.indBoutStartAllData);
    indBoutEndAllData = BoutInf(indsA,EnumeratorBoutInf.indBoutEndAllData);
    boutCatThisFish = BoutInf(indsA,EnumeratorBoutInf.boutCat);
    BoutInfThisFish = BoutInf(indsA,:);
    BoutKinematicParametersThisFish = BoutKinematicParameters(indsA,:);
    
      for nn = 1 : length(indBoutStartAllData)%loop through each bout 
          
          %avoid being out of data
          if indBoutStartAllData(nn)-bouSpace < 1 || indBoutEndAllData(nn)+bouSpace > size(FishData,1)
             
              bouSpace1 = 0;
              
          else
              
              bouSpace1 = bouSpace;
              
          end
          
          indBoutStartAllDataWithSpace = indBoutStartAllData(nn)-bouSpace1;
          indBoutEndAllDataWithSpace = indBoutEndAllData(nn)+bouSpace1;
          
          FishDataThisBout = FishData(indBoutStartAllDataWithSpace:indBoutEndAllDataWithSpace,:);
          FishDataMap = [FishDataMap' FishDataThisBout']';
          
         indBoutStartAllDataInFinalArray(counter) = size(FishDataMap,1) - (indBoutEndAllDataWithSpace - indBoutStartAllDataWithSpace);
         indBoutEndAllDataInFinalArray(counter) = size(FishDataMap,1);
         
         counter = counter +1;
      end
      
      BoutInfFinalArray = [BoutInfFinalArray' BoutInfThisFish']';
      BoutKinematicParametersFinalArray = [BoutKinematicParametersFinalArray' BoutKinematicParametersThisFish']';
      boutCatFinalArray = [boutCatFinalArray' boutCatThisFish']';

      
%       if counter ~=1
%           allArrayLength = allArrayLength + size(FishDataMap,1);
%       end
%     
      
%       
%       boutCatThisBouts = BoutInf(indsA,EnumeratorBoutInf.boutCat);
%       
%       
%       BoutCatFishMapNew = [BoutCatFishMapNew' boutCatThisBouts']';
      
      
  end

     end
    
end




%%
%%%%%%%%%%%%%%%%% save bout map all %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('C:\Joao analysis\BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat',...
    'behavioralSpaceStructure','finalClustering','col','FishDataMap','indBoutStartAllDataInFinalArray','indBoutEndAllDataInFinalArray',...
    'boutCatFinalArray','BoutInfFinalArray','BoutKinematicParametersFinalArray', '-v7.3')


