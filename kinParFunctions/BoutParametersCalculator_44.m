
%input
%1) BeatKinematicParameters
%2)
%3)


%output
%1)boutKinematicParametersThisBout
%2)indRealBoutStart
%3) indRealBoutEnd
%4) indDistanceBoutEnd


%test function
% allboutstarts2 = allboutstarts(zzzz)
% allboutends2 = allboutends(zzzz)

function [BoutKinematicParameters] = BoutParametersCalculator_44(BeatKinematicParametersThisBout,indRealBoutEnd,indRealBoutStart,...
    indDistanceBoutEnd,interpBodyAngles, interpBodyAngles2,interpPosX,interpPosY,pixelSize,cumsumInterpolatedAngleByBout,C1Angle,C1Duration,...
    C1MaxAngularSpeed,C2Angle,C2Duration,C2MaxAngularSpeed,eyeConvAvrThisBout,eyeConv20FramesBeforeBout,eyeConv20FramesAfterBout,eyeConvDiff2)
global fps

% %test function 
%    BeatKinematicParameters = BeatKinematicParametersThisBout;
 
%%
%%%%%%%%%%%%%%% retreive beat kin  pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
upDown = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.upDown);
numbBeatInBout = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.numbBeatInBout);
beatDuration = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatDuration);
beatFrequency = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatFrequency);

beatAmplitude1 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude1);
beatAmplitude2 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude2);
beatAmplitude3 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude3);
beatAmplitude4 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude4);
beatAmplitude5 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude5);
beatAmplitude6 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude6);
beatAmplitude7 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude7);
beatAmplitude8 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude8);
beatAmplitude9 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude9);
beatAmplitude10 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitude10);
beatAmplitudeAvr = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitudeAvr);
beatAmplitudeMax = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitudeMax);

beatMaxTailAngle = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxTailAngle);
beatMinTailAngle = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMinTailAngle);

beatHalfBendAngle = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatHalfBendAngle);
beatMaxTailPos = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxTailPos);
beatMinTailPos = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMinTailPos);
beatHalfBendPos = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatHalfBendPos);

beatWaveSpeed = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatWaveSpeed);
beatAngularVelocity = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAngularVelocity);
beatAmplitudePositionRate = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAmplitudePositionRate);

AUC1 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC1);
AUC2 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC2);
AUC3 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC3);
AUC4 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC4);
AUC5 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC5);
AUC6 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC6);
AUC7 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC7);
AUC8 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC8);
AUC9 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC9);
AUC10 = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUC10); 
AUCAvr = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUCAvr); 
AUCmax = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.AUCmax);

beatAngle = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatAngle);
beatMaxAngle = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxAngle);
beatMaxAngularSpeed = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxAngularSpeed);

beatDistanceX = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatDistanceX);
beatDistanceY = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatDistanceY);
beatSpeedX = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatSpeedX);
beatSpeedY = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatSpeedY);

maxTailChange = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.maxTailChange);
meanTailChange = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.meanTailChange);


beatMaxCurvature = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxCurvature);
beatMaxCurvatureRate = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxCurvatureRate);

beatCMPosInt = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatCMPosInt);

%%
%%%%%%%%%%%%%%%%%%%%numb of halfBeats bout%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbHalfBeats = length(beatDuration);

BoutKinematicParameters(1) = numbHalfBeats;


%%
%%%%%%%%%%%%%Calculate bout duration%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutDuration = (indRealBoutEnd - indRealBoutStart)/fps;%in ms it uses start and end of bout of beat detector

distBoutDuration = (indDistanceBoutEnd - indRealBoutStart)/fps;% in ms

BoutKinematicParameters(2) = boutDuration;
BoutKinematicParameters(3) = distBoutDuration;

%%
%%%%%%%%%%%%%calculate frequency of bout%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %by end of beat
% if numbHalfBeats > 1
% 
% boutFreqAll = 350./diff(indBeatEndAll);% in hz - use Beat end beacuse it seems more acurate
% 
% BoutKinematicParameters.meanBoutFreq = nanmean(boutFreqAll);% in hz
% BoutKinematicParameters.maxBoutFreq = max(boutFreqAll);% in hz
% BoutKinematicParameters.minBoutFreq = min(boutFreqAll);% in hz
% 
% else
% %put nan in case there is opnly one beat
% BoutKinematicParameters.meanBoutFreq = NaN;
% BoutKinematicParameters.maxBoutFreq = NaN;
% BoutKinematicParameters.minBoutFreq = NaN;
%     
% end


