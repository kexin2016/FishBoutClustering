 classdef (Sealed) EnumeratorBeatParameters
    properties (Constant)
 
%%%%%%%%%%%%%%%%%%save beat inf%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

indBeatInStimStart = 20;
indBeatInStimEnd = 21;
indBeatStartNotInt = 22;
indBeatEndNotInt = 23;

indBeatStart = 24;
indBeatEnd = 25;

indStimStart = 26;
indStimEnd = 27;

numberOfBoutInStim = 28;

previousStimNumber = 29;



    end

    methods (Access = private)    % private so that you cant instantiate
        function out = EnumeratorBeatParameters
        end
    end
end