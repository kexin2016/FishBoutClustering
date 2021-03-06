
clear all 
% close all

%%
%%%%%%%%%%%%%%% load bout map with raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('C:\Joao analysis\FreeData\clusteringData\boutMap\final\BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')

%%


%%
%%%%%%%%%%%%% pick subset of bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbInBetween = 1;

boutCatFinalArray = boutCatFinalArray(1:numbInBetween:end);
indBoutStartAllDataInFinalArray = indBoutStartAllDataInFinalArray(1:numbInBetween:end);
 indBoutEndAllDataInFinalArray = indBoutEndAllDataInFinalArray(1:numbInBetween:end);
 
BoutKinematicParametersFinalArray = BoutKinematicParametersFinalArray(1:numbInBetween:end,:);
 
 %%
 %%%%%% go through all the bout types and calcualte coeff of correlation %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 pearsonCorr = zeros(length(boutCatFinalArray)-1,length(boutCatFinalArray)-1);
 kendallCorr = zeros(length(boutCatFinalArray)-1,length(boutCatFinalArray)-1);
 spearmanCorr = zeros(length(boutCatFinalArray)-1,length(boutCatFinalArray)-1);
 MSEarray = zeros(length(boutCatFinalArray)-1,length(boutCatFinalArray)-1);
 
 sizeOfBout = 140;
 segmentNumber = 7;

 for n  = 1 : length(boutCatFinalArray)-1
%   n =1  
    n
%     indThisBoutType1 = find(boutCatFinalArray == uniqueBoutCat(n));
%             if indBoutStartAllDataInFinalArray((nn))+150 < length(FishDataMap)

%        cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray((n)):indBoutStartAllDataInFinalArray((n)) + sizeOfBout,EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;
       cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray((n)):indBoutEndAllDataInFinalArray((n)),EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;

     beat1beatAmplitude8 = BoutKinematicParametersFinalArray((n),EnumeratorBoutKinPar.beat1beatAmplitude8);

    if beat1beatAmplitude8 > 0
    movementThis1 = cumsumInterpFixedSegmentAngles(:,segmentNumber);

    
    else
%     for nnn = 1 : 7

    movementThis1 = cumsumInterpFixedSegmentAngles(:,segmentNumber)*-1;
   
    end
     
    
    
     for nn  = 1 : length(boutCatFinalArray)-1
    
%         indThisBoutType2 = find(boutCatFinalArray == uniqueBoutCat(nn));
%         if indBoutStartAllDataInFinalArray((nn))+150 < length(FishDataMap)
            
       cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray((nn)):indBoutEndAllDataInFinalArray((nn)),EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;
     beat1beatAmplitude8 = BoutKinematicParametersFinalArray((nn),EnumeratorBoutKinPar.beat1beatAmplitude8);
     
     
     

    if beat1beatAmplitude8 > 0
    movementThis2 = cumsumInterpFixedSegmentAngles(:,segmentNumber);

    
    else
%     for nnn = 1 : 7

    movementThis2 = cumsumInterpFixedSegmentAngles(:,segmentNumber)*-1;
   
    end
     
    
    minVal  = min(size(movementThis1,1),size(movementThis2,1));
    
    movementThis1 = movementThis1(1:minVal);
    movementThis2 = movementThis2(1:minVal);

    if n ~= nn
         pearsonCorr(n,nn) = corr(movementThis1,movementThis2);
         kendallCorr(n,nn) = corr(movementThis1,movementThis2,'type','Kendall');
         spearmanCorr(n,nn) = corr(movementThis1,movementThis2,'type','Spearman');         
         MSEarray(n,nn) = sum((movementThis1-movementThis2).*(movementThis1-movementThis2))/length(movementThis1);
    else
         pearsonCorr(n,nn) = nan;
         kendallCorr(n,nn) = nan;
         spearmanCorr(n,nn) = nan;        
         MSEarray(n,nn) = nan;
    end
%          plot(movementThis1)
%          hold on
%          plot(movementThis2, 'color','r')

         
     end
     

 end
 
 
 
 
 %%
 %%%%%%%%%%%%%% calcuyalte average correlations between bout types %%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
 
uniqueBoutType = unique(boutCatFinalArray);
boutCatFinalArray(end) = [];

pearsonCorrAvr  = zeros(length(uniqueBoutType),length(uniqueBoutType));
kendallCorrAvr  = zeros(length(uniqueBoutType),length(uniqueBoutType));
spearmanCorrAvr  = zeros(length(uniqueBoutType),length(uniqueBoutType));
MSEarrayAvr  = zeros(length(uniqueBoutType),length(uniqueBoutType));

 for i = 1 : length(uniqueBoutType)
 
 indThisBoutType1 = find(boutCatFinalArray == uniqueBoutType(i));
 
 for ii = 1 : length(uniqueBoutType)
 
 indThisBoutType2 = find(boutCatFinalArray == uniqueBoutType(ii));
 
 
 pearsonCorrAvr(i,ii) = nanmean(nanmean(abs(pearsonCorr(indThisBoutType1,indThisBoutType2))));
  kendallCorrAvr(i,ii) = nanmean(nanmean(abs(kendallCorr (indThisBoutType1,indThisBoutType2))));
 spearmanCorrAvr(i,ii) = nanmean(nanmean(abs(spearmanCorr(indThisBoutType1,indThisBoutType2))));
 MSEarrayAvr(i,ii) = nanmean(nanmean(abs(MSEarray(indThisBoutType1,indThisBoutType2))));

 end
 
 end     
     
 
 figure
subplot(2,2,1)
imagesc(pearsonCorrAvr)
axis square
colormap gray

subplot(2,2,2)
imagesc(kendallCorrAvr)
axis square
colormap gray

subplot(2,2,3)
imagesc(spearmanCorrAvr)
axis square
colormap gray

subplot(2,2,4)
imagesc(MSEarrayAvr)
axis square
colormap gray
 
 
 %%
 %%%%%%%%%%%%%%% order by bout type %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
[boutCatFinalArraySorted,idx] = sort(boutCatFinalArray(1:end-1));

figure
subplot(2,2,1)
imagesc(abs(pearsonCorr(idx,idx)))
axis square
colormap gray

subplot(2,2,2)
imagesc(abs(kendallCorr(idx,idx)))
axis square
colormap gray

subplot(2,2,3)
imagesc(abs(spearmanCorr(idx,idx)))
axis square
colormap gray

subplot(2,2,4)
imagesc(abs(MSEarray(idx,idx)))
axis square
colormap gray
