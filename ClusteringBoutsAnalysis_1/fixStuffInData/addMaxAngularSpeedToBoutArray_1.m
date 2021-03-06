% AddFunctionToPath

close all
clear all


%%
%%%%%%%%%%%%%% load array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%4d prey capture uncov bouts
folder = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\';
fileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated3.mat';

path1 = strcat(folder,fileName);


T = load(path1,'BoutKinematicParameters');
BoutKinematicParameters = T.BoutKinematicParameters;
clearvars T;

T = load(path1,'BoutInf');
BoutInf = T.BoutInf;
clearvars T;



%%
%%%%%%%%%%%%%%%% add zero columns in array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 if size(BoutKinematicParameters,2) < EnumeratorBoutKinPar.beat3beatAngularVelocitySmooth
        
          vectorWithZeros = zeros(size(BoutKinematicParameters,1),1);
          
          for k = 1 : (EnumeratorBoutKinPar.beat3beatAngularVelocitySmooth - size(BoutKinematicParameters,2))
              
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
%%%%%%%%%%%%%%% find datasets that have eye convergence %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indDataSet = 1 : length(fishMap);

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

clearvars -except BoutKinematicParameters BoutInf path1

%%
%%%%%%%%%%%%%%%%%%%% save all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pause
disp('saving array')

load(path1,'boutDataPCASample');
%boutDataPCASample = T.boutDataPCASample;
%clearvars T;

load(path1,'indStructure');
% indStructure = T.indStructure;
% clearvars T;

load(path1,'ROCareaNormDimProjtestNoNans');
% ROCareaNormDimProjtestNoNans = T.ROCareaNormDimProjtestNoNans;
% clearvars T;

load(path1,'clusterStructure');
% clusterStructure = T.clusterStructure;
% clearvars T;

load(path1,'groupClusterSctructure');
% groupClusterSctructure = T.groupClusterSctructure;
% clearvars T;

load(path1,'finalClustering');
% finalClustering = T.finalClustering;
% clearvars T;

load(path1,'behavioralSpaceStructure');
% behavioralSpaceStructure = T.behavioralSpaceStructure;
% clearvars T;



%%
%%%%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folder = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\';

newFileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated4.mat';



save(strcat(folder,newFileName),'BoutInf','BoutKinematicParameters','ROCareaNormDimProjtestNoNans','behavioralSpaceStructure',...
    'boutDataPCASample','clusterStructure','groupClusterSctructure','indStructure','finalClustering','-v7.3')





