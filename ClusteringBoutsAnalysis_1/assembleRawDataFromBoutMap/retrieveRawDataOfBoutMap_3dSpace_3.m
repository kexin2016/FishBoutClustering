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


% load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')
  load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto_final.mat');


%%
%%%%%%%%%%%%%%%%%%%% get stuff out of boutmap %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

%5d solution
% col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50; 0 0 0])./255;
% idx = [3 7 4 1 2 12 8 10 11 6 9 5];

%3d solution
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

idx = [5 4 9 8 11 10 2 1 7 6 3];



indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
boutMapCat = finalClustering.assignment;
boutUniqueNumber = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);

boutUniqueNumberMap = boutUniqueNumber(indsBoutMapInAllData);
BoutInfMap = BoutInf(indsBoutMapInAllData,:);
BoutKinematicParametersMap = BoutKinematicParameters(indsBoutMapInAllData,:);
boutDataPCASampleMap = boutDataPCASample(indsBoutMapInAllData,:);

clearvars -except BoutInfMap BoutKinematicParametersMap boutDataPCASampleMap behavioralSpaceStructure finalClustering col idx boutUniqueNumberMap...
    allBoutStructure fishMap





%%
%%%%%%%%%%%%%%%%%pick data set%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataSetNumber = BoutInfMap(:,EnumeratorBoutInf.dataSetNumber);
boutCatInMap = BoutInfMap(:,EnumeratorBoutInf.boutCat);

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

indBeatStartAllDataInFinalArray = 0;
indBeatEndAllDataInFinalArray = 0;


boutCatFinalArray = [];     
BoutInfFinalArray = [];     
BoutKinematicParametersFinalArray = [];     

bouSpace = 20;

counter =1;
counterBeat = 1;
% allArrayLength = 0;

BeatKinematicParametersFinalArray = [];
BeatInfFinalArray = [];
BoutCatInHalfBeatFinalArray = [];

for n = 1 : length(fishMap(indDataSet))%file loop
   n 
%      n = 1
%     
    %%
    %%%%%%%%%%%%%%load fish file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pathSelectedFish = fishMap(indDataSet(n)).fishPath;
    load(pathSelectedFish)
    
     for nnn = 1 : length(allBoutStructure)%loop through each fish
       
   %get bout variables
   BoutInf = allBoutStructure(nnn).BoutInf;
   BoutKinematicParameters = allBoutStructure(nnn).BoutKinematicParameters;
   FishData = allBoutStructure(nnn).FishData;
   
   BeatKinematicParameters = allBoutStructure(nnn).BeatKinematicParameters;
   BeatInf = allBoutStructure(nnn).BeatInf;
   boutUniqueNumberInHalfBeats = BeatInf(:,EnumeratorBeatInf.boutUniqueNumber);
   

   boutUniqueNumberThisFish = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);
   
  [mapBoutUniqueNumberThisFish,indsA,indsB] = intersect(boutUniqueNumberThisFish,boutUniqueNumberMap);
  
  
    
  if ~isempty(indsA)
      
    %get start and end of bouts
    indBoutStartAllData = BoutInf(indsA,EnumeratorBoutInf.indBoutStartAllData);
    indBoutEndAllData = BoutInf(indsA,EnumeratorBoutInf.indBoutEndAllData);
%     boutCatThisFish = BoutInf(indsA,EnumeratorBoutInf.boutCat);%bout cat in bout files

    boutCatThisFish = boutCatInMap(indsB);%boutcat in map

    
    BoutInfThisFish = BoutInf(indsA,:);
    BoutKinematicParametersThisFish = BoutKinematicParameters(indsA,:);
    
    
   
      for nn = 1 : length(indBoutStartAllData)%loop through each bout 
          
          %%
          %%%%%%%%%%%%% get half beats of this bout %%%%%%%%%%%%%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
          indHalfBeatsThisBout = find(boutUniqueNumberInHalfBeats == mapBoutUniqueNumberThisFish(nn));
          
          BeatKinematicParametersThisBout = BeatKinematicParameters(indHalfBeatsThisBout,:);
          BeatInfThisBout = BeatInf(indHalfBeatsThisBout,:);
          
          %get ind of half beats from start of bout