BoutKinematicParameters(4) = max(beatFrequency)/2;%divide by 2 because these are half beat freq
BoutKinematicParameters(5) = min(beatFrequency)/2;%divide by 2 because these are half beat freq
BoutKinematicParameters(6) = mean(beatFrequency)/2;%divide by 2 because these are half beat freq
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%head yaw%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%uses yawCalculator_3 - maxDiffYaw


boutBodyAngles2 = interpBodyAngles2(1:end);
  
[BoutKinematicParameters(7), BoutKinematicParameters(8), BoutKinematicParameters(9)] = yawCalculator_4(boutBodyAngles2);% in degrees

%%
%%%%%%%%%%%%%%%%%%%%%%%%%calculate bout angle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%normalize bout by starting at zero
interpBodyAnglesNorm = interpBodyAngles(1) - interpBodyAngles;
interpBodyAnglesNorm2 = interpBodyAngles2(1) - interpBodyAngles2;

boutAngle = (interpBodyAnglesNorm2(end) - interpBodyAnglesNorm2(1))*180/pi;% in degrees

distBoutAngle = (interpBodyAnglesNorm(end) - interpBodyAnglesNorm(1))*180/pi;% in degrees

%save in structure
BoutKinematicParameters(10) = boutAngle;
BoutKinematicParameters(11) = distBoutAngle;

%%
%%%%%%%%%%%%%Calculate bout max angle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%the max angle a fish has in a bout

%normalize body angle
normBoutBodyAngles = boutBodyAngles2(1) - boutBodyAngles2;
if mean(normBoutBodyAngles) < 0
    
    normBoutBodyAngles = normBoutBodyAngles*-1*180/pi;
    
    
else
    normBoutBodyAngles = normBoutBodyAngles*180/pi;
    
end

% test norm body angles
% plot(normBoutBodyAngles, '.')
% hold on
% plot(diff(normBoutBodyAngles), 'r.')
boutMaxAngle = max(abs(normBoutBodyAngles));

BoutKinematicParameters(12) = boutMaxAngle;


%%
%%%%%%%%%%%%%%%%Calculate Bout Angular Speed%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutAngularSpeed2 = diff(normBoutBodyAngles)/(1/fps);%in degrees/ms

boutMaxAngularSpeed = max(abs(boutAngularSpeed2));%degrees
boutAvrAngularSpeed = nanmean(abs(boutAngularSpeed2));

BoutKinematicParameters(13) = boutMaxAngularSpeed;%degrees/ms
BoutKinematicParameters(14) = boutAvrAngularSpeed;

%test angular velocity
% figure
% plot(normBoutBodyAngles, '.')
% hold on
% plot(boutAngularSpeed, 'r.')

%%
%%%%%%%%%%%%%%%%%%Calculate bout distances%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get positions by tail end of bout
posX = interpPosX(indRealBoutStart : indRealBoutEnd);  
posY = interpPosY(indRealBoutStart : indRealBoutEnd);   

%get positions by distance end of bout
distPosX = interpPosX(indRealBoutStart : end);  
distPosY = interpPosY(indRealBoutStart : end);   


% figure
% plot(interpPosX,interpPosY, '.')
% hold on 
% plot(posX,posY, 'or')


interpBodyAnglesDegrees = interpBodyAngles2*180/pi;%body angles are in degrees

distInterpBodyAnglesDegrees = interpBodyAngles(indRealBoutStart : end)*180/pi;%body angles are in degrees

[boutDistanceX,boutDistanceY,boutSpeedX,boutSpeedY,~,~] = speedWithDirectionCalculator_4(posX,posY,boutAngle,boutDuration,interpBodyAnglesDegrees,pixelSize/1);%pixelSize comes in mm devide byn 10 because of interpolation

[distBoutDistanceX,distBoutDistanceY,distBoutSpeedX,distBoutSpeedY,~,~] = speedWithDirectionCalculator_4(distPosX,distPosY,distBoutAngle,distBoutDuration,distInterpBodyAnglesDegrees,pixelSize/1);%pixelSize comes in mm devide by 10 because of interpolation



