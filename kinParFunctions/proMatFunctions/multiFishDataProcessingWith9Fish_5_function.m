        
function [allFishStructure,FileInfStructure] = multiFishDataProcessingWith9Fish_5_function(a,fishUniqueNumber,uniqueFileNumber,realFishUniqueNumber,trueUniqueFishNumber,dataSetName,protocolNumber,date,experimentNumber,fishAge,frameRate,strain,numbFishInFile,numbColumns,experimentRepeat)


        
        %%
        %%%%%%%%%%%%%%%%%Get parts that are the same for 7 fish tracking %%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %7 fish tracking 
        if numbFishInFile > 1 && numbFishInFile <= 7
        
            %check if it is tracking 16 segments    
            if 1 + numbFishInFile*37 + 8 == numbColumns;

               %get frame number
            frameNumber = a(:,1);

            %get end data
            endData = a(:,(numbFishInFile*37 + 2):end);

            end 
        
            %case where program is tracking 9 segments
            if 1 + numbFishInFile*23 + 8 == numbColumns;


            frameNumber = a(:,1);
            endData = a(:,(numbFishInFile*23 + 2):end);


            end 
        
       
   
        
        
        
        end
        
        %%
        %%%%%%%%%%%%%%%%%Get parts that are the same for 9 fish tracking %%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %9 fish tracking only has 8 segments
         if numbFishInFile >= 8
             
             
        %get frame number
        frameNumber = a(:,1);
        endData = a(:,(numbFishInFile*23 + 2):end);

             
         end
        
      
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%% multi fish loop %%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %pre-alocate structure
        s = struct('FishData',cell(1),'FishInf',cell(1));
        allFishStructure = repmat(s,1,numbFishInFile);

        
        %%
        %%%%%%%%%%%% update unique numbers unifish %%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        %update file number
        uniqueFileNumber = uniqueFileNumber + 1;
        
        if numbFishInFile == 1%uni fish

        %update
        fishUniqueNumber = fishUniqueNumber +1;
            
        if experimentRepeat == 0%only update realFishUniqueNumber when first fish file is on 
           
        realFishUniqueNumber = realFishUniqueNumber +1;
        
%        %test unique numbers
%         disp('update')
%         thisFileName
%         realFishUniqueNumber
%         fishUniqueNumber
%         uniqueFileNumber
%         pause


       end %only update realFishUniqueNumber when first fish file is on       
       end%uni fish        
        
        
        for r  = 1 : numbFishInFile %multi fish loop
          
            
        %%
        %%%%%%%%%%%% update unique numbers multifish %%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        if numbFishInFile > 1%uni fish 
            
        realFishUniqueNumber = realFishUniqueNumber +1;      
        fishUniqueNumber = fishUniqueNumber +1;    
        
%        %test unique numbers
%         disp('update')
%         thisFileName
%         realFishUniqueNumber
%         fishUniqueNumber
%         uniqueFileNumber
%         pause

            
        end
            

        %% 
        %%%%%%%%%%%%%%% update trueUniqueFishNumber %%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %rules: 
        %1) each multifish counts as same fish 
        %2) takes into acount split files: it only updated when experimentRepeat == 000
        
         if r == 1%dont count multifish as independent fish
             
         if experimentRepeat == 0
             
             trueUniqueFishNumber = trueUniqueFishNumber +1;
             
         end
             
         end
        
        
       
        
       
        
        %%
        %%%%%%%%%%%%%%%%%%%%% split multifish files 7 fish tracking %%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %7 fish tracker
        if numbFishInFile > 1  && numbFishInFile <= 7
            
            
            
            %check if it is tracking 16 segments    
            if 1 + numbFishInFile*37 + 8 == numbColumns;
                
            %determine start and end of columns
            indStartCol = 37*r + 1 - 36;
            indEndCol = 37*r + 1;

            aThisFish = [frameNumber a(:,indStartCol:indEndCol) endData];
        
            end
            
            %case where program is tracking 9 segments
            if 1 + numbFishInFile*23 + 8 == numbColumns;
                
            indStartCol = 23*r + 1 - 22;
            indEndCol = 23*r + 1;
            
            aThisFish = [frameNumber a(:,indStartCol:indEndCol) endData];
               
            end
            

        end   
   
        %%
        %%%%%%%%%%%%% split multifish files 9 fish tracking %%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if numbFishInFile >= 8
             
            
         indStartCol = 23*r + 1 - 22;
         indEndCol = 23*r + 1;
            
          aThisFish = [frameNumber a(:,indStartCol:indEndCol) endData];
             
             
        end
        
     
        
        %%
        %%%%%%%%%%%%%% case where there is only one fish %%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         if numbFishInFile == 1
            
           aThisFish = a; 
            
         end
        
       
        
        
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%Erase NaNs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %if program is not ended correctly a NaN formes in the last row of the data
        if isnan(aThisFish(end,end))
            
            aThisFish(end,:) = [];
            
            
        end
        
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%% detect data set %%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         pause
        [stim,lagNumber,tailAngles,tailValues,bodyAngles,xPos,yPos,blobVal,pixelSize,headToBladderLength,tailSegmentLength,distanceEyesToBlob,dataSetNumber,arenaX,arenaY,protocolNumb,leftEyeAngle,rightEyeAngle,numbFishInSquare,parameciaCounter,frameNumber2] = DataBaseDetector_23(aThisFish,dataSetName);

