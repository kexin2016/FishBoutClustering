
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

function [BoutKinematicParameters] = BoutParametersCalculator(BeatKinematicParametersThisBout,indRealBoutEnd,indRealBoutStart,...
    cumsumInterpolatedAngleByBout,eyeConvAvrThisBout,eyeConv20FramesBeforeBout,eyeConv20FramesAfterBout,eyeConvDiff2,fps)

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

maxTailChange = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.maxTailChange);
meanTailChange = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.meanTailChange);


beatMaxCurvature = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxCurvature);
beatMaxCurvatureRate = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxCurvatureRate);

beatCMPosInt = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatCMPosInt);

%%
%%%%%%%%%%%%%%%%%%%%numb of halfBeats bout%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbHalfBeats = length(beatDuration);

%%
%%%%%%%%%%%%%Calculate bout duration%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutDuration = (indRealBoutEnd - indRealBoutStart)/fps;%in ms it uses start and end of bout of beat detector

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


maxbeatFreq = max(beatFrequency)/2;%divide by 2 because these are half beat freq
minbeatFreq = min(beatFrequency)/2;%divide by 2 because these are half beat freq
meanbeatFreq = mean(beatFrequency)/2;%divide by 2 because these are half beat freq

%test angular velocity
% figure
% plot(normBoutBodyAngles, '.')
% hold on
% plot(boutAngularSpeed, 'r.')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%maxTailChange%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%do average of beat
maxTailChangeAvr = nanmean(maxTailChange);
meanTailChangeAvr = nanmean(meanTailChange);

%do max of bout
maxTailChangeMax = max(maxTailChange);
meanTailChangeMax = max(meanTailChange);


%%
%%%%%%%%%%%%%%%%%%%bout propagation parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

boutTailWaveSpeedAll = abs(beatWaveSpeed);
boutTailAngularVelocityAll = abs(beatAngularVelocity);
boutTailAmplitudePositionRateAll = abs(beatAmplitudePositionRate);

maxboutTailWaveSpeedAll = max(boutTailWaveSpeedAll);
minboutTailWaveSpeedAll = min(boutTailWaveSpeedAll);
meanboutTailWaveSpeedAll = nanmean(boutTailWaveSpeedAll);

maxboutTailAngularVelocityAll = max(boutTailAngularVelocityAll );
minboutTailAngularVelocityAll = min(boutTailAngularVelocityAll );
meanboutTailAngularVelocityAll = nanmean(boutTailAngularVelocityAll );

maxboutTailAmplitudePositionRateAll = max(boutTailAmplitudePositionRateAll);
minboutTailAmplitudePositionRateAll = min(boutTailAmplitudePositionRateAll);
meanboutTailAmplitudePositionRateAll = nanmean(boutTailAmplitudePositionRateAll);


%%
%%%%%%%%%%%%%%%%%%%%%%%bending Position%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


boutHalfBendingPosAll = abs(beatHalfBendPos);

maxboutHalfBendingPosAll = max(boutHalfBendingPosAll);
minboutHalfBendingPosAll = min(boutHalfBendingPosAll);
meanboutHalfBendingPosAll = nanmean(boutHalfBendingPosAll);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% curvature %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutCruvatureAll = beatMaxCurvature;
boutCurvatureRateAll = beatMaxCurvatureRate;

maxboutCruvatureAll = max(boutCruvatureAll);
minboutCruvatureAll = min(boutCruvatureAll);
meanboutCruvatureAll = nanmean(boutCruvatureAll);

maxboutCurvatureRateAll = max(boutCurvatureRateAll);
minboutCurvatureRateAll = min(boutCurvatureRateAll);
meanboutCurvatureRateAll = mean(boutCurvatureRateAll);

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

absAUCAll1 = absAUCAll(1);
absAUCAll2 = absAUCAll(2);
absAUCAll3 = absAUCAll(3);
absAUCAll4 = absAUCAll(4);
absAUCAll5 = absAUCAll(5);
absAUCAll6 = absAUCAll(6);
absAUCAll7 = absAUCAll(7);
absAUCAll8 = absAUCAll(8);
absAUCAll9 = absAUCAll(9);
absAUCAll10 = absAUCAll(10);

