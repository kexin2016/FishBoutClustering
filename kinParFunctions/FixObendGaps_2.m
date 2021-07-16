

function [fixedSegmentAngles, errorListObends,totalNumberFrames] = FixObendGaps_Mike1(fixedSegmentAngles,chosenSegmentValues);

% hold off
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%test function%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
errorListObends=zeros(size(fixedSegmentAngles,1),1);
%  erasedSegmentAngle = chosenTailAngles; 

%%
totalLength=size(fixedSegmentAngles,1);
% errorList = zeros(1,size(erasedSegmentAngle,1));
totalNumberFrames=0;
%loop through each segment and fix when tail tracking fails
% size(sum(abs(fixedSegmentAngles')))
% size(chosenSegmentValues(:,2))
% 'prctile'

allTrackingFailurePoints=(sum(abs(fixedSegmentAngles'))==0)'|(chosenSegmentValues(:,2)<(min(100,prctile(chosenSegmentValues(:,2),1)*0.9)));

trackingFailureStarts=find(diff(allTrackingFailurePoints)==1)+1;
for i = 1 : length(trackingFailureStarts)
    clear xs
numberThisFix=1;
    xs(1)=-1;
    if  ((trackingFailureStarts(i)>2)&~(allTrackingFailurePoints(trackingFailureStarts(i)-2)))
    xs=[xs -2];
    end
    if  ((trackingFailureStarts(i)>3)&~(allTrackingFailurePoints(trackingFailureStarts(i)-3)))
    xs=[xs -3];
    end
    currentPoint=trackingFailureStarts(i);
    pointsAdded=0;
    while(pointsAdded<3)
        currentPoint=currentPoint+1;
        
        if (currentPoint<=totalLength)
            if (~allTrackingFailurePoints(currentPoint))
            xs=[xs currentPoint-trackingFailureStarts(i)];
            pointsAdded=pointsAdded+1;
            else
                totalNumberFrames=totalNumberFrames+1;
                numberThisFix=numberThisFix+1;
            end
       else
          break 
       end
    end
    
%     xs
%     numberThisFix
   
%     figure
if ((numberThisFix<10)&(pointsAdded>0))
%     subplot(1,2,1)
% hold off
%     plot(fixedSegmentAngles(trackingFailureStarts(i)-50:trackingFailureStarts(i)+50,:),'b')
%     hold on
    for whichseg=1:size(fixedSegmentAngles,2)
%         size(xs)
%         size(fixedSegmentAngles(xs+trackingFailureStarts(i),whichseg))
     polycoeffs = polyfit(xs',fixedSegmentAngles(xs+trackingFailureStarts(i),whichseg),2);
     fixedSegmentAngles(trackingFailureStarts(i):trackingFailureStarts(i)+numberThisFix-1,whichseg)=polyval(polycoeffs,[0:numberThisFix-1]);
    end
%     subplot(1,2,2)
%     hold off
%     plot(fixedSegmentAngles(trackingFailureStarts(i)-50:trackingFailureStarts(i)+50,:),'r')
%      clear xs
%      drawnow
%      pause
%     pause
end
    errorListObends(trackingFailureStarts(i):trackingFailureStarts(i)+numberThisFix-1)=numberThisFix;
end
    %%
    
% figure
% plot(erasedSegmentAngle(i))

%find tail traking mistake
% indTailErrors = erasedSegmentAngle(:,i) < -2;
% 
% 
% %%
% %     %%%%%%%%%%%%%case where -100 is at the end of vector%%%%%%%%%%%%%%%%%%%
% %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     if indTailErrors(end) == size(erasedSegmentAngle,1)
% %     
% %     indTailErrors(end) = [];
% %     
% %     
% %         
% %         
% %     end
%     %%
% %make vector with 1 as tracking mistakes
% trackingErrors=zeros(size(erasedSegmentAngle, 1),1);
% trackingErrors(indTailErrors) = 1;
% 
% 
% diffTrackingErrors = [diff(trackingErrors)' 0];
% 
% 
% %find start and end of errors
% indStartErrors = find(diffTrackingErrors == 1);
% indEndErrors = find(diffTrackingErrors == -1)+1;%so it's one ind after the error
% 
% 
% %%
% % %%%%%%%%%%%%case where -100 is at the end of vector%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % if  trackingErrors(end) == 1
% %     
% %     indEndErrors = length(trackingErrors);
% %     
% % end
% 
% 
% 
% %%
% 
% % length(indStartErrors)
% % length(indEndErrors)
% 
% % %test start and end of errors
% % startErrors=zeros(1,length(trackingErrors));
% % endErrors=zeros(1,length(trackingErrors));
% % 
% % startErrors(indStartErrors)=1;
% % endErrors(indEndErrors)=1;
% % 
% % 
% % figure
% % hold on
% % plot(erasedSegmentAngle(:,i), '.')
% % plot(trackingErrors*-100,'co')
% % plot(startErrors*-100,'go')
% % plot(endErrors*-100, 'mo')
% 
% %%%%%%If tracking failed at the end or begining erase that data%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% if ~isempty(indStartErrors)%avoid case where there are no errors
% if ~isempty(indEndErrors)%avoid case where there are no errors
%    
%     %find out if errors appear at the begining - there is no start
% if indEndErrors(1) <= indStartErrors(1)
%     
%     %erase all data in begining
%     erasedSegmentAngle(1:indEndErrors(1),i)=0;
%     
%     %erase cut error
%     indEndErrors(1)=NaN;
%    
%     
% end
% 
% if indEndErrors(end) <= indStartErrors(end)
%    
%     %cut all data in ending
%     
%     erasedSegmentAngle(indStartErrors(end):end,i)=0;
%     
%     %erase cut error
%     indStartErrors(end)=NaN;
% end 
% 
% %erase NaNs
% 
% indStartErrors=indStartErrors(~isnan(indStartErrors));
% indEndErrors= indEndErrors(~isnan(indEndErrors));
% 
% 
% 
% %%
% %%%%%%If tracking error is short fill the data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %there is no need to through away data when the tracking fails for a few
% %frames - thus we fill the gap with the average of the two points at the edges of the gap
% 
% %calculate error length
% % length(indStartErrors)
% % length(indEndErrors)
% 
% % indStartErrors(1)
% % indEndErrors(1)
% % indStartErrors(end)
% % indEndErrors(end)
% 
% errorLength=indEndErrors-indStartErrors;
% 
% %find events that are worth fixing
% fixThreshold=10;
% indStartFixableErrors = indStartErrors(errorLength<fixThreshold);
% indEndFixableErrors = indEndErrors(errorLength<fixThreshold);
% 
% %fix events by averaging value before and after
% if ~isempty(indStartFixableErrors)%case where there are no fixable errors
% 
%     %%MIKE here there was an error that the values before and after
%     %%a tracking error were also being replaced
% for ii=1:length(indStartFixableErrors)
% %     i
% %     
% %     indEndFixableErrors(ii)-indStartFixableErrors(ii)
% %     startpoint=max(indStartFixableErrors(ii)-10,1);
% %     subplot(1,2,1)
% %     plot( erasedSegmentAngle(startpoint:startpoint+20,:))
%      erasedSegmentAngle(indStartFixableErrors(ii)+1:indEndFixableErrors(ii)-1,i)=mean([erasedSegmentAngle((indStartFixableErrors(ii)),i) erasedSegmentAngle((indEndFixableErrors(ii)),i)]);
%      
% %     subplot(1,2,2)
% %     plot( erasedSegmentAngle(startpoint:startpoint+20,:))  
% %     pause
%      errorList(indStartFixableErrors(ii):indEndFixableErrors(ii))= indEndFixableErrors(ii)-indStartFixableErrors(ii);  
% end 
% 
% 
% end
% %plot(erasedSegmentAngle(:,i),'.g')
% 
% %%%%%%If tracking error is long make tag to exclude bout%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %find events that are worth fixing - when gap is smaller than 4 frames
% indStartUnfixableErrors = indStartErrors(errorLength>=fixThreshold);
% indEndUnfixableErrors=indEndErrors(errorLength>=fixThreshold);
% 
% %make vector with ones where error cannot be fixed because tracking failed
% %for too long
% 
% if ~isempty(indStartUnfixableErrors)%case where there are no unfixable errors
% 
% for iii=1:length(indStartUnfixableErrors)
%     
%     erasedSegmentAngle(indStartUnfixableErrors(iii):indEndUnfixableErrors(iii),i)=0;%unfixable frames turn to 0
%     errorList(indStartUnfixableErrors(iii):indEndUnfixableErrors(iii))=2;
%     
% end
% end
% 
% 
% end
% end
% end
% 
% numbFixedFrames = find(errorList == 1);
% numbeUnfixedFrames = find(errorList == 2);
% totalNumberFrames = length(errorList);