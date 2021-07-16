classdef (Sealed) EnumeratorBeatInf
    properties (Constant)
    
        
%%%%%%%%%%%%%%%%%%save beat inf%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fishDirectionX = 1;       
fishDirectionY = 2;     
dataSetNumber = 3;   
protocolNumber = 4;   
fishUniqueNumber = 5;   
errorTailList = 6;   
stimNumber = 7;   
previousStimNumber = 8;   
pixelSize = 9;   
headToBladderLength = 10;   
tailSegmentLength = 11;   
distanceEyesToBlob = 12;   
lastMeasuredSegment = 13;   
fishAge = 14;   
boutUniqueNumber = 15;   
lagDetector = 16;   
numberOfBoutInStim = 17;   
uniqueFileNumber = 18;   
beatUniqueNumber = 19;   
numberOfBoutAfterCollision = 20;   

%%%%%%%%%%%%%%%%%%%%%%%%%% inds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indBeatStartAllData = 21;   
indBeatEndAllData = 22;   
indBeatStartInBout  = 23;   
indBeatEndInBout  = 24;   
indBeatStartInBoutInt = 25;   
indBeatEndInBoutInt = 26;   

latencyOfBoutAfterStim = 27;   
stimUniqueNumber = 28;   

realFishUniqueNumber = 29;   
trueUniqueFishNumber = 30;

wellNumber = 31;
fishIdentityNumber = 32;

beatCat = 33;
    end

    methods (Access = private)    % private so that you cant instantiate
        function out =  EnumeratorBeatInf
        end
    end
end