
AddFunctionToPath

%   close all
% clear all


%%
%%%%%%%%%%%%%%%%%%%%%% load all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\';
FileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated3.mat';


 load(strcat(PathName,FileName),'BoutInf')
 load(strcat(PathName,FileName),'finalClustering')
 load(strcat(PathName,FileName),'BoutKinematicParameters')
 load(strcat(PathName,FileName),'boutDataPCASample')


%%
%%%%%%%%%%%%%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_corr_1(BoutInf,pickFirstBout,edgeLim);

mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);

indKinSpaceMistake = find(mistakesIn74KinSpace);

indExcludedBoutsAll  = unique([indBadBouts' indKinSpaceMistake']');

indAllGoodBouts = 1 : length(BoutInf);
indAllGoodBouts(indExcludedBoutsAll) = [];


% BoutKinematicParametersGood = BoutKinematicParameters(indAllGoodBouts,:);
% BoutInfGood  = BoutInf(indAllGoodBouts,:);




%%
%%%%%%%%%%%%%%%% define color map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;



%%
%%%%%%%%% plot clusters in all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
col = finalClustering.col;
idx = finalClustering.idx;

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
latencyOfBoutAfterStim = BoutInf(:,EnumeratorBoutInf.latencyOfBoutAfterStim);



uniqueBoutCat = unique(boutCat);
% col = jet(length(uniqueBoutCat));

sizeClustersInAllData = zeros(1,length(uniqueBoutCat));
sizeClustersInAllDataCore = zeros(1,length(uniqueBoutCat));

figure
for nn = 1 : length(uniqueBoutCat)

indThisCluster = find(boutCat == uniqueBoutCat(idx(nn)));

%  numbBoutsToPick = length(indThisCluster);
  numbBoutsToPick = 1000;

indPerm = randperm(length(indThisCluster));
indThisClusterRand = indThisCluster(indPerm(1:numbBoutsToPick));
    
   
   
indThisClusterRandCore = intersect(indAllGoodBouts,indThisClusterRand);
   

% subplot(1,2,1)
% plot3(boutDataPCASample(indThisClusterRand,1),boutDataPCASample(indThisClusterRand,2),boutDataPCASample(indThisClusterRand,3),'.','color',col(nn,:))
% hold on
% axis square
%  axis([-25 30 -10 25 -10 50])   
% 
% subplot(1,2,2)
%   plot3(finalData(indThisClusterRand,1),finalData(indThisClusterRand,2),finalData(indThisClusterRand,3),'.','color','k')
hold on
% plot3(boutDataPCASample(indThisClusterRandCore,1),boutDataPCASample(indThisClusterRandCore,2),boutDataPCASample(indThisClusterRandCore,3),'.','color',col(indOrderOfBouts(nn),:))
% hold on
% axis square
% axis([-25 30 -10 25 -10 10])   

plot(boutDataPCASample(indThisClusterRandCore,1),boutDataPCASample(indThisClusterRandCore,2),'.','color',col(nn,:))
hold on
axis square
axis([-15 25 -10 15])   
xlabel('PC 1')
ylabel('PC 2')
title(uniqueBoutCat(nn))
%  plot3(boutDataPCASample(indThisCluster,1),boutDataPCASample(indThisCluster,2),boutDataPCASample(indThisCluster,3), '.','color', col(nn,:))
% plot(boutDataPCASample(indThisCluster,1),boutDataPCASample(indThisCluster,2), '.','color', col(nn,:))

hold on

sizeClustersInAllData(nn) = length(indThisClusterRand);
sizeClustersInAllDataCore(nn) = length(indThisClusterRandCore);

%   pause
end

percentOfBoutTypeCore =  sizeClustersInAllDataCore./(sum(sizeClustersInAllDataCore))*100;
percentOfBoutType =  sizeClustersInAllData./(sum(sizeClustersInAllData))*100;


%%
%%%%%%%%%%%%%%%%% indStimSctructure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[indStimSctructure,stimNameAll] = makeIndStimSctructure_3(BoutInf,BoutKinematicParameters);



%  ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCapture);
% %  ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaive);
% %   ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.SpontanousEyeTracking);
% 
% %     ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaiveTu);
% %     ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureExpTu);
% %     ind = find(BoutInf(:,EnumeratorBoutInf.dataSetNumber) == EnumeratorDataSet.PreyCaptureNaiveTu2);
% 
% 
% 
% 
%  figure
% plot(BoutInf(ind,end));

%%
%%%%%%%%%%%%% calculate prob of bout type %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

