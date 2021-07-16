classdef (Sealed) EnumeratorBoutParameters
    properties (Constant)
    
        
%%%%%%%%%%%%%%%%%%bout inf%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
fishDirectionX = 1;        
fishDirectionY = 2;    
arenaX = 3;
arenaY = 4;
dataSetNumber = 5;
protocolNumber = 6;
fishUniqueNumber = 7;
errorTailList = 8;
stimNumber = 9;
pixelSize = 10;
headToBladderLength = 11;
tailSegmentLength = 12;
distanceEyesToBlob = 13;
lastMeasuredSegment = 14;
stimDirection = 15;
fishAge = 16;
stimUniqueNumber = 17;
boutUniqueNumber = 18;
lagDetector = 19;

%%%%%%%%%%%%%%%%%%%%%%%%%% inds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indBoutStartStimBlock = 20;
indBoutEndStimBlock  = 21;
indBoutRealEndStimBlock = 22;

indPreviousBoutStartStimBlock = 23;
indPreviousBoutEndStimBlock = 24;
indPreviousBoutRealEndStimBlock = 25;

indBoutStartInBoutPrecise = 26;
indBoutEndInBoutPrecise = 27;

indBoutStartStimBlockPrecise = 28;
indBoutEndStimBlockPrecise = 29;

indPreviousBoutStartStimBlockPrecise = 30;
indPrevuousBoutEndStimBlockPrecise = 31;

indStimStart = 32;
indStimEnd = 33;

numberOfBoutInStim = 34;

previousStimNumber = 35;

experimentUniqueNumber = 36;

    end

    methods (Access = private)    % private so that you cant instantiate
        function out = EnumeratorBoutParameters
        end
    end
end