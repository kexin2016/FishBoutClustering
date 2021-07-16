
 function [boutCurvature] = TailCurvatureCalculator_13(cumsumInterpolatedAngleByBout,tailMM)
%very noisy

%this function calculates the curvature of the tail 

%%
%%%%%%%%%%%%transform angles into positions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sizeSegment = mean(diff(tailMM));

tailPosX = cumsumInterpolatedAngleByBout.*0;
tailPosY = cumsumInterpolatedAngleByBout.*0;

for nn = 1 : size(cumsumInterpolatedAngleByBout,2)%loop througg each segment

%     %calcualte rho
%     rho = sizeSegment./cos(cumsumInterpolatedAngleByBout(:,nn));
    
 [tailPosNormX,tailPosNormY] = pol2cart(cumsumInterpolatedAngleByBout(:,nn),sizeSegment);
%  tailPosNormX = tailPosNormX*sizeSegment;
%  tailPosNormY = tailPosNormY*sizeSegment;

 
  if nn == 1
 
 tailPosX(:,1) = tailPosNormX;
 tailPosY(:,1) = tailPosNormY;
 
 
 else
     tailPosX(:,nn) = tailPosX(:,(nn-1)) + tailPosNormX;
     tailPosY(:,nn) = tailPosY(:,(nn-1)) + tailPosNormY;
%      
 end
end


% %test tail positions
% for n = 1 :10: size(halfBeatTailAngles2,1)
%     
%     
%     
% hold off
% plot(tailPosX(n,:),tailPosY(n,:))
% hold on
% plot(tailPosX(n,:),tailPosY(n,:), 'ro')
% 
% axis([-5 5 -5 5])
% pause
% end



%%
% %%%%%%%%%%%%%%%%%%smooth dail data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% halfBeatTailAngles =cumsumInterpolatedAngleByBout*0;
% for n = 1:size(cumsumInterpolatedAngleByBout,2)
%     
% halfBeatTailAngles(:,n) = smooth(cumsumInterpolatedAngleByBout(:,n),100);
% 
% end
% 
% 
% halfBeatTailAngles2 =halfBeatTailAngles*0;
% for n = 1:size(cumsumInterpolatedAngleByBout,1)
%     
% halfBeatTailAngles2(n,:) = smooth(halfBeatTailAngles(n,:),10);
% 
% end
% 
% plot(cumsumInterpolatedAngleByBout,'color', 'blue')
% hold on
% plot(halfBeatTailAngles2, 'color', 'red')


%%
%%%%%%%%%%calculate curvature%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%test tail curvature 

curvature =cumsumInterpolatedAngleByBout.*0;

for n = 1 : size(cumsumInterpolatedAngleByBout,1)

    %calcualte speed and acelaration
xSpeed = diff(tailPosX(n,:));
xAc = [diff(xSpeed) 0];

ySpeed = diff(tailPosY(n,:));
yAc = [diff(ySpeed) 0];
    
    
%     angleVel = diff(halfBeatTailAngles(n,:));
%     angleAc = [diff(angleVel) 0];
%     
     k = [0 sqrt(xAc.^2 + yAc.^2)./(xSpeed.^2 + ySpeed.^2)];
    
      Ksign = k*0;
     
     indPos = find(tailPosY(n,:) >0);
     Ksign(indPos) = k(indPos);
     indNeg = find(tailPosY(n,:) <=0);
     Ksign(indNeg) = k(indNeg)*-1;
     
     
%      k = [0 sqrt((angleAc).^2)./(angleVel.^2)];
     
     
% hold off 
% plot(tailPosX(n,:),tailPosY(n,:), 'color','k')
% hold on
% plot(tailPosX(n,:),tailPosY(n,:), 'or')
% hold on
% quiver(tailPosX(n,:),tailPosY(n,:),[posAc 0], Ksign, 'color', 'red','linewidth', 1 )
% axis([-5 5 -3 3])
% pause

curvature(n,:) = Ksign;
end

%%
%%%%%%%%%%%%%%%%%average all segments%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutCurvature = nanmean(curvature(:,2:end),2);
% plot(meanCurvature)

% %pause
% figure
% plot(cumsumInterpolatedAngleByBout, 'color', 'k')
% hold on
% plot(halfBeatTailAngles2, 'color', 'r')
% 
% 
% figure
% plot(curvature)
% figure
% imagesc(curvature)
% 
% figure
% imagesc(cumsumInterpolatedAngleByBout)