%         %test position of fish
%         figure
%         plot(xPos, yPos)
        
        %%
        %%%%%%%%%%%%%%%%% Claculate eye convergence %%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %correct
        if (length(rightEyeAngle)>1)
      
         rightEyeAngleMod = sgolayfilt(mod(rightEyeAngle,pi),2,21,[],1);
         leftEyeAngleMod = sgolayfilt(mod(leftEyeAngle,pi),2,21,[],1);
         
         %calculate eye conv and smooth a bit
%          eyeConvergence = conv(rightEyeAngleMod - leftEyeAngleMod,ones(10,1)/10,'same');
           eyeConvergence =rightEyeAngleMod - leftEyeAngleMod;
         %get rid of nans
         eyeConvergence(isnan(eyeConvergence))=nanmean(eyeConvergence);
        end
%         eyeConvergence =rightEyeAngleMod - leftEyeAngleMod;


% %test eye convergence
% figure
% plot(rightEyeAngleMod*360/pi)
% hold on
% plot(leftEyeAngleMod*360/pi, 'color','red')
% plot(eyeConvergence*360/pi, 'color','green')
%  plot(cumsum(fixedSegmentAngles')', 'color','k')
       
        %%
%         %%%%%%%%%%%%%%%%%%%%%%%Create data file name%%%%%%%%%%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %data will be saved by fish
%         %name of file is of the following form:
%         %Stim_DatasetName_protocolNumb_date_FishAge_FrameRate_PixelSize_fishStrain_numbColumns_fileNumbAfterColision_numbOfFishInFile_fishNumberInFile_uniqueFileNumber_fishUniqueNumber
%         
% %         fileName = strcat('proData_', char(dataSetName),'_', num2str(protocolNumb),'_',num2str(date),'_',num2str(fishAge),'_',num2str(frameRate),'_',num2str(pixelSize),'_',strain,'_',num2str(numbColumns),'_',num2str(fileNumbAfterColision),'_',num2str(numbFishInFile),'_',num2str(r),'_',num2str(uniqueFileNumber),'_',num2str(fishUniqueNumber));
%         fileName = strcat('proData_',splitStr1(1),'_',splitStr1(2),'_',splitStr1(3),'_',splitStr1(4),'_',splitStr1(5),'_',splitStr1(6),'_',splitStr1(7),'_',splitStr1(8),'_',splitStr1(9),'_',splitStr1(10),'_',splitStr1(11));
%       
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%detect high lag%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %for multi fish the lag is the same so only do this for the 1st fish
      
        if r == 1
         
            indLag = find(lagNumber > 190);
            
            %make vector that lables frames that may be conpromised
            lagVector = lagNumber*0;
            lagVector(indLag) = 1;
            
%             %test lab
%             plot(lagVector)
            
        end
        
        
        %%
        %%%%%%%%%%%%%%%%%%%%%%% stim detection %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %for multi fish the stim is the same so only do this for the 1st fish

        %it assumed that the end of a stim is the start of another and does
        %not need any -1 to work
       
        if r == 1
            
        %find start and end of stim - Mike's way        
        indStimStartAll = [1 ;find(diff(stim))+1];
        indStimEndAll = [find(diff(stim)); length(stim)];


        %test start and end of stim blocks
        stimStartAll = stim.*0;
        stimStartAll(indStimStartAll) = 1;

        stimEndAll=stim.*0;
        stimEndAll(indStimEndAll) = 1;

        %make array with stim number
      
        
        stimNumbers = stim(indStimStartAll + 1);

      
%         %figure
%         hold off
%         plot(stim)
%         hold on
%         plot(stimStartAll,'o','color','green','LineWidth',4)
%         plot(stimEndAll,'o','color','red','LineWidth',4)
%         plot(stim, '.')
%         pause(0.1)
            
            
        end
        
        %%
        %%%%%%%%%%%%%%%%%% collisions detection %%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   if r == 1
            
%         [indNoCollisionStartAll,indNoCollisionEndAll,indFishInSquareStartAll,indFishInSquareEndAll] = CollisionDetector(a,numbFishInSquare);
       [indNoCollisionStartAll,indNoCollisionEndAll,indFishInSquareStartAll,indFishInSquareEndAll,noCollision,fishInSquare] = CollisionDetector_2(aThisFish,numbFishInSquare);
       
   %1 fish case          
   if numbFishInFile == 1      
       
   collisionflag=logical(zeros(size(a,1),1));
   
   end
   
   %7 fish case    
   if (numbFishInFile>1 && numbFishInFile <=7)
       
   if 1 + numbFishInFile*37 + 8 == numbColumns;    
       
       collisionflag=logical(zeros(size(a,1),numbFishInFile));

       for fish=1:numbFishInFile

       startx=a(:,4+(fish-1)*37);
       starty=a(:,5+(fish-1)*37);
       startth=a(:,22+(fish-1)*37);
       for fish2=1:numbFishInFile

       if (fish2~=fish)

       nextx=a(:,4+(fish2-1)*37);
       nexty=a(:,5+(fish2-1)*37);
       dx=nextx-startx;
       dy=nexty-starty;
       [theta,rho]=cart2pol(dx,dy);
       theta=theta-startth;
       [dx dy]=pol2cart(theta,rho);
       collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish)=1;
       collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish2)=1;

       end
       end

       end
   end
    
   if 1 + numbFishInFile*23 + 8 == numbColumns;
        collisionflag=logical(zeros(size(a,1),numbFishInFile));

       for fish=1:numbFishInFile

       startx=a(:,4+(fish-1)*23);
       starty=a(:,5+(fish-1)*23);
       startth=a(:,15 + (fish-1)*23);
       for fish2=1:numbFishInFile

       if (fish2~=fish)

       nextx=a(:,4+(fish2-1)*23);
       nexty=a(:,5+(fish2-1)*23);
       dx=nextx-startx;
       dy=nexty-starty;
       [theta,rho]=cart2pol(dx,dy);
       theta=theta-startth;%think it is wrong...
       [dx dy]=pol2cart(theta,rho);
       collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish)=1;
       collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish2)=1;

       end
       end

       end
       
   end
   
               
   end
   
   
   %9 fish tracker case
   if numbFishInFile >= 8
       
       collisionflag=logical(zeros(size(a,1),numbFishInFile));

       for fish=1:numbFishInFile

       startx=a(:,4+(fish-1)*23);
       starty=a(:,5+(fish-1)*23);
       startth=a(:,15 + (fish-1)*23);
       for fish2=1:numbFishInFile

       if (fish2~=fish)

       nextx=a(:,4+(fish2-1)*23);
       nexty=a(:,5+(fish2-1)*23);
       dx=nextx-startx;
       dy=nexty-starty;
       [theta,rho]=cart2pol(dx,dy);
       theta=theta-startth;
       [dx dy]=pol2cart(theta,rho);
       collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish)=1;
       collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish2)=1;

       end
       end

       end

               
   end
   
   
   
   
   
   
   
   
   if isnan(a(end,end))
    collisionflag(end,:) = [];
   end
        
        
   end
        
        
        
        
        %%
        %%%%%%%%%%%%%%%%%%Calculate real body angle of fish%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
         [realBodyAngles,bodyAnglesVelocity] = FishAngleCalculatorFast(bodyAngles);%result comes in rads
         errorRealBodyAngles=realBodyAngles-sgolayfilt(realBodyAngles,2,13,[],1);
         realBodyAngles=sgolayfilt(realBodyAngles,2,13,[],1);
        
         
