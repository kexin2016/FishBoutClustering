%this function extrapolates tail pos and amplitude for missing segments


%input
%1) halfBeatStructure
%2) pixelsize
%3) tailSegmentLength

%ouput
%1) halfBeatExtrapolatedStructure
%2) velocityBeatPropagationStructure 


 function  [halfBeatExtrapolatedStructure,velocityBeatPropagationStructure] = halfBeatTailWaveExtrapolation_3(halfBeatStructure,tailMM,cumsum2DInterpolatedAngles,fps)
% %test function
% clf
% hold off
%%
%%%%%%%%%%%%%%%%loop through each beat%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get last measured segment
lastMeasuredSegment = halfBeatStructure(1).lastMeasuredSegment;

 col = jet(length(halfBeatStructure));
for n = 1 : length(halfBeatStructure)


%%
%%%%%%%%%%%%%%%%get beat things from structure%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


halfBeatInd = halfBeatStructure(n).halfBeatInd;
halfBeatLinearInd = halfBeatStructure(n).halfBeatLinearInd;
halfBeatVal = halfBeatStructure(n).halfBeatVal;
halfBeatValGray = halfBeatStructure(n).halfBeatValGray;
upDown = halfBeatStructure(n).upDown;
halfBeatCMInd = halfBeatStructure(n).halfBeatCMInd;
halfBeatCMLinearInd = halfBeatStructure(n).halfBeatCMLinearInd;
halfBeatCMVal = halfBeatStructure(n).halfBeatCMVal;
halfBeatCMValGray = halfBeatStructure(n).halfBeatCMValGray;
indBeatStart = halfBeatStructure(n).indBeatStart;
indBeatEnd = halfBeatStructure(n).indBeatEnd;

%%
%%%%%%%%%%%%%%%calculate halfBeatDuration%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

halfBeatDuration = (indBeatEnd - indBeatStart)/fps;%in ms


%%
%%%%%%%%%%%%%%%Calculate inverse half beat wave speed%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this is the velocity the beat takes to move through tail - mm/ms = m/s
%this fitting is used to extrapolate time of beat for missing segments

rostralSegment = min(halfBeatInd(:,1));
   
%calcualte segment length in mm
tailMMThisBeat = tailMM(rostralSegment:lastMeasuredSegment);
 
 
 
%calculate beatTime in ms
beatTime = (halfBeatCMInd(:,2)/fps)';
  
%fit line using least squares
[lineConstants1, erros, mu] = polyfit(tailMMThisBeat,beatTime,1);
   
velocityBeatPropagation = lineConstants1(1);% in ms/mm = s/m
   



%calcualte fitted beat time
[curveValLog1] = polyval(lineConstants1,tailMMThisBeat, erros, mu);
   
%Calcualte RSquare
halfBeatWaveSpeedRsquare = 1 - erros.normr^2 / norm(beatTime-mean(beatTime))^2;

%extrapolated missing segments
numbMissingSegments = 10-lastMeasuredSegment;
 

if numbMissingSegments ~= 0
    
missingSegmentsMM = linspace(tailMM(lastMeasuredSegment + 1),tailMM(end),numbMissingSegments);

extrapolatedPos = polyval(lineConstants1,missingSegmentsMM,erros, mu);

else
    
    missingSegmentsMM = [];
    extrapolatedPos = [];
    
end

if min(extrapolatedPos) < 0
    
    indError = find(extrapolatedPos < 0);
    extrapolatedPos(indError) = 1;
    
end

%calcualte halfBeatWaveSpeed - m/s = mm/ms
% halfBeatWaveSpeed = 1/velocityBeatPropagation;%m/s = mm/ms

if length(tailMMThisBeat) > 1
instantaneousWaveVelocity = diff(tailMMThisBeat)./diff(beatTime);
instantaneousWaveVelocity(isinf(instantaneousWaveVelocity)) = 0;
halfBeatWaveSpeed = nanmedian(instantaneousWaveVelocity);%mm/ms

else
halfBeatWaveSpeed = NaN;
end

% %calcualte halfBeatWaveAcelaration - m/s2 = mm/ms2

% halfBeatWaveAcelaration = nanmean(diff(instantaneousWaveVelocity))/halfBeatDuration;%m/s2 = mm/ms2
% 
%  mean(instantaneousWaveVelocity)
%  (tailMMThisBeat(end) - tailMMThisBeat(1))/(beatTime(end) - beatTime(1))

