%this function calculates kinematic parameters for each beat

%inputs
%1) numb of beat in bout (n)
%2) halfBeatExtrapolatedStructure
%3) velocityBeatPropagationStructure
%4) interpBodyAngles
%5) indRealBoutStart
%6) indRealBoutEnd
%7) interpPosX
%8) interpPosY
%9) tailSegmentLength
%10) pixelSize



%ouput
%1) halfBeatDuration (mm/s)
%2) velocityBeatPropagation (mm/ms)
%3) velocityBeatPropagationRsquare
%4) velocityBeatAmplitude (degrees/ms)
%5) velocityBeatAmplitudeRsquare
%6) halfBeatCMValDegrees
%7) halfBeatAmplitudeAll (degrees)
%8) halfBeatAmplitude1;
%9) halfBeatAmplitude2;
%10) halfBeatAmplitude3;
%11) halfBeatAmplitude4;
%12) halfBeatAmplitude5;
%13) halfBeatAmplitude6;
%14) halfBeatAmplitude7;
%15) halfBeatAmplitude8;
%16) halfBeatAmplitude9;
%17) halfBeatAmplitude10;
%18) halfBeatMeanAmplitude
%19) halfBeatMaxAmplitude
%20) AUCAll
%21) AUC1
%22) AUC2
%23) AUC3
%24) AUC4
%25) AUC5
%26) AUC6
%27) AUC7
%28) AUC8
%29) AUC9
%30) AUC10
%31) AUCmean
%32) AUCmax 
%33) beatAngle
%34) indBeatEnd %ind of beat in bout
%35) indBeatStart %ind of beat in bout
%36) upDown
%37) beatDistanceX
%38) beatDistanceY
%39) beatSpeedX
%40) beatSpeedY
%41) halfBeatHalfBendAngle
%42) halfBeatlHalfBendPos
%43) halfBeatMaxTailAngle
%44) halfBeatMinTailAngle
%45) halfBeatMaxTailPos
%46) halfBeatMinTailPos
%47) indBeatInSimStart
%48) indBeatInSimEnd
%49) numbBeatInBout

function  [BeatKinematicParameters, indBeatInStimStart,indBeatInStimEnd] = BeatParametersCalculator_13(n,tailMM, halfBeatExtrapolatedStructure, ...
    velocityBeatPropagationStructure, interpBodyAngles, indRealBoutStart,  interpPosX, interpPosY, pixelSize,interpSmootherTailCurveMeasure,...
    boutCurvature,interpBodyAnglesLessSmooth)
                                                                                                           
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%test function%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   n = 2;
%open variable
BeatKinematicParameters = zeros(1,48);


%%
%%%%%%%%%%%%%%%%get beat things from structure%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

halfBeatInd = halfBeatExtrapolatedStructure(n).halfBeatInd;

halfBeatVal =  halfBeatExtrapolatedStructure(n).halfBeatVal*180/pi;

%lastMeasuredSegment = halfBeatExtrapolatedStructure(n).lastMeasuredSegment;

 indBeatStart = halfBeatExtrapolatedStructure(n).indBeatStart;
 indBeatEnd = halfBeatExtrapolatedStructure(n).indBeatEnd;

%halfBeatLinearInd = halfBeatExtrapolatedStructure(n).halfBeatLinearInd;
%halfBeatValGray = halfBeatExtrapolatedStructure(n).halfBeatValGray;
upDown = halfBeatExtrapolatedStructure(n).upDown;

% BeatKinematicParameters.upDown = upDown;
% BeatKinematicParameters.numbBeatInBout = n;
numbBeatInBout = n;
BeatKinematicParameters(1) = upDown;
BeatKinematicParameters(2) = numbBeatInBout;

halfBeatCMInd = halfBeatExtrapolatedStructure(n).halfBeatCMInd;

% %calcualte postion in tail in mm
% tailMM2 = 1*tailSegmentLength*pixelSize/1000 : tailSegmentLength*pixelSize/1000 : max(halfBeatCMInd(:,1))*tailSegmentLength*pixelSize/1000;

% tailLength = tailMM(end); 

%halfBeatCMLinearInd = halfBeatExtrapolatedStructure(n).halfBeatCMLinearInd;
halfBeatCMVal = halfBeatExtrapolatedStructure(n).halfBeatCMVal*180/pi;
%lastMeasuredSegment = halfBeatExtrapolatedStructure(n).lastMeasuredSegment;
% halfBeatCMValGray = halfBeatExtrapolatedStructure(n).halfBeatCMValGray;