probBoutType = zeros(length(indStimSctructure),length(uniqueBoutCat));
probBoutTypeGood = zeros(length(indStimSctructure),length(uniqueBoutCat));

probOfLatencySmall = zeros(length(indStimSctructure),1);
latencyThres = 200;

for n = 1 : length(indStimSctructure)
  n  
    indThisStim = indStimSctructure(n).ind;
    indThisStimGood  = intersect(indThisStim,indAllGoodBouts); 
    
    
    for nn = 1 : length(uniqueBoutCat)
    
        indThisBoutType = find(boutCat == uniqueBoutCat(nn)); 
        
        %%
        %%%%%%%%%%%%%%%%%%%%%%%% get inds for probs %%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        indThisBoutsAll = intersect(indThisStim,indThisBoutType);
                
        indThisBoutsGood = intersect(indAllGoodBouts,indThisBoutsAll);
        
        
         %%
%         %%%%%%%%%%%%%%%% find left and right bouts %%%%%%%%%%%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         
%         beat1beatAmplitudeAvrThisBoutType = beat1beatAmplitudeAvr(indThisBoutsGood,:);
%         boutAngleThisBoutType = boutAngle(indThisBoutsGood,:);
%         
%       
        
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%% calculate probabilities%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        probBoutType(n,nn) = length(indThisBoutsAll)./length(indThisStim);
        
        
        probBoutTypeGood(n,nn) = length(indThisBoutsGood)./length(indThisStimGood);
        
        
      
    end
    
     indSmallLatency = find(latencyOfBoutAfterStim(indThisStimGood) <= latencyThres);
        
        probOfLatencySmall(n) = length(indSmallLatency)/length(indThisStimGood);
        
    
    
end

% %merged 7 solution
% idx = [2 12 3 7 4 1 11 10 6 5 8 9 13];

%merged 8 solution
 %idx = [1 9 11 3 4 5 2 10 8 6 13 12 7];

 %merged 11
%  idx = finalClustering.idx;
 
probBoutTypeGoodSorted = probBoutTypeGood(:,idx);




%%
%%%%%%%%%%%%%%% make heat map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spaceVector = (zeros(1, length(1:length(uniqueBoutCat))) + 1);
indOMRSpeed5 = 2:11;
indOMRTurns2 = 14:26;
indBeeps = 27:36;
indFlashBeeps = 37:46;
indDarkFlashs = [53 54 56 59 63 68 69 71 74 78];
indLightFlashs = [ 102 106 109 111 112];
% indPhototaxis = 125:129;
indPhototaxis = 125:128;%less one to have same amount of colmuns

ind3minDark = 148:155;
ind3minLight = 156:163;
ind3minLux = 155;

indLoomDirectionsAllStims = 164:171;
indLoomDirectionsColapsed = 164:168;

indLoomingSpeed = 169:174;
% indPrey = 47:52;%old
indPrey = 175:189;


% 
% probBoutTypeWithSpaceGood = [probBoutTypeGood(ind3minDark,:)', spaceVector', probBoutTypeGood(ind3minLight,:)', spaceVector',probBoutTypeGood(indSpontLightDark,:)', spaceVector', probBoutTypeGood(indPrey,:)',...
% spaceVector',probBoutTypeGood(  indOMRSpeed5,:)', spaceVector',probBoutTypeGood(  indOMRTurns2,:)' spaceVector',...
% probBoutTypeGood(  indBeeps,:)', spaceVector',probBoutTypeGood(  indFlashBeeps,:)' , spaceVector',probBoutTypeGood(   indDarkFlashs,:)',...
% spaceVector',probBoutTypeGood(   indLightFlashs,:)', spaceVector',probBoutTypeGood(   indPhototaxis,:)' ]';
 
% probBoutTypeWithSpaceGood = [probBoutTypeGood(ind3minLux,:)', probBoutTypeGood(ind3minLight,:)', spaceVector', probBoutTypeGood(indPrey,:)',...
% spaceVector',probBoutTypeGood(  indOMRSpeed5,:)', spaceVector',probBoutTypeGood(  indOMRTurns2,:)' spaceVector',...
% probBoutTypeGood(  indBeeps,:)', spaceVector',probBoutTypeGood(  indFlashBeeps,:)' , spaceVector',probBoutTypeGood(   indDarkFlashs,:)',...
%  spaceVector',probBoutTypeGood(   indPhototaxis,:)',spaceVector',probBoutTypeGood(   indLoomDirectionsColapsed,:)',...
%  spaceVector',probBoutTypeGood(   indLoomingSpeed,:)' ]';

