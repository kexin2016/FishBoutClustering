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


function [allboutstarts,allboutends] = BoutDetectorCurvatureFunction(smoothedTailCurvature,fs,indThisStimTypeStart,indThisStimTypeEnd)
% %test function variables
% close all;
%  nnn=5;


%  indThisStimTypeStart2=indThisStimTypeStart(5)
%  indThisStimTypeEnd2=indThisStimTypeEnd(5)

%%%%%%%%%%%%%%%%%%%%%%%%Find bouts by threshold%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxData=max(smoothedTailCurvature);
%
% [b,a] = butter(4,3/(fs*100/2),'high');
% smoothedTailCurvature = filtfilt(b,a,smoothedTailCurvature');
% smoothedTailCurvature=smoothedTailCurvature';
%%
%%%%%%%%%%%%%%%%%%%%% define threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gm = fitgmdist(row2col(smoothedTailCurvature,1),2);
[~,idx] = min(gm.ComponentProportion);
threshold = max(0.05,gm.mu(idx)-gm.Sigma(idx)*2);
% threshold based on percentile - works prey capture
% threshold=max(prctile(smoothedTailCurvature,75),1.5);
% threshold = prctile(smoothedTailCurvature,75);
% if (threshold > 2)
%     threshold=2;
% end

%%
%  threshold=0.1;
%
%%


%threshold on filtered movement for end of bout detection
endThresh=0.025;

allBouts=find(diff((abs(smoothedTailCurvature)>threshold)));
allboutstarts_1=allBouts(1:2:end);
allboutends_1=allBouts(2:2:end);
allboutstarts_1 = allboutstarts_1(1:min(length(allboutstarts_1),length(allboutends_1)));
allboutends_1 = allboutends_1(1:min(length(allboutstarts_1),length(allboutends_1)));


allboutstarts_2=allBouts(2:2:end);
allboutends_2=allBouts(3:2:end);
allboutstarts_2=allboutstarts_2(1:min(length(allboutstarts_2),length(allboutends_2)));
allboutends_2=allboutends_2(1:min(length(allboutstarts_2),length(allboutends_2)));

if median(allboutends_1 - allboutstarts_1)>median(allboutends_2 - allboutstarts_2)
    allboutstarts = allboutstarts_2;
    allboutends = allboutends_2;
else
    allboutstarts = allboutstarts_1;
    allboutends = allboutends_1;
end



% %test starts and ends of bouts
% % startBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% startBout(allboutstarts)=1;
% % endBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% endBout(allboutends)=1;
% 
% figure
% plot(smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2), '.', 'color', 'black')
% hold on
% plot(startBout,'o','color', 'green','LineWidth',2)
% hold on
% plot(endBout, 'o', 'color', 'red','LineWidth',2)


%%%%%%%%%%%%%%%%%%%%%%%%add bouts that are near%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
minimuminterboutinterval=400/fs/100;
% minimuminterboutinterval=2;
while (1==1)
    allinterboutlengths=allboutstarts(2:end)-allboutends(1:end-1);%calculate inter bout lengths
    if ~isempty(find(allinterboutlengths<minimuminterboutinterval, 1))%if there are bouts that are near
        shortinterval= find(allinterboutlengths<minimuminterboutinterval,1);
        
        if (shortinterval<length(allboutstarts-2))
            allboutstarts=[row2col(allboutstarts(1:shortinterval),1);row2col(allboutstarts(shortinterval+2:end),1)];
        else
            allboutstarts=allboutstarts(1:shortinterval);
        end
        if (shortinterval>=1)
            allboutends=[row2col(allboutends(1:shortinterval-1),1);row2col(allboutends(shortinterval+1:end),1)];
        else
            allboutends=allboutends(2:end);
        end
    else
        break
    end
    
end



%%

% %test starts and ends of bouts
% startBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% startBout(allboutstarts)=1;
% endBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% endBout(allboutends)=1;
%
% figure
% plot(smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2), '.', 'color', 'black')
% hold on
% plot(startBout,'o','color', 'green','LineWidth',2)
% hold on
% plot(endBout, 'o', 'color', 'red','LineWidth',2)


%%%%%%%%%%%%%%%%%%%%%%%%erase bouts that are too short%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