%%
%%%%%%%%%%%%%Calculate beat duration%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


halfBeatDuration = velocityBeatPropagationStructure(n).halfBeatDuration;

%save in structure
% BeatKinematicParameters.beatDuration = halfBeatDuration;% in ms
BeatKinematicParameters(3) = halfBeatDuration;% in ms


%%
%%%%%%%%%%%%%calculate frequency of beat%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%!!!! don't if it is possible or even makes sense to calculate the freq of one
%beat.... Doing inverse of time as frequency

halfBeatFrequency = 1/(halfBeatDuration/1000);%in hertz

%save in structure
% BeatKinematicParameters.beatFrequency = halfBeatFrequency;%in hertz
BeatKinematicParameters(4) = halfBeatFrequency;%in hertz
%%
%%%%%%%%%%%%%%%%%%%%%%%%Calculate beat amplitude%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%put half beat amplitude in vector with NaN when segment is not used

%make start NaN vector
startNaN = zeros(1, halfBeatCMInd(1,1)-1);
startNaN(:,:) = NaN;

%make end NaN vector
endNaN = zeros(1, 10 - max(halfBeatCMInd(:,1)));
endNaN(:,:) = NaN;

%concatenate
halfBeatAmplitudeAll = [startNaN halfBeatCMVal endNaN];%in degrees

%save in structure
% BeatKinematicParameters.beatAmplitudeAll = halfBeatAmplitudeAll;

%also save each segment individually
 halfBeatAmplitude1 = halfBeatAmplitudeAll(1);
 halfBeatAmplitude2 = halfBeatAmplitudeAll(2);
 halfBeatAmplitude3 = halfBeatAmplitudeAll(3);
 halfBeatAmplitude4 = halfBeatAmplitudeAll(4);
 halfBeatAmplitude5 = halfBeatAmplitudeAll(5);
 halfBeatAmplitude6 = halfBeatAmplitudeAll(6);
 halfBeatAmplitude7 = halfBeatAmplitudeAll(7);
 halfBeatAmplitude8 = halfBeatAmplitudeAll(8);
 halfBeatAmplitude9 = halfBeatAmplitudeAll(9);
 halfBeatAmplitude10 = halfBeatAmplitudeAll(10);

 %save in structure
%  BeatKinematicParameters.beatAmplitude1 = halfBeatAmplitude1;
%  BeatKinematicParameters.beatAmplitude2 = halfBeatAmplitude2;
%  BeatKinematicParameters.beatAmplitude3 = halfBeatAmplitude3;
%  BeatKinematicParameters.beatAmplitude4 = halfBeatAmplitude4;
%  BeatKinematicParameters.beatAmplitude5 = halfBeatAmplitude5;
%  BeatKinematicParameters.beatAmplitude6 = halfBeatAmplitude6;
%  BeatKinematicParameters.beatAmplitude7 = halfBeatAmplitude7;
%  BeatKinematicParameters.beatAmplitude8 = halfBeatAmplitude8;
%  BeatKinematicParameters.beatAmplitude9 = halfBeatAmplitude9;
%  BeatKinematicParameters.beatAmplitude10 = halfBeatAmplitude10;
 
 BeatKinematicParameters(5) = halfBeatAmplitude1;
 BeatKinematicParameters(6) = halfBeatAmplitude2;
 BeatKinematicParameters(7) = halfBeatAmplitude3;
 BeatKinematicParameters(8) = halfBeatAmplitude4;
 BeatKinematicParameters(9) = halfBeatAmplitude5;
 BeatKinematicParameters(10) = halfBeatAmplitude6;
 BeatKinematicParameters(11) = halfBeatAmplitude7;
 BeatKinematicParameters(12) = halfBeatAmplitude8;
 BeatKinematicParameters(13) = halfBeatAmplitude9;
 BeatKinematicParameters(14) = halfBeatAmplitude10;
 
%calcualte halfBeatMeanAmplitude
halfBeatMeanAmplitude = nanmean(halfBeatAmplitudeAll,2);

%save in structure
% BeatKinematicParameters.beatAmplitudeAvr = halfBeatMeanAmplitude;
BeatKinematicParameters(15) = halfBeatMeanAmplitude;

