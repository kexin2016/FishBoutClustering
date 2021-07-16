

 function [fixedSegmentAngles,errorListAllMitakes,errorListNotFixedMistakes] = FixTailTrackingGaps_2(chosenTailAngles)


%arror lists
errorListAllMitakes = zeros(size(chosenTailAngles,1),size(chosenTailAngles,2));
errorListNotFixedMistakes = zeros(size(chosenTailAngles,1),size(chosenTailAngles,2));

% errorList =  zeros(size(chosenTailAngles,1),size(chosenTailAngles,2));

%loop through each segment and fix when tail tracking fails
for i = 1 : size(chosenTailAngles,2)
    
   
    %%
    %%%%%%% find for each segment tail traking failure %%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    indTailErrors = chosenTailAngles(:,i) < -2;
    
    
    %make vector with 1 as tracking mistakes
    trackingErrors=zeros(size(chosenTailAngles, 1),1);
    trackingErrors(indTailErrors) = 1;



    diffTrackingErrors = [diff(trackingErrors)' 0];


    %find start and end of errors
    indStartErrors = find(diffTrackingErrors == 1);
    indEndErrors = find(diffTrackingErrors == -1)+1;%so it's one ind after the error
    
    
%     %test start and end of errors
%     startErrors=zeros(1,length(trackingErrors));
%     endErrors=zeros(1,length(trackingErrors));
% 
%     startErrors(indStartErrors)=1;
%     endErrors(indEndErrors)=1;
% 
% 
%     clf
%     hold on
%     plot(chosenTailAngles(:,i), '.')
%     plot(trackingErrors*-100,'co')
%     plot(startErrors*-100,'go')
%     plot(endErrors*-100, 'mo')
%     title(i)
%     pause

if ~isempty(indStartErrors)%avoid case where there are no errors
if ~isempty(indEndErrors)%avoid case where there are no errors
    
    %%
    %%%%%%%%%%%%%%% if errors are in the begining or end %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        %find out if errors appear at the begining - there is no start
if indEndErrors(1) <= indStartErrors(1)
    
    %erase all data in begining
    chosenTailAngles(1:indEndErrors(1),i)=0;
    
    %erase cut error
    indEndErrors(1)=NaN;
   
    
end

if indEndErrors(end) <= indStartErrors(end)
   
    %cut all data in ending
    
    chosenTailAngles(indStartErrors(end):end,i)=0;
    
    %erase cut error
    indStartErrors(end)=NaN;
end 

%erase NaNs

indStartErrors=indStartErrors(~isnan(indStartErrors));
indEndErrors= indEndErrors(~isnan(indEndErrors));

%%
%%%%%%If tracking error is short fill the data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%there is no need to through away data when the tracking fails for a few
%frames - thus we fill the gap with the average of the two points at the edges of the gap
errorLength=indEndErrors-indStartErrors;

%find events that are worth fixing
fixThreshold=10;
indStartFixableErrors = indStartErrors(errorLength <= fixThreshold);
indEndFixableErrors = indEndErrors(errorLength <= fixThreshold);

%fix events by averaging value before and after
if ~isempty(indStartFixableErrors)%case where there are no fixable errors

for ii=1:length(indStartFixableErrors)
    
     chosenTailAngles(indStartFixableErrors(ii)+1:indEndFixableErrors(ii)-1,i)=mean([chosenTailAngles((indStartFixableErrors(ii)),i) chosenTailAngles((indEndFixableErrors(ii)),i)]);
%      errorList(indStartFixableErrors(ii):indEndFixableErrors(ii))=-1;  
     
%      errorList(indStartFixableErrors(ii)+1:indEndFixableErrors(ii)-1,i)= indEndFixableErrors(ii)-indStartFixableErrors(ii);  

     errorListAllMitakes(indStartFixableErrors(ii)+1:indEndFixableErrors(ii)-1,i)= indEndFixableErrors(ii)-indStartFixableErrors(ii);  
     errorListNotFixedMistakes(indStartFixableErrors(ii)+1:indEndFixableErrors(ii)-1,i) = 0; 
     
    
end 


end

%%
%%%%%%If tracking error is long make tag to exclude bout%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find events that are worth fixing - when gap is smaller than 4 frames
indStartUnfixableErrors = indStartErrors(errorLength > fixThreshold);
indEndUnfixableErrors=indEndErrors(errorLength > fixThreshold);

%make vector with ones where error cannot be fixed because tracking failed
%for too long

if ~isempty(indStartUnfixableErrors)%case where there are no unfixable errors

for iii=1:length(indStartUnfixableErrors)
    
    chosenTailAngles(indStartUnfixableErrors(iii):indEndUnfixableErrors(iii),i) = 0;%unfixable frames turn to 0
     
%      errorList(indStartUnfixableErrors(ii)+1:indEndUnfixableErrors(ii)-1,i)= indEndFixableErrors(ii)-indStartFixableErrors(ii);  

    errorListAllMitakes(indStartUnfixableErrors(iii)+1:indEndUnfixableErrors(iii)-1,i)= indEndUnfixableErrors(iii)-indStartUnfixableErrors(iii);  
    errorListNotFixedMistakes(indStartUnfixableErrors(iii)+1:indEndUnfixableErrors(iii)-1,i) = -1; 
    
end

end
    
end%no errors
end%no errors


end%loop through each segment


%%
%%% make lists 10 segment length so that they can be sabed in structure %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if size(errorListAllMitakes,2) ~= 10
    
    if size(errorListAllMitakes,2) <= 10
        
      minusTag = zeros(size(errorListAllMitakes,1),10 - size(errorListAllMitakes,2)) -1;
                 
      errorListAllMitakes = [errorListAllMitakes minusTag];  
      errorListNotFixedMistakes  = [errorListNotFixedMistakes minusTag];
      
    else

        
     errorListAllMitakes = errorListAllMitakes(:,1:10) ; 
     errorListNotFixedMistakes = errorListNotFixedMistakes(:,1:10) ;   
     
     
     
    end
    
end

fixedSegmentAngles = chosenTailAngles;


% %test list of fixable and unfixable mistakes
% plot(errorListAllMitakes(:,9)','color','k')
% 
% hold on
% plot(errorListNotFixedMistakes(:,9)','color','r')


