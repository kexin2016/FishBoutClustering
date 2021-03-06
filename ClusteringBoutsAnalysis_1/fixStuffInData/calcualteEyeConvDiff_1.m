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
%%%%%%%%%%%%%%%%%pick data set%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%datasets
indDataSetStruct(1).ind = EnumeratorDataSet.PreyCapture;
indDataSetStruct(2).ind = EnumeratorDataSet.PreyCaptureNaive;
indDataSetStruct(3).ind = EnumeratorDataSet.SpontanousEyeTracking;



indDataSet1 = find([fishMap.dataSetNumber] == indDataSetStruct(1).ind);
indDataSet2 = find([fishMap.dataSetNumber] == indDataSetStruct(2).ind);
indDataSet3 = find([fishMap.dataSetNumber] == indDataSetStruct(3).ind);

indDataSet = [indDataSet1 indDataSet2 indDataSet3];
  
%%
%%%%%%%%%%%%%%%%%% load BoutCat data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
FileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged8.mat';


 load(strcat(PathName,FileName))


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% find ind of datasets %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataSetNumber = BoutInf(:,EnumeratorBoutInf.dataSetNumber);
boutUniqueNumber = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);

indAll = [];

for n = 1 : length(indDataSetStruct)
    
    ind = indDataSetStruct(n).ind;
    indBouts = find(dataSetNumber == ind);
    
    indAll = [indAll' indBouts']';
    
    
end

boutUniqueNumberAllData = boutUniqueNumber(indAll);


%%



bouSpace = 20;

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
         
            BoutInfThis = allBoutStructure(nnn).BoutInf;
            FishData = allBoutStructure(nnn).FishData;
            convergengePar = FishData(:,EnumeratorFishData.convergengePar);

            
            boutUniqueNumberThisFish = BoutInfThis(:,EnumeratorBoutInf.boutUniqueNumber);
            [boutUniqueNumberThisFish2,indsA] = intersect(boutUniqueNumberThisFish,boutUniqueNumberAllData);
            
            %find place in boutInf array
            [~,indsB]= intersect(boutUniqueNumber,boutUniqueNumberThisFish2);

       
       %%
       %%%%%%%%%%%%%%%% calculate eyeConvDiff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       

       indBoutStartAllData = BoutInfThis(:,EnumeratorBoutInf.indBoutStartAllData);
       indBoutEndAllData = BoutInfThis(:,EnumeratorBoutInf.indBoutEndAllData);
   
    if ~isnan(sum(convergengePar))
         
        eyeConvDiffThis = zeros(1, length(indBoutStartAllData));

        for i = 1 : length(indBoutStartAllData)%loop through each bout 

       
       %avoid being out of data
          if indBoutStartAllData(i)- bouSpace < 1 || indBoutEndAllData(i) + bouSpace > size(FishData,1)
             
              bouSpace1 = 0;
              
          else
              
              bouSpace1 = bouSpace;
              
          end
          
          
          indBoutStartAllDataWithSpace = indBoutStartAllData(i) - bouSpace1;
          indBoutEndAllDataWithSpace = indBoutEndAllData(i) + bouSpace1;
          convergengeParThisBout = convergengePar(indBoutStartAllDataWithSpace:indBoutEndAllDataWithSpace)*180/pi;
          


            if length(convergengeParThisBout) > 140
                
            indend = 130;
            
            else
                
            indend = length(convergengeParThisBout)-10;

        
            end


          eyeConvDiffThis(i) = nanmean(convergengeParThisBout(indend:(indend+10))) - nanmean(convergengeParThisBout(1:10));

          
        end
        
    else
       eyeConvDiffThis = zeros(size(BoutInfThis,1),1);
       eyeConvDiffThis(:,:) = nan;
    end
         
    
    %%
    %%%%%%%%%%%%%%%%%%%%%%% save eyeConvDiff in array %%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    BoutInf(indsB,EnumeratorBoutInf.eyeConvDiff) = eyeConvDiffThis;
            
     end
     
     
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
FileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged9.mat';


save(strcat(PathName,FileName),'BoutInf','BoutKinematicParameters','ROCareaNormDimProjtestNoNans','behavioralSpaceStructure','boutDataPCASample','clusterStructure','groupClusterSctructure','indStructure','finalClustering','-v7.3')