%calculate halfBeatMaxAmplitude
if nanmean(halfBeatAmplitudeAll)<0
    
halfBeatMaxAmplitude = -max(abs(halfBeatAmplitudeAll));

else
    
halfBeatMaxAmplitude = max(halfBeatAmplitudeAll); 

end

%save in structure
% BeatKinematicParameters.beatAmplitudeMax = halfBeatMaxAmplitude;
BeatKinematicParameters(16) = halfBeatMaxAmplitude;
%%
%%%%%%%%%%%%%%calculate halfBeatPos and halfBeatBeatAmp%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%find segments that have no nans and interpolate them

indStartSegment = find(~isnan(halfBeatAmplitudeAll));

%Calculate values of interpolated x%%%%%%%%%%%%%%%%%%%
         
        
%determine x - the length of tail in real data in mm
xPerc = tailMM(indStartSegment(1):indStartSegment(end));
        
%determine xi - the values we want to interpolate
xi = linspace(tailMM(indStartSegment(1)),tailMM(indStartSegment(end)),100);% x values that we want to interpolate
     
% %test new xi
%     plot(xPerc,xPerc,'o')  
%     hold on
%     plot(xi,xi, '.r')
%%%%%%%%%%%%%%%%%%%%%%%%%%interpolate tail data%%%%%%%%%%%%%%%%%%%%
       
