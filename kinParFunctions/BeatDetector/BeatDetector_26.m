%this function detects beats and tis max and min from tail data





function [cumsum2DInterpolatedAngles,cumsumInterpolatedAnglesGray,indRealBoutStart,indRealBoutEnd,halfBeatStructure,numbBeats,halfBeatPosInt,halfBeatMag] = BeatDetector_26(cumsumInterpolatedAngles,lastMeasuredSegment,makeplot,fps)

if makeplot == 1
%     clf
    
end
%% test function
%  makeplot = 1;
%        cumsumInterpolatedAngles = cumsumInterpolatedAngleByBout;

%% % %%%%%%%%%%%%%%%Interpolate data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %interpolate data in time domain
%
% %create x - frames in real data
% x = 1:1:length(cumsumInterpolatedAngles);
%
% %create xi - parts of frames to interpolate
% xi=1:0.1:length(cumsumInterpolatedAngles);
%
% %interpolate
% cumsum2DInterpolatedAngles = zeros(length(xi), size(cumsumInterpolatedAngles,2));
%
% for f = 1:size(cumsumInterpolatedAngles,2)
%
%
% cumsum2DInterpolatedAngles(:,f) = interp1(x,cumsumInterpolatedAngles(:,f),xi, '*spline')';
%
%
% end

cumsum2DInterpolatedAngles = cumsumInterpolatedAngles;
% % %test interpolation
% subplot(1,2,1)
% imagesc(cumsumInterpolatedAngles)
% colormap gray
%
% subplot(1,2,2)
% imagesc(cumsum2DInterpolatedAngles)
% colormap gray
%
% hold off
% plot(xi, interpOneSegmentAngle, 'r.')
% hold on
% plot(x,oneSegmentAngle, 'bo')
% plot(oneSegmentAngle, 'color','cyan')
% pause



%% transform data into gray scale image%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this normalizes all bouts to be between 0 and 1
cumsumInterpolatedAnglesGray = mat2gray(cumsum2DInterpolatedAngles);

% %test gray scale image
% subplot(1,2,1)
% imagesc(cumsum2DInterpolatedAngles)
% colormap gray
% 
% subplot(1,2,2)
% imagesc(cumsumInterpolatedAnglesGray)
% colormap gray


%% make dynamic threshold%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

binaryImageUpThres = cumsumInterpolatedAnglesGray.*0;
binaryImageDownThres = cumsumInterpolatedAnglesGray.*0;

smoothingThres = fps*42;
stdThres = 15;
%case that rolling average is bigger than bout length exclude bout - its too small to be bout anyway
if size(cumsumInterpolatedAnglesGray,1) > smoothingThres%exclude very small bouts
    
    for z = 1 : size(cumsumInterpolatedAnglesGray,2)
        
        cumsumInterpolatedAnglesGraySmooth = mikesmooth(cumsumInterpolatedAnglesGray(:,z),smoothingThres);
        
%         cumsumInterpolatedAnglesGraySmoothStd = std(cumsumInterpolatedAnglesGray(:,z));
%         cumsumInterpolatedAnglesGraySmoothStd = std(cumsumInterpolatedAnglesGray(:,z))*abs(cumsumInterpolatedAnglesGray(:,z));
        cumsumInterpolatedAnglesGraySmoothStd = std(cumsumInterpolatedAnglesGray(:,z)) + std(cumsumInterpolatedAnglesGray(:,z))*abs(cumsumInterpolatedAnglesGraySmooth);

        binaryImageUpThres(:,z) = cumsumInterpolatedAnglesGraySmooth + cumsumInterpolatedAnglesGraySmoothStd./stdThres;
        
        
        
        binaryImageDownThres(:,z) = cumsumInterpolatedAnglesGraySmooth - cumsumInterpolatedAnglesGraySmoothStd./stdThres;
        
        
        % %look at thresholds
        if makeplot
        figure
        plot(cumsumInterpolatedAnglesGray(:,z))
        hold on
        plot(cumsumInterpolatedAnglesGraySmooth, 'r')
        plot(binaryImageUpThres(:,z), 'k')
        plot(binaryImageDownThres(:,z), 'k')
        box off
        end