%save in structure
BoutKinematicParameters(15) = boutDistanceX;
BoutKinematicParameters(16) = boutDistanceY;
BoutKinematicParameters(17) = boutSpeedX;
BoutKinematicParameters(18) = boutSpeedY;

BoutKinematicParameters(19) = distBoutDistanceX;
BoutKinematicParameters(20) = distBoutDistanceY;
BoutKinematicParameters(21) = distBoutSpeedX;
BoutKinematicParameters(22) = distBoutSpeedY;


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%maxTailChange%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%do average of beat
maxTailChangeAvr = nanmean(maxTailChange);
meanTailChangeAvr = nanmean(meanTailChange);

%do max of bout
maxTailChangeMax = max(maxTailChange);
meanTailChangeMax = max(meanTailChange);

%save bout parameters
BoutKinematicParameters(23) = maxTailChangeAvr;
BoutKinematicParameters(24) = meanTailChangeAvr;

BoutKinematicParameters(25) = maxTailChangeMax;
BoutKinematicParameters(26) = meanTailChangeMax;

%%
%%%%%%%%%%%%%%%%%%%bout propagation parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutTailWaveSpeedAll = abs(beatWaveSpeed);
boutTailAngularVelocityAll = abs(beatAngularVelocity);
boutTailAmplitudePositionRateAll = abs(beatAmplitudePositionRate);

BoutKinematicParameters(27) = max(boutTailWaveSpeedAll);
BoutKinematicParameters(28) = min(boutTailWaveSpeedAll);
BoutKinematicParameters(29) = nanmean(boutTailWaveSpeedAll);

BoutKinematicParameters(30) = max(boutTailAngularVelocityAll );
BoutKinematicParameters(31) = min(boutTailAngularVelocityAll );
BoutKinematicParameters(32) = nanmean(boutTailAngularVelocityAll );

BoutKinematicParameters(33) = max(boutTailAmplitudePositionRateAll);
BoutKinematicParameters(34) = min(boutTailAmplitudePositionRateAll);
BoutKinematicParameters(35) = nanmean(boutTailAmplitudePositionRateAll);


%%
%%%%%%%%%%%%%%%%%%%%%%%bending Position%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


boutHalfBendingPosAll = abs(beatHalfBendPos);

BoutKinematicParameters(36) = max(boutHalfBendingPosAll);
BoutKinematicParameters(37) = min(boutHalfBendingPosAll);
BoutKinematicParameters(38) = nanmean(boutHalfBendingPosAll);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% curvature %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutCruvatureAll = beatMaxCurvature;
boutCurvatureRateAll = beatMaxCurvatureRate;

BoutKinematicParameters(39) = max(boutCruvatureAll);
BoutKinematicParameters(40) = min(boutCruvatureAll);
BoutKinematicParameters(41) = nanmean(boutCruvatureAll);

BoutKinematicParameters(42) = max(boutCurvatureRateAll);
BoutKinematicParameters(43) = min(boutCurvatureRateAll);
BoutKinematicParameters(44) = mean(boutCurvatureRateAll);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Amplitudes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%do average of abs beats - measure vigor
boutAbsAmplitude1Avr = nanmean(abs(beatAmplitude1));
boutAbsAmplitude2Avr = nanmean(abs(beatAmplitude2));
boutAbsAmplitude3Avr = nanmean(abs(beatAmplitude3)); 
boutAbsAmplitude4Avr = nanmean(abs(beatAmplitude4)); 
boutAbsAmplitude5Avr = nanmean(abs(beatAmplitude5)); 
boutAbsAmplitude6Avr = nanmean(abs(beatAmplitude6)); 
boutAbsAmplitude7Avr = nanmean(abs(beatAmplitude7)); 
boutAbsAmplitude8Avr = nanmean(abs(beatAmplitude8)); 
boutAbsAmplitude9Avr = nanmean(abs(beatAmplitude9));
boutAbsAmplitude10Avr = nanmean(abs(beatAmplitude10));

%save in structure
BoutKinematicParameters(45) = boutAbsAmplitude1Avr;
BoutKinematicParameters(46) = boutAbsAmplitude2Avr;
BoutKinematicParameters(47) = boutAbsAmplitude3Avr;
BoutKinematicParameters(48) = boutAbsAmplitude4Avr;
BoutKinematicParameters(49) = boutAbsAmplitude5Avr;
BoutKinematicParameters(50) = boutAbsAmplitude6Avr;
BoutKinematicParameters(51) = boutAbsAmplitude7Avr;
BoutKinematicParameters(52) = boutAbsAmplitude8Avr;
BoutKinematicParameters(53) = boutAbsAmplitude9Avr;
BoutKinematicParameters(54) = boutAbsAmplitude10Avr;

