

function [BoutKinematicParametersThisBout] = BoutParametersCalculatorMaxAngularSpeed_1(BoutKinematicParametersThisBout,BeatKinematicParametersThisBout,realBodyAnglesLessSmoothThis)


% %test function 
%    BeatKinematicParameters = BeatKinematicParametersThisBout;
 
%%
%%%%%%%%%%%%%%% retreive beat kin  pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbBeatInBout = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.numbBeatInBout);

beatMaxAngularSpeedLessSmooth = BeatKinematicParametersThisBout(:,EnumeratorBeatKinPar.beatMaxAngularSpeedLessSmooth);


numbHalfBeats = length(numbBeatInBout);

%%
%%%%%%%%%%%%%% caculate boutMaxAngularSpeedLessSmooth %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%normalize body angle
normBoutBodyAngles2 = realBodyAnglesLessSmoothThis(1) - realBodyAnglesLessSmoothThis;
if mean(normBoutBodyAngles2) < 0
    
    normBoutBodyAngles2 = normBoutBodyAngles2*-1*180/pi;
    
    
else
    normBoutBodyAngles2 = normBoutBodyAngles2*180/pi;
    
end

boutAngularSpeedSmoot2 = diff(normBoutBodyAngles2)/1.426;%in degrees/ms

boutMaxAngularSpeedLessSmooth = max(abs(boutAngularSpeedSmoot2));%degrees
boutAvrAngularSpeedLessSmooth = nanmean(abs(boutAngularSpeedSmoot2));


BoutKinematicParametersThisBout(EnumeratorBoutKinPar.boutMaxAngularSpeedLessSmooth) = boutMaxAngularSpeedLessSmooth;
BoutKinematicParametersThisBout(EnumeratorBoutKinPar.boutAvrAngularSpeedLessSmooth) = boutAvrAngularSpeedLessSmooth;


%%
%%%%%%%%%%%%%%%%%% half beats max angular  speed %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutKinematicParametersThisBout(EnumeratorBoutKinPar.beat1beatAngularVelocitySmooth) = beatMaxAngularSpeedLessSmooth(1);

if numbHalfBeats >= 2

BoutKinematicParametersThisBout(EnumeratorBoutKinPar.beat2beatAngularVelocitySmooth) = beatMaxAngularSpeedLessSmooth(2);
else
    
BoutKinematicParametersThisBout(EnumeratorBoutKinPar.beat2beatAngularVelocitySmooth) = NaN;

end

if numbHalfBeats >= 3
    
BoutKinematicParametersThisBout(EnumeratorBoutKinPar.beat3beatAngularVelocitySmooth) = beatMaxAngularSpeedLessSmooth(3);

else
    
BoutKinematicParametersThisBout(EnumeratorBoutKinPar.beat3beatAngularVelocitySmooth) = NaN;

end 