% % test acelaration
% figure
% plot(beatTime, [instantaneousWaveVelocity 0],'.')
% hold on
% plot(beatTime, [diff([instantaneousWaveVelocity 0]) 0], '.r')

%%
%%%%%%%%%%%%%%%%%calcualte half beat angular velocity%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this is the velocity that the increase in amplitude occurs in a beat - degrees/s

%transform halfBeatCMVal into degrees
halfBeatCMValDegrees =  halfBeatCMVal*180/pi;

%fit line using least squares
[lineConstants2, erros, mu] = polyfit(beatTime,halfBeatCMValDegrees,1);
  
% halfBeatAngularVelocity = lineConstants2(1);% in degrees/ms

if length(halfBeatCMValDegrees) >1

instantaneousHalfBeatAngularVelocity = diff(halfBeatCMValDegrees)./diff(beatTime);
instantaneousHalfBeatAngularVelocity(isinf(instantaneousHalfBeatAngularVelocity)) = 0;
halfBeatAngularVelocity = nanmedian(instantaneousHalfBeatAngularVelocity);
else
    
halfBeatAngularVelocity = NaN;

end

%calcualte fitted beat time
[curveValLog2] = polyval(lineConstants2,beatTime, erros, mu);

%Calcualte RSquare
halfBeatAngularVelocityRsquare = 1 - erros.normr^2 / norm(halfBeatCMValDegrees-mean(halfBeatCMValDegrees))^2;


%%
%%%%%%%%%%%%Calculate tail amplitude by tail position rate%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this fitting is used to extrapolate amplitude of beat for missing segments

%fit line using least squares
[lineConstants3, erros, mu] = polyfit(tailMMThisBeat,halfBeatCMValDegrees,1);

% halfBeatAmplitudePositionRate = lineConstants3(1);% in degrees/mm

if length(tailMMThisBeat) > 1
    
    instantanousHalfBeatAmplitudePositionRate = diff(halfBeatCMValDegrees)./diff(tailMMThisBeat);%degrees/mm
    halfBeatAmplitudePositionRate = nanmean(instantanousHalfBeatAmplitudePositionRate);
    
else
    
    halfBeatAmplitudePositionRate = NaN;
    
end

%calcualte fitted beat time
[curveValLog3] = polyval(lineConstants3,tailMMThisBeat, erros, mu);


%Calcualte RSquare
halfBeatAmplitudePositionRateRsquare = 1 - erros.normr^2 / norm(halfBeatCMValDegrees-mean(halfBeatCMValDegrees))^2;

%extrapolated missing segments
if numbMissingSegments ~= 0
    

extrapolatedAmp = polyval(lineConstants3,missingSegmentsMM, erros, mu);
    
    
end

%%
%%%%%%%%%%%%save halfBeatExtrapolatedStructure%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%halfBeatExtrapolatedStructure

%same as in old structure
halfBeatExtrapolatedStructure(n).halfBeatInd = halfBeatInd;
halfBeatExtrapolatedStructure(n).halfBeatLinearInd = halfBeatLinearInd;
halfBeatExtrapolatedStructure(n).halfBeatVal = halfBeatVal;
halfBeatExtrapolatedStructure(n).halfBeatValGray = halfBeatValGray;
halfBeatExtrapolatedStructure(n).upDown = upDown;
halfBeatExtrapolatedStructure(n).halfBeatCMValGray = halfBeatCMValGray;
halfBeatExtrapolatedStructure(n).lastMeasuredSegment = lastMeasuredSegment;
halfBeatExtrapolatedStructure(n).indBeatStart = indBeatStart;
halfBeatExtrapolatedStructure(n).indBeatEnd = indBeatEnd;

%with new segments in structure
if numbMissingSegments ~= 0
    
% avoid error that extrapolated pos is 0 (not a ind) - make 1
indError = find(extrapolatedPos*fps < 1);

if ~isempty(indError)

    extrapolatedPos(indError) = 1/fps;

end

    
    
allPos = [halfBeatCMInd' [((lastMeasuredSegment+1):1:length(tailMM))' (extrapolatedPos*fps)']']' ;   
    


halfBeatExtrapolatedStructure(n).halfBeatCMInd = allPos;%in frame ind

if size(cumsum2DInterpolatedAngles,1) > extrapolatedPos(end)*fps%if extrapolated pos are inside the bout array