%         
%         
%         
%         mean(cumsumInterpolatedAnglesGray(:,z))
%         std(cumsumInterpolatedAnglesGray(:,z))
        
    end
    
    %% make binary images%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    binaryBoutPos = cumsumInterpolatedAnglesGray.*0;
    binaryBoutNeg = cumsumInterpolatedAnglesGray.*0;
    binaryImage = cumsumInterpolatedAnglesGray.*0;
    
    for i = 1:size(cumsumInterpolatedAnglesGray,2)%loop through each segment
        %  i=8
        %apply threshold
        indBinaryPos = find(cumsumInterpolatedAnglesGray(:,i) > binaryImageUpThres(:,i));
        indBinaryNeg = find(cumsumInterpolatedAnglesGray(:,i) < binaryImageDownThres(:,i));
        
        %case where it does nor detect anything
        if isempty(indBinaryPos) || isempty(indBinaryNeg)%threshold detects nothing
            
            %!!! don't know what ot put here; maybe nothing?
            disp('threshold detects nothing');
            
        else%threshold detects something
            
            %% erase signals that are super short%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %make array of 0 and 1
            binaryPos = cumsumInterpolatedAnglesGray(:,i).*0;
            binaryNeg = cumsumInterpolatedAnglesGray(:,i).*0;
            
            binaryPos(indBinaryPos) = 1;
            binaryNeg(indBinaryNeg) = 1;
            
            %find ind of events
            indStartPos = find([0 diff(binaryPos)']' == 1);
            indStartNeg = find([0 diff(binaryNeg)']' == 1);
            indEndPos = find([0 diff(binaryPos)']' == -1);
            indEndNeg = find([0 diff(binaryNeg)']' == -1);
            
            %find lengths events
            lengthPos = indEndPos - indStartPos;
            lengthNeg = indEndNeg - indStartNeg;
            
            %find events that are smaller than 20 frames - becuse data is interpolated 10 times it corresponds to beats of 2.8ms - way to short
            indindFakeBeatPos =  find(lengthPos < 2*3*fps);
            indindFakeBeatNeg = find(lengthNeg < 2*3*fps);
            
            
            %erase events that are smaller than 20 frames
            fakeIndsPos = indStartPos(indindFakeBeatPos):indEndPos(indindFakeBeatPos);
            indStartPos(indindFakeBeatPos) = [];
            indEndPos(indindFakeBeatPos) = [];
            
            fakeIndsNeg = indStartNeg(indindFakeBeatNeg):indEndNeg(indindFakeBeatNeg);
            indStartNeg(indindFakeBeatNeg) = [];
            indEndNeg(indindFakeBeatNeg) = [];
            
            %remake ind binary array
            indBinaryPos2 = cumsumInterpolatedAnglesGray.*0;
            indBinaryNeg2 = cumsumInterpolatedAnglesGray.*0;
            
            for ii = 1:length(indStartPos)
                
                indBinaryPos2(indStartPos(ii) : indEndPos(ii)-1) = 1;%don't know why -1 in ends...
                
            end
            
            for iii = 1:length(indStartNeg)
                
                indBinaryNeg2(indStartNeg(iii) : indEndNeg(iii)-1) = 1;%don't know why -1 in ends...
                
            end
            
            indBinaryPos2 = find(indBinaryPos2);
            indBinaryNeg2 = find(indBinaryNeg2);
            
            %test erase signals that are super short
            startPos = cumsumInterpolatedAnglesGray*0;
            startNeg = cumsumInterpolatedAnglesGray*0;
            endPos = cumsumInterpolatedAnglesGray*0;
            endNeg = cumsumInterpolatedAnglesGray*0;
            
            binaryPos2 = cumsumInterpolatedAnglesGray(:,i)*0;
            binaryNeg2 = cumsumInterpolatedAnglesGray(:,i)*0;
            
            binaryPos2(indBinaryPos2) = 1;
            binaryNeg2(indBinaryNeg2) = 1;
            
            
            startPos(indStartPos) = 1;
            startNeg(indStartNeg) = 1;
            
            endPos(indEndPos) = 1;
            endNeg(indEndNeg) = 1;
            
            
%             figure
%             hold off
%             plot(cumsumInterpolatedAnglesGray(:,i), 'k.')
%             hold on
%             
%              plot(binaryPos, 'color','b', 'linewidth', 4)
%             % % plot(binaryPos2, 'color','c', 'linewidth', 4)
%             plot(startPos, 'go','linewidth', 4)
%             plot(endPos, 'ro','linewidth', 4)
            %
            % % plot(binaryNeg, 'color','b','linewidth', 4)
            % % % % plot(binaryNeg2, 'color','c', 'linewidth', 4)
            % % plot(startNeg, 'go','linewidth', 4)
            % % plot(endNeg, 'ro','linewidth', 4)
            
            %% first and last beat must have a certain amplitude%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %find start and end values
            startAmp = median(cumsumInterpolatedAnglesGray(1:10,i));
            endAmp = cumsumInterpolatedAnglesGray(end,i);
            
            %case where it does not detect neg or pos beats
            if isempty(indStartPos) || isempty(indStartNeg)%case where it does not detect neg or pos beats
                
                %!!! don't know what ot put here; maybe nothing?
                
            else%case where it does not detect neg or pos beats
                
                %erase first beat if amp is small
                if indStartPos(1) < indStartNeg(1)
                    
%                     [firstBeatAmp,I_1stBeatAmp] = max(abs(cumsumInterpolatedAnglesGray(indStartPos(1):indEndPos(1),i)));
                    x_tmp = (cumsumInterpolatedAnglesGray(indStartPos(1):indEndPos(1),i));
                    [~,I_tmp] = min(abs(diff(row2col(x_tmp,1),1,1)));
                    firstBeatAmp = x_tmp(I_tmp);
                    if firstBeatAmp < startAmp*1.2 || abs(x_tmp(end)-x_tmp(I_tmp))>10*abs(x_tmp(I_tmp)-x_tmp(1))%(firstBeatAmp - abs(startAmp)) < (firstBeatAmp*0.1)
                        
                        indStartPos(1) = [];
                        indEndPos(1) = [];
                        
                        %remake ind binary array
                        indBinaryPos2 = cumsumInterpolatedAnglesGray.*0;
                        
                        for ii = 1:length(indStartPos)
                            
                            indBinaryPos2(indStartPos(ii) : indEndPos(ii)-1) = 1;%don't know why -1 in ends...
                            
                        end
                        
                        
                        indBinaryPos2 = find(indBinaryPos2);
                        
                        
                        
                        
                    end
                    
                else
                    
%                     firstBeatAmp = min(abs(cumsumInterpolatedAnglesGray(indStartNeg(1):indEndNeg(1),i)));
                    x_tmp = (cumsumInterpolatedAnglesGray(indStartNeg(1):indEndNeg(1),i));
                    [~,I_tmp] = min(abs(diff(row2col(x_tmp,1),1,1)));
                    firstBeatAmp = x_tmp(I_tmp);
                    if firstBeatAmp > startAmp*0.8 || abs(x_tmp(end)-x_tmp(I_tmp))>10*abs(x_tmp(I_tmp)-x_tmp(1))%(firstBeatAmp - abs(startAmp)) < (firstBeatAmp*0.1)
                        
                        indStartNeg(1) = [];
                        indEndNeg(1) = [];
                        
                        %remake ind binary array
                        indBinaryNeg2 = cumsumInterpolatedAnglesGray.*0;
                        
                        for ii = 1:length(indStartNeg)
                            
                            indBinaryNeg2(indStartNeg(ii) : indEndNeg(ii)-1) = 1;%don't know why -1 in ends...
                            
                        end
                        
                        
                        indBinaryNeg2 = find(indBinaryNeg2);
                        
                    end
                    
                end
                
                %make binary image
                binaryBoutPos(indBinaryPos2,i) = 1;
                binaryBoutNeg(indBinaryNeg2,i) = 1;
                
                binaryImage(indBinaryPos2,i) = 1;
                binaryImage(indBinaryNeg2,i) = -1;
                
                
                
                %test erase 1st and last beat if they've small amplitude
                startPos = cumsumInterpolatedAnglesGray*0;
                startNeg = cumsumInterpolatedAnglesGray*0;
                endPos = cumsumInterpolatedAnglesGray*0;
                endNeg = cumsumInterpolatedAnglesGray*0;
                
                binaryPos2 = cumsumInterpolatedAnglesGray(:,i)*0;
                binaryNeg2 = cumsumInterpolatedAnglesGray(:,i)*0;
                
                binaryPos2(indBinaryPos2) = 1;
                binaryNeg2(indBinaryNeg2) = 1;
                
                
                startPos(indStartPos) = 1;
                startNeg(indStartNeg) = 1;
                
                endPos(indEndPos) = 1;
                endNeg(indEndNeg) = 1;
                
%                 figure
%                 hold off
%                 plot(cumsumInterpolatedAnglesGray(:,i), 'k.')
%                 hold on
%                 
%                 % plot(binaryPos, 'color','b', 'linewidth', 4)
%                 % plot(binaryPos2, 'color','c', 'linewidth', 4)
%                 % plot(startPos, 'go','linewidth', 4)
%                 % plot(endPos, 'ro','linewidth', 4)
%                 
%                 plot(binaryNeg, 'color','b','linewidth', 4)
%                 plot(binaryNeg2, 'color','c', 'linewidth', 4)
%                 plot(startNeg, 'go','linewidth', 4)
%                 plot(endNeg, 'ro','linewidth', 4)
                
                
                
                
            end%case where it does not detect neg or pos beats
            
            
        end%threshold detects nothing
        
        
    end%loop through each segment
    
    %% fill binary images%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %probably not necessary
    % filledBinaryBoutPos = imfill(binaryBoutPos);
    % filledBinaryBoutNeg = imfill(binaryBoutNeg);
    
    %no need to fill binary image
    filledBinaryBoutPos = binaryBoutPos;
    filledBinaryBoutNeg = binaryBoutNeg;
    
    
    %% detect shapes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    statsPos = bwconncomp(filledBinaryBoutPos,4);
    statsNeg = bwconncomp(filledBinaryBoutNeg,4);
    
    
    
    %%  Calculate peaks of beats%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [objPixelRealPos] = ObjDetector_2(statsPos,cumsumInterpolatedAnglesGray);
    
    
    [objPixelRealNeg] = ObjDetector_2(statsNeg,cumsumInterpolatedAnglesGray);
    
    
    %% Calculate number of half beats%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %objPixelRealPos and objPixelRealNeg may have empty entries - erase them
    
    if isempty(objPixelRealPos)%case that objPixelRealPos cames back as NaN because no obj where detected by ObjDetector_2
        
        objPixelRealPos2 = [];
        
        numbPos = 0;
    else
        
        numbPos = 0;
        objPixelRealPos2 = [];
        
        for i = 1 : length(objPixelRealPos)
            
            if ~isempty(objPixelRealPos(i).PixelList)
                
                numbPos = numbPos + 1;
                
                objPixelRealPos2(numbPos).PixelList = objPixelRealPos(i).PixelList;
                
            end
        end
    end
    
    
    if isempty(objPixelRealNeg)%case that objPixelRealNeg cames back as NaN because no obj where detected by ObjDetector_2
        
        objPixelRealNeg2 = [];
        
        numbNeg = 0;
        
    else
        
        
        numbNeg = 0;
        objPixelRealNeg2 = [];
        
        for i = 1 : length(objPixelRealNeg)
            
            if ~isempty(objPixelRealNeg(i).PixelList)
                
                numbNeg = numbNeg + 1;
                
                objPixelRealNeg2(numbNeg).PixelList = objPixelRealNeg(i).PixelList;
                
            end
        end
    end
    
    numbBeats = numbPos + numbNeg;
    
    
    %% Create arrays where neg and pos obj are present%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %add all objects
    objPixelAll = [objPixelRealPos2 objPixelRealNeg2];
    % upDown = [(zeros(1,length(objPixelRealPos2)) + 1),(zeros(1,length(objPixelRealNeg2)) - 1)];
    
    
    
    %case that no obj where detected objPixelAll will be empty
    if isempty(objPixelAll)
        
        indRealBoutStart = NaN;
        indRealBoutEnd = NaN;
        halfBeatStructure = NaN;
        halfBeatPosInt = NaN;
        halfBeatMag = NaN;
        
        
    else
        
        
        %determine inds of obj order - order is defined by appearance in the last segment
        objStart = zeros(1,length(objPixelRealPos));
        objPosNeg2 = zeros(1,length(objPixelRealPos));
        
        for i = 1:length(objPixelAll)
            %find last segment of obj
            indLastSegment = objPixelAll(i).PixelList(:,1) == max(objPixelAll(i).PixelList(:,1));
            
            objStart(i) = min(objPixelAll(i).PixelList(indLastSegment,2));
            
            
            %make array with 1 for pos and 0 for neg
            if i <= length(objPixelRealPos2)
                
                objPosNeg2(i) = 1;
                
            else
                
                objPosNeg2(i) = 0;
                
            end
        end
        
        
        %sort obj by ascending order
        [~,indObjStart] = sort(objStart);
        objPosNeg = objPosNeg2(indObjStart);
        
        %%   erase 1st half beap if it is too caudal %%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        if (min(objPixelAll(indObjStart(1)).PixelList(:,1))>6)
            
            indObjStart(1)=[];
            objPosNeg(1)=[];
            
        end
        
        %% here I am going to try to erase the first beat if it is less that x
        
        % firstBeatLastSeg=min(objPixelAll(indObjStart(1)).PixelList(:,1));
        %%  save halfBeat vals and inds in halfBeat structure%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        objStartAll = zeros(1, length(indObjStart));
        objEndAll = zeros(1, length(indObjStart));
        halfBeatPosInt = zeros(1, length(indObjStart));
        halfBeatMag = zeros(1, length(indObjStart));
        numbBeats=length(indObjStart);
        
        for iii = 1 : length(indObjStart)%loop through each real obj
            
            %reorganize obj order
            halfBeatStructure(iii).halfBeatInd = objPixelAll(indObjStart(iii)).PixelList;
            
            
            %transform col row to ind
            objX = halfBeatStructure(iii).halfBeatInd(:,1);
            objY = halfBeatStructure(iii).halfBeatInd(:,2);
            
            objLinerInd = sub2ind(size(cumsum2DInterpolatedAngles), objY, objX);
            
            %%  find bout start and end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %bout start is the lowest row(time) that a obj has
            %bout end is the largest row(time) that a obj has
            
            objStartAll(iii) = min(objPixelAll(indObjStart(iii)).PixelList(:,2));
            objEndAll(iii) = max(objPixelAll(indObjStart(iii)).PixelList(:,2));
            
            %save beat start and end
            halfBeatStructure(iii).indBeatStart = objStartAll(iii);
            halfBeatStructure(iii).indBeatEnd = objEndAll(iii);
            
            %% %save indexes and vals
            halfBeatStructure(iii).halfBeatLinearInd = objLinerInd;
            halfBeatStructure(iii).halfBeatVal = cumsum2DInterpolatedAngles(objLinerInd);% in rads
            halfBeatStructure(iii).halfBeatValGray = cumsumInterpolatedAnglesGray(objLinerInd);
            
            %save if beat is up or down - 1 is up 0 is down
            halfBeatStructure(iii).upDown = objPosNeg(iii);
            
            
            %% find peaks by center of mass for each segment in obj%%%%%%%%%%%%%%
            %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %     objVal = cumsumInterpolatedAnglesGray(objLinerInd);
            %
            %     %calculate center of mass for each segment
            %     CM_X = nan(1,10);
            %     CM_Y = nan(1,10);
            %
            %
            %     [uniqueSegmentsVal uniqueSegmentsInd] = unique(objX, 'first');
            %
            %     for iiii = 1 : length(uniqueSegmentsVal)%loop through each segment
            %
            %     indThisSegment =  find(objX == uniqueSegmentsVal(iiii));
            %
            %     CM_X(uniqueSegmentsVal(iiii)) = sum(objVal(indThisSegment).*objX(indThisSegment))/(sum(objVal(indThisSegment)));
            %     CM_Y(uniqueSegmentsVal(iiii)) = sum(objVal(indThisSegment).*objY(indThisSegment))/(sum(objVal(indThisSegment)));
            %
            %
            %     end%loop through each segment
            %
            %      %erase nans
            %      CM_X_ind = round(CM_X(isfinite(CM_X)));
            %      CM_Y_ind = round(CM_Y(isfinite(CM_Y)));
            
            %% find peaks by smoothing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            thisBeapInd =   objPixelAll(indObjStart(iii)).PixelList;
            %       thisBeapInd =  objPixelAll(iii).PixelList;
            %        uniqueSegments = unique(thisBeapInd(:,1));
            [uniqueSegments, ~] = unique(objX, 'first');
            CM_X = nan(1,10);
            CM_Y = nan(1,10);
            
            for hh = 1 : length(uniqueSegments)%loop through segment
                
                indThisSegment = find(thisBeapInd(:,1) == uniqueSegments(hh));
                inds = thisBeapInd(indThisSegment,2);
                
                %find peaks by smoothing and finging max
                thisBeat = cumsum2DInterpolatedAngles(inds,uniqueSegments(hh));
                
                %case when data is smaller than 50 smooth with size of data
                %         if size(thisBeat,1) >= 50
                %
                cumsumInterpolatedAnglesSmooth = sgolayfilt(thisBeat,min(2,nearestOdd(9*fps/7)-1),nearestOdd(9*fps/7),[],1);
                
                %         else
                %           cumsumInterpolatedAnglesSmooth = mikesmooth(thisBeat,size(thisBeat,1));
                %
                %         end
                
                if objPosNeg(iii) == 1
                    
                    [peakVal, peakInd]= max(cumsumInterpolatedAnglesSmooth);
                    
                end
                
                if objPosNeg(iii) == 0
                    
                    [peakVal, peakInd]= min(cumsumInterpolatedAnglesSmooth);
                    
                end
                
                CM_Y(uniqueSegments(hh)) = inds(1) + peakInd(1) -1;
                CM_X(uniqueSegments(hh)) = uniqueSegments(hh);
                %%  test beats maxs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %        col = jet(length(objPixelAll));
                
                %         plot(cumsumInterpolatedAnglesGray(:,uniqueSegments(hh)),'color','k')
                %         hold on
                %         plot(inds,cumsumInterpolatedAnglesGraySmooth,'.','color',col(iii,:), 'linewidth',3)
                %         plot((inds(1) + peakInd -1),peakVal,'go', 'linewidth', 4)
                % %         pause
            end%loop through segment
            
            %erase nans
            CM_X_ind = round(CM_X(isfinite(CM_X)));
            CM_Y_ind = round(CM_Y(isfinite(CM_Y)));
            
            
            %% save half beat max in structure%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            halfBeatStructure(iii).halfBeatCMInd = [CM_X_ind'  CM_Y_ind'];
            
            halfBeatCMLinearInd = sub2ind(size(cumsum2DInterpolatedAngles), CM_Y_ind, CM_X_ind);
            
            halfBeatStructure(iii).halfBeatCMLinearInd = halfBeatCMLinearInd;
            halfBeatStructure(iii).halfBeatCMVal = cumsum2DInterpolatedAngles(halfBeatCMLinearInd);
            halfBeatStructure(iii).halfBeatCMValGray = cumsumInterpolatedAnglesGray(halfBeatCMLinearInd);
            halfBeatStructure(iii).lastMeasuredSegment = lastMeasuredSegment;
            
            
            %% save beat positions and amp in array %%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %calcualte beats pos by 7th semgment - if bout has less than 7
            %segments calcualte the last segment
            
            
            %      if ~isempty(find(CM_X_ind == 7, 1))
            %
            %      indLastSegment = find(CM_X_ind == 7);
            %      halfBeatPosInt(iii) = CM_Y_ind(indLastSegment);
            %      halfBeatMag(iii) = cumsum2DInterpolatedAngles(halfBeatPosInt(iii),indLastSegment);
            %      segmentToCalcualateBeatPeaks(iii) = 7;
            
            %      else
            indLastSegment = find(CM_X_ind == lastMeasuredSegment);
            CM_Y_ind;
            halfBeatPosInt(iii) = CM_Y_ind(indLastSegment);
            halfBeatMag(iii) = cumsum2DInterpolatedAngles(halfBeatPosInt(iii),indLastSegment);
            
            
            %      end
            
            %% save number of segments and max map that this beat has %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % to exclude mini 1st beats
            numberSegmentsOfBeat = length(halfBeatCMLinearInd);
            halfBeatStructure(iii).numberSegmentsOfBeat = numberSegmentsOfBeat;
            
            
            
            if objPosNeg(iii) == 1
                
                beatMaxAmplitude = max(cumsum2DInterpolatedAngles(halfBeatCMLinearInd)*(180/pi));
                
            else
                
                beatMaxAmplitude = min(cumsum2DInterpolatedAngles(halfBeatCMLinearInd)*(180/pi));
                
            end
            
            halfBeatStructure(iii).beatMaxAmplitude = beatMaxAmplitude;
            
            beatDuration = (objEndAll(iii) - objStartAll(iii))/fps;
            halfBeatStructure(iii).beatDuration = beatDuration;
            
        end%loop through each real obj
        
        
        
        
        %% detertmine start and end of bout%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        indRealBoutStart = min(objStartAll);
        indRealBoutEnd = max(objEndAll);
        
        
        %% case where there were no halfbeats found %%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        if ~exist('halfBeatStructure') || isempty(indRealBoutStart) || isempty(indRealBoutEnd)
            
            indRealBoutStart = NaN;
            indRealBoutEnd = NaN;
            halfBeatStructure = NaN;
            halfBeatPosInt = NaN;
            halfBeatMag = NaN;
            
        end
        
        %% make color image%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if makeplot == 1
            %create color image
            my_image  = zeros((size(cumsumInterpolatedAnglesGray,1)),size(cumsumInterpolatedAnglesGray,2),3); %initialize the image
            my_image(:,:,1) = cumsumInterpolatedAnglesGray;
            my_image(:,:,2) = cumsumInterpolatedAnglesGray;
            my_image(:,:,3) = cumsumInterpolatedAnglesGray;
            
            
            for j = 1 : length(indObjStart) % loop trough each beat
                
                %get CM_X_ind,  CM_Y_ind, halfBeatCMLinearInd from beat structure
                
                CM_X_ind = halfBeatStructure(j).halfBeatCMInd(:,1);
                CM_Y_ind = halfBeatStructure(j).halfBeatCMInd(:,2);
                halfBeatCMLinearInd = halfBeatStructure(j).halfBeatCMLinearInd;
                upDown = halfBeatStructure(j).upDown;
                
                CM_Y_LinearIndOne = sub2ind(size(my_image), CM_Y_ind', CM_X_ind',(zeros(1, length(CM_X_ind)) + 1));
                CM_Y_LinearIndTwo = sub2ind(size(my_image), CM_Y_ind', CM_X_ind',(zeros(1, length(CM_X_ind)) + 2));
                CM_Y_LinearIndNeg = sub2ind(size(my_image), CM_Y_ind', CM_X_ind',(zeros(1, length(CM_X_ind)) + 3));
                nS = halfBeatStructure.lastMeasuredSegment;
                sz = size(my_image);
                if   ~isnan(CM_Y_LinearIndOne)
                    %lable image
                    for ff = 1 : length(CM_Y_LinearIndOne)%loop throug each half beat
                        
                        %red for up
                        if   upDown == 1
                            
                            my_image(round(max(1,CM_Y_LinearIndOne(ff)-nS) : min((CM_Y_LinearIndOne(ff)+nS),sz(1)*sz(2)))) = 1;%*cumsumInterpolatedAnglesGray(halfBeatCMLinearInd(ff));
                            my_image(round(max(1,CM_Y_LinearIndTwo(ff)-nS) : min((CM_Y_LinearIndTwo(ff)+nS),sz(1)*sz(2)*2))) = 0;
                            my_image(round(max(1,CM_Y_LinearIndNeg(ff)-nS) : min((CM_Y_LinearIndNeg(ff)+nS),sz(1)*sz(2)*sz(3)))) = 0;
                            
                        else%green for down
                            my_image(round((CM_Y_LinearIndOne(ff)-nS) : min((CM_Y_LinearIndOne(ff)+nS),sz(1)*sz(2)))) = 0;
                            my_image(round((CM_Y_LinearIndTwo(ff)-nS) : min((CM_Y_LinearIndTwo(ff)+nS),sz(1)*sz(2)*2))) = 1;%*cumsumInterpolatedAnglesGray(halfBeatCMLinearInd(ff));
                            my_image(round((CM_Y_LinearIndNeg(ff)-nS) :  min((CM_Y_LinearIndNeg(ff)+nS),sz(1)*sz(2)*sz(3)))) = 0;
                            
                            
                        end
                        
                    end
                    
                    
                end
                
            end
%              if (firstBeatLastSeg>5)
            figure
            %test thresholds and detection
%             nexttile,
%             imagesc(cumsumInterpolatedAnglesGray)
%             colormap gray
%             axis square
%             xlabel('Segment number')
%             ylabel('Number of frames')
%             
%             nexttile,
%             imagesc(binaryImageUpThres)
%             colormap gray
%             axis square
%             xlabel('Segment number')
%             ylabel('Number of frames')
%             box off
%             
%             nexttile,
%             imagesc(binaryImage)
%             colormap gray
%             axis square
%             xlabel('Segment number')
%             ylabel('Number of frames')
%             box off
%             
%             nexttile,
%             imagesc(my_image)
%             colormap gray
%             axis square
%             xlabel('Segment number')
%             ylabel('Number of frames')
%             box off
            
            nexttile,
            plot(cumsumInterpolatedAngles);
            hold on;
            [color,~] = getColorSymbol(length(halfBeatStructure));
            arrayfun(@(i) xline(halfBeatStructure(i).indBeatStart,'Color',color(i,:)),1:length(halfBeatStructure),'un',0);
            arrayfun(@(i) xline(halfBeatStructure(i).indBeatEnd,'--','Color',color(i,:)),1:length(halfBeatStructure),'un',0);
%             pause
%              end
            drawnow;
        end
    end%if of no obj were detected
    
    
else%exclude very small bouts
    disp('very small bout')
    indRealBoutStart = NaN;
    indRealBoutEnd = NaN;
    halfBeatStructure = NaN;
    halfBeatPosInt = NaN;
    halfBeatMag = NaN;
    
end%exclude very small bouts

