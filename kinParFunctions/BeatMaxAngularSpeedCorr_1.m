      function [BeatKinematicParametersThisBeat] = BeatMaxAngularSpeedCorr_1(realBodyAnglesLessSmoothThis,indStart,indBeatStartNotInt,indBeatEndNotInt,BeatKinematicParametersThisBeat)
     
        
        indThisHalfBeatStart = (indBeatStartNotInt-indStart);
        indThisHalfBeatEnd = (indBeatEndNotInt-indStart);
        
        if indThisHalfBeatEnd > length(realBodyAnglesLessSmoothThis)
            
            indThisHalfBeatEnd = length(realBodyAnglesLessSmoothThis);
        end

        realBodyAnglesLessSmoothThisHalfbeat = realBodyAnglesLessSmoothThis(indThisHalfBeatStart : indThisHalfBeatEnd)*180/pi;
        

        %normlize half beat body angles
        halfBeatBodyAnglesNorm = realBodyAnglesLessSmoothThisHalfbeat(1) - realBodyAnglesLessSmoothThisHalfbeat;
        
        halfBeatAngularSpeed = diff(halfBeatBodyAnglesNorm(1:end))./1.426;% in degrees/ms
        halfBeatMaxAngularSpeed = max(abs(halfBeatAngularSpeed));
        
        BeatKinematicParametersThisBeat(EnumeratorBeatKinPar.beatMaxAngularSpeedLessSmooth) = halfBeatMaxAngularSpeed;