halfBeatExtrapolatedStructure(n).halfBeatCMLinearInd = [halfBeatCMLinearInd sub2ind([size(cumsum2DInterpolatedAngles,1) 10],(extrapolatedPos*fps)', ((lastMeasuredSegment+1):1:length(tailMM))')'];%in linear ind

else%if extrapolated pos are outside the bout array
    
halfBeatExtrapolatedStructure(n).halfBeatCMLinearInd = [halfBeatCMLinearInd sub2ind([extrapolatedPos(end)*fps 10],(extrapolatedPos*fps)', ((lastMeasuredSegment+1):1:length(tailMM))')'];%in linear ind
   


end

halfBeatExtrapolatedStructure(n).halfBeatCMVal = [halfBeatCMVal extrapolatedAmp*pi/180];%in rads

else
    
    halfBeatExtrapolatedStructure(n).halfBeatCMInd = halfBeatCMInd;
    halfBeatExtrapolatedStructure(n).halfBeatCMLinearInd = halfBeatCMLinearInd;
    halfBeatExtrapolatedStructure(n).halfBeatCMVal = halfBeatCMVal;
    
end

%%
%%%%%%%%%%%%%%%%%%%%%%%save slope and r2 of correlations%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


velocityBeatPropagationStructure(n).halfBeatWaveSpeed = halfBeatWaveSpeed;%m/s = mm/ms
velocityBeatPropagationStructure(n).halfBeatWaveSpeedRsquare = halfBeatWaveSpeedRsquare;

velocityBeatPropagationStructure(n).halfBeatAngularVelocity = halfBeatAngularVelocity;
velocityBeatPropagationStructure(n).halfBeatAngularVelocityRsquare = halfBeatAngularVelocityRsquare;

velocityBeatPropagationStructure(n).halfBeatAmplitudePositionRate = halfBeatAmplitudePositionRate;
velocityBeatPropagationStructure(n).halfBeatAmplitudePositionRateRsquare = halfBeatAmplitudePositionRateRsquare;

velocityBeatPropagationStructure(n).halfBeatDuration = halfBeatDuration;

%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%Test extrapolation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %plot tail beat
% 
% subplot(2,2,1)
% 
% 
% plot(halfBeatInd(:,2)/7,halfBeatVal*180/pi, '.k') 
% hold on
% plot(halfBeatCMInd(:,2)/7,halfBeatCMVal*180/pi, 'ob', 'linewidth',4) 
%    
% if numbMissingSegments ~= 0
%   
% plot(extrapolatedPos,extrapolatedAmp,'or','linewidth',4)
% 
% end
% 
% 
% axis([0 300 -200 200])
%    
% xlabel('Time (ms)')
%    
%   
% ylabel('Tail amplitude (degrees)')
% 
% 
% %%
% 
% %plot half beat wave speed
% 
% subplot(2,2,2)
% 
% 
% plot(beatTime,tailMMThisBeat, 'ok')
% hold on
% plot(curveValLog1,tailMMThisBeat,  'color', col(n,:),'linewidth',2)
% 
% if numbMissingSegments ~= 0
%   
% plot(extrapolatedPos,missingSegmentsMM,'or')
% 
% end
% 
% title({halfBeatWaveSpeedRsquare halfBeatWaveSpeed})
%  axis([ 0 300 0 4])
% 
% xlabel('Time (ms)')
% ylabel('Tail position (mm)')
% 
% 
% %%
% %plot halfBeatAngularVelocity
% subplot(2,2,3)
% 
% 
% plot(beatTime,halfBeatCMValDegrees, 'ok')
% hold on
% plot(beatTime, curveValLog2,'color', col(n,:),'linewidth',2)
% 
% if numbMissingSegments ~= 0
%   
% plot(extrapolatedPos,extrapolatedAmp,'or','linewidth',4)
% 
% end
% 
% title({halfBeatAngularVelocityRsquare halfBeatAngularVelocity})
% axis([0 300 -200 200])
% 
% xlabel('Time (ms)')
% ylabel('Tail amplitude (degrees)')
% 
% %%
% %plot tail amplitude by tail position
% 
% subplot(2,2,4)
% 
% 
% plot(tailMMThisBeat,halfBeatCMValDegrees, 'ko')
% hold on
% plot(tailMMThisBeat, curveValLog3,'color', col(n,:),'linewidth',2)
% 
% if numbMissingSegments ~= 0
%   
% plot(missingSegmentsMM,extrapolatedAmp,'or')
% 
% end
% 
% 
% title({halfBeatAmplitudePositionRateRsquare halfBeatAmplitudePositionRate})
% axis([0 4 -200 200])
% 
% xlabel('Tail position (mm)')
% ylabel('Tail amplitude (degrees)')
% pause

end
% pause(0.01)