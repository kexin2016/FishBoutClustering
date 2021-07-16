%input
%1) smootherTailCurveMeasure
%2) indThisStimTypeStart
%3) indThisStimTypeEnd
%4) filteredDistance

%output
%1)allboutstarts - ind start of bout
%2)allboutends - ind end of bout
%3)indRealEnds - ind real end of bout - by distance

%this function calculates bout start end and realend ind from bout
%curvature data for each stim block


function [allboutstarts,allboutends,indRealEnds] = BoutDetectorCurvatureFunction4(smootherTailCurveMeasure,indThisStimTypeStart,indThisStimTypeEnd,filteredDistance)
% %test function variables
% close all;
%  nnn=5;
indThisStimTypeStart2=indThisStimTypeStart;
indThisStimTypeEnd2=indThisStimTypeEnd;

%  indThisStimTypeStart2=indThisStimTypeStart(5)
%  indThisStimTypeEnd2=indThisStimTypeEnd(5)

%%%%%%%%%%%%%%%%%%%%%%%%Find bouts by threshold%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxData=max(smootherTailCurveMeasure);
threshold=maxData/20;
allBouts=find(diff((smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)>threshold)));

%if array starts in the middle of a bout
if (smootherTailCurveMeasure(indThisStimTypeStart2)>threshold)
    allboutstarts=allBouts(2:2:end);
    allboutends=allBouts(3:2:end);
    allboutstarts=allboutstarts(1:length(allboutends));
else
    %if array does not start in the middle of bout
    allboutstarts=allBouts(1:2:end);
    allboutends=allBouts(2:2:end);
    allboutstarts=allboutstarts(1:length(allboutends));
end

% %test starts and ends of bouts
% startBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% startBout(allboutstarts)=1;
% endBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% endBout(allboutends)=1;
%
% figure
% plot(smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2), '.', 'color', 'black')
% hold on
% plot(startBout,'o','color', 'green','LineWidth',2)
% hold on
% plot(endBout, 'o', 'color', 'red','LineWidth',2)

%%%%%%%%%%%%%%%%%%%%%%%%add bouts that are near%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


minimuminterboutinterval=30;

while (1==1)
    allinterboutlengths=allboutstarts(2:end)-allboutends(1:end-1);%calculate inter bout lengths
    if ~isempty(find(allinterboutlengths<minimuminterboutinterval, 1))%if there are bouts that are near
        shortinterval= find(allinterboutlengths<minimuminterboutinterval,1);
        
        if (shortinterval<length(allboutstarts-2))
            allboutstarts=[allboutstarts(1:shortinterval) allboutstarts(shortinterval+2:end)];
        else
            allboutstarts=allboutstarts(1:shortinterval);
        end
        if (shortinterval>1)
            allboutends=[allboutends(1:shortinterval-1) allboutends(shortinterval+1:end)];
        else
            allboutends=allboutends(2:end);
        end
    else
        break
    end
    
end





% %test starts and ends of bouts
% startBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% startBout(allboutstarts)=1;
% endBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% endBout(allboutends)=1;
%
% figure
% plot(smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2), '.', 'color', 'black')
% hold on
% plot(startBout,'o','color', 'green','LineWidth',2)
% hold on
% plot(endBout, 'o', 'color', 'red','LineWidth',2)


%%%%%%%%%%%%%%%%%%%%%%%%erase bouts that are too short%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


minimumboutlength=30;

newallboutstarts=allboutstarts(find((allboutends-allboutstarts)>minimumboutlength));
newallboutends=allboutends(find((allboutends-allboutstarts)>minimumboutlength));
allboutstarts=newallboutstarts;
allboutends=newallboutends;

% %test starts and ends of bouts
% startBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% startBout(allboutstarts)=1;
% endBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% endBout(allboutends)=1;
%
% figure
% plot(smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2), '.', 'color', 'black')
% hold on
% plot(startBout,'o','color', 'green','LineWidth',2)
% hold on
% plot(endBout, 'o', 'color', 'red','LineWidth',2)


%%%%%%%%%%%%%%%%%%%erase bouts that have low max curvature%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%erase bouts with small curvature%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isempty(allboutstarts)%avoid cases when it does not pick any bout
    minimummaxcurvature=0.2;
    goodstarts=ones(size(allboutstarts));
    curvatureBlock=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2);
    for n=1:length(allboutstarts)
        if (max(curvatureBlock(allboutstarts(n):allboutends(n)))<minimummaxcurvature)
            goodstarts(n)=0;
        end
    end
    allboutstarts=allboutstarts(find(goodstarts));
    allboutends=allboutends(find(goodstarts));
    
    
    % %test starts and ends of bouts
    % startBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
    % startBout(allboutstarts)=1;
    % endBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
    % endBout(allboutends)=1;
    %
    % figure
    % plot(cumFilteredSegmentAngle(indThisStimTypeStart2:indThisStimTypeEnd2))
    % hold on
    % plot(smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2), '.', 'color', 'black')
    % hold on
    % plot(startBout,'o','color', 'green','LineWidth',2)
    % hold on
    % plot(endBout, 'o', 'color', 'red','LineWidth',2)
    
    
    
    %%%%%%%%%%%%%%%%%Pick end of bout by min distance%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    indRealEnds=allboutstarts*0;
    
    for n=1:length(allboutstarts)-1
        interboutregion= filteredDistance(allboutends(n):allboutstarts(n+1)-1);
        [Y,I] = min(interboutregion);
        
        indRealEnds(n)=allboutends(n)+I-1;
        
    end
    
    interboutregion= filteredDistance(allboutends(end):end);
    [Y,I] = min(interboutregion);
    
    indRealEnds(length(allboutstarts))=allboutends(end)+I-1;
    
    
    
else
    indRealEnds=[];
end
% allboutstarts=allboutstarts;
% allboutends=allboutends;
% indRealEnds=indRealEnds;


%test starts and ends of bouts
startBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
startBout(allboutstarts)=1;
endBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
endBout(allboutends)=1;
realEndBout=smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
realEndBout(indRealEnds)=1;



% figure
% %plot(cumFilteredSegmentAngle(indThisStimTypeStart2:indThisStimTypeEnd2))
% hold on
% plot(smootherTailCurveMeasure(indThisStimTypeStart2:indThisStimTypeEnd2),  'color', 'black')
% hold on
% plot(startBout,  'color', 'red','LineWidth',2)
% hold on
% plot(endBout,  'color', 'red','LineWidth',2)
% hold on
% plot(realEndBout, 'color', 'magenta','LineWidth',2)
% length(allboutstarts)
% pause



end