minimumboutlength=2;

newallboutstarts=allboutstarts(find((allboutends-allboutstarts)>minimumboutlength));
newallboutends=allboutends(find((allboutends-allboutstarts)>minimumboutlength));
allboutstarts=newallboutstarts;
allboutends=newallboutends;



% allboutstarts(allboutstarts>14)=allboutstarts(allboutstarts>14)-14;
% allboutstarts(allboutstarts<15)=1;
% %test starts and ends of bouts
% startBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% startBout(allboutstarts)=1;
% endBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% endBout(allboutends)=1;
%
% figure
% plot(smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2), '.', 'color', 'black')
% hold on
% plot(startBout,'o','color', 'green','LineWidth',2)
% hold on
% plot(endBout, 'o', 'color', 'red','LineWidth',2)


%%%%%%%%%%%%%%%%%%%erase bouts that have low max curvature%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%erase bouts with small curvature%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isempty(allboutstarts)%avoid cases when it does not pick any bout
%     minimummaxcurvature=max(0.05,gm.mu(idx)+gm.Sigma(idx)*2);
    minimummaxcurvature=0.05;
    goodstarts=ones(size(allboutstarts));
    curvatureBlock=smoothedTailCurvature;
    for n=1:length(allboutstarts)
        if (max(curvatureBlock(allboutstarts(n):allboutends(n)))<minimummaxcurvature)
            goodstarts(n)=0;
        end
    end
    allboutstarts=allboutstarts(find(goodstarts));
    allboutends=allboutends(find(goodstarts));
end    



%     
%     % %test starts and ends of bouts
%     % startBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
%     % startBout(allboutstarts)=1;
%     % endBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
%     % endBout(allboutends)=1;
%     %
%     % figure
%     % plot(cumFilteredSegmentAngle(indThisStimTypeStart2:indThisStimTypeEnd2))
%     % hold on
%     % plot(smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2), '.', 'color', 'black')
%     % hold on
%     % plot(startBout,'o','color', 'green','LineWidth',2)
%     % hold on
%     % plot(endBout, 'o', 'color', 'red','LineWidth',2)
%     
%     
%     
%     %%%%%%%%%%%%%%%%%Pick end of bout by min distance%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % indRealEnds=allboutstarts*0;
%     %
%     % for n=1:length(allboutstarts)-1
%     %    interboutregion= filteredDistance(allboutends(n):allboutstarts(n+1)-1);
%     %    [Y,I] = min(interboutregion);
%     %    I;
%     %    I2=find(interboutregion<endThresh,1,'first');
%     %    if (~isempty(I2))
%     %            indRealEnds(n)=allboutends(n)+min(I,I2)-1;
%     %    else
%     %            indRealEnds(n)=allboutends(n)+I-1;
%     %
%     %    end
%     % end
%     %
%     %  interboutregion= filteredDistance(allboutends(end):end);
%     %    [Y,I] = min(interboutregion);
%     %
%     %    I2=find(interboutregion<endThresh,1,'first');
%     %    if (~isempty(I2))
%     %            indRealEnds(length(allboutstarts))=allboutends(length(allboutstarts))+min(I,I2)-1;
%     %    else
%     %
%     %            indRealEnds(length(allboutstarts))=allboutends(length(allboutstarts))+I-1;
%     %    end
% else
%     indRealEnds=[];
% end
% allboutstarts=allboutstarts;
% allboutends=allboutends;
% indRealEnds=indRealEnds;


%test starts and ends of bouts
% startBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% startBout(allboutstarts)=1;
% endBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% endBout(allboutends)=1;
% realEndBout=smoothedTailCurvature(indThisStimTypeStart2:indThisStimTypeEnd2)*0;
% realEndBout(indRealEnds)=1;



% figure
% %plot(cumFilteredSegmentAngle(indThisStimTypeStart2:indThisStimTypeEnd2))
% hold on
% plot(smoothedTailCurvature,  'color', 'black')
% hold on
% plot(startBout,  'color', 'green','LineWidth',2)
% hold on
% plot(endBout,  'color', 'red','LineWidth',2)
% hold on
% plot(realEndBout, 'color', 'magenta','LineWidth',2)
% length(allboutstarts)
% % pause



end