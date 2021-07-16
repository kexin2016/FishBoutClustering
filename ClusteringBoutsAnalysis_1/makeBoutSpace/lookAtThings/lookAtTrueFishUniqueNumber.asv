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
%%%%%%%%%%%%%%%% pick data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%OMRTurns2
indDataSet1 = find([fishMap.dataSetNumber] == EnumeratorDataSet.OMRTurns2);

%OMRSpeed5
indDataSet2 = find([fishMap.dataSetNumber] == EnumeratorDataSet.OMRSpeed5);

%Obends
indDataSet3 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiFlash3min1sManyInt3);
indDataSet4 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiFlash3min1sManyInt);
 
%beeps
indDataSet5 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap200Hz100ms3min);
indDataSet6 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap400Hz100ms3min);
indDataSet7 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap600Hz100ms3min);
indDataSet8 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap800Hz100ms3min);
indDataSet9 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1000Hz100ms3min);
indDataSet10 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1200Hz100ms3min);
indDataSet11 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1400Hz100ms3min);
indDataSet12 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1600Hz100ms3min);
indDataSet13 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap1800Hz100ms3min);
indDataSet14 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeap2000Hz100ms3min);

indDataSet15 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash200Hz100ms3min);
indDataSet16 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash400Hz100ms3min);
indDataSet17 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash600Hz100ms3min);
indDataSet18 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash800Hz100ms3min);
indDataSet19 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1000Hz100ms3min);
indDataSet20 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1200Hz100ms3min);
indDataSet21 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1400Hz100ms3min);
indDataSet22 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1600Hz100ms3min);
indDataSet23 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash1800Hz100ms3min);
indDataSet24 = find([fishMap.dataSetNumber] == EnumeratorDataSet.multiBeapFlash2000Hz100ms3min);
 
%phototaxis
indDataSet25 = find([fishMap.dataSetNumber] == EnumeratorDataSet.Phototaxis4);

%prey capture
indDataSet26 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCapture);
indDataSet27 = find([fishMap.dataSetNumber] == EnumeratorDataSet.PreyCaptureNaive);
indDataSet28 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.SpontanousEyeTracking);
indDataSet29 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.LightDark3min2);
indDataSet30 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.SpontaneousMultiFishGray);
indDataSet31 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.SpontaneousMultiFishBlack2);

indDataSet32 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.Beeps200to2000);
indDataSet33 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.FlashBeeps200to2000);

indDataSet34 =  find([fishMap.dataSetNumber] == EnumeratorDataSet.ShortLightFlash);

%join data sets
indDataSet = [indDataSet1 indDataSet2 indDataSet3 indDataSet4 indDataSet5 indDataSet6 indDataSet7 indDataSet8 indDataSet9 indDataSet10 indDataSet11 indDataSet12 indDataSet13 indDataSet14 indDataSet15 indDataSet16 indDataSet17 indDataSet18 indDataSet19 indDataSet20 ...
indDataSet21 indDataSet22 indDataSet23 indDataSet24 indDataSet25 indDataSet26 indDataSet27 indDataSet28 indDataSet29 indDataSet30 indDataSet31 indDataSet32 indDataSet33 indDataSet34];



trueUniqueFishNumberBoutsAll = [];

%%
%%%%%%%%%%%%%%%%%concatenate data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BoutInfAll = [];
BoutKinematicParametersAll = [];
FishDataAll = [];
stimOrderAll = [];
indStimStartAll = [];
indBoutStartThisFishAll  = [];
indBoutEndThisFishAll = [];

for n = 1 : length(fishMap(indDataSet))%file loop
    n 
    
   
    %%
    %%%%%%%%%%%%%%load fish file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pathSelectedFish = fishMap(indDataSet(n)).fishPath;
    
     %%
    %%%%%%% avoid corrupt files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
   
    
    load(pathSelectedFish)
    
    
   for nn = 1 : length(allBoutStructure)%loop through each fish
       
   %get bout variables
   BoutInf = allBoutStructure(nn).BoutInf;
   BoutKinematicParameters = allBoutStructure(nn).BoutKinematicParameters;
%     FishData = allBoutStructure(nn).FishData;
   stimOrder = FileInfStructure.stimOrder;
   indStimStart = FileInfStructure.indStimStartAll;
   
   %concatenate fish variables
   
   indStimStartAll = [indStimStartAll' indStimStart']';
   
   if size(BoutInf,2) == 149
       
    zeroVector = zeros(1,size(BoutInf,1))';

    BoutInf = [BoutInf zeroVector zeroVector zeroVector];

   end
   
   
   BoutInfAll = [BoutInfAll' BoutInf']';
   BoutKinematicParametersAll = [BoutKinematicParametersAll' BoutKinematicParameters']';
   
   stimOrderAll = [stimOrderAll' stimOrder']';
   indStimStartAll = [indStimStartAll' indStimStart']';
   
   
   
   %%
   %%%%%%%%%%%%% recreat bout inds so that it works with FishDataAll %%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   indBoutStartAllData = BoutInf(:,EnumeratorBoutInf.indBoutStartAllData);
   indBoutEndAllData = BoutInf(:,EnumeratorBoutInf.indBoutEndAllData);
   
%    indNegInds = find(indBoutStartAllData<0);
%    
%    if ~isempty(indNegInds)
%       
%        pause
%        
%    end
   
   if isempty(FishDataAll)
       
       indBoutStartThisFish = indBoutStartAllData;
       indBoutEndThisFish = indBoutEndAllData;
       
   else
       
       indBoutStartThisFish = length(FishDataAll) + indBoutStartAllData;
       indBoutEndThisFish = length(FishDataAll) + indBoutEndAllData;
   end
   
       indBoutStartThisFishAll = [indBoutStartThisFishAll' indBoutStartThisFish']';
       indBoutEndThisFishAll = [indBoutEndThisFishAll' indBoutEndThisFish']';
       
   %concatenate all fish data
%      FishDataAll = [FishDataAll' FishData']';
   
   end
   
   
    
end

%%

trueUniqueFishNumberAll = BoutInfAll(:,EnumeratorBoutInf.trueUniqueFishNumber);
boutUniqueNumber = BoutInfAll(:,EnumeratorBoutInf.boutUniqueNumber);


figure
plot(trueUniqueFishNumberAll, '.')
