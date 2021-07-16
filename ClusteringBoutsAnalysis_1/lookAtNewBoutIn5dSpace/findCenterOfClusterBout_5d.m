

% clear all
 close all

%%
%%%%%%%%%%%% load bout map with raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')


%%
%%%%%%%%%%%%% put bout map into space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get vars out of structure
meanAllVar = behavioralSpaceStructure.meanAllVar;
stdAllVar = behavioralSpaceStructure.stdAllVar;
COEFF = behavioralSpaceStructure.COEFF;
latent = behavioralSpaceStructure.latent;
maxKinPars = behavioralSpaceStructure.maxKinPars;
indKinPars = behavioralSpaceStructure.indKinPars;
meanPCASpace = behavioralSpaceStructure.meanPCASpace;

%%
%%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[boutDataPCASampleFinalArray] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParametersFinalArray,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);

boutDataPCASampleFinalArray = boutDataPCASampleFinalArray(:,1:5);



%%
%%%%%%%%%%%%%%%%%%%%%%%%%% calculate center of cluster %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutCat = unique(boutCatFinalArray);
figure
centerOfClusters = zeros(length(uniqueBoutCat),size(boutDataPCASampleFinalArray,2));

indClosestBoutToTheCenter = zeros(1,length(uniqueBoutCat));
% subplot(3,4,1)
figure
% idx = [10 1 2 3 4 5 6 7 8 9  11 12];

col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50; 0 0 0])./255;
idx = [3 7 4 1 2 12 8 10 11 6 9 5];



for n =  1 : length(uniqueBoutCat)
    
%     n = 1
indThisBoutType = find(boutCatFinalArray == uniqueBoutCat((n)));

boutDataPCASampleThisBoutType = boutDataPCASampleFinalArray(indThisBoutType,:);



%%
%%%%%%%%%%%% calcualte center of cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
centerOfClusters(n,:) = nanmean(boutDataPCASampleThisBoutType);


%%
%%%%%%%%%%%% calculate distance to center %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distanceOfBouts = zeros(1,length(indThisBoutType));
for nn = 1 : length(indThisBoutType)

distanceOfBouts(nn) = pdist2(centerOfClusters(n,:),[boutDataPCASampleFinalArray(indThisBoutType(nn),:)]);

end

[minVal,indMin]= min(distanceOfBouts);

 indClosestBoutToTheCenter(idx(n)) = indThisBoutType(indMin);
% indClosestBoutToTheCenter((n)) = indThisBoutType(indMin);

%%
%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(1,2,1)
%  plot(boutDataPCASampleThisBoutType(:,1),boutDataPCASampleThisBoutType(:,2),'.', 'color',col(idx(n),:))
 plot3(boutDataPCASampleThisBoutType(:,1),boutDataPCASampleThisBoutType(:,2),boutDataPCASampleThisBoutType(:,5),'.', 'color',col(idx(n),:))

hold on 
%  plot(boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),1),boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),2),'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',10)
 plot3(boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),1),boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),2),boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),5),'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',10)

axis square
box off
xlabel('PC 1')
ylabel('PC 2')
zlabel('PC 5')

axis([-17 22 -10 12 -5 5])    
% % title(uniqueBoutCat((n)))
% indClosestBoutToTheCenter

  pause


end





%%
%%%%%%%%%%%%%%%%%%%%% plot center bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbSegments = 9;
col2 = jet(numbSegments);

boutName = {'Approach swim','Slow 1','Slow 2','Burst swim','J turn','HAT','Routine turn','SAR',...
    'O bend','LLE','C start','Routine turn2'};
 figure
 
 idx2 = [1,2,3,4,5,6,7,12,8,9, 10,11];
%   idx2 = 1:12;

beat1beatDurationAll = zeros(1,length(indClosestBoutToTheCenter));
beat2beatDurationAll = zeros(1,length(indClosestBoutToTheCenter));
beat3beatDurationAll = zeros(1,length(indClosestBoutToTheCenter));

for i = 1 : length(indClosestBoutToTheCenter)
% i =1
     cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray(indClosestBoutToTheCenter(idx2(i))):indBoutEndAllDataInFinalArray(indClosestBoutToTheCenter(idx2(i))),EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;
     beat1beatAmplitude8 = BoutKinematicParametersFinalArray(indClosestBoutToTheCenter(idx2(i)),EnumeratorBoutKinPar.beat1beatAmplitude8);
     
          beat1beatDurationAll((i)) = BoutKinematicParametersFinalArray(indClosestBoutToTheCenter(idx2(i)),EnumeratorBoutKinPar.beat1beatDuration);
          beat2beatDurationAll((i)) = BoutKinematicParametersFinalArray(indClosestBoutToTheCenter(idx2(i)),EnumeratorBoutKinPar.beat2beatDuration);
          beat3beatDurationAll((i)) = BoutKinematicParametersFinalArray(indClosestBoutToTheCenter(idx2(i)),EnumeratorBoutKinPar.beat3beatDuration);

     
     
% 
%         cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray(indClosestBoutToTheCenter((i))):indBoutEndAllDataInFinalArray(indClosestBoutToTheCenter((i))),EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;
%      beat1beatAmplitude8 = BoutKinematicParametersFinalArray(indClosestBoutToTheCenter((i)),EnumeratorBoutKinPar.beat1beatAmplitude8);

    timeX = (1 : length(cumsumInterpFixedSegmentAngles)).*(1000/700);
    
     subplot(3,4,i)
%     figure
    if beat1beatAmplitude8 > 0
    
    for nnn = 1 : numbSegments
    plot(timeX,cumsumInterpFixedSegmentAngles(:,nnn),'color',col2(nnn,:),'linewidth',2)
    hold on
    end
    
    else
    for nnn = 1 : numbSegments
    plot(timeX,cumsumInterpFixedSegmentAngles(:,nnn)*-1,'color',col2(nnn,:),'linewidth',2)
    hold on
    end
    end
    
    box off
    axis([0 220 -130 250])
    axis square
%     axis off
       title(boutName{idx2(i)})
      
%        title(beat1beatDurationAll(idx2(i)))

% beat1beatDurationAll
% title(indClosestBoutToTheCenter(idx2(i)))
%         title(boutName{(i)})

end

%%
% %%%%%%%%%%%%% make average bout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% boutCat = finalClustering.assignment;
% 
% uniqueBoutCat = unique(boutCat);
% 
% col2 = jet(8);
% 
% figure
%  for n =  1 : length(boutCat)
%      
%     indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(n));
%     
% 
%     cumsumInterpFixedSegmentAnglesAvr = zeros(150,8);
%     
%     for nn = 1 : length(indThisBoutType)
%     cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn)):indBoutEndAllDataInFinalArray(indThisBoutType(nn)),EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;
%      
%     timeX = (1 : length(cumsumInterpFixedSegmentAngles)).*(1000/700);
%     
%     clf
%     
%     for nnn = 1 : 8
%     plot(timeX,cumsumInterpFixedSegmentAngles(:,nnn),'color',col2(nnn,:),'linewidth',3)
%     hold on
%     end
%     
%     box off
%     axis([0 200 -300 300])
%     axis square
%     axis off
%     pause
%     end
%     
%     
%  end
% 
% 
