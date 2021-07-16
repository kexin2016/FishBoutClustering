%this function calculates the number of segments that are part of tail
%input


%output


  function [indLastTailSegment,chosenSegmentValues, chosenTailAngles] = NumberTailSegmentsDetector_5(tailValues, tailAngles,makePlot)




        %turn NaNs to zeros
        tailValues(isnan(tailValues)) = 0;

        %average value for each segment
        tailValuesAvr = median(tailValues,1);

        %turn to percentage
        normPercTailValuesAvr = tailValuesAvr./max(tailValuesAvr);
        
        %normalize by min at 0.1
%         minOffset = min(PercTailValuesAvr)-0.1;   
%         normPercTailValuesAvr = PercTailValuesAvr-minOffset;
        
        %determine segments by difference between them
        diffNormPercTailValuesAvr = [diff(normPercTailValuesAvr) 0];
       
        
        %this will always equal -0.02!!
        %fishDetectorThreshold = max(((diffNormPercTailValuesAvr - max(diffNormPercTailValuesAvr))-0.01)).*2
        fishDetectorThreshold = -0.02;
        %flip diff array - we want to find the first lower than threshold
        flipedDiffvector = fliplr(diffNormPercTailValuesAvr);
        
        %calculate ind of last tail segment
        indLastTailSegment = size(tailAngles,2)+1 - find(flipedDiffvector < fishDetectorThreshold, 1, 'first');
        
        chosenSegmentValuesMean = normPercTailValuesAvr(1:indLastTailSegment);
       
        chosenSegmentValues = tailValues(:,1:indLastTailSegment);
        
        chosenTailAngles = tailAngles(:,1:indLastTailSegment);
        
        
        if makePlot ==1
%         
%         Test selected segments
%       figure
        clf
        hold off
        plot(normPercTailValuesAvr,'o');
        hold on
        plot(chosenSegmentValuesMean,'o', 'color','red');
        
        xlim([0 16])
        ylim([0 1])
        
%          pause

        end