%get more extreme abs amp of beats
[~, indMoreExtreme1] = max(abs(beatAmplitude1));
[~, indMoreExtreme2] = max(abs(beatAmplitude2));
[~, indMoreExtreme3] = max(abs(beatAmplitude3)); 
[~, indMoreExtreme4] = max(abs(beatAmplitude4)); 
[~, indMoreExtreme5] = max(abs(beatAmplitude5)); 
[~, indMoreExtreme6] = max(abs(beatAmplitude6)); 
[~, indMoreExtreme7] = max(abs(beatAmplitude7)); 
[~, indMoreExtreme8] = max(abs(beatAmplitude8)); 
[~, indMoreExtreme9] = max(abs(beatAmplitude9));
[~, indMoreExtreme10] = max(abs(beatAmplitude10));

%get more extreme amplitude of beats
boutAmplitude1Max = beatAmplitude1(indMoreExtreme1);
boutAmplitude2Max = beatAmplitude2(indMoreExtreme2);
boutAmplitude3Max = beatAmplitude3(indMoreExtreme3); 
boutAmplitude4Max = beatAmplitude4(indMoreExtreme4); 
boutAmplitude5Max = beatAmplitude5(indMoreExtreme5);
boutAmplitude6Max = beatAmplitude6(indMoreExtreme6); 
boutAmplitude7Max = beatAmplitude7(indMoreExtreme7); 
boutAmplitude8Max = beatAmplitude8(indMoreExtreme8);
boutAmplitude9Max = beatAmplitude9(indMoreExtreme9); 
boutAmplitude10Max = beatAmplitude10(indMoreExtreme10); 

%save in structure
BoutKinematicParameters(55) = boutAmplitude1Max;
BoutKinematicParameters(56) = boutAmplitude2Max;
BoutKinematicParameters(57) = boutAmplitude3Max;
BoutKinematicParameters(58) = boutAmplitude4Max;
BoutKinematicParameters(59) = boutAmplitude5Max;
BoutKinematicParameters(60) = boutAmplitude6Max;
BoutKinematicParameters(61) = boutAmplitude7Max;
BoutKinematicParameters(62) = boutAmplitude8Max;
BoutKinematicParameters(63) = boutAmplitude9Max;
BoutKinematicParameters(64) = boutAmplitude10Max;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%calculate bout AUC%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcualte abs AUC of bout for each segment
absAUCAll = zeros(1, size(cumsumInterpolatedAngleByBout,2));

for i =  1 : size(cumsumInterpolatedAngleByBout,2)

  absAUCAll(i) = trapz(abs(cumsumInterpolatedAngleByBout(indRealBoutStart : indRealBoutEnd,i)))/10;%because data is interpolated 10 times
    
    
end

nanTail = zeros(1, 10-size(cumsumInterpolatedAngleByBout,2));
nanTail(:,:) = NaN;

absAUCAll = [absAUCAll nanTail];

% absAUCAvr = nanmean(absAUCAll);

% save in structure
BoutKinematicParameters(65) = absAUCAll(1);
BoutKinematicParameters(66) = absAUCAll(2);
BoutKinematicParameters(67) = absAUCAll(3);
BoutKinematicParameters(68) = absAUCAll(4);
BoutKinematicParameters(69) = absAUCAll(5);
BoutKinematicParameters(70) = absAUCAll(6);
BoutKinematicParameters(71) = absAUCAll(7);
BoutKinematicParameters(72) = absAUCAll(8);
BoutKinematicParameters(73) = absAUCAll(9);
BoutKinematicParameters(74) = absAUCAll(10);

%%
%%%%%%%%%%%%%%%%% save 1st beat kin par %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BoutKinematicParameters(75) = upDown(1); 
BoutKinematicParameters(76) = numbBeatInBout(1); 
BoutKinematicParameters(77) = beatDuration(1); 
BoutKinematicParameters(78) = beatFrequency(1);