%           indBeatStartInBout = BeatInfThisBout(:,EnumeratorBeatInf.indBeatStartInBout);
%           indBeatEndInBout = BeatInfThisBout(:,EnumeratorBeatInf.indBeatEndInBout);    
          indBeatStartInBout = BeatInfThisBout(:,EnumeratorBeatInf.indBeatStartAllData);
          indBeatEndInBout = BeatInfThisBout(:,EnumeratorBeatInf.indBeatEndAllData);    
          

          BeatKinematicParametersFinalArray =[BeatKinematicParametersFinalArray' BeatKinematicParametersThisBout']';
          BeatInfFinalArray = [BeatInfFinalArray' BeatInfThisBout']';
          
          BoutCatInHalfBeatArrayThisBout = zeros(length(indHalfBeatsThisBout),1) + boutCatThisFish(nn);
          
          BoutCatInHalfBeatFinalArray = [BoutCatInHalfBeatFinalArray' BoutCatInHalfBeatArrayThisBout']';
          
          %%
          %%%%%%%%%%%%%%% get raw data in map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
          %avoid being out of data
          if indBoutStartAllData(nn)-bouSpace < 1 || indBoutEndAllData(nn)+bouSpace > size(FishData,1)
             
              bouSpace1 = 0;
              
          else
              
              bouSpace1 = bouSpace;
              
          end
          
          indBoutStartAllDataWithSpace = indBoutStartAllData(nn) - bouSpace1;
          indBoutEndAllDataWithSpace = indBoutEndAllData(nn) + bouSpace1;
          
          
          indBeatStartInBoutWithSpace =  indBeatStartInBout - (indBoutStartAllData(nn) - bouSpace1);
          indBeatEndInBoutWithSpace =  indBeatEndInBout - (indBoutStartAllData(nn) - bouSpace);
          
%           indBeatStartInBoutWithSpace = indBeatStartInBout;
%           indBeatEndInBoutWithSpace = indBeatEndInBout;
          
          FishDataThisBout = FishData(indBoutStartAllDataWithSpace:indBoutEndAllDataWithSpace,:);
          FishDataMap = [FishDataMap' FishDataThisBout']';
          
         %save inds of bout in raw data that is being concatenated 
         indBoutStartAllDataInFinalArray(counter) = size(FishDataMap,1) - (indBoutEndAllDataWithSpace - indBoutStartAllDataWithSpace);
         indBoutEndAllDataInFinalArray(counter) = size(FishDataMap,1);
         

         %save inds of beats in raw data that is being concatenated 
         for t = 1 : length(indBeatStartInBoutWithSpace)
         
         indBeatStartAllDataInFinalArray(counterBeat) =  indBoutStartAllDataInFinalArray(counter) + indBeatStartInBoutWithSpace(t);
         indBeatEndAllDataInFinalArray(counterBeat) =  indBoutStartAllDataInFinalArray(counter) + indBeatEndInBoutWithSpace(t);
         
         
         counterBeat = counterBeat +1;
         end
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

BeatKinematicParametersOfMapAll = [];
BeatInfOfMapAll = [];
BoutCatInHalfbeatArray = [];

save('C:\Joao analysis\BoutMapWithRawWithHalfbeats_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto.mat',...
    'behavioralSpaceStructure','finalClustering','col','FishDataMap','indBoutStartAllDataInFinalArray','indBoutEndAllDataInFinalArray',...
    'indBeatStartAllDataInFinalArray','indBeatEndAllDataInFinalArray',...
    'boutCatFinalArray','BoutInfFinalArray','BoutKinematicParametersFinalArray','BeatKinematicParametersFinalArray',...
    'BeatInfFinalArray','BoutCatInHalfBeatFinalArray','col','idx','-v7.3')