%%
%%%%%%%%%%%%%%%%% save 1st beat kin par %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:3
    if numbHalfBeats>=i
        eval(['hb' num2str(i) '_ud = upDown(' num2str(i) ');']);
        eval(['hb' num2str(i) '_numBeat = numbBeatInBout(' num2str(i) ');']);
        eval(['hb' num2str(i) '_dur = beatDuration(' num2str(i) ');']);
        eval(['hb' num2str(i) '_freq = beatFrequency(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp1 = beatAmplitude1(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp2 = beatAmplitude2(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp3 = beatAmplitude3(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp4 = beatAmplitude4(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp5 = beatAmplitude5(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp6 = beatAmplitude6(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp7 = beatAmplitude7(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp8 = beatAmplitude8(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp9 = beatAmplitude9(' num2str(i) ');']);
        eval(['hb' num2str(i) '_amp10 = beatAmplitude10(' num2str(i) ');']);
        eval(['hb' num2str(i) '_ampAvr = beatAmplitudeAvr(' num2str(i) ');']);
        eval(['hb' num2str(i) '_ampMax = beatAmplitudeMax(' num2str(i) ');']);
        eval(['hb' num2str(i) '_maxTailAngle = beatMaxTailAngle(' num2str(i) ');']);
        eval(['hb' num2str(i) '_minTailAngle = beatMinTailAngle(' num2str(i) ');']);
        eval(['hb' num2str(i) '_halfBendAngle = beatHalfBendAngle(' num2str(i) ');']);
        eval(['hb' num2str(i) '_maxTailPos = beatMaxTailPos(' num2str(i) ');']);
        eval(['hb' num2str(i) '_minTailPos = beatMinTailPos(' num2str(i) ');']);
        eval(['hb' num2str(i) '_halfBendPos = beatHalfBendPos(' num2str(i) ');']);
        eval(['hb' num2str(i) '_waveSpeed = beatWaveSpeed(' num2str(i) ');']);
        eval(['hb' num2str(i) '_angularVel = beatAngularVelocity(' num2str(i) ');']);
        eval(['hb' num2str(i) '_ampPosRate = beatAmplitudePositionRate(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc1 = AUC1(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc2 = AUC2(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc3 = AUC3(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc4 = AUC4(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc5 = AUC5(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc6 = AUC6(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc7 = AUC7(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc8 = AUC8(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc9 = AUC9(' num2str(i) ');']);
        eval(['hb' num2str(i) '_auc10 = AUC10(' num2str(i) ');']);
        eval(['hb' num2str(i) '_aucAvr = AUCAvr(' num2str(i) ');']);
        eval(['hb' num2str(i) '_aucMax = AUCmax(' num2str(i) ');']);
        eval(['hb' num2str(i) '_maxTailChange = maxTailChange(' num2str(i) ');']);
        eval(['hb' num2str(i) '_meanTailChange = meanTailChange(' num2str(i) ');']);
        eval(['hb' num2str(i) '_maxCurv = beatMaxCurvature(' num2str(i) ');']);
        eval(['hb' num2str(i) '_maxCurvRate = beatMaxCurvatureRate(' num2str(i) ');']);
    else
        eval(['hb' num2str(i) '_ud = nan;']);
        eval(['hb' num2str(i) '_numBeat = nan;']);
        eval(['hb' num2str(i) '_freq = nan;']);
        eval(['hb' num2str(i) '_dur = nan;']);
        eval(['hb' num2str(i) '_amp1 = nan;']);
        eval(['hb' num2str(i) '_amp2 = nan;']);
        eval(['hb' num2str(i) '_amp3 = nan;']);
        eval(['hb' num2str(i) '_amp4 = nan;']);
        eval(['hb' num2str(i) '_amp5 = nan;']);
        eval(['hb' num2str(i) '_amp6 = nan;']);
        eval(['hb' num2str(i) '_amp7 = nan;']);
        eval(['hb' num2str(i) '_amp8 = nan;']);
        eval(['hb' num2str(i) '_amp9 = nan;']);
        eval(['hb' num2str(i) '_amp10 = nan;']);
        eval(['hb' num2str(i) '_ampAvr = nan;']);
        eval(['hb' num2str(i) '_ampMax = nan;']);
        eval(['hb' num2str(i) '_maxTailAngle = nan;']);
        eval(['hb' num2str(i) '_minTailAngle = nan;']);
        eval(['hb' num2str(i) '_halfBendAngle = nan;']);
        eval(['hb' num2str(i) '_maxTailPos = nan;']);
        eval(['hb' num2str(i) '_minTailPos = nan;']);
        eval(['hb' num2str(i) '_halfBendPos = nan;']);
        eval(['hb' num2str(i) '_waveSpeed = nan;']);
        eval(['hb' num2str(i) '_angularVel = nan;']);
        eval(['hb' num2str(i) '_ampPosRate = nan;']);
        eval(['hb' num2str(i) '_auc1 = nan;']);
        eval(['hb' num2str(i) '_auc2 = nan;']);
        eval(['hb' num2str(i) '_auc3 = nan;']);
        eval(['hb' num2str(i) '_auc4 = nan;']);
        eval(['hb' num2str(i) '_auc5 = nan;']);
        eval(['hb' num2str(i) '_auc6 = nan;']);
        eval(['hb' num2str(i) '_auc7 = nan;']);
        eval(['hb' num2str(i) '_auc8 = nan;']);
        eval(['hb' num2str(i) '_auc9 = nan;']);
        eval(['hb' num2str(i) '_auc10 = nan;']);
        eval(['hb' num2str(i) '_aucAvr = nan;']);
        eval(['hb' num2str(i) '_aucMax = nan;']);
        eval(['hb' num2str(i) '_maxTailChange = nan;']);
        eval(['hb' num2str(i) '_meanTailChange = nan;']);
        eval(['hb' num2str(i) '_maxCurv = nan;']);
        eval(['hb' num2str(i) '_maxCurvRate = nan;']);
    end
