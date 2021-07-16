% clear all
 close all

%%
%%%%%%%%%%%% load bout map with raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')



%%
%%%%%%%%%%%%%%%% rotate trajectories %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutCat = unique(boutCatFinalArray);
% figure

yPosRotEndThisBotTypeAll = [];
xPosRotEndThisBotTypeAll = [];
orderOfBoutsAll = [];
boutSpeedXThisBoutAll = [];
boutSpeedYThisBoutAll = [];
distBoutDistanceXThisBoutAll = [];
distBoutDistanceYThisBoutAll = [];
boutAngleAll = [];
boutMaxAngleAll = [];

for n =  1 : length(uniqueBoutCat)
  n  
%find bouts of this type
indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(n));


% yPosRotEndThisBotType = zeros(1,length(indThisBoutType)); 
% xPosRotEndThisBotType = zeros(1,length(indThisBoutType)); 
 orderOfBouts = zeros(1,length(indThisBoutType)) + n; 
% 
% for nn = 1 : length(indThisBoutType)
% 
%     %get raw postitions
%      xPosThisBout = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn))+20:indBoutEndAllDataInFinalArray(indThisBoutType(nn))-20,EnumeratorFishData.xPos)*0.062;
%      yPosThisBout = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn))+20:indBoutEndAllDataInFinalArray(indThisBoutType(nn))-20,EnumeratorFishData.yPos)*0.062;
%      realBodyAnglesThisBout = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn))+20:indBoutEndAllDataInFinalArray(indThisBoutType(nn))-20,EnumeratorFishData.realBodyAngles);
%      realBodyAnglesThisBout = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn))+20:indBoutEndAllDataInFinalArray(indThisBoutType(nn))-20,EnumeratorFishData.bodyAngles);
% 
% %  xPosThisBout = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn)):indBoutStartAllDataInFinalArray(indThisBoutType(nn))+200,EnumeratorFishData.xPos)/ 0.0620;
% %      yPosThisBout = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn)):indBoutStartAllDataInFinalArray(indThisBoutType(nn))+200,EnumeratorFishData.yPos)/ 0.0620;
% %      realBodyAnglesThisBout = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn)):indBoutStartAllDataInFinalArray(indThisBoutType(nn))+200,EnumeratorFishData.realBodyAngles);
% % 
% 
%      %center bout
%       xPosCentered = xPosThisBout(1) - xPosThisBout;
%       yPosCentered = yPosThisBout(1) - yPosThisBout;
%       
%        [theta,rho] = cart2pol(xPosCentered,yPosCentered);
%        theta = theta - realBodyAnglesThisBout;
%        [xPosRot yPosRot] = pol2cart(theta,rho);
%        
%        
%    yPosRotEndThisBotType(nn) = yPosRot(end);
%    xPosRotEndThisBotType(nn) = xPosRot(end);
% 
% end

% yPosRotEndThisBotType = yPosRotEndThisBotType';
% xPosRotEndThisBotType = xPosRotEndThisBotType';
orderOfBouts = orderOfBouts';

% yPosRotEndThisBotTypeAll = [yPosRotEndThisBotTypeAll' yPosRotEndThisBotType']';
% xPosRotEndThisBotTypeAll  = [xPosRotEndThisBotTypeAll' xPosRotEndThisBotType']';
orderOfBoutsAll  = [orderOfBoutsAll' orderOfBouts']';

%%
%%%%%%%%%%%% calculate velocity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distBoutDistanceXThisBout = BoutKinematicParametersFinalArray(indThisBoutType,EnumeratorBoutKinPar.distBoutDistanceX);
distBoutDistanceYThisBout = BoutKinematicParametersFinalArray(indThisBoutType,EnumeratorBoutKinPar.distBoutDistanceY);

boutSpeedXThisBout = BoutKinematicParametersFinalArray(indThisBoutType,EnumeratorBoutKinPar.distBoutSpeedX);
boutSpeedYThisBout = BoutKinematicParametersFinalArray(indThisBoutType,EnumeratorBoutKinPar.distBoutSpeedY);

boutAngle = BoutKinematicParametersFinalArray(indThisBoutType,EnumeratorBoutKinPar.boutAngle);
boutMaxAngle = BoutKinematicParametersFinalArray(indThisBoutType,EnumeratorBoutKinPar.boutMaxAngle);


distBoutDistanceXThisBoutAll = [distBoutDistanceXThisBoutAll' distBoutDistanceXThisBout']';
distBoutDistanceYThisBoutAll = [distBoutDistanceYThisBoutAll' distBoutDistanceYThisBout']';

boutSpeedXThisBoutAll = [boutSpeedXThisBoutAll' boutSpeedXThisBout']';
boutSpeedYThisBoutAll = [boutSpeedYThisBoutAll' boutSpeedYThisBout']';

