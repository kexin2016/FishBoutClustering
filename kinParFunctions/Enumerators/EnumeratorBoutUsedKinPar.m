classdef (Sealed) EnumeratorBoutUsedKinPar
    properties (Constant)
    
        



%%%%%%%%%%%%%%%%%%%%%kinematic parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutMaxAngularSpeed = 1;
maxTailChangeMax = 2; 
boutAmplitude7Max  = 3;
boutAvrAngularSpeed  = 4; 
meanTailChangeMax   = 5;
boutAmplitude1Max  = 6;
boutAmplitude8Max  = 7;
boutAmplitude2Max  = 8;
boutAmplitude3Max  = 9;
boutAmplitude4Max  = 10;
boutAmplitude5Max   = 11;
boutCruvatureMax  = 12;   
headMaxYaw  = 13;
headMeanYaw  = 14;
boutMaxAngle  = 15;
boutAngle  = 16;
boutSpeedY  = 17;
maxBoutFreq = 18;
    



    end

    methods (Access = private)    % private so that you cant instantiate
        function out = EnumeratorBoutUsedKinPar
        end
    end
end