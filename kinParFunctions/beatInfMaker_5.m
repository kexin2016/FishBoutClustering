
function [BeatInfThisBeat] = beatInfMaker_5(zzzz,xPos,yPos,dataSetNumber,protocolNumber,fishUniqueNumber,thisBoutStim, boutPreviousStim,pixelSize,headToBladderLength,tailSegmentLength,distanceEyesToBlob,lastMeasuredSegment,fishAge,boutUniqueNumber,lagVector,allboutstarts,sequenceOfBoutsInStim,uniqueFileNumber,beatUniqueNumber,indBeatStartNotIntAllData,indBeatEndNotIntAllData,indBeatStartNotInt,indBeatEndNotInt,indBeatStart,indBeatEnd,sequenceOfBoutsInNoCollision,latencyOfBoutAfterStim,stimUniqueNumberBoutVector,realFishUniqueNumber,trueUniqueFishNumber,wellLetter)


%fishDirectionX - save general X direction fish is going - + left to right; - right to left       
BeatInfThisBeat(1) = (xPos(indBeatEndNotIntAllData) - xPos(indBeatStartNotIntAllData));
        
%fishDirectionY - save general Y direction fish is going - + down to up; - up to down
BeatInfThisBeat(2) = (yPos(indBeatEndNotIntAllData) - yPos(indBeatStartNotIntAllData));
             
% BeatInf(beatNumber).dataSetNumber =  n;
BeatInfThisBeat(3) = dataSetNumber;

%save protocol number
BeatInfThisBeat(4) = protocolNumber;

%save fish number - each fish has an idividual number
BeatInfThisBeat(5) = fishUniqueNumber;

% %save error list of beat -  0 no error, 1 fixed error, 2 unfixable error
% BeatInfThisBeat(6) = max(errorList((allboutstarts(zzzz) + indBeatStartNotInt) : (allboutstarts(zzzz) + indBeatEndNotInt )));

%save stim Number
BeatInfThisBeat(7) = thisBoutStim;

%save previous stim number
BeatInfThisBeat(8) = boutPreviousStim;

%save pixel size
BeatInfThisBeat(9) = pixelSize;%in mm

%save headToBladderLength
BeatInfThisBeat(10) = headToBladderLength;%in pixel

%save tailSegmentLength
BeatInfThisBeat(11) = tailSegmentLength;%in pixel

%save distanceEyesToBlob
BeatInfThisBeat(12) = distanceEyesToBlob/1000;% in mm

%save ind last segment interpolated - the others are extrapolated
BeatInfThisBeat(13) = lastMeasuredSegment;

%save fish age
BeatInfThisBeat(14) = fishAge;

%save boutUniqueNumber 
BeatInfThisBeat(15) = boutUniqueNumber;


%save if bout was in a trial with high lag
if max(lagVector((allboutstarts(zzzz) + indBeatStartNotInt) : (allboutstarts(zzzz) + indBeatEndNotInt ))) == 1
    
%     BeatInf(beatNumber).lagDetector = 1;
    BeatInfThisBeat(16) = 1;
else
    
%     BeatInf(beatNumber).lagDetector = 0;
     BeatInfThisBeat(16) = 0;
    
end  

%sequence of bout in stim
BeatInfThisBeat(17) = sequenceOfBoutsInStim(zzzz);

%file number
BeatInfThisBeat(18) = uniqueFileNumber;

BeatInfThisBeat(19) = beatUniqueNumber;

BeatInfThisBeat(20) = sequenceOfBoutsInNoCollision(zzzz);


%%%%%%%%%%%%%%%%%%%%%%%%%% save inds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BeatInfThisBeat(21) = indBeatStartNotIntAllData;
BeatInfThisBeat(22) = indBeatEndNotIntAllData; 
BeatInfThisBeat(23) = indBeatStartNotInt;
BeatInfThisBeat(24) = indBeatEndNotInt;
BeatInfThisBeat(25) = indBeatStart;
BeatInfThisBeat(26) = indBeatEnd;

BeatInfThisBeat(27) = latencyOfBoutAfterStim(zzzz);
BeatInfThisBeat(28) = stimUniqueNumberBoutVector(zzzz);

BeatInfThisBeat(29) = realFishUniqueNumber;

BeatInfThisBeat(30) = trueUniqueFishNumber;


%%
%%%%%%%%%%%%%% well numbers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isnan(wellLetter)
switch wellLetter
    
    case 'A'
        
      wellNumber = 1; 
      
    case 'B'
        
      wellNumber = 2;    

    case 'C'
        
      wellNumber = 3;    
           
    case 'D'
        
      wellNumber = 4;    
         
    case 'F'
        
      wellNumber = 5;    
             
    case 'G'
       wellNumber = 6;    
  
    case 'H'
       wellNumber = 7;    
  
    case 'I'
       wellNumber = 8;    

    case 'J'
       wellNumber = 9;    

    otherwise
      wellNumber = nan;  
end
else
      wellNumber = nan;  
    
end

BeatInfThisBeat(31) = wellNumber;


%%
%%%%%%%%%%%%%%%%%% save fish idendity for ablations %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[fishIdentityNumber]  = fishIdentity_1(wellLetter);

BeatInfThisBeat(32) = fishIdentityNumber;