BoutKinematicParameters(79) = beatAmplitude1(1); 
BoutKinematicParameters(80) = beatAmplitude2(1); 
BoutKinematicParameters(81) = beatAmplitude3(1); 
BoutKinematicParameters(82) = beatAmplitude4(1); 
BoutKinematicParameters(83) = beatAmplitude5(1); 
BoutKinematicParameters(84) = beatAmplitude6(1);  
BoutKinematicParameters(85) = beatAmplitude7(1); 
BoutKinematicParameters(86) = beatAmplitude8(1); 
BoutKinematicParameters(87) = beatAmplitude9(1); 
BoutKinematicParameters(88) = beatAmplitude10(1); 
BoutKinematicParameters(89) = beatAmplitudeAvr(1); 
BoutKinematicParameters(90) = beatAmplitudeMax(1); 

BoutKinematicParameters(91) = beatMaxTailAngle(1); 
BoutKinematicParameters(92) = beatMinTailAngle(1); 

BoutKinematicParameters(93) = beatHalfBendAngle(1); 
BoutKinematicParameters(94) = beatMaxTailPos(1); 
BoutKinematicParameters(95) = beatMinTailPos(1); 
BoutKinematicParameters(96) = beatHalfBendPos(1); 

BoutKinematicParameters(97) = beatWaveSpeed(1);  
BoutKinematicParameters(98) = beatAngularVelocity(1);
BoutKinematicParameters(99) = beatAmplitudePositionRate(1); 

BoutKinematicParameters(100) = AUC1(1); 
BoutKinematicParameters(101) = AUC2(1); 
BoutKinematicParameters(102) = AUC3(1); 
BoutKinematicParameters(103) = AUC4(1); 
BoutKinematicParameters(104) = AUC5(1); 
BoutKinematicParameters(105) = AUC6(1); 
BoutKinematicParameters(106) = AUC7(1); 
BoutKinematicParameters(107) = AUC8(1); 
BoutKinematicParameters(108) = AUC9(1); 
BoutKinematicParameters(109) = AUC10(1); 
BoutKinematicParameters(110) = AUCAvr(1); 
BoutKinematicParameters(111) = AUCmax(1); 

BoutKinematicParameters(112) = beatAngle(1); 
BoutKinematicParameters(113) = beatMaxAngle(1); 
BoutKinematicParameters(114) = beatMaxAngularSpeed(1);

BoutKinematicParameters(115) = beatDistanceX(1); 
BoutKinematicParameters(116) = beatDistanceY(1); 
BoutKinematicParameters(117) = beatSpeedX(1); 
BoutKinematicParameters(118) = beatSpeedY(1); 
BoutKinematicParameters(119) = maxTailChange(1); 
BoutKinematicParameters(120) = meanTailChange(1); 

BoutKinematicParameters(121) = beatMaxCurvature(1); 
BoutKinematicParameters(122) = beatMaxCurvatureRate(1); 


%%
%%%%%%%%%%%%%%%%% save 2nd beat kin par %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if numbHalfBeats >= 2

BoutKinematicParameters(123) = upDown(2); 
BoutKinematicParameters(124) = numbBeatInBout(2); 
BoutKinematicParameters(125) = beatDuration(2); 
BoutKinematicParameters(126) = beatFrequency(2);

BoutKinematicParameters(127) = beatAmplitude1(2); 
BoutKinematicParameters(128) = beatAmplitude2(2); 
BoutKinematicParameters(129) = beatAmplitude3(2); 
BoutKinematicParameters(130) = beatAmplitude4(2); 
BoutKinematicParameters(131) = beatAmplitude5(2); 
BoutKinematicParameters(132) = beatAmplitude6(2);  
BoutKinematicParameters(133) = beatAmplitude7(2); 
BoutKinematicParameters(134) = beatAmplitude8(2); 
BoutKinematicParameters(135) = beatAmplitude9(2); 
BoutKinematicParameters(136) = beatAmplitude10(2); 
BoutKinematicParameters(137) = beatAmplitudeAvr(2); 
BoutKinematicParameters(138) = beatAmplitudeMax(2); 

BoutKinematicParameters(139) = beatMaxTailAngle(2); 
BoutKinematicParameters(140) = beatMinTailAngle(2); 

BoutKinematicParameters(141) = beatHalfBendAngle(2); 
BoutKinematicParameters(142) = beatMaxTailPos(2); 
BoutKinematicParameters(143) = beatMinTailPos(2); 
BoutKinematicParameters(144) = beatHalfBendPos(2); 