end
%%
%%%%%%%%%%%%%%% symmetry kin parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(indRealBoutStart) >= 2
    
    firstBeatAmplitudeDiff = abs(beatAmplitude8(1)) - abs(beatAmplitude8(2));
    
    
else
    
    firstBeatAmplitudeDiff = NaN;
    
end

upBeatAmplitude = find(beatAmplitude8 > 0);
downBeatAmplitude = find(beatAmplitude8 < 0);

boutAmplitudeDiff = sum(abs(upBeatAmplitude)) - sum(abs(downBeatAmplitude));

%%
%%%%%%%%%%%%%%% calculate correct frequency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if numbHalfBeats >= 3
    
    %calculate mean bout frequency
    firstHalfBeatPos = beatCMPosInt(1)./(fps*1000);%in s
    lastHalfBeatPos = beatCMPosInt(end)./(fps*1000);%in s
    
    meanBoutFreqCorr = ((length(beatCMPosInt) - 1)*0.5)./(lastHalfBeatPos - firstHalfBeatPos);%in Hz
    
    
    
    %calcualte max bout frequency
    %new way to calcualte max frequency
    tbfPos =(fps*1000)./diff(beatCMPosInt(1:2:end));
    tbfNeg = (fps*1000)./diff(beatCMPosInt(2:2:end));
    
    maxBoutFreqCorr = max([tbfPos' tbfNeg']);%in Hz
    minBoutFreqCorr = min([tbfPos' tbfNeg']);%in Hz
    
else
    
    meanBoutFreqCorr = NaN;
    maxBoutFreqCorr = NaN;
    minBoutFreqCorr = NaN;
    
end

BoutKineEnumerator = getEnumeratorBoutKinematicParams();
field = fieldnames(BoutKineEnumerator);
BoutKinematicParameters = zeros(length(field),1);
for cfield = col2row(field,1)
    eval(['BoutKinematicParameters(BoutKineEnumerator.' cfield{1} ') = (' cfield{1} ');']);
end
end

