
% clear all 
% close all

%%
%%%%%%%%%%%%%%% load bout map with raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\FreeData\clusteringData\boutMap\final\BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')

%%
%%%%%%%%%%%%%%%%% import bout map with raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutCat = BoutInfFinalArray(:, EnumeratorBoutInf.boutCat);


uniqueBoutCat = unique(boutCatFinalArray);


 for n  = 1 : length(uniqueBoutCat)
%   n =1  
    
    indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(n));
    
    
    
% end

% subplot(2,6,n)
figure

%%
%%%%%%%%%%%%%%%%%%%%% plot center bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col2 = jet(8);
segmentNumber = 7;
boutName = {'Approach swim','Slow 1','Slow 2','Burst swim','J turn','HAT','Routine turn','SAR',...
    'O bend','LLE','C start'};
% figure
for i = 1 :1: 4%length(indThisBoutType)
     cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(i)):indBoutEndAllDataInFinalArray(indThisBoutType(i)),EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;
     beat1beatAmplitude8 = BoutKinematicParametersFinalArray(indThisBoutType(i),EnumeratorBoutKinPar.beat1beatAmplitude8);

     
    timeX = (1 : length(cumsumInterpFixedSegmentAngles)).*(1000/700);
    
%     subplot(3,4,i+1)
%     figure
    if beat1beatAmplitude8 > 0
    
%     for nnn = 1 : 7
    plot(timeX,cumsumInterpFixedSegmentAngles(:,segmentNumber),'color','k','linewidth',1)
    hold on
%     end
    
    else
%     for nnn = 1 : 7
    plot(timeX,cumsumInterpFixedSegmentAngles(:,segmentNumber)*-1,'color','k','linewidth',1)
    hold on
%     end
    end
    
    box off
    axis([0 220 -130 250])
    axis square
    xlabel('Time (ms)')
    
    ylabel('End tail angle (°)')

%     axis off
%     title(boutName{i})
%     
end
 end
 
 