BoutKinematicParameters(145) = beatWaveSpeed(2);  
BoutKinematicParameters(146) = beatAngularVelocity(2);
BoutKinematicParameters(147) = beatAmplitudePositionRate(2); 

BoutKinematicParameters(148) = AUC1(2); 
BoutKinematicParameters(149) = AUC2(2); 
BoutKinematicParameters(150) = AUC3(2); 
BoutKinematicParameters(151) = AUC4(2); 
BoutKinematicParameters(152) = AUC5(2); 
BoutKinematicParameters(153) = AUC6(2); 
BoutKinematicParameters(154) = AUC7(2); 
BoutKinematicParameters(155) = AUC8(2); 
BoutKinematicParameters(156) = AUC9(2); 
BoutKinematicParameters(157) = AUC10(2); 
BoutKinematicParameters(158) = AUCAvr(2); 
BoutKinematicParameters(159) = AUCmax(2); 

BoutKinematicParameters(160) = beatAngle(2); 
BoutKinematicParameters(161) = beatMaxAngle(2); 
BoutKinematicParameters(162) = beatMaxAngularSpeed(2);

BoutKinematicParameters(163) = beatDistanceX(2); 
BoutKinematicParameters(164) = beatDistanceY(2); 
BoutKinematicParameters(165) = beatSpeedX(2); 
BoutKinematicParameters(166) = beatSpeedY(2); 
BoutKinematicParameters(167) = maxTailChange(2); 
BoutKinematicParameters(168) = meanTailChange(2); 

BoutKinematicParameters(169) = beatMaxCurvature(2); 
BoutKinematicParameters(170) = beatMaxCurvatureRate(2); 

else
    
BoutKinematicParameters(123) = NaN; 
BoutKinematicParameters(124) = NaN; 
BoutKinematicParameters(125) = NaN; 
BoutKinematicParameters(126) = NaN; 

BoutKinematicParameters(127) = NaN; 
BoutKinematicParameters(128) = NaN; 
BoutKinematicParameters(129) = NaN; 
BoutKinematicParameters(130) = NaN; 
BoutKinematicParameters(131) = NaN; 
BoutKinematicParameters(132) = NaN; 
BoutKinematicParameters(133) = NaN; 
BoutKinematicParameters(134) = NaN; 
BoutKinematicParameters(135) = NaN; 
BoutKinematicParameters(136) = NaN; 
BoutKinematicParameters(137) = NaN; 
BoutKinematicParameters(138) = NaN; 

BoutKinematicParameters(139) = NaN; 
BoutKinematicParameters(140) = NaN; 

BoutKinematicParameters(141) = NaN; 
BoutKinematicParameters(142) = NaN; 
BoutKinematicParameters(143) = NaN; 
BoutKinematicParameters(144) = NaN; 

BoutKinematicParameters(145) = NaN; 
BoutKinematicParameters(146) = NaN; 
BoutKinematicParameters(147) = NaN; 

BoutKinematicParameters(148) = NaN; 
BoutKinematicParameters(149) = NaN; 
BoutKinematicParameters(150) = NaN; 
BoutKinematicParameters(151) = NaN; 
BoutKinematicParameters(152) = NaN; 
BoutKinematicParameters(153) = NaN; 
BoutKinematicParameters(154) = NaN; 
BoutKinematicParameters(155) = NaN;  
BoutKinematicParameters(156) = NaN; 
BoutKinematicParameters(157) = NaN; 
BoutKinematicParameters(158) = NaN; 
BoutKinematicParameters(159) = NaN; 

BoutKinematicParameters(160) = NaN; 
BoutKinematicParameters(161) = NaN; 
BoutKinematicParameters(162) = NaN; 

BoutKinematicParameters(163) = NaN; 
BoutKinematicParameters(164) = NaN; 
BoutKinematicParameters(165) = NaN; 
BoutKinematicParameters(166) = NaN; 
BoutKinematicParameters(167) = NaN; 
BoutKinematicParameters(168) = NaN; 

BoutKinematicParameters(169) = NaN; 
BoutKinematicParameters(170) = NaN; 

end

%%
%%%%%%%%%%%%%%%%% save 3rd beat kin par %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if numbHalfBeats >= 3

