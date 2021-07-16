function [BoutKinematicParameters] = boutKine_calc(boutKine_dwnsampl,eyeConv_dwnsampl,fps,lastMeasuredSegment,mode)
%function [BoutKinematicParameters] = boutKine_calc(boutKine_dwnsampl,eyeConv_dwnsampl,fps,lastMeasuredSegment)
% input: 
%boutKine_dwnsampl: cell array (each cell represents one bout), inside each cell, time frames x tail segment matrix
% eyeConv_dwnsampl: cell array similar to boutKine_dwnsampl. but inside
% each cell, time frames x 1 vector (each time frame's convergence angle)
% fps: 1 for free moving, 0.5 for fixed-fish
% lastMeasuredSegment: 8 for free moving, 10 for fixed fish
%mode: test(for and plot) or batch (parfor and no plot)
%Todo:
%1.check tailsmoothercurvature smooth parameter and consider the fps
%2.bout duration
%allboutstarts&ends is the start and end thresholded by tail curvature
%indRealEnds, is when the glide stops
% load(fullfile(getpath('result'),'selected_bouts'),'boutKine_dwnsampl');

% fps=fps/100;
cumsumInterpFixedSegmentAngles = double(cat(1,boutKine_dwnsampl{:}));
convergengePar = double(cat(1,eyeConv_dwnsampl{:}));

index = zeros(length(boutKine_dwnsampl),2);
index(:,2) = cumsum(cellfun(@(x) size(x,1),boutKine_dwnsampl));
index(:,1) = [1;index(1:end-1,2)+1];

if strcmpi(mode,'batch')
makeplot = false;
elseif strcmpi(mode,'test')
    makeplot = true;
else
    warning('not choose run mode! will run batch in default');
    makeplot = false;
end
% lastMeasuredSegment = 10;
tailMM = 310:310:3100;
beatUniqueNumber = 0;
boutUniqueNumber = 0;
allboutstarts = index(:,1);
allboutends = index(:,2);

%%
tailSmootherMakePlot =0;
intPoints = [ones(lastMeasuredSegment,1);zeros(10-lastMeasuredSegment,1)];
[smootherTailCurveMeasure] = TailSmoother_6(cumsumInterpFixedSegmentAngles,intPoints,tailSmootherMakePlot);
smootherTailCurveMeasure(isinf(smootherTailCurveMeasure)) = 0;
%% batch mode
BoutKinematicParameters = zeros(length(allboutstarts),179);
if strcmpi(mode,'batch')
parfor iBout = 1 : length(allboutstarts)
    if mod(iBout,1000)==0
        disp(['processing ' num2str(iBout) ' bout...']);
    end
    cumsumAngleByBout = cumsumInterpFixedSegmentAngles(allboutstarts(iBout) : allboutends(iBout),1:lastMeasuredSegment);
%     size(cumsumAngleByBout)
    %inperpolate tail angle
    %create x - frames in real data
    x = 1:1:length(cumsumAngleByBout);
    
    %create xi - parts of frames to interpolate
    xi = 1:0.1:length(cumsumAngleByBout);
    
    %interpolate tail data
    cumsumInterpolatedAngleByBout = zeros(length(xi), size(cumsumAngleByBout,2));
    for f = 1:size(cumsumAngleByBout,2)
        
        
        cumsumInterpolatedAngleByBout(:,f) = interp1(x,cumsumAngleByBout(:,f),xi, '*spline')';
        
        
    end
    %interpolate bodyAngle data
    interpBodyAngles = nan(length(xi),1);% in rads
    interpBodyAngles2 = interpBodyAngles;
    %interpolate position data
    interpPosX = nan(length(xi),1);
    interpPosY = nan(length(xi),1);
    
    %interpolate smootherTailCurveMeasure
    interpSmootherTailCurveMeasure = row2col(interp1(x,smootherTailCurveMeasure((allboutstarts(iBout)) : (allboutends(iBout))),xi,'*spline'),1);
    
    %tail curvature
    [boutCurvature] = TailCurvatureCalculator_13(cumsumInterpolatedAngleByBout,tailMM);
    %detect beat
%     size(cumsumInterpolatedAngleByBout)
    %% beat detector
    if length(cumsumInterpolatedAngleByBout)<130%some bout is too short to use filtfilt because filtfilt has an implicit requirement that samples number must be three times longer than filter order
        BoutKinematicParameters(iBout,:) =nan(1,179);
        continue;
    end
    [cumsum2DInterpolatedAngles,cumsumInterpolatedAnglesGray,indRealBoutStart,indRealBoutEnd,halfBeatStructure]...
        = BeatDetector_26(cumsumInterpolatedAngleByBout,lastMeasuredSegment,makeplot,fps);
    if isnumeric(halfBeatStructure)&&isnan(halfBeatStructure)
        BoutKinematicParameters(iBout,:) =nan(1,179);
        continue;
    end
    if halfBeatStructure(1).indBeatStart<30 || length(halfBeatStructure)>11
        BoutKinematicParameters(iBout,:) =nan(1,179);
        continue;
    end
    
%     indRealBoutStartAll(iBout) = allboutstarts(iBout) + floor(indRealBoutStart/10);%need to round indRealBoutStart because is from interpolated data
%     indRealBoutEndAll(iBout) = allboutstarts(iBout) + floor(indRealBoutEnd/10);
    %%
    %%%%%%%%%%%%%Extrapolate missing segments%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %!!!this kin parameters don't seem to be useful - don't know why
    %if you want to use extrpolated data use BeatPropagationCalculatorExtrapolation_2.m, if not use BeatPropagationCalculator_2.m
    
    %         %not extrapolating missing segments
    %[halfBeatExtrapolatedStructure,velocityBeatPropagationStructure] = BeatPropagationCalculator_2(halfBeatStructure,tailMM,cumsum2DInterpolatedAngles);
    
    %extrapolating missing segments
    [halfBeatExtrapolatedStructure,velocityBeatPropagationStructure] = halfBeatTailWaveExtrapolation_3(halfBeatStructure,tailMM,cumsum2DInterpolatedAngles,fps);
    
    %%
    %%%%%%%%%%%%%%%%%%%%%%beat loop%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %to save inds of beats
    indBeatStartAll = zeros(1,length(halfBeatExtrapolatedStructure));
    indBeatEndAll = zeros(1,length(halfBeatExtrapolatedStructure));
    
    BeatKinematicParametersThisBout = nan(length(halfBeatExtrapolatedStructure),50);
    
%     BeatInfThisBout = zeros(length(halfBeatExtrapolatedStructure),32);
    
    
    for jBeat = 1: length(halfBeatExtrapolatedStructure) %beat loop
        %           j =2
        %%%%%%%%%%%%get start and end of beat in bout%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        indBeatStart = halfBeatExtrapolatedStructure(jBeat).indBeatStart;
        indBeatStartNotInt = round(indBeatStart/10);
        indBeatStartNotIntAllData = allboutstarts(iBout) + indBeatStartNotInt;
        
        indBeatEnd = halfBeatExtrapolatedStructure(jBeat).indBeatEnd;
        indBeatEndNotInt = round(indBeatEnd/10);
        indBeatEndNotIntAllData = allboutstarts(iBout) + indBeatEndNotInt;
        
        %%avoid case where beat start ind is zero or negative
        if indBeatStartNotInt < 1
            
            indBeatStartNotInt = 1;
            
        end
        
        
        %save beat position to calculate bout frequency
        indBeatStartAll(jBeat) = indBeatStartNotInt;
        indBeatEndAll(jBeat) = indBeatEndNotInt;
        
        [BeatKinematicParametersThisBeat, ~,~] = BeatParametersCalculator(jBeat,tailMM, halfBeatExtrapolatedStructure, ...
            velocityBeatPropagationStructure,indRealBoutStart,interpSmootherTailCurveMeasure,boutCurvature,fps);
        %the destroyed data here is 38(BeatAngles),39(halfBeatMaxAngles),
        %41&42(beatDistance), 43&44(beatSpeed)
        %%
        %%%%%%%% calculate max angular speed with less smoothing %%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        BeatKinematicParametersThisBout(jBeat,:) = BeatKinematicParametersThisBeat;
        %%%%%%%%%%%% make BeatInf array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
%         [BeatInfThisBeat] = beatInfMaker_5(iBout,xPos,yPos,dataSetNumber,protocolNumber,fishUniqueNumber,thisBoutStim, ...
% %             boutPreviousStim,pixelSize,headToBladderLength,tailSegmentLength,distanceEyesToBlob,lastMeasuredSegment,fishAge,boutUniqueNumber,...
%             lagVector,allboutstarts,sequenceOfBoutsInStim,uniqueFileNumber,beatUniqueNumber,indBeatStartNotIntAllData,indBeatEndNotIntAllData,...
%             indBeatStartNotInt,indBeatEndNotInt,indBeatStart,indBeatEnd,sequenceOfBoutsInNoCollision,latencyOfBoutAfterStim,...
%             stimUniqueNumberBoutVector,realFishUniqueNumber,trueUniqueFishNumber,wellLetter);
        
%         BeatInfThisBout(jBeat,:) = BeatInfThisBeat;
        
        beatUniqueNumber = beatUniqueNumber + 1;
        
    end %beat loop
%     BeatInf = [BeatInf' BeatInfThisBout']';
%     BeatKinematicParameters = [BeatKinematicParameters'  BeatKinematicParametersThisBout']';
    %%%%%%%%%%%%%%%%%% find C1 and C2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     [C1Angle,C1Duration,C1MaxAngularSpeed,C2Angle,C2Duration,C2MaxAngularSpeed] = C1C2Calculator_5(halfBeatStructure,interpBodyAngles);
    %C1Angle, C1Duration, C1MaxAngularSpeed, and C2s cannot be correctly
    %calculated
    bouSpace = 1;
    indstarts = max(1,floor(indRealBoutStart/10));
    indend = floor(indRealBoutEnd/10);
    convergengeParthisBout = convergengePar(allboutstarts(iBout):allboutends(iBout));
    eyeConvAvrThisBout = nanmean(convergengeParthisBout(indstarts:indend));
    
    [eyeConv20FramesBeforeBoutThisBout,eyeConv20FramesAfterBoutThisBout,eyeConvDiff2ThisBout] = eyeKinParCalculator_1...
        (convergengeParthisBout,bouSpace,indstarts,indend);
    
    %combine the previously calculated parameters together
    [BoutKinematicParametersThisBout] = BoutParametersCalculator(BeatKinematicParametersThisBout,indRealBoutEnd,indRealBoutStart,...
        cumsumInterpolatedAngleByBout,eyeConvAvrThisBout,eyeConv20FramesBeforeBoutThisBout,...
        eyeConv20FramesAfterBoutThisBout,eyeConvDiff2ThisBout,fps);
    %3(distBoutDuration),7-9(head yaw),10-11(boutAngle),12(boutMaxAngle) 15-22(distance, speed, distDistance, speed),
    %226-231(C1&C2), 112-118(beatAngle), 163-166(beatDIstance/speed),
    %211-124(beatDistance&speed)
    %     [BoutKinematicParametersThisBout] = BoutParametersCalculatorMaxAngularSpeed_1(BoutKinematicParametersThisBout,...
    %         BeatKinematicParametersThisBout,realBodyAnglesLessSmoothThis);
    BoutKinematicParameters(iBout,:) = col2row(BoutKinematicParametersThisBout,1);
    
    %     [BoutInfThisBout] = boutInfMaker_21(iBout,xPos,yPos,dataSetNumber,protocolNumber,fishUniqueNumber,thisBoutStim, boutPreviousStim,pixelSize,headToBladderLength,tailSegmentLength,...
    %           distanceEyesToBlob,lastMeasuredSegment,fishAge,boutUniqueNumber,lagVector,indRealBoutStartAll,indRealBoutEndAll,sequenceOfBoutsInStim,uniqueFileNumber,...
    %           sequenceOfBoutsInNoCollision,latencyOfBoutAfterStim,stimUniqueNumberBoutVector,0,0,0,0,...
    %           firstSegmentWithNotfixedMistakes,firstSegmentWithAnyMistake,realFishUniqueNumber,trueUniqueFishNumber,wellLetter,eyeConvDiffThisBout);
    %     BoutInf = [BoutInf' BoutInfThisBout']';
    
    
    %update bout number
    boutUniqueNumber = boutUniqueNumber + 1;
end
%% test mode
elseif strcmpi(mode,'test')
    for iBout = 1 : length(allboutstarts)
        disp(['processing ' num2str(iBout) ' bout...']);
    cumsumAngleByBout = cumsumInterpFixedSegmentAngles(allboutstarts(iBout) : allboutends(iBout),1:lastMeasuredSegment);
%     size(cumsumAngleByBout)
    %inperpolate tail angle
    %create x - frames in real data
    x = 1:1:length(cumsumAngleByBout);
    
    %create xi - parts of frames to interpolate
    xi = 1:0.1:length(cumsumAngleByBout);
    
    %interpolate tail data
    cumsumInterpolatedAngleByBout = zeros(length(xi), size(cumsumAngleByBout,2));
    for f = 1:size(cumsumAngleByBout,2)
        
        
        cumsumInterpolatedAngleByBout(:,f) = interp1(x,cumsumAngleByBout(:,f),xi, '*spline')';
        
        
    end
    %interpolate bodyAngle data
    interpBodyAngles = nan(length(xi),1);% in rads
    interpBodyAngles2 = interpBodyAngles;
    %interpolate position data
    interpPosX = nan(length(xi),1);
    interpPosY = nan(length(xi),1);
    
    %interpolate smootherTailCurveMeasure
    interpSmootherTailCurveMeasure = row2col(interp1(x,smootherTailCurveMeasure((allboutstarts(iBout)) : (allboutends(iBout))),xi,'*spline'),1);
    
    %tail curvature
    [boutCurvature] = TailCurvatureCalculator_13(cumsumInterpolatedAngleByBout,tailMM);
    %detect beat
%     size(cumsumInterpolatedAngleByBout)
    [cumsum2DInterpolatedAngles,cumsumInterpolatedAnglesGray,indRealBoutStart,indRealBoutEnd,halfBeatStructure]...
        = BeatDetector_26(cumsumInterpolatedAngleByBout,lastMeasuredSegment,makeplot,fps);
    if isnumeric(halfBeatStructure)&&isnan(halfBeatStructure)
        BoutKinematicParameters(iBout,:) =nan(1,179);
        continue;
    end
    if halfBeatStructure(1).indBeatStart<30
        BoutKinematicParameters(iBout,:) =nan(1,179);
        continue;
    end
%     indRealBoutStartAll(iBout) = allboutstarts(iBout) + floor(indRealBoutStart/10);%need to round indRealBoutStart because is from interpolated data
%     indRealBoutEndAll(iBout) = allboutstarts(iBout) + floor(indRealBoutEnd/10);
    %%
    %%%%%%%%%%%%%Extrapolate missing segments%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %!!!this kin parameters don't seem to be useful - don't know why
    %if you want to use extrpolated data use BeatPropagationCalculatorExtrapolation_2.m, if not use BeatPropagationCalculator_2.m
    
    %         %not extrapolating missing segments
    %[halfBeatExtrapolatedStructure,velocityBeatPropagationStructure] = BeatPropagationCalculator_2(halfBeatStructure,tailMM,cumsum2DInterpolatedAngles);
    
    %extrapolating missing segments
    [halfBeatExtrapolatedStructure,velocityBeatPropagationStructure] = halfBeatTailWaveExtrapolation_3(halfBeatStructure,tailMM,cumsum2DInterpolatedAngles,fps);
    
    %%
    %%%%%%%%%%%%%%%%%%%%%%beat loop%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %to save inds of beats
    indBeatStartAll = zeros(1,length(halfBeatExtrapolatedStructure));
    indBeatEndAll = zeros(1,length(halfBeatExtrapolatedStructure));
    
    BeatKinematicParametersThisBout = nan(length(halfBeatExtrapolatedStructure),50);
    
%     BeatInfThisBout = zeros(length(halfBeatExtrapolatedStructure),32);
    
    
    for jBeat = 1: length(halfBeatExtrapolatedStructure) %beat loop
        %           j =2
        %%%%%%%%%%%%get start and end of beat in bout%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        indBeatStart = halfBeatExtrapolatedStructure(jBeat).indBeatStart;
        indBeatStartNotInt = round(indBeatStart/10);
        indBeatStartNotIntAllData = allboutstarts(iBout) + indBeatStartNotInt;
        
        indBeatEnd = halfBeatExtrapolatedStructure(jBeat).indBeatEnd;
        indBeatEndNotInt = round(indBeatEnd/10);
        indBeatEndNotIntAllData = allboutstarts(iBout) + indBeatEndNotInt;
        
        %%avoid case where beat start ind is zero or negative
        if indBeatStartNotInt < 1
            
            indBeatStartNotInt = 1;
            
        end
        
        
        %save beat position to calculate bout frequency
        indBeatStartAll(jBeat) = indBeatStartNotInt;
        indBeatEndAll(jBeat) = indBeatEndNotInt;
        
        [BeatKinematicParametersThisBeat, ~,~] = BeatParametersCalculator(jBeat,tailMM, halfBeatExtrapolatedStructure, ...
            velocityBeatPropagationStructure,indRealBoutStart,interpSmootherTailCurveMeasure,boutCurvature,fps);
        %the destroyed data here is 38(BeatAngles),39(halfBeatMaxAngles),
        %41&42(beatDistance), 43&44(beatSpeed)
        %%
        %%%%%%%% calculate max angular speed with less smoothing %%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        BeatKinematicParametersThisBout(jBeat,:) = BeatKinematicParametersThisBeat;
        %%%%%%%%%%%% make BeatInf array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
%         [BeatInfThisBeat] = beatInfMaker_5(iBout,xPos,yPos,dataSetNumber,protocolNumber,fishUniqueNumber,thisBoutStim, ...
% %             boutPreviousStim,pixelSize,headToBladderLength,tailSegmentLength,distanceEyesToBlob,lastMeasuredSegment,fishAge,boutUniqueNumber,...
%             lagVector,allboutstarts,sequenceOfBoutsInStim,uniqueFileNumber,beatUniqueNumber,indBeatStartNotIntAllData,indBeatEndNotIntAllData,...
%             indBeatStartNotInt,indBeatEndNotInt,indBeatStart,indBeatEnd,sequenceOfBoutsInNoCollision,latencyOfBoutAfterStim,...
%             stimUniqueNumberBoutVector,realFishUniqueNumber,trueUniqueFishNumber,wellLetter);
        
%         BeatInfThisBout(jBeat,:) = BeatInfThisBeat;
        
        beatUniqueNumber = beatUniqueNumber + 1;
        
    end %beat loop
%     BeatInf = [BeatInf' BeatInfThisBout']';
%     BeatKinematicParameters = [BeatKinematicParameters'  BeatKinematicParametersThisBout']';
    %%%%%%%%%%%%%%%%%% find C1 and C2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     [C1Angle,C1Duration,C1MaxAngularSpeed,C2Angle,C2Duration,C2MaxAngularSpeed] = C1C2Calculator_5(halfBeatStructure,interpBodyAngles);
    %C1Angle, C1Duration, C1MaxAngularSpeed, and C2s cannot be correctly
    %calculated
    bouSpace = 1;
    indstarts = max(1,floor(indRealBoutStart/10));
    indend = floor(indRealBoutEnd/10);
    convergengeParthisBout = convergengePar(allboutstarts(iBout):allboutends(iBout));
    eyeConvAvrThisBout = nanmean(convergengeParthisBout(indstarts:indend));
    
    [eyeConv20FramesBeforeBoutThisBout,eyeConv20FramesAfterBoutThisBout,eyeConvDiff2ThisBout] = eyeKinParCalculator_1...
        (convergengeParthisBout,bouSpace,indstarts,indend);
    
    %combine the previously calculated parameters together
    [BoutKinematicParametersThisBout] = BoutParametersCalculator(BeatKinematicParametersThisBout,indRealBoutEnd,indRealBoutStart,...
        cumsumInterpolatedAngleByBout,eyeConvAvrThisBout,eyeConv20FramesBeforeBoutThisBout,...
        eyeConv20FramesAfterBoutThisBout,eyeConvDiff2ThisBout,fps);
    %3(distBoutDuration),7-9(head yaw),10-11(boutAngle),12(boutMaxAngle) 15-22(distance, speed, distDistance, speed),
    %226-231(C1&C2), 112-118(beatAngle), 163-166(beatDIstance/speed),
    %211-124(beatDistance&speed)
    %     [BoutKinematicParametersThisBout] = BoutParametersCalculatorMaxAngularSpeed_1(BoutKinematicParametersThisBout,...
    %         BeatKinematicParametersThisBout,realBodyAnglesLessSmoothThis);
    BoutKinematicParameters(iBout,:) = col2row(BoutKinematicParametersThisBout,1);
    
    %     [BoutInfThisBout] = boutInfMaker_21(iBout,xPos,yPos,dataSetNumber,protocolNumber,fishUniqueNumber,thisBoutStim, boutPreviousStim,pixelSize,headToBladderLength,tailSegmentLength,...
    %           distanceEyesToBlob,lastMeasuredSegment,fishAge,boutUniqueNumber,lagVector,indRealBoutStartAll,indRealBoutEndAll,sequenceOfBoutsInStim,uniqueFileNumber,...
    %           sequenceOfBoutsInNoCollision,latencyOfBoutAfterStim,stimUniqueNumberBoutVector,0,0,0,0,...
    %           firstSegmentWithNotfixedMistakes,firstSegmentWithAnyMistake,realFishUniqueNumber,trueUniqueFishNumber,wellLetter,eyeConvDiffThisBout);
    %     BoutInf = [BoutInf' BoutInfThisBout']';
    
    
    %update bout number
    boutUniqueNumber = boutUniqueNumber + 1;
    end
end
end