%         %test real body angles
%         subplot(1,2,1)
%         plot(bodyAngles)
%        
%         
%         subplot(1,2,2)
%         plot(realBodyAngles, '.')



        %%
        %%%%%%%%%%%  fix problem of not traking 16 segments %%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if size(tailAngles,2) < 16
            
            extraTailValArray = zeros(size(tailAngles,1),16 - size(tailAngles,2));
            extraTailAngleArray  = zeros(size(tailValues,1),16 - size(tailValues,2));
            
            extraTailAngleArray(:,:) = -100;
            extraTailValArray(:,:) =  nanmean(tailValues(:,end));%fills missing segment with value oa average of last segment - it should be an impossible segment like the 9th - not completelly sure this will work always...
            tailValues = [tailValues,extraTailValArray];
            tailAngles = [tailAngles,extraTailAngleArray];
        end

        %%
        %%%%%%%%%%%%%%%Find number of segments of tail%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %uses NumberTailSegmentsDetector_3 - this fixes problem with multitraking
       
        makePlot = 0;
        [indLastTailSegment,~, ~] = NumberTailSegmentsDetector_5(tailValues, tailAngles,makePlot);
       
%         pause
%         
        
        %%
        %%%%%%%%%%%%%fix multitraking problem%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if indLastTailSegment > 10
            
            chosenSegmentValues = tailValues(:,1:10);
            chosenTailAngles = tailAngles(:,1:10);
            indLastTailSegment = 10;
        else
            
            chosenSegmentValues = tailValues(:,1:10);
            chosenTailAngles = tailAngles(:,1:10);
