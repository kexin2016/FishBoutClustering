

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

boutDataPCASampleFinalArray = boutDataPCASampleFinalArray(:,1:3);



%%
%%%%%%%%%%%%%%%%%%%%%%%%%% calculate center of cluster %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutCat = unique(boutCatFinalArray);
figure
centerOfClusters = zeros(length(uniqueBoutCat),size(boutDataPCASampleFinalArray,2));

indClosestBoutToTheCenter = zeros(1,length(uniqueBoutCat));
% subplot(3,4,1)
figure
idx = [10 1 2 3 4 5 6 7 8 9  11];

for n =  1 : length(uniqueBoutCat)
    
%     n = 1
indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(idx(n)));

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

%%
%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(1,2,1)
plot(boutDataPCASampleThisBoutType(:,1),boutDataPCASampleThisBoutType(:,2),'.', 'color',col(idx(n),:))
hold on 
% plot(centerOfClusters(n,1),centerOfClusters(n,2),'ko')
plot(boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),1),boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),2),'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',5)

axis square
box off
xlabel('PC 1')
ylabel('PC 2')
axis([-17 22 -10 12])    


end





%%
%%%%%%%%%%%%%%%%%%%%% plot center bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col2 = jet(8);

boutName = {'Approach swim','Slow 1','Slow 2','Burst swim','J turn','HAT','Routine turn','SAR',...
    'O bend','LLE','C start'};
% figure
for i = 1 : length(indClosestBoutToTheCenter)
i =1
     cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray(indClosestBoutToTheCenter(i)):indBoutEndAllDataInFinalArray(indClosestBoutToTheCenter(i)),EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;
     beat1beatAmplitude8 = BoutKinematicParametersFinalArray(indClosestBoutToTheCenter(i),EnumeratorBoutKinPar.beat1beatAmplitude8);

     
    timeX = (1 : length(cumsumInterpFixedSegmentAngles)).*(1000/700);
    
%     subplot(3,4,i+1)
    figure
    if beat1beatAmplitude8 > 0
    
    for nnn = 1 : 7
    plot(timeX,cumsumInterpFixedSegmentAngles(:,nnn),'color',col2(nnn,:),'linewidth',3)
    hold on
    end
    
    else
    for nnn = 1 : 7
    plot(timeX,cumsumInterpFixedSegmentAngles(:,nnn)*-1,'color',col2(nnn,:),'linewidth',3)
    hold on
    end
    end
    
    box off
    axis([0 220 -130 250])
    axis square
%     axis off
    title(boutName{i})
    
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