BoutKinematicParameters(171) = upDown(3); 
BoutKinematicParameters(172) = numbBeatInBout(3); 
BoutKinematicParameters(173) = beatDuration(3); 
BoutKinematicParameters(174) = beatFrequency(3);

BoutKinematicParameters(175) = beatAmplitude1(3); 
BoutKinematicParameters(176) = beatAmplitude2(3); 
BoutKinematicParameters(177) = beatAmplitude3(3); 
BoutKinematicParameters(178) = beatAmplitude4(3); 
BoutKinematicParameters(179) = beatAmplitude5(3); 
BoutKinematicParameters(180) = beatAmplitude6(3);  
BoutKinematicParameters(181) = beatAmplitude7(3); 
BoutKinematicParameters(182) = beatAmplitude8(3); 
BoutKinematicParameters(183) = beatAmplitude9(3); 
BoutKinematicParameters(184) = beatAmplitude10(3); 
BoutKinematicParameters(185) = beatAmplitudeAvr(3); 
BoutKinematicParameters(186) = beatAmplitudeMax(3); 

BoutKinematicParameters(187) = beatMaxTailAngle(3); 
BoutKinematicParameters(188) = beatMinTailAngle(3); 

BoutKinematicParameters(189) = beatHalfBendAngle(3); 
BoutKinematicParameters(190) = beatMaxTailPos(3); 
BoutKinematicParameters(191) = beatMinTailPos(3); 
BoutKinematicParameters(192) = beatHalfBendPos(3); 

BoutKinematicParameters(193) = beatWaveSpeed(3);  
BoutKinematicParameters(194) = beatAngularVelocity(3);
BoutKinematicParameters(195) = beatAmplitudePositionRate(3); 

BoutKinematicParameters(196) = AUC1(3); 
BoutKinematicParameters(197) = AUC2(3); 
BoutKinematicParameters(198) = AUC3(3); 
BoutKinematicParameters(199) = AUC4(3); 
BoutKinematicParameters(200) = AUC5(3); 
BoutKinematicParameters(201) = AUC6(3); 
BoutKinematicParameters(202) = AUC7(3); 
BoutKinematicParameters(203) = AUC8(3); 
BoutKinematicParameters(204) = AUC9(3); 
BoutKinematicParameters(205) = AUC10(3); 
BoutKinematicParameters(206) = AUCAvr(3); 
BoutKinematicParameters(207) = AUCmax(3); 

BoutKinematicParameters(208) = beatAngle(3); 
BoutKinematicParameters(209) = beatMaxAngle(3); 
BoutKinematicParameters(210) = beatMaxAngularSpeed(3);

BoutKinematicParameters(211) = beatDistanceX(3); 
BoutKinematicParameters(212) = beatDistanceY(3); 
BoutKinematicParameters(213) = beatSpeedX(3); 
BoutKinematicParameters(214) = beatSpeedY(3); 
BoutKinematicParameters(215) = maxTailChange(3); 
BoutKinematicParameters(216) = meanTailChange(3); 

BoutKinematicParameters(217) = beatMaxCurvature(3); 
BoutKinematicParameters(218) = beatMaxCurvatureRate(3); 

else

BoutKinematicParameters(171) = NaN;
BoutKinematicParameters(172) = NaN;
BoutKinematicParameters(173) = NaN;
BoutKinematicParameters(174) = NaN;

BoutKinematicParameters(175) = NaN;
BoutKinematicParameters(176) = NaN;
BoutKinematicParameters(177) = NaN;
BoutKinematicParameters(178) = NaN;
BoutKinematicParameters(179) = NaN;
BoutKinematicParameters(180) = NaN;
BoutKinematicParameters(181) = NaN;
BoutKinematicParameters(182) = NaN;
BoutKinematicParameters(183) = NaN;
BoutKinematicParameters(184) = NaN;
BoutKinematicParameters(185) = NaN;
BoutKinematicParameters(186) = NaN;

BoutKinematicParameters(187) = NaN;
BoutKinematicParameters(188) = NaN;

BoutKinematicParameters(189) = NaN;
BoutKinematicParameters(190) = NaN;
BoutKinematicParameters(191) = NaN;
BoutKinematicParameters(192) = NaN;

BoutKinematicParameters(193) = NaN; 
BoutKinematicParameters(194) = NaN;
BoutKinematicParameters(195) = NaN; 

