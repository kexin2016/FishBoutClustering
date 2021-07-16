
function [BoutInfThisBout] = boutInfMaker_20(zzzz,xPos,yPos,dataSetNumber,protocolNumber,fishUniqueNumber,thisBoutStim, boutPreviousStim,...
    pixelSize,headToBladderLength,tailSegmentLength,distanceEyesToBlob,lastMeasuredSegment,fishAge,boutUniqueNumber,lagVector,allboutstarts,...
    allboutends,sequenceOfBoutsInStim,uniqueFileNumber,sequenceOfBoutsInNoCollision,latencyOfBoutAfterStim,stimUniqueNumberBoutVector,...
    brokenBouts,halfBeatPosWithNaNTag,halfBeatMagWithNaNTag,doubleBout,firstSegmentWithNotfixedMistakes,firstSegmentWithAnyMistake,...
    realFishUniqueNumber,trueUniqueFishNumber,wellLetter,eyeConvDiffThisBout)


%fishDirectionX - save general X direction fish is going - + left to right; - right to left       
BoutInfThisBout(1) = (xPos(allboutends(zzzz)) - xPos(allboutstarts(zzzz)));
        
%fishDirectionY - save general Y direction fish is going - + down to up; - up to down
BoutInfThisBout(2) = (yPos(allboutends(zzzz)) - yPos(allboutstarts(zzzz)));
             
% BeatInf(beatNumber).dataSetNumber =  n;
BoutInfThisBout(3) = dataSetNumber;

%save protocol number
BoutInfThisBout(4) = protocolNumber;

%save fish number - each fish has an idividual number
BoutInfThisBout(5) = fishUniqueNumber;

% %save error list of beat -  0 no error, 1 fixed error, 2 unfixable error
% BoutInfThisBout(6) = max(errorList((allboutstarts(zzzz)) : (allboutends(zzzz))));

%save stim Number
BoutInfThisBout(7) = thisBoutStim;

%save previous stim number
BoutInfThisBout(8) = boutPreviousStim;

%save pixel size
BoutInfThisBout(9) = pixelSize;%in mm

%save headToBladderLength
BoutInfThisBout(10) = headToBladderLength;%in pixel

%save tailSegmentLength
BoutInfThisBout(11) = tailSegmentLength;%in pixel

%save distanceEyesToBlob
BoutInfThisBout(12) = distanceEyesToBlob/1000;% in mm

%save ind last segment interpolated - the others are extrapolated
BoutInfThisBout(13) = lastMeasuredSegment;

%save fish age
BoutInfThisBout(14) = fishAge;

%save boutUniqueNumber 
BoutInfThisBout(15) = boutUniqueNumber;


%save if bout was in a trial with high lag
if max(lagVector((allboutstarts(zzzz)) : (allboutends(zzzz)))) == 1
    
%     BeatInf(beatNumber).lagDetector = 1;
    BoutInfThisBout(16) = 1;
else
    
%     BeatInf(beatNumber).lagDetector = 0;
     BoutInfThisBout(16) = 0;
    
end  

%sequence of bout in stim
BoutInfThisBout(17) = sequenceOfBoutsInStim(zzzz);

%file number
BoutInfThisBout(18) = uniqueFileNumber;

%sequence of bouts after collision
BoutInfThisBout(19) = sequenceOfBoutsInNoCollision(zzzz);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%% save inds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BoutInfThisBout(20) = allboutstarts(zzzz);
BoutInfThisBout(21) = allboutends(zzzz); 

BoutInfThisBout(22) = latencyOfBoutAfterStim(zzzz);

BoutInfThisBout(23) = stimUniqueNumberBoutVector(zzzz);

BoutInfThisBout(24) = brokenBouts;

%%
%%%%%%%%%%%%%%%% save neat pos and amplitudes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutInfThisBout(25:74) = halfBeatPosWithNaNTag;

BoutInfThisBout(75:124) = halfBeatMagWithNaNTag;

BoutInfThisBout(125) = doubleBout;


BoutInfThisBout(126) = firstSegmentWithNotfixedMistakes;

BoutInfThisBout(127) = firstSegmentWithAnyMistake;

%%
%%%%%%%%%%%%%%%%%%%%%%%%% edges %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save pos of fish in start and end of bout so that bouts in the edges can
%be excluded
    
BoutInfThisBout(128) = xPos(allboutstarts(zzzz));
BoutInfThisBout(129) = yPos(allboutstarts(zzzz));

BoutInfThisBout(130) = xPos(allboutends(zzzz));
BoutInfThisBout(131) = yPos(allboutends(zzzz));
    
BoutInfThisBout(132) = NaN;

BoutInfThisBout(133) = realFishUniqueNumber;
    

BoutInfThisBout(134) = NaN;%boutCat

BoutInfThisBout(135:1:148) = NaN;%rotatedPositionAtSartOfBout


BoutInfThisBout(149) = 0;%social bout flag

BoutInfThisBout(150) = 0;%coreBout flag

BoutInfThisBout(151) = 0;%mistakesIn74KinSpace

BoutInfThisBout(152) = 0;%usedToMakeBehavioralSpace

BoutInfThisBout(153) = trueUniqueFishNumber;


%%
%%%%%%%%%%%%%%%%% make well letter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

BoutInfThisBout(154) = wellNumber;

%%
%%%%%%%%%%%%%%%%%% save fish idendity for ablations %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [fishIdentityNumber]  = fishIdentity_1(wellLetter);
 
BoutInfThisBout(155) = fishIdentityNumber;

%%
%%%%%%%%%%%%%%%%%%%%%%%% center of bout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutInfThisBout(EnumeratorBoutInf.distToClusterCenter) = nan;%distance to center bout

%%
%%%%%%%%%%%% eyeConvDiff par  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutInfThisBout(EnumeratorBoutInf.eyeConvDiff) = eyeConvDiffThisBout;
BoutInfThisBout(EnumeratorBoutInf.eyeStateCat) = nan;

%%
%%%%%%%%%%%%%%%%%%%%%% new bout cat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BoutInfThisBout(EnumeratorBoutInf.boutCat2) = nan;
BoutInfThisBout(EnumeratorBoutInf.distToClusterCenter2) = nan;





