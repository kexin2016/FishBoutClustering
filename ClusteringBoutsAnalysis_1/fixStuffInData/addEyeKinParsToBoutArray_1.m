% AddFunctionToPath

close all
clear all


%%
%%%%%%%%%%%%%% load array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%4d prey capture uncov bouts
folder = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
fileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated2.mat';


path2 = strcat(folder,fileName);


T = load(path1,'BoutKinematicParameters');
BoutKinematicParameters = T.BoutKinematicParameters;
clearvars T;

T = load(path1,'BoutInf');
BoutInf = T.BoutInf;
clearvars T;



%%
%%%%%%%%%%%%%%%% add zero columns in array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 if size(BoutKinematicParameters,2) < EnumeratorBoutKinPar.eyeConvDiff2
        
          vectorWithZeros = zeros(size(BoutKinematicParameters,1),1);
          
          for k = 1 : (EnumeratorBoutKinPar.eyeConvDiff2 - size(BoutKinematicParameters,2))
              
              BoutKinematicParameters = [BoutKinematicParameters vectorWithZeros];
              
              
          end
           
 end


%%
%%%%%%%%%%%%%%%%%%%%%pick Bout fish map%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick main folder where data set subfolders and fishMap are
% dataPath =  uigetdir;


dataPath = 'C:\Joao analysis\FreeData\boutFiles\boutFilesFinal\';
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
%%%%%%%%%%%%%%% find datasets that have eye convenrgence %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 indDataSet1 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCapture);
  indDataSet2 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureNaive);
  indDataSet3 = find([fishMap.dataSetNumber] == EnumeratorDataSet.SpontanousEyeTracking);
  indDataSet4 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureSmallRotTuNaive);
  indDataSet5 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureSmallRotTuNaive2);
  indDataSet6 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureSmallRotTuWithRot);
  indDataSet7 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureNaiveTu);
  indDataSet8 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureNaiveTu2);
  indDataSet9 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureExpTu);
  indDataSet10 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureExpTu2);

indDataSet = [indDataSet1 indDataSet2 indDataSet3 indDataSet4 indDataSet5 indDataSet6 indDataSet7 indDataSet8 indDataSet9 indDataSet10];


%%
%%%%%%%%%%%%%%%%%%

boutUniqueNumberArray = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);



for n = 1 : length(fishMap(indDataSet))%file loop
   n 
%      n = 1
%     
    %%
    %%%%%%%%%%%%%%load fish file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pathSelectedFish = fishMap(indDataSet(n)).fishPath;
    load(pathSelectedFish)
    
    r =1
    
   BoutInfThis = allBoutStructure(r).BoutInf;
   BoutKinematicParametersThis = allBoutStructure(r).BoutKinematicParameters;

   
   boutUniqueNumberThisFish = BoutInfThis(:,EnumeratorBoutInf.boutUniqueNumber);
   
  [mapBoutUniqueNumberThisFish,indsA,indsB] = intersect(boutUniqueNumberThisFish,boutUniqueNumberArray);
  
  if ~isempty(indsB)
      
      
      BoutKinematicParameters(indsB,:) = BoutKinematicParametersThis;
      
      
  end
   
end