intHalfBeatAmplitudeAll = interp1(xPerc,halfBeatAmplitudeAll(indStartSegment(1):indStartSegment(end))',xi, '*spline')';
        
%get values 
halfBeatMaxTailAngle = max(intHalfBeatAmplitudeAll);
halfBeatMinTailAngle = min(intHalfBeatAmplitudeAll);



indhalfBeatMaxTailAngle = find(intHalfBeatAmplitudeAll == halfBeatMaxTailAngle,1, 'first');
indhalfBeatMinTailAngle = find(intHalfBeatAmplitudeAll == halfBeatMinTailAngle,1, 'first');



%find halfBeatAmp
halfBeatHalfBendAngle = (halfBeatMinTailAngle +  halfBeatMaxTailAngle)/2;%in degrees




%find halfBeatBeatPos

%case max is bigger than min
if indhalfBeatMaxTailAngle > indhalfBeatMinTailAngle
        
        %find nearest position to halfBeatHalfBendAngle
        [~, indx] = min(abs(intHalfBeatAmplitudeAll(indhalfBeatMinTailAngle:indhalfBeatMaxTailAngle) - halfBeatHalfBendAngle));
    
        indhalfBeatHalfBendAngle = indhalfBeatMinTailAngle-1 + indx;
    
else%case min is bigger than max 
        
        %find nearest position to halfBeatHalfBendAngle
        [~, indx] = min(abs(intHalfBeatAmplitudeAll(indhalfBeatMaxTailAngle:indhalfBeatMinTailAngle) - halfBeatHalfBendAngle));
        
        indhalfBeatHalfBendAngle = indhalfBeatMaxTailAngle-1 + indx;
        
end
   
%calculate postions
halfBeatMaxTailPos = xi(indhalfBeatMaxTailAngle);
halfBeatMinTailPos = xi(indhalfBeatMinTailAngle);
halfBeatHalfBendPos = xi(indhalfBeatHalfBendAngle);
   
%save in structure
% BeatKinematicParameters.beatMaxTailAngle = halfBeatMaxTailAngle;
% BeatKinematicParameters.beatMinTailAngle = halfBeatMinTailAngle;
% 
% BeatKinematicParameters.beatHalfBendAngle = halfBeatHalfBendAngle;
% 
% BeatKinematicParameters.beatMaxTailPos = halfBeatMaxTailPos;
% BeatKinematicParameters.beatMinTailPos = halfBeatMinTailPos;
% BeatKinematicParameters.beatHalfBendPos = halfBeatHalfBendPos;


BeatKinematicParameters(17) = halfBeatMaxTailAngle;
BeatKinematicParameters(18)= halfBeatMinTailAngle;

BeatKinematicParameters(19) = halfBeatHalfBendAngle;

BeatKinematicParameters(20) = halfBeatMaxTailPos;
BeatKinematicParameters(21) = halfBeatMinTailPos;
BeatKinematicParameters(22) = halfBeatHalfBendPos;


% %test beatHalfBeatPos and beatHalfBeatAmp
% figure
% plot(xi, intHalfBeatAmplitudeAll)
% hold on
% plot(xi(indhalfBeatHalfBendAngle), intHalfBeatAmplitudeAll(indhalfBeatHalfBendAngle), 'oc')
% plot(xi(indhalfBeatMaxTailAngle), intHalfBeatAmplitudeAll(indhalfBeatMaxTailAngle), 'or')
% plot(xi(indhalfBeatMinTailAngle), intHalfBeatAmplitudeAll(indhalfBeatMinTailAngle), 'og') 

%%
%%%%%%%%%%%%%%%%%%%%%%save beat propagation parameters%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
halfBeatWaveSpeed = velocityBeatPropagationStructure(n).halfBeatWaveSpeed;
% halfBeatWaveSpeedRsquare = velocityBeatPropagationStructure(n).halfBeatWaveSpeedRsquare;

halfBeatAngularVelocity = velocityBeatPropagationStructure(n).halfBeatAngularVelocity;
% halfBeatAngularVelocityRsquare = velocityBeatPropagationStructure(n).halfBeatAngularVelocityRsquare;

halfBeatAmplitudePositionRate = velocityBeatPropagationStructure(n).halfBeatAmplitudePositionRate;
% vhalfBeatAmplitudePositionRateRsquare = velocityBeatPropagationStructure(n).halfBeatAmplitudePositionRateRsquare;

%save in structure
% BeatKinematicParameters.beatWaveSpeed = halfBeatWaveSpeed;%mm/s
BeatKinematicParameters(23) = halfBeatWaveSpeed;%mm/s

% BeatKinematicParameters.beatWaveSpeedRsquare = halfBeatWaveSpeedRsquare;

% BeatKinematicParameters.beatAngularVelocity = halfBeatAngularVelocity;
BeatKinematicParameters(24) = halfBeatAngularVelocity;
% BeatKinematicParameters.beatAngularVelocityRsquare = halfBeatAngularVelocityRsquare;

BeatKinematicParameters(25) = halfBeatAmplitudePositionRate;
% BeatKinematicParameters.beatAmplitudePositionRate = halfBeatAmplitudePositionRate;
% BeatKinematicParameters.beatAmplitudePositionRateRsquare = vhalfBeatAmplitudePositionRateRsquare;


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%calcualte AUC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%put AUC in vector with NaN when segment is not used

%make end NaN vector - must end in last segment because don't have data to calculate it
 endNaN = zeros(1, 10 - max(halfBeatInd(:,1)));
 endNaN(:,:) = NaN;

AUC = zeros(1, length(unique(halfBeatInd(:,1))));
numb = 1;
 
for i  =  min(halfBeatInd(:,1)) : 1 : max(halfBeatInd(:,1))%loop through each segment to calcualte AUC

% get col ind of this segment
indThisSegment = find(halfBeatInd(:,1) == i);
    
AUC(numb) = trapz(indThisSegment,halfBeatVal(indThisSegment))/10;%/10 because data is interpolated 10 times

numb = numb + 1;

end
%concatenate
AUCAll = [startNaN AUC endNaN];%in degrees

AUC1 = AUCAll(1);
AUC2 = AUCAll(2);
AUC3 = AUCAll(3);
AUC4 = AUCAll(4);
AUC5 = AUCAll(5);
AUC6 = AUCAll(6);
AUC7 = AUCAll(7);
AUC8 = AUCAll(8);
AUC9 = AUCAll(9);
AUC10 = AUCAll(10);

AUCmean = nanmean(AUCAll,2);

%calculate more extreme AUC
if nanmean(AUCAll) < 0
    
AUCmax = -max(abs(AUCAll));

else
    
AUCmax = max(AUCAll); 

end


%save in structure
% BeatKinematicParameters.AUCAll = AUCAll/10;%/10 beacuse of interpolation

% BeatKinematicParameters.AUC1 = AUC1/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC2 = AUC2/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC3 = AUC3/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC4 = AUC4/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC5 = AUC5/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC6 = AUC6/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC7 = AUC7/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC8 = AUC8/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC9 = AUC9/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUC10 = AUC10/10;%/10 beacuse of interpolation
% 
% BeatKinematicParameters.AUCAvr = AUCmean/10;%/10 beacuse of interpolation
% BeatKinematicParameters.AUCmax = AUCmax/10;%/10 beacuse of interpolation

BeatKinematicParameters(26) = AUC1/10;%/10 beacuse of interpolation
BeatKinematicParameters(27) = AUC2/10;%/10 beacuse of interpolation
BeatKinematicParameters(28) = AUC3/10;%/10 beacuse of interpolation
BeatKinematicParameters(29) = AUC4/10;%/10 beacuse of interpolation
BeatKinematicParameters(30) = AUC5/10;%/10 beacuse of interpolation
BeatKinematicParameters(31) = AUC6/10;%/10 beacuse of interpolation
BeatKinematicParameters(32) = AUC7/10;%/10 beacuse of interpolation
BeatKinematicParameters(33) = AUC8/10;%/10 beacuse of interpolation
BeatKinematicParameters(34) = AUC9/10;%/10 beacuse of interpolation
BeatKinematicParameters(35) = AUC10/10;%/10 beacuse of interpolation

BeatKinematicParameters(36) = AUCmean/10;%/10 beacuse of interpolation
BeatKinematicParameters(37) = AUCmax/10;%/10 beacuse of interpolation

%%
%%%%%%%%%%%%%%%%%%%%%%%%%calculate beat angle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get body angles in half beat beat
halfBeatBodyAngles = interpBodyAngles(indBeatStart : indBeatEnd)*180/pi;% in degrees

%normlize half beat body angles
halfBeatBodyAnglesNorm = halfBeatBodyAngles(1) - halfBeatBodyAngles;

%calculate beatAngle
beatAngle = (halfBeatBodyAnglesNorm(end) - halfBeatBodyAnglesNorm(1));% in degrees

%find max angle of half beat
halfBeatMaxAngle = max(abs(halfBeatBodyAnglesNorm));

%save in structure
% BeatKinematicParameters.beatAngle = beatAngle;
% BeatKinematicParameters.beatMaxAngle = halfBeatMaxAngle;% in degrees

BeatKinematicParameters(38) = beatAngle;
BeatKinematicParameters(39) = halfBeatMaxAngle;% in degrees


% %test beat angle
% figure
% plot(halfBeatBodyAnglesNorm, '.')

%%
%%%%%%%%%%%%%%%%Calculate halfBeat AngularSpeed%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
halfBeatAngularSpeed = diff(halfBeatBodyAnglesNorm(1:end))./0.14;% in degrees/ms

halfBeatMaxAngularSpeed = max(abs(halfBeatAngularSpeed));
% halfBeatAvrAngularSpeed = nanmean(abs(halfBeatAngularSpeed));

% BeatKinematicParameters.beatMaxAngularSpeed = halfBeatMaxAngularSpeed;
BeatKinematicParameters(40) = halfBeatMaxAngularSpeed;

% BeatKinematicParameters.beatAvrAngularSpeed = halfBeatAvrAngularSpeed;

%test angular velocity

% figure
% plot(halfBeatBodyAnglesNorm, '.')
% hold on
% plot(halfBeatAngularSpeed, 'r.')


%%
%%%%%%%%%%%%%%%%%%Calculate beat distances%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

posX = interpPosX(indBeatStart : indBeatEnd);  
posY = interpPosY(indBeatStart : indBeatEnd);   

% figure
% plot(interpPosX,interpPosY, '.')
% hold on 
% plot(posX,posY, 'or')
% 

interpBodyAnglesDegrees = interpBodyAngles(indBeatStart : indBeatEnd)*180/pi;%body angles are in degrees

[beatDistanceX,beatDistanceY,beatSpeedX,beatSpeedY,~,~] = speedWithDirectionCalculator_3(posX,posY,beatAngle,halfBeatDuration,interpBodyAnglesDegrees,pixelSize);

%save in structure
% BeatKinematicParameters.beatDistanceX = beatDistanceX;
% BeatKinematicParameters.beatDistanceY = beatDistanceY;
% BeatKinematicParameters.beatSpeedX = beatSpeedX;
% BeatKinematicParameters.beatSpeedY = beatSpeedY;

BeatKinematicParameters(41) = beatDistanceX;
BeatKinematicParameters(42) = beatDistanceY;
BeatKinematicParameters(43) = beatSpeedX;
BeatKinematicParameters(44) = beatSpeedY;

%%
%%%%%%%%%%%%%%%%%%%%%%%Calcualte ind of beat%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indBeatInStimStart = indRealBoutStart + indBeatStart;
indBeatInStimEnd = indRealBoutStart + indBeatEnd;

%save in structure
indBeatInStimStart = round(indBeatInStimStart/10);%/10 beacuse of interpolation
indBeatInStimEnd = round(indBeatInStimEnd/10);%/10 beacuse of interpolation


%%
%%%%%%%%%%%%%%%%%%%%%%%save maxTailChange%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% BeatKinematicParameters.maxTailChange = nanmax(interpSmootherTailCurveMeasure(indBeatStart:indBeatEnd));
% BeatKinematicParameters.meanTailChange = nanmean(interpSmootherTailCurveMeasure(indRealBoutStart:indBeatEnd));

BeatKinematicParameters(45) = nanmax(interpSmootherTailCurveMeasure(indBeatStart:indBeatEnd));
BeatKinematicParameters(46) = nanmean(interpSmootherTailCurveMeasure(indRealBoutStart:indBeatEnd));


 
%%
%%%%%%%%%%%%%%%%%%Get times of tail wave%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% endNaN = zeros(1, 10 - max(halfBeatCMInd(:,1)));
% endNaN(:,:) = NaN;
% 
% halfBeatTime = halfBeatExtrapolatedStructure(n).halfBeatCMInd(:,2)/7;% in ms
% 
% %concatenate
% halfBeatTimeAll = [startNaN halfBeatTime' endNaN];%in ms
% 
% %save in structure
% BeatKinematicParameters.beatTimeAll = halfBeatTimeAll;
% 
% BeatKinematicParameters.beatTime1 = halfBeatTimeAll(1);
% BeatKinematicParameters.beatTime2 = halfBeatTimeAll(2);
% BeatKinematicParameters.beatTime3 = halfBeatTimeAll(3);
% BeatKinematicParameters.beatTime4 = halfBeatTimeAll(4);
% BeatKinematicParameters.beatTime5 = halfBeatTimeAll(5);
% BeatKinematicParameters.beatTime6 = halfBeatTimeAll(6);
% BeatKinematicParameters.beatTime7 = halfBeatTimeAll(7);
% BeatKinematicParameters.beatTime8 = halfBeatTimeAll(8);
% BeatKinematicParameters.beatTime9 = halfBeatTimeAll(9);
% BeatKinematicParameters.beatTime10 = halfBeatTimeAll(10);

%%
%%%%%%%%%%%%%Calcualte tail curvature parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

halfBeatMaxCurvature = max(abs(boutCurvature(indBeatStart : indBeatEnd)));
halfBeatMaxCurvatureRate = max(abs(diff(boutCurvature(indBeatStart : indBeatEnd))));

% BeatKinematicParameters.beatMaxCurvature = halfBeatMaxCurvature;
% BeatKinematicParameters.beatMaxCurvatureRate = halfBeatMaxCurvatureRate;

BeatKinematicParameters(47) = halfBeatMaxCurvature;
BeatKinematicParameters(48) = halfBeatMaxCurvatureRate;

%%
%%%%%%%%%%%%%%%% save index of max of half beat in last position %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this measure is used to calculate the bout av freq and bout max freq
beatCMPosInt = halfBeatCMInd(end,end);%in not int index


BeatKinematicParameters(49) = beatCMPosInt;



%test curvature

% % plot(boutCurvature(indBeatStart : indBeatEnd), '.')
% hold on
% plot(diff(boutCurvature(indBeatStart : indBeatEnd)), 'r.')

%%
%%%%%%%%%%%%%%%%% calculate max angular speed less smooth %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

halfBeatBodyAnglesLessSmooth = interpBodyAnglesLessSmooth(indBeatStart : indBeatEnd)*180/pi;% in degrees

halfBeatBodyAnglesNormLessSmooth = halfBeatBodyAnglesLessSmooth(1) - halfBeatBodyAnglesLessSmooth;


halfBeatAngularSpeedLessSmooth = diff(halfBeatBodyAnglesNormLessSmooth(1:end))./0.14;% in degrees/ms

beatMaxAngularSpeedLessSmooth = max(abs(halfBeatAngularSpeedLessSmooth));

BeatKinematicParameters(50) = beatMaxAngularSpeedLessSmooth;