boutAngleAll = [boutAngleAll' boutAngle']'; 
boutMaxAngleAll = [boutMaxAngleAll' boutMaxAngle']'; 

% xVector = -40:1:70;
% yVector = -0:1:40;
% [NSpeedX] = hist(boutSpeedXThisBout,xVector);
% [NSpeedY] = hist(abs(boutSpeedYThisBout),yVector);
% 
% subplot(1,2,1)
%  plot(xVector,NSpeedX/sum(NSpeedX),'-','color',col(n,:))
% hold on
% subplot(1,2,2)
%  plot(yVector,NSpeedY/sum(NSpeedX),'-','color',col(n,:))
%  hold on

% %       plot(yPosRot,xPosRot,'-','color',col(n,:))
% % subplot(2,6,n)
%       plot(yPosRotEndThisBotType,xPosRotEndThisBotType,'.','color',col(n,:),'MarkerSize',7)
% 
%       axis square
% axis([-7 7 -1 15])
%       hold on
%       box off
%       xlabel('y position at the end of bout (mm)')
%       ylabel('X position at the end of bout (mm)')
% 
% % pause

end


%%
%%%%%%%%%%%%%%%%% make scatter plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colorArray = zeros(size(orderOfBoutsAll,1),size(col,2));

for n = 1 : size(col,1)
    indThisColor = find(orderOfBoutsAll == n);

    
    for nn = 1 : 3
colorArray(indThisColor,nn) = col(n,nn);

    end
end
% 
% figure
% subplot(1,2,1)
% scatter(yPosRotEndThisBotTypeAll,xPosRotEndThisBotTypeAll,5,'k','filled') 
% axis([-6 6 -1 13])
% axis square
% xlabel('y position at the end of bout (mm)')
% ylabel('X position at the end of bout (mm)')
% 
% 
% subplot(1,2,2)
% scatter(yPosRotEndThisBotTypeAll,xPosRotEndThisBotTypeAll,5,colorArray,'filled' ) 
% axis([-6 6 -1 13])
% axis square
% xlabel('y position at the end of bout (mm)')
% ylabel('X position at the end of bout (mm)')
% 


% figure
% subplot(1,2,1)
% scatter(boutAngleAll,distBoutDistanceXThisBoutAll,5,'k','filled') 
% axis([-300 300 -10 15])
% axis square
% xlabel('y position at the end of bout (mm)')
% ylabel('X position at the end of bout (mm)')
% 
% 
% subplot(1,2,2)
% scatter(boutAngleAll,distBoutDistanceXThisBoutAll,5,colorArray,'filled' ) 
% axis([-200 200 -10 15])
% axis square
% xlabel('y position at the end of bout (mm)')
% ylabel('X position at the end of bout (mm)')



figure
% subplot(2,2,1)
scatter(distBoutDistanceYThisBoutAll,distBoutDistanceXThisBoutAll,5,'k','filled') 
axis([-10 10 -10 15])
axis square
ylabel('Forward bout distance (mm)')
xlabel('Lateral bout distance (mm)')

figure
% subplot(2,2,2)
scatter(distBoutDistanceYThisBoutAll,distBoutDistanceXThisBoutAll,5,colorArray,'filled' ) 
axis([-12 12 -9 15])
axis square
ylabel('Forward bout distance (mm)')
xlabel('Lateral bout distance (mm)')

figure
% subplot(2,2,3)
scatter(distBoutDistanceYThisBoutAll,distBoutDistanceXThisBoutAll,5,'k','filled') 
% axis([-5.5 5.5 -2 6])
axis([-3 3 -1 5])
axis square
ylabel('Forward bout distance (mm)')
xlabel('Lateral bout distance (mm)')

figure
% 
% subplot(2,2,4)
scatter(distBoutDistanceYThisBoutAll,distBoutDistanceXThisBoutAll,5,colorArray,'filled' ) 
axis([-3 3 -1 5])
axis square
ylabel('Forward bout distance (mm)')
xlabel('Lateral bout distance (mm)')



% figure
% subplot(1,2,1)
% scatter(boutSpeedYThisBoutAll,boutSpeedXThisBoutAll,5,'k','filled' ) 
%  axis([-30 30 -20 50])
% axis square
% xlabel('Lateral velocity (mm/s)')
% ylabel('Forward velocity (mm/s)')
% 
% % figure
% subplot(1,2,2)
% scatter(boutSpeedYThisBoutAll,boutSpeedXThisBoutAll,5,colorArray,'filled' ) 
%  axis([-30 30 -20 50])
% axis square
% xlabel('Lateral velocity (mm/s)')
% ylabel('Forward velocity (mm/s)')
