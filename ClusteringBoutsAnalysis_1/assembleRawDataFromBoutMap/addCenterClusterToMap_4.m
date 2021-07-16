%%
%%%%%%%%%%%%%%%%%%%%%% ehat this does %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calcualted cluster centers for boutMap of 14 bout type categorization 




%%
clear all
close all

%%
%%%%%%%%%%%%%%%%%%% load bout map with raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PathName = 'C:\JoaoStuff\boutTypeStuff\FreeData\boutTypeProject\boutClustering\boutMaps\14Solution\';
FileName = 'BoutMap_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_withChasingDots.mat';

boutMapPath = strcat(PathName, FileName);
load(boutMapPath)




% load('BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4_withGliding.mat')




%%
%%%%%%%%%%%%% put bout map into space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idx = finalClustering.idx;
% finalClustering.col = ([102 255 255;0 150 255;  0 0 200;100 100 100;  0 0 0;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;
col  = finalClustering.col;


%must order correctly the bouts so that they are displayed correctly
%  idx = [ 1 2 3 4 5 6 7 8 9 10 11 12 13];%order bouts to be displayed in order


%must know dimentions of bout map
numDim = 20
behavioralSpaceStructure.numDim = numDim;



%get vars out of structure
meanAllVar = behavioralSpaceStructure.meanAllVar;
stdAllVar = behavioralSpaceStructure.stdAllVar;
COEFF = behavioralSpaceStructure.COEFF;
latent = behavioralSpaceStructure.latent;
maxKinPars = behavioralSpaceStructure.maxKinPars;
indKinPars = behavioralSpaceStructure.indKinPars;
meanPCASpace = behavioralSpaceStructure.meanPCASpace;
 
 
%%
% %%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% [boutDataPCASampleFinalArray] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParametersFinalArray,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);
% 
% boutDataPCASampleFinalArray = boutDataPCASampleFinalArray(:,1:numDim);
% 
% 


boutDataPCASampleFinalArray = finalClustering.dataToDoMap;
boutCatFinalArray = finalClustering.clusterAssignmentInMap;
 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%% calculate center of cluster %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutCat = unique(boutCatFinalArray);


centerOfClusters = zeros(length(uniqueBoutCat),size(boutDataPCASampleFinalArray,2));

indClosestBoutToTheCenter = zeros(1,length(uniqueBoutCat));
movementSpaceCoordinates = zeros(length(uniqueBoutCat),numDim);


% subplot(3,4,1)
figure
%    idx = [ 1 2 3 4 5 6 7 8 9 10 11 12 13];%order bouts to be displayed in order


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

indClosestBoutToTheCenter((n)) = indThisBoutType(indMin);
movementSpaceCoordinates((n),:) = centerOfClusters(n,:);

%%
%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(1,2,1)
plot(boutDataPCASampleThisBoutType(:,1),boutDataPCASampleThisBoutType(:,2),'.', 'color',col((n),:))
hold on 
% plot(centerOfClusters(n,1),centerOfClusters(n,2),'ko')
plot(boutDataPCASampleFinalArray(indClosestBoutToTheCenter((n)),1),boutDataPCASampleFinalArray(indClosestBoutToTheCenter((n)),2),'o','MarkerEdgeColor','k','MarkerFaceColor',col((n),:),'MarkerSize',10)

axis square
box off
xlabel('PC 1')
ylabel('PC 2')
axis([-17 22 -10 12])    
% pause

end


%%
% %%%%%%%%%%%%%%%%%%%%% plot center bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% col2 = jet(7);
% 
% boutName = {'Approach swim','Slow 1','Slow 2','slow capture swim','Fast capture swim','Burst swim','J turn','HAT','Routine turn','SAR',...
%     'O bend','LLE','C start'};
%  figure
% for i = 1 : length(indClosestBoutToTheCenter)
% % i =1
%      cumsumInterpFixedSegmentAngles = FishDataMap(indBoutStartAllDataInFinalArray(indClosestBoutToTheCenter(i)):indBoutEndAllDataInFinalArray(indClosestBoutToTheCenter(i)),EnumeratorFishData.cumsumInterpFixedSegmentAngles)*180/pi;
%      beat1beatAmplitude8 = BoutKinematicParametersFinalArray(indClosestBoutToTheCenter(i),EnumeratorBoutKinPar.beat1beatAmplitude8);
% 
%      
%     timeX = (1 : length(cumsumInterpFixedSegmentAngles)).*(1000/700);
%     
%      subplot(2,7,i+1)
% %     figure
%     if beat1beatAmplitude8 > 0
%     
%     for nnn = 1 : 7
%     plot(timeX,cumsumInterpFixedSegmentAngles(:,nnn),'color',col2(nnn,:),'linewidth',2)
%     hold on
%     end
%     
%     else
%     for nnn = 1 : 7
%     plot(timeX,cumsumInterpFixedSegmentAngles(:,nnn)*-1,'color',col2(nnn,:),'linewidth',2)
%     hold on
%     end
%     end
%     
%     box off
%     axis([0 220 -130 250])
%     axis square
% %     axis off
%      title(boutName{i})
%     
% end
% 
% 
% 





%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%% save map with raw %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% folderToSave = 'C:\Joao analysis\FreeData\clusteringData\boutMap\LDA\';
% filename = 'BoutMapWithRawCenters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';
%  
% 
% % 
%  filenameWithPath = strcat(folderToSave,filename );
% 
% 
% save(filenameWithPath,'BeatInfFinalArray','BeatKinematicParametersFinalArray','BoutCatInHalfBeatFinalArray','BoutInfFinalArray','BoutKinematicParametersFinalArray',...
%     'FishDataMap','behavioralSpaceStructure','boutCatFinalArray','col','finalClustering','idx','indBeatEndAllDataInFinalArray',...
%     'indBeatStartAllDataInFinalArray','indBoutEndAllDataInFinalArray','indBoutEndAllDataInFinalArrayByTail','indBoutStartAllDataInFinalArray',...
%      'indClosestBoutToTheCenter','movementSpaceCoordinates','-v7.3');
% 
%  
%%
%%%%%%%%%%%%%%%%%%%%%%%%%% save map with no raw %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filename = 'BoutMapCenters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_withChasingDots.mat';



save(strcat(PathName,filename),'finalClustering','behavioralSpaceStructure','indClosestBoutToTheCenter','-v7.3');
