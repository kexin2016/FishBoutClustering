% AddFunctionToPath

close all
clear all


%%
%%%%%%%%%%%%%% load array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%4d prey capture uncov bouts
folder = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
fileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';


path2 = strcat(folder,fileName);

%%
%%%%%%%%%%%%%%%%%%%% save all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(path2,'finalClustering');


load(path2,'BoutKinematicParameters');
% BoutKinematicParameters = T.BoutKinematicParameters;
% clearvars T;

load(path2,'BoutInf');
% BoutInf = T.BoutInf;
% clearvars T;



%%
%%%%%%%%%%%%%%%% add zero columns in array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%should put in enumerator the laarges that exists in it 


 if size(BoutKinematicParameters,2) < EnumeratorBoutKinPar.eyeConvDiff2
        
          vectorWithZeros = zeros(size(BoutKinematicParameters,1),1);
          
          for k = 1 : (EnumeratorBoutKinPar.eyeConvDiff2 - size(BoutKinematicParameters,2))
              
              BoutKinematicParameters = [BoutKinematicParameters vectorWithZeros];
              
              
          end
           
 end

if size(BoutInf,2) < EnumeratorBoutInf.eyeStateCat
        
          vectorWithZeros = zeros(size(BoutInf,1),1);
          
          for k = 1 : (EnumeratorBoutInf.eyeStateCat - size(BoutInf,2))
              
              BoutInf = [BoutInf vectorWithZeros];
              
              
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
%%%%%%%%%%%%%%% choose datasets to update %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%% loop through each fish and update array %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutUniqueNumberArray = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);



for n = 1 : length(fishMap(indDataSet))%file loop
   n 
   tic
%      n = 1
%     
    %%
    %%%%%%%%%%%%%%load fish file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pathSelectedFish = fishMap(indDataSet(n)).fishPath;
    load(pathSelectedFish)
    
    r =1;
    
   BoutInfThis = allBoutStructure(r).BoutInf;
   BoutKinematicParametersThis = allBoutStructure(r).BoutKinematicParameters;

   
   boutUniqueNumberThisFish = BoutInfThis(:,EnumeratorBoutInf.boutUniqueNumber);
   
  [~,indsA,indsB] = intersect(boutUniqueNumberThisFish,boutUniqueNumberArray);
  
  if ~isempty(indsB)
      
      
      BoutKinematicParameters(indsB,:) = BoutKinematicParametersThis;
      BoutInf(indsB,:) = BoutInfThis;
      
  end
   toc
end

clearvars -except BoutKinematicParameters BoutInf
%%
%%%%%%%%%%%%%%%%%%%% save all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pause
disp('saving array')

load(path2,'boutDataPCASample');
%boutDataPCASample = T.boutDataPCASample;
%clearvars T;

load(path2,'indStructure');
% indStructure = T.indStructure;
% clearvars T;

load(path2,'ROCareaNormDimProjtestNoNans');
% ROCareaNormDimProjtestNoNans = T.ROCareaNormDimProjtestNoNans;
% clearvars T;

load(path2,'clusterStructure');
% clusterStructure = T.clusterStructure;
% clearvars T;

load(path2,'groupClusterSctructure');
% groupClusterSctructure = T.groupClusterSctructure;
% clearvars T;

load(path2,'finalClustering');
% finalClustering = T.finalClustering;
% clearvars T;

load(path2,'behavioralSpaceStructure');
% behavioralSpaceStructure = T.behavioralSpaceStructure;
% clearvars T;



%%
%%%%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folder = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\LDA\';
fileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated2.mat';


% save(strcat(folder,fileName),'BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')

save(strcat(folder,fileName),'BoutInf','BoutKinematicParameters','ROCareaNormDimProjtestNoNans','behavioralSpaceStructure','boutDataPCASample','clusterStructure','groupClusterSctructure','indStructure','finalClustering','-v7.3')