%             indLastTailSegment = 10;
            
        end
        
        %%
        %%%%%%%%%%%%%%%%%%%%%fix tail tracking errors%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %FixTailTrackingGaps_2 function replaces the -100 numbers and fixes
        %tail traking gaps of less or equal to 2 frames. It makes two
        %arrays:
        %1) errorListAllMitakes - -1 in all gaps
        %2) errorListNotFixedMistakes - -1 in gaps that were not fixed
        
        [fixedSegmentAngles,errorListAllMitakes,errorListNotFixedMistakes] = FixTailTrackingGaps_3(chosenTailAngles);
        [fixedSegmentAngles, errorListObends,totalNumberFrames] = FixObendGaps_2(fixedSegmentAngles,chosenSegmentValues);
%         totalNumberFrames 
        
        smoothdata=sgolayfilt(fixedSegmentAngles,2,5,[],1);
        residuals=abs(cumsum(smoothdata')'-cumsum(fixedSegmentAngles')');
%         plot(cumsum(fixedSegmentAngles')','b')
        fixedSegmentAngles=smoothdata;
%         hold on
%         plot(cumsum(fixedSegmentAngles')','g')
%         plot(residuals(:,7)*10,'r.')
%         pause

         %%
%         %%%%%%%%%%%%%%%%%%%%%fix tail tracking errors%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         % errorlist:
%         % 0 no error
%         % 1 fixed tail error
%         % 2 unfixed tail error
%         pause
%         [fixedSegmentAngles, errorList, numbFixedFrames,numbeUnfixedFrames,totalNumberFrames] = FixTailTrackingGaps(chosenTailAngles);
%         
% %          errorList = [errorList 0];
% 
% 
% %         %test tailtraking error
% %         plot(cumsum(fixedSegmentAngles')', 'color','k')
% %         hold on
% %         plot(gapsArray(:,3), 'color','r')
% %         pause
%%
%%%%%%%%%%%%%%%%%%%%%% test eye convergence parameter %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure
% plot(rightEyeAngleMod*360/pi)
% hold on
% plot(leftEyeAngleMod*360/pi, 'color','red')
% plot(eyeConvergence*360/pi, 'color','green')
%  plot((cumsum(fixedSegmentAngles')')*100, 'color','k')
%        

        %%
        %%%%%%%%%%%%%%%%%calculate length of fish%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
        %total length of fish in mm
        totalFishLength = distanceEyesToBlob./1000 + (pixelSize./1000)*headToBladderLength + (pixelSize./1000).*indLastTailSegment.*tailSegmentLength;%in mm
        
        %head body length
        bodyLength = distanceEyesToBlob./1000 + (pixelSize./1000).*headToBladderLength;
        
        %tail length
        tailLength = (pixelSize./1000).*indLastTailSegment.*tailSegmentLength;
        
        %corrected tail length - make sure that tail starts in all cases
        %1.0486mm from mid eye point. This is the value of the data set
        %with highest body length
        normalizedTailLength = (pixelSize./1000).*indLastTailSegment.*tailSegmentLength - (1.0486 - (distanceEyesToBlob./1000 + (pixelSize./1000).*headToBladderLength));
        
        %this is the length where interpolation starts so that tail starts
        %always in the same part of fish
        tailStartCorrection = 1.0486 - bodyLength;%in mm
      
        %number of segments
        numbSegments = indLastTailSegment;
        
       
      
        
        
        %%
        %%%%%%%%%%%%%%%%%%%interpolate tail data%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        interpolationModel = '*spline';% *spline is much faster
        
         tailLengthToInterpolate = 3.1;%length o tail that data should be interpolated in mm - it is the longest tail in data sets
         
         %case fish is bigger than previously seen
         if tailLength > tailLengthToInterpolate 
             
            disp(' biggest fish')
            tailLength
            
         end
    
        %%
         %%%%%%%%%%%%% calcualte real x of this fish %%%%%%%%%%%%%%%%%%%%%%
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %not implemented for old speed rig
        if isnan(blobVal)%prey capture rig


        firstSegmentLength = 300;

        xPerc = zeros(1,numbSegments)+300;
        xPerc(1) = firstSegmentLength;
        xPerc = cumsum(xPerc);
         

        else%normal rig
    
        firstSegmentLength = 310;

        xPerc = zeros(1,numbSegments)+310;
        xPerc(1) = firstSegmentLength;
        xPerc = cumsum(xPerc);

        end
        
        
        %%
        %%%%%%%%%%%%%%%%%%%%%% tail interpolation for diff data sets %%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
%          pause
%         [cumsumInterpFixedSegmentAngles, xPerc, tailMM,intPoints] = TailInterpolatorMM_5(fixedSegmentAngles, pixelSize, tailLength, tailLengthToInterpolate, interpolationModel,tailStartCorrection);
%     size(fixedSegmentAngles)
        [cumsumInterpFixedSegmentAngles, xPerc, tailMM,intPoints] = TailInterpolatorMM_5(fixedSegmentAngles(:,1:numbSegments), interpolationModel,xPerc);
        
        
        
        %calcualte lastMeasuredSegment of this fish
        lastMeasuredSegment = find(intPoints == 1,1, 'last');

        %calculate the distance of each segment after interpolated
        tailSegmentDistance = diff(tailMM(1:2));
        
%          %test interpolation - goes through every frame and plots tail
%          for ii = 1:10: size(cumsumInterpFixedSegmentAngles,1)
%             
%          hold off
%          plot(xPerc,cumsum(fixedSegmentAngles(ii,:)), 'o')
%          hold on
%          plot(tailMM,cumsumInterpFixedSegmentAngles(ii,:), 'color', 'green')
%          
%          axis([0 3.5 -2 2])
%          pause
%          
%          end

%%
%%%%%%%%%%%create smooth tail data for detector%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%uses tailSmoother to smooth all tail data and prepare it for bout
%detector
tailSmootherMakePlot =0;
[smootherTailCurveMeasure] = TailSmoother_6(cumsumInterpFixedSegmentAngles,intPoints,tailSmootherMakePlot);

% %test smootherTailCurvature
% hold on
% plot(cumsumInterpFixedSegmentAngles(:,2:8))
% plot(smootherTailCurveMeasure, 'color', 'k', 'linewidth',2)

%%
    %%%%%%%%%%%%%%calculate filteredDistance%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %we need to calculate the distance do that we can determine bout end by
    %distance and not tail
    %uses calculate distance function
    
    [distanceNoFilter] = calculateDistance(xPos,yPos);
    
    %filter distance
    
    dfilt=10;
    filteredDistance = conv(distanceNoFilter,ones(dfilt,1)/dfilt,'same');
    
%     %test distance
%     hold off
%     plot(distanceNoFilter)
%     hold on
%     plot(filteredDistance,'color','red')
%     pause

%%
%%%%%%%%%%%%% smooth data of normal rig %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%have to add new dat


%do this only to normal rig data
if isnan(blobVal)

realBodyAnglesSmooth = realBodyAngles;
cumsumInterpFixedSegmentAnglesSmooth = cumsumInterpFixedSegmentAngles;
smootherTailCurveMeasureSmooth = smootherTailCurveMeasure';

else
    
realBodyAnglesSmooth = realBodyAngles;
cumsumInterpFixedSegmentAnglesSmooth = cumsumInterpFixedSegmentAngles;
smootherTailCurveMeasureSmooth = smootherTailCurveMeasure';    
    
    
% realBodyAnglesSmooth = mikesmooth(realBodyAngles,5);
% cumsumInterpFixedSegmentAnglesSmooth = mikesmooth(cumsumInterpFixedSegmentAngles,5);   
% smootherTailCurveMeasureSmooth = mikesmooth(smootherTailCurveMeasure',5);   

end

%%
%%%%%%%%%%%%%%%%%%%%%%%%% Make fish Inf structure %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this structutre saves information about the fish that is a string or more than one number 
if r == 1

FileInfStructure.fileName = nan;
FileInfStructure.strain = strain;
FileInfStructure.stimOrder = stimNumbers;
FileInfStructure.indStimStartAll = indStimStartAll;
FileInfStructure.indStimEndAll = indStimEndAll;
FileInfStructure.tailMM = tailMM;
FileInfStructure.indNoCollisionStartAll = indNoCollisionStartAll;
FileInfStructure.indNoCollisionEndAll = indNoCollisionEndAll;
FileInfStructure.indFishInSquareStartAll = indFishInSquareStartAll;
FileInfStructure.indFishInSquareEndAll = indFishInSquareEndAll;
FileInfStructure.percEyeConvBouts = NaN;

end
%%
%%%%%%%%%%%%%%%%%%%%%%%%% Make fish Inf array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this array saves one number information
% FishInf(1) = arenaX;
% FishInf(2) = arenaY; 
% FishInf(3) = dataSetNumber;
% FishInf(4) = protocolNumb;
% FishInf(5) = fishUniqueNumber;
% FishInf(6) = pixelSize./1000;%in mm 
% FishInf(7) = headToBladderLength;%in pixel
% FishInf(8)  = tailSegmentLength;%in pixel
% FishInf(9) = distanceEyesToBlob./1000;%in mm
% FishInf(10) = lastMeasuredSegment;
% FishInf(11) = fishAge;
% FishInf(12) = uniqueFileNumber;
% 
% if isnan(leftEyeAngle) 
%     
%     FishInf(13) = 0;
%     
% else
%     
%     FishInf(13) = 1;
%     
% end
% 
% FishInf(14) = r;%fish number in file

allFishStructure(r).FishInf(1) = arenaX;
allFishStructure(r).FishInf(2) = arenaY; 
allFishStructure(r).FishInf(3) = dataSetNumber;
allFishStructure(r).FishInf(4) = protocolNumb;
allFishStructure(r).FishInf(5) = fishUniqueNumber;
allFishStructure(r).FishInf(6) = pixelSize./1000;%in mm 
allFishStructure(r).FishInf(7) = headToBladderLength;%in pixel
allFishStructure(r).FishInf(8)  = tailSegmentLength;%in pixel
allFishStructure(r).FishInf(9) = distanceEyesToBlob./1000;%in mm
allFishStructure(r).FishInf(10) = lastMeasuredSegment;
allFishStructure(r).FishInf(11) = fishAge;
allFishStructure(r).FishInf(12) = uniqueFileNumber;

if isnan(leftEyeAngle) 
    
    allFishStructure(r).FishInf(13) = 0;
    
else
    
    allFishStructure(r).FishInf(13) = 1;
    
end

allFishStructure(r).FishInf(14) = r;%fish number in file
allFishStructure(r).FishInf(15) = realFishUniqueNumber;
allFishStructure(r).FishInf(16) = trueUniqueFishNumber;

%save average pos of fish in arena to identify fish in multiple well arenas
allFishStructure(r).FishInf(17) = nanmean(xPos);
allFishStructure(r).FishInf(18) = nanmean(yPos);

%%
%%%%%%%%%%%%%%%%%%% make array with fish processed information%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%open variable
allFishStructure(r).FishData = zeros(length(bodyAngles),67);
allFishStructure(r).FishData(:,1) = bodyAngles;
allFishStructure(r).FishData(:,2) = realBodyAnglesSmooth;
allFishStructure(r).FishData(:,3:12) = cumsumInterpFixedSegmentAnglesSmooth;
allFishStructure(r).FishData(:,13) = smootherTailCurveMeasureSmooth;
allFishStructure(r).FishData(:,14) = filteredDistance;
% allFishStructure(r).FishData(:,15) = lagVector;
allFishStructure(r).FishData(:,15) = lagNumber;

if isnan(leftEyeAngle) 
    
    %make nan vector to fill array on eye data
    nanVector = zeros(length(bodyAngles),1);
    nanVector(:,:) = NaN;
    
    nanVector2 = zeros(length(bodyAngles),31);
    nanVector2(:,:) = NaN;
    
allFishStructure(r).FishData(:,16) = nanVector;
allFishStructure(r).FishData(:,17) = nanVector;
allFishStructure(r).FishData(:,18) = nanVector;
allFishStructure(r).FishData(:,19:49) = nanVector2;

    
else
    
allFishStructure(r).FishData(:,16) = leftEyeAngle;
allFishStructure(r).FishData(:,17) = rightEyeAngle;
allFishStructure(r).FishData(:,18) = eyeConvergence;
allFishStructure(r).FishData(:,19:49) = parameciaCounter;

end

allFishStructure(r).FishData(:,50) = xPos;
allFishStructure(r).FishData(:,51) = yPos;
allFishStructure(r).FishData(:,52) = stim;

allFishStructure(r).FishData(:,53) = noCollision';
allFishStructure(r).FishData(:,54) = fishInSquare';
allFishStructure(r).FishData(:,55) = (frameNumber2')/700;


allFishStructure(r).FishData(:,56:65) = errorListAllMitakes;
allFishStructure(r).FishData(:,66:75) = errorListNotFixedMistakes;

allFishStructure(r).FishData(:,76:85) = chosenSegmentValues;
allFishStructure(r).FishData(:,86) =  collisionflag(:,r);
allFishStructure(r).FishData(:,87) =  errorListObends;

if isnan(leftEyeAngle) 
    
  allFishStructure(r).FishData(:,88) =  NaN;
  allFishStructure(r).FishData(:,89) = NaN;
else 
  allFishStructure(r).FishData(:,88) =  leftEyeAngleMod;
  allFishStructure(r).FishData(:,89) = rightEyeAngleMod;
end
  allFishStructure(r).FishData(:,90) = residuals(:,7);
  allFishStructure(r).FishData(:,91) = errorRealBodyAngles;
  

%%
%%%%%%%%%%%%% put multi fish in structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% allFishStructure = [allFishStructure FishStructure];
% thisFileName
% realFishUniqueNumber
% fishUniqueNumber
% uniqueFileNumber
% pause

        
        
        
        end %multi fish file loop

         
   
% toc





%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% Save fish data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%         
% pathfileName = strcat(dataPathSubfolder, '\', fileName);
% 
% save(char(pathfileName), 'allFishStructure','FileInfStructure','-v7.3')  
% 
%         
% % uniqueFileNumber = uniqueFileNumber + 1;


%        toc 
%        end%loop through each file
%     pause
%   end%loop through each dataset

%%
% %%%%%%%%%%%%%%%%%% make unique number tracker %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% dataSetNumberAll = dataSetNumber; 
% fishUniqueNumberAll = max(fishUniqueNumber);
% uniqueFileNumberAll = max(uniqueFileNumber);
% realFishUniqueNumberAll = max(fishUniqueNumber);
% trueUniqueFishNumberAll = max(trueUniqueFishNumber);
% 
% 
%  %%
%  %%%%%%%%%%%%%% save uniqueNumberCounterProMat %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  pathfileName = strcat(dataPath2, '\', 'uniqueNumberCounterProMat.mat');
% 
%  save(char(pathfileName), 'dataSetNumberAll', 'fishUniqueNumberAll','uniqueFileNumberAll','realFishUniqueNumberAll','trueUniqueFishNumberAll') 

       