BoutKinematicParameters(196) = NaN;
BoutKinematicParameters(197) = NaN;
BoutKinematicParameters(198) = NaN;
BoutKinematicParameters(199) = NaN;
BoutKinematicParameters(200) = NaN;
BoutKinematicParameters(201) = NaN;
BoutKinematicParameters(202) = NaN;
BoutKinematicParameters(203) = NaN;
BoutKinematicParameters(204) = NaN;
BoutKinematicParameters(205) = NaN;
BoutKinematicParameters(206) = NaN;
BoutKinematicParameters(207) = NaN;

BoutKinematicParameters(208) = NaN;
BoutKinematicParameters(209) = NaN;
BoutKinematicParameters(210) = NaN;

BoutKinematicParameters(211) = NaN;
BoutKinematicParameters(212) = NaN;
BoutKinematicParameters(213) = NaN;
BoutKinematicParameters(214) = NaN;
BoutKinematicParameters(215) = NaN;
BoutKinematicParameters(216) = NaN;

BoutKinematicParameters(217) = NaN;
BoutKinematicParameters(218) = NaN;
    
    
    
end

%%
%%%%%%%%%%%%%%% symmetry kin parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(indRealBoutStart) >= 2
    
firstBeatAmplitudeDiff = abs(beatAmplitude8(1)) - abs(beatAmplitude8(2));

BoutKinematicParameters(219) = firstBeatAmplitudeDiff;

else
    
BoutKinematicParameters(219) = NaN;

end

upBeatAmplitude = find(beatAmplitude8 > 0);
downBeatAmplitude = find(beatAmplitude8 < 0);

boutAmplitudeDiff = sum(abs(upBeatAmplitude)) - sum(abs(downBeatAmplitude));
BoutKinematicParameters(220) = boutAmplitudeDiff;

%%
%%%%%%%%%%%%%%% calculate correct frequency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if numbHalfBeats >= 3

%calculate mean bout frequency
firstHalfBeatPos = beatCMPosInt(1)./7000;%in s
lastHalfBeatPos = beatCMPosInt(end)./7000;%in s

meanBoutFreqCorr = ((length(beatCMPosInt) - 1)*0.5)./(lastHalfBeatPos - firstHalfBeatPos);%in Hz



%calcualte max bout frequency
%new way to calcualte max frequency
tbfPos = 7000./diff(beatCMPosInt(1:2:end));
tbfNeg = 7000./diff(beatCMPosInt(2:2:end));

maxBoutFreqCorr = max([tbfPos' tbfNeg']);%in Hz
minBoutFreqCorr = min([tbfPos' tbfNeg']);%in Hz


BoutKinematicParameters(221) = meanBoutFreqCorr;
BoutKinematicParameters(222) = maxBoutFreqCorr;
BoutKinematicParameters(223) = minBoutFreqCorr;

else
    
BoutKinematicParameters(221) = NaN;
BoutKinematicParameters(222) = NaN;
BoutKinematicParameters(223) = NaN;

end

%%
%%%%%%%%%%%%%%%%%%% Calculate maxDiffBodyAngle %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this measure is useful to find mistakes in bouts

maxDiffBodyAngle = max(abs(diff(boutBodyAngles2)));

BoutKinematicParameters(224) = maxDiffBodyAngle;

%%
%%%%%%%%%%%%%%%%% calculate bout max angular ratio %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isnan(boutMaxAngularSpeed) && ~isnan(boutMaxAngle)

boutMaxAngleRatio = boutMaxAngularSpeed/boutMaxAngle;

BoutKinematicParameters(225) = boutMaxAngleRatio;

else
    
    BoutKinematicParameters(225) = NaN;
    
end





%%
%%%%%%%%%%%%%%% calcualte C1 and C2 parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


BoutKinematicParameters(226) = C1Angle;
BoutKinematicParameters(227) = C1Duration;
BoutKinematicParameters(228) = C1MaxAngularSpeed;
BoutKinematicParameters(229) = C2Angle;
BoutKinematicParameters(230) = C2Duration;
BoutKinematicParameters(231) = C2MaxAngularSpeed;


%% 
%%%%%%%%%% eye kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutKinematicParameters(232) = eyeConvAvrThisBout;
BoutKinematicParameters(233) = eyeConv20FramesBeforeBout;
BoutKinematicParameters(234) = eyeConv20FramesAfterBout;
BoutKinematicParameters(235) = eyeConvDiff2;


