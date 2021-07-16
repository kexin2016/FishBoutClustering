 classdef (Sealed) EnumeratorBeatKinPar
    properties (Constant)
 



%%%%%%%%%%%%%%%%%%%%%kinematic parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

upDown = 1;
numbBeatInBout = 2;
beatDuration = 3;
beatFrequency = 4;

beatAmplitude1= 5;
beatAmplitude2 = 6;
beatAmplitude3 = 7;
beatAmplitude4 = 8; 
beatAmplitude5 = 9;
beatAmplitude6 = 10; 
beatAmplitude7 = 11; 
beatAmplitude8 = 12;
beatAmplitude9 = 13; 
beatAmplitude10 = 14; 
beatAmplitudeAvr = 15;
beatAmplitudeMax = 16;

beatMaxTailAngle = 17;
beatMinTailAngle = 18;

beatHalfBendAngle = 19;
beatMaxTailPos = 20;
beatMinTailPos = 21;
beatHalfBendPos = 22;

beatWaveSpeed = 23;
beatAngularVelocity = 24;
beatAmplitudePositionRate = 25;

AUC1 = 26;
AUC2 = 27;
AUC3 = 28; 
AUC4 = 29;
AUC5 = 30;
AUC6 = 31; 
AUC7 = 32;
AUC8 = 33;
AUC9 = 34;
AUC10 = 35; 
AUCAvr = 36; 
AUCmax = 37;

beatAngle = 38;
beatMaxAngle = 39;
beatMaxAngularSpeed = 40;

beatDistanceX = 41;
beatDistanceY = 42;
beatSpeedX = 43;
beatSpeedY = 44;

maxTailChange = 45;
meanTailChange = 46;


beatMaxCurvature = 47;
beatMaxCurvatureRate = 48;

beatCMPosInt = 49;

beatMaxAngularSpeedLessSmooth = 50;

    end

    methods (Access = private)    % private so that you cant instantiate
        function out = EnumeratorBeatKinPar
        end
    end
end