



% this function calculates bout distance and speed of X and Y by taking into acount the rotation of fish

%inputs
%1)posX
%2)posY
%3)buntAngle - should come in degrees
%4)boutDurationTail - should come in degrees
%5)bodyAngles
%6)pixelSize


%outpus
%1)boutDistanceX
%2)boutDistanceY
%3)boutSpeedX
%4)boutSpeedY

function[boutDistanceX,boutDistanceY,boutSpeedX,boutSpeedY,rotStartX,rotStartY] = speedWithDirectionCalculator_4(posX,posY,boutAngle,boutDuration,bodyAngles,pixelSize)


%Note: pixelSize must vome in mm

%close all
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Test function%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% n =1;
% nn = 31;
% close all
% %retrieve x and y position from bout strucuture
% posX = StimTypeBoutsMultiFish(n).boutStructure(nn).posX;
% posY = StimTypeBoutsMultiFish(n).boutStructure(nn).posY;
% 
% % figure
% % plot(posX, posY)
% %retireve bout turn from strucuture
% boutAngle = StimTypeBoutsMultiFish(n).boutStructure(nn).boutTurningAngles;% it comes in degrees
% 
% %retrieve bout duration
% boutDuration = StimTypeBoutsMultiFish(n).boutStructure(nn).boutDurationTail;%it comes in ms
% 
% %retrieve angle at the start of bout
% bodyAngles = StimTypeBoutsMultiFish(n).boutStructure(nn).measuredBodyAngles;% it comes in degrees


%%
%%%%%%%%%%Dock start vector in zero zero%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
normPosX = posX - posX(1);
normPosY = posY - posY(1);


%transform 1st angle in positive angle if it is negative
%  if bodyAngles(1)<0
% firstAngle = 360 + bodyAngles(1);
% 
% 
%  else
%      
% firstAngle = bodyAngles(1);
%      
%  end

%body angles have to come in Degrees
firstAngle = bodyAngles(1);

% %%%%%%%%%%%%rotate vectors so that start vector has angle zero%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[rotStartX,rotStartY] = rotate_matrix(normPosX,normPosY, 180-firstAngle);% it comes in pixel


 
%  %%%%%%%%%%%%%%%%%%%Calculate x and y distances%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% boutDiffX = rotStartX(end) - rotStartX(1);
% boutDiffY = rotStartY(end) - rotStartY(1);


 boutDistanceX = rotStartX(end)*pixelSize;%in mm
 boutDistanceY = rotStartY(end)*pixelSize;%in mm
 
 
 boutSpeedX = boutDistanceX/boutDuration*1000;%in mm/s * 1000 to make in seconds
 boutSpeedY = boutDistanceY/boutDuration*1000;%in mm/s

%%
% %%%%%%%%%%%%%test function%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clf
% subplot(2,2,1)
% hold on
% plot(normPosX*pixelSize,normPosY*pixelSize)
% arrow([normPosX(1)*pixelSize,normPosY(1)*pixelSize],[normPosX(2)*pixelSize,normPosY(2)*pixelSize])
% plot(normPosX(1)*pixelSize,normPosY(1)*pixelSize, 'go')
% plot(normPosX(end)*pixelSize,normPosY(end)*pixelSize, 'ro')
% plot(rotStartX*pixelSize,rotStartY*pixelSize,'r')
% hold on
% plot(rotStartX*pixelSize,rotStartY*pixelSize,'r')
% arrow([rotStartX(1)*pixelSize,rotStartY(1)*pixelSize],[rotStartX(2)*pixelSize,rotStartY(2)*pixelSize])
% plot(rotStartX(1)*pixelSize,rotStartY(1)*pixelSize, 'co')
% plot(rotStartX(end)*pixelSize,rotStartY(end)*pixelSize, 'mo')
% 
% 
% 
% title(firstAngle)
% 
% subplot(2,2,2)
% plot(bodyAngles)
% title(boutDistanceX)
% 
% 
% pause

