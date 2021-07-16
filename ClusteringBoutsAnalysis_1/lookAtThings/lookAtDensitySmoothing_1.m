%%
%%%%%%%%%%%% what this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1)impoorts Kedens files
%2) puts densities with several smoothing factors in same structure
%3) makes plot with diferent smotting for wach data set



%%
clear all
close all


AddFunctionToPath

%get folder name where the folders with each dataset are
dataPath =  uigetdir;%choose kedens folder

%%
%%%%%%%%%%%%%%%%%%get names of all files of all data sets%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%test function


%creats structure with names of things inside folder
DataFiles = dir(dataPath);

%erase dots
DataFiles(1) = [];
DataFiles(1) = [];

%erase first data set - kedens without smoothing
DataFiles(1) = [];


%%
%%%%%%%%%%%%%% get densities and rand numbers for each data set %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for n = 1 : length(DataFiles)
    n
        load(char(strcat(dataPath, '\', DataFiles(n).name)),'-mat');
        
        %%
        %%%%%%%%%%%%%%%% make densitySmoothingStruct %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if n == 1 
         for nn = 1 : length(indStructure)  
             
        densitySmoothingStruct(nn).thisIndRand = []; 
        densitySmoothingStruct(nn).densities = []; 
        densitySmoothingStruct(nn).scallingFactor = []; 
        
         end
        end
        
        
        %%
        %%%%%%%%%% get things %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for nn = 1 : length(indStructure)  
            
        thisIndRand = indStructure(nn).thisIndRand;
        densities = indStructure(nn).densitiesScalled';
        scallingFactor = indStructure(nn).scallingFactor;
        
        
        
        thisIndRandAll = densitySmoothingStruct(nn).thisIndRand; 
        densitiesAll = densitySmoothingStruct(nn).densities; 
        scallingFactorAll = densitySmoothingStruct(nn).scallingFactor; 
        
        thisIndRandAll = [thisIndRandAll thisIndRand]; 
        densitiesAll = [densitiesAll densities];  
        scallingFactorAll = [scallingFactorAll scallingFactor];  
        
        densitySmoothingStruct(nn).thisIndRand = thisIndRandAll; 
        densitySmoothingStruct(nn).densities = densitiesAll; 
        densitySmoothingStruct(nn).scallingFactor = scallingFactorAll; 
        
        
        
        end
   
end

%%
%%%%%%%% indStructure map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indOMRTurns2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.OMRTurns2))';%1-13
% indOMRSpeed5 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.OMRSpeed5))';%14-23
% 
% indLightDark3min2 =  intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LightDark3min2))';%24-27
% 
% indMultiFlash3min1sManyInt = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt))';%28 dark; 29 light
% indMultiFlash3min1sManyInt3 =  intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiFlash3min1sManyInt3))';%30 dark; 31 light
% 
% indmultiBeap200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap200Hz100ms3min))';%32
% indmultiBeap400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap400Hz100ms3min))';%33
% indmultiBeap600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap600Hz100ms3min))';%34
% indmultiBeap800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap800Hz100ms3min))';%35
% indmultiBeap1000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1000Hz100ms3min))';%36
% indmultiBeap1200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1200Hz100ms3min))'; %37
% indmultiBeap1400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1400Hz100ms3min))';%38
% indmultiBeap1600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1600Hz100ms3min))'; %39
% indmultiBeap1800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap1800Hz100ms3min))';%40
% indmultiBeap2000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeap2000Hz100ms3min))'; %41
% indmultiBeapFlash200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash200Hz100ms3min))'; %42
% indmultiBeapFlash400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash400Hz100ms3min))';%43
% indmultiBeapFlash600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash600Hz100ms3min))'; %44
% indmultiBeapFlash800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash800Hz100ms3min))';%45
% indmultiBeapFlash1000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1000Hz100ms3min))';%46
% indmultiBeapFlash1200Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1200Hz100ms3min))';%47
% indmultiBeapFlash1400Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1400Hz100ms3min))';%48
% indmultiBeapFlash1600Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1600Hz100ms3min))';%49
% indmultiBeapFlash1800Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash1800Hz100ms3min))';%50
% indmultiBeapFlash2000Hz100ms3min = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.multiBeapFlash2000Hz100ms3min))';%51
% 
% indBeeps200to2000 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.Beeps200to2000))';%32 - 51
% indFlashBeeps200to2000 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.FlashBeeps200to2000))';%32 - 51
% 
% indPhototaxis4 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.Phototaxis4))';%52 with obends; 53 no obends
% 
% indPreyCapture = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCapture))';%54-55
% indPreyCaptureNaive = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.PreyCaptureNaive))';%56-57
% indSpontanousEyeTracking = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.SpontanousEyeTracking))';%58-59
% 
% indBeepsLightDarkEyeConv = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.BeepsLightDarkEyeConv))';%60 - 64
% indBigCircleDiferentDirections2 = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.bigCircleDiferentDirections2))';%65 to 72
% indLoomingDiferentSpeeds = intersect(indGoodBouts,find(dataSetNumber == EnumeratorDataSet.LoomingDiferentSpeeds))';%73 to 78


%%
%%%%%%%%%%%% look at densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  indStruct = 1:13;%indOMRTurns2
 indStruct = 14:23;%indOMRSpeed5
  indStruct = 24:27;%indLightDark3min2
 indStruct = 28:31;%flashs
%  indStruct = 32:51;%Beeps
%  indStruct = 52:53;%indPhototaxis4
%   indStruct = 54:59;%prey capture
%   indStruct = 60:64;%prey capture
%   indStruct = 65:72;%visual escapes
 
 
figure
for i =  1 : length(indStruct)

%    i =1 
    thisIndRandAll = densitySmoothingStruct(indStruct(i)).thisIndRand; 
    densitiesAll = densitySmoothingStruct(indStruct(i)).densities; 
     scallingFactorAll = densitySmoothingStruct(indStruct(i)).scallingFactor; 
    
    col = jet(size(thisIndRandAll,2));
    
    clf
    for ii = 1 : length(1 : size(thisIndRandAll,2))
        subplot(2,3,ii)
%         plot3(boutDataPCASample(thisIndRandAll(:,ii),1),boutDataPCASample(thisIndRandAll(:,ii),2),densitiesAll(:,ii), '.','color',col(ii,:))
         plot3(boutDataPCASample(thisIndRandAll(:,ii),1),boutDataPCASample(thisIndRandAll(:,ii),2),densitiesAll(:,ii), '.','color','k')
        hold on
%         axis([-15 20 -10 15 0 max(max(densitiesAll))])
        axis([-15 20 -10 15 0 max(densitiesAll(:,ii))])

       title(scallingFactorAll(ii))
        axis square

    end    
      pause   
        
    
   
    
    
end    