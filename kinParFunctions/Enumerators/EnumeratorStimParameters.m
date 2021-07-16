 classdef (Sealed) EnumeratorStimParameters
    properties (Constant)
 
%%%%%%%%%%%%%%%%%%save bout inf%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arenaX = 1;
arenaY = 2;
dataSetNumber = 3;
protocolNumber = 4;
fishUniqueNumber = 5;
errorTailList = 6;
stimNumber = 7;
pixelSize = 8;
headToBladderLength = 9;
tailSegmentLength = 10;
distanceEyesToBlob = 11;
lastMeasuredSegment = 12;
stimDirection = 13;
fishAge = 14;
stimUniqueNumber = 15;
lagDetector = 16;



%%%%%%%%%%%%%%%%%%%%%%%%%% inds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indStimStart = 17;
indStimEnd = 18;

experimentUniqueNumber = 19;
    end

    methods (Access = private)    % private so that you cant instantiate
        function out = EnumeratorStimParameters
        end
    end
end