% probBoutTypeWithSpaceGood = [probBoutType(ind3minLux,:)', probBoutType(ind3minLight,:)', spaceVector', probBoutType(indPrey,:)',...
% spaceVector',probBoutType(  indOMRSpeed5,:)', spaceVector',probBoutType(  indOMRTurns2,:)' spaceVector',...
% probBoutType(  indBeeps,:)', spaceVector',probBoutType(  indFlashBeeps,:)' , spaceVector',probBoutType(   indDarkFlashs,:)',...
%  spaceVector',probBoutType(   indPhototaxis,:)',spaceVector',probBoutType(   indLoomDirectionsAllStims,:)' ]';


probBoutTypeWithSpaceGood = [probBoutTypeGoodSorted(ind3minLux,:)', probBoutTypeGoodSorted(ind3minLight,:)', spaceVector', probBoutTypeGoodSorted(indPrey,:)',...
spaceVector',probBoutTypeGoodSorted(  indOMRSpeed5,:)', spaceVector',probBoutTypeGoodSorted(  indOMRTurns2,:)',spaceVector',probBoutTypeGoodSorted(   indPhototaxis,:)',...
 spaceVector',probBoutTypeGoodSorted(  indBeeps,:)', spaceVector',probBoutTypeGoodSorted(  indFlashBeeps,:)' , spaceVector',probBoutTypeGoodSorted(   indDarkFlashs,:)',...
 spaceVector',probBoutTypeGoodSorted(   indLoomDirectionsColapsed,:)',...
 spaceVector',probBoutTypeGoodSorted(   indLoomingSpeed,:)' ]';



figure
imagesc(probBoutTypeWithSpaceGood')
colormap('gray')
axis equal 
box off
axis([0.5 size(probBoutTypeWithSpaceGood,1)+0.5 0.5 size(probBoutTypeWithSpaceGood,2)+0.5])
colorbar
caxis([0 0.7])
axis off
 

%%
%%%%%%%%%%%%%%% plot heat plot in 2 rows %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


probBoutTypeWithSpaceGood1 = [probBoutTypeGoodSorted(ind3minLux,:)', probBoutTypeGoodSorted(ind3minLight,:)', spaceVector', probBoutTypeGoodSorted(indPrey,:)',...
spaceVector',probBoutTypeGoodSorted(  indOMRSpeed5,:)', spaceVector',probBoutTypeGoodSorted(  indOMRTurns2,:)',spaceVector',probBoutTypeGoodSorted(   indPhototaxis,:)']';


probBoutTypeWithSpaceGood2 = [probBoutTypeGoodSorted(  indBeeps,:)', spaceVector',probBoutTypeGoodSorted(  indFlashBeeps,:)' , spaceVector',probBoutTypeGoodSorted(   indDarkFlashs,:)',...
spaceVector',probBoutTypeGoodSorted(   indLoomDirectionsColapsed,:)',...
spaceVector',probBoutTypeGoodSorted(   indLoomingSpeed,:)',spaceVector',spaceVector',spaceVector',spaceVector',spaceVector',spaceVector',spaceVector',spaceVector',spaceVector',spaceVector' ]';

spaceVector2 = (zeros(1, length(probBoutTypeWithSpaceGood1))+1);

probBoutTypeWithSpaceGoodAll = [probBoutTypeWithSpaceGood1 spaceVector2' probBoutTypeWithSpaceGood2];

figure
imagesc(probBoutTypeWithSpaceGoodAll')
colormap('gray')
axis equal 
box off
axis([0.5 size(probBoutTypeWithSpaceGoodAll,1)+0.5 0.5 size(probBoutTypeWithSpaceGoodAll,2)+0.5])
colorbar
caxis([0 0.7])
axis off
 
%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%% plot beeps prob %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% xFreq = 200:200:2000;
% 
% figure
% subplot(1,2,1)
% plot(xFreq,probOfLatencySmall(indFlashBeeps), '-k')
% axis square
% box off
% xlabel('Frequency (Hz)')
% ylabel('Prob. of bout in 200 ms')
% 
% 
% subplot(1,2,2)
% 
% for n = 1 : 13
% plot(xFreq,probBoutTypeGoodSorted(indFlashBeeps,n), '-','color', col(n,:))
% axis square
% box off
% xlabel('Frequency (Hz)')
% ylabel('Prob. of bout type')
% hold on
% 
% end
% 
