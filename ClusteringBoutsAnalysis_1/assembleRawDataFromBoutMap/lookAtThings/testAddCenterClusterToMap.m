
clear all
close all

%%
%%%%%%%%%%%%%%%%%%%%%%%% import bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folderToSave = 'C:\Joao analysis\FreeData\clusteringData\boutMap\final_11Solution\withRaw\';

filename = strcat(folderToSave, 'BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4_withGlidingCenters.mat');


  load(filename);



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
numDim = behavioralSpaceStructure.numDim;



%%
%%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[boutDataPCASampleFinalArray] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParametersFinalArray,BoutInfFinalArray,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);

boutDataPCASampleFinalArray = boutDataPCASampleFinalArray(:,1:numDim);



%%
%%%%%%%%%%%%%%%%%%% calcualte distances of bouts to center %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueBoutCat = unique(boutCatFinalArray);

figure
 
% subplot(3,4,1)

 

for n =  1 : length(uniqueBoutCat)
    
%      n = 2
 indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(idx(n)));

boutDataPCASampleThisBoutType = boutDataPCASampleFinalArray(indThisBoutType,:);





%%
%%%%%%%%%%%% calcualte center of cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clusterCenterThis = movementSpaceCoordinates(idx(n),:);


%%
%%%%%%%%%%%% calculate distance to center %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distanceOfBouts = zeros(1,length(indThisBoutType));
for nn = 1 : length(indThisBoutType)

distanceOfBouts(nn) = pdist2(clusterCenterThis,[boutDataPCASampleFinalArray(indThisBoutType(nn),:)]);
clf
%%
%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(1,2,1)
plot3(boutDataPCASampleThisBoutType(:,1),boutDataPCASampleThisBoutType(:,2),boutDataPCASampleThisBoutType(:,3),'.', 'color',col(idx(n),:))
hold on 
% plot(centerOfClusters(n,1),centerOfClusters(n,2),'ko')
plot3(boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),1),boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),2),boutDataPCASampleFinalArray(indClosestBoutToTheCenter(idx(n)),3),'o','MarkerEdgeColor','k','MarkerFaceColor',col(idx(n),:),'MarkerSize',5)




plot3(boutDataPCASampleFinalArray(indThisBoutType(nn),1),boutDataPCASampleFinalArray(indThisBoutType(nn),2),boutDataPCASampleFinalArray(indThisBoutType(nn),3),'o','color','r','MarkerSize',10)

title(distanceOfBouts(nn))
pause

end

axis square
box off
xlabel('PC 1')
ylabel('PC 2')
axis([-17 22 -10 12])    




end


