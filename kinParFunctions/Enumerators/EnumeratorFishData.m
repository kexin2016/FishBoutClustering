 classdef EnumeratorFishData
    properties (Constant)
 
%%%%%%%%%%%%%%%%%%save bout inf%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bodyAngles = 1;%raw data 
realBodyAngles = 2;%pi corrected and smoothed by sgolayfilt(realBodyAngles,2,13,[],1);
cumsumInterpFixedSegmentAngles = [3 4 5 6 7 8 9 10 11 12];

smootherTailCurveMeasure = 13;
filteredDistance = 14;
lagVector = 15;
leftEyeAngle = 16;
rightEyeAngle = 17;
convergengePar = 18;
parameciaCounter = [19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49];

xPos = 50;%in pixels
yPos = 51;%in pixels
stim = 52;
noCollision = 53;
fishInSquare = 54;

timeInSeconds = 55;
errorListAllMitakes = [56 57 58 59 60 61 62 63 64 65];
errorListNotFixedMistakes = [66 67 68 69 70 71 72 73 74 75];

tailVals = [76 77 78 79 80 81 82 83 84 85 ];
collisionflag  = 86;
obendErrors  = 87;
smoothLeftEye= 88;
smoothRightEye  = 89;
smoothTailResiduals  = 90;
smoothBodyResiduals  = 91;

  end

    methods (Access = private)    % private so that you cant instantiate
        function out = EnumeratorFishData
        end
    end
 end

 
 
    