
%this function calculates the head yaw in degrees


function [maxDiffYaw,meanDiffYaw,minDiffYaw] = yawCalculator_4(boutBodyAngles)


% %test function
% for m=1:20
%     for n=1:length([StimTypeBoutsMultiFish(m).boutStructure])
% boutBodyAngles=StimTypeBoutsMultiFish(m).boutStructure(n).bodyAngles;
% 
% 


%%%%%%%%%%%%%%%%%%%%%%%normalize bout to zero%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subtract first value to the others

normalizedBodyAngles = boutBodyAngles(:) - boutBodyAngles(1);


%%%%%%%%%%%%%%%%%%%%%%%smooth data a little bit%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filteredBodyAngles=conv(normalizedBodyAngles,boxcarf(4),'same');

% %cumsum gives increasing thing - very strange!!!! - not using it
% cumsumFilteredBodyAngles=cumsum(filteredBodyAngles')';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%interpolate data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create x - frames in real data
%x=oneSegmentAngle*0;
x=1:1:length(filteredBodyAngles);

%create xi - parts of frames to interpolate
xi=1:0.1:length(filteredBodyAngles);

%interpolate
interpFilteredBodyAngles=interp1(x,filteredBodyAngles,xi, 'spline')';

%%%%%%%%%%%%%%find all mins and max%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find all max and mins in 6th segment
%needs find peaks function to work
allmaxes=findPeaks_1(interpFilteredBodyAngles);
allmins=-findPeaks_1(-interpFilteredBodyAngles);

allPotentialPeaks=allmaxes+allmins;

%%%%%%%%%%%%%%%%%%%%%%choose first beat%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%thresholds to determine what is true event 
%firstthresh=0.05;
%peaktopeak=0.05;
firstthresh = max(abs(interpFilteredBodyAngles))/10;
peaktopeak = abs((max(interpFilteredBodyAngles))+abs(min(interpFilteredBodyAngles)))/10;


%find first beat - 1st beat has to be bigger than 0.2 to destinguish from
%noise
firstTailbeatPosition=find(abs(allPotentialPeaks)>firstthresh,1,'first');

firstTailbeatValue = allPotentialPeaks(firstTailbeatPosition);

% %test first beat
% hold on
% plot(normalizedBodyAngles, '.')
% plot(filteredBodyAngles, 'ro')
% plot(xi, interpFilteredBodyAngles, 'g.')
% firstBeat = interpFilteredBodyAngles*0;
% firstBeat(firstTailbeatPosition) = interpFilteredBodyAngles(firstTailbeatPosition);
% plot(xi,firstBeat, 'co','LineWidth', 4)


allhalfbeatsMag=0;
allhalfbeatsPos=0;


if (~isempty(firstTailbeatPosition))%in the case it does not find anything

%Determine if 1sst beat starts with a max or a min - max is one, min is -1
minormax=sign(allPotentialPeaks(firstTailbeatPosition));

    %save first half beat
    allhalfbeatsMag(1)=allPotentialPeaks(firstTailbeatPosition);
    allhalfbeatsPos(1)=firstTailbeatPosition;
   
    %erase peaks before first
    allPotentialPeaks(1:firstTailbeatPosition)=0;

%     %test min and max found
%       hold on
%     plot(normalizedBodyAngles, '.')
%     plot(filteredBodyAngles, 'ro')
%     plot(xi, interpFilteredBodyAngles, 'g.')
%     plot(xi, allPotentialPeaks, 'bo','LineWidth', 4)
%     halfBeats = allPotentialPeaks*0;
%     halfBeats(allhalfbeatsPos) = allhalfbeatsMag;
%     plot(xi,halfBeats,'co','LineWidth', 4 )


for nnn=find(allPotentialPeaks)'%goes through all the reamining indexes of potential peaks

if (minormax>0)%1st peak was positive
   if  (allPotentialPeaks(nnn)>allhalfbeatsMag(end))%if second is beigger than the first use second
       allhalfbeatsMag(end)=allPotentialPeaks(nnn);
       allhalfbeatsPos(end)=nnn;
   else if (allhalfbeatsMag(end)-allPotentialPeaks(nnn)>peaktopeak)%new peak has to have a certain amplitude
       minormax=-1;% be in down
       allhalfbeatsMag(end+1)=allPotentialPeaks(nnn);%down peak is saved
       allhalfbeatsPos(end+1)=nnn;
       end
   end
   
else
    if  (allPotentialPeaks(nnn)<allhalfbeatsMag(end))
       allhalfbeatsMag(end)=allPotentialPeaks(nnn);
       allhalfbeatsPos(end)=nnn;
    else if  (-allhalfbeatsMag(end)+allPotentialPeaks(nnn)>peaktopeak)
       minormax=1;
       allhalfbeatsMag(end+1)=allPotentialPeaks(nnn);
       allhalfbeatsPos(end+1)=nnn;
        end
    end
end
end
%allhalfbeatsMag=allhalfbeatsMag(2:end);
%allhalfbeatsPos=allhalfbeatsPos(2:end)*0.1+0.9;%don't know why have to add 1!!!!

%     %test picked half beats
%     hold on
%     plot(normalizedBodyAngles, '.')
%     plot(filteredBodyAngles, 'ro')
%     plot(xi, interpFilteredBodyAngles, 'g.')
%     plot(xi, allPotentialPeaks, 'bo','LineWidth', 4)
%     halfBeats = allPotentialPeaks*0;
%     halfBeats(allhalfbeatsPos) = allhalfbeatsMag;
%     plot(xi,halfBeats,'co','LineWidth', 4 )   

% pause(0.1)
else
   maxDiffYaw=NaN;
   meanDiffYaw=NaN;
   minDiffYaw=NaN;
end

%%%%%%%%%%%yaw is defined as the largest amp o body angle%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  
   
    
    if ~isempty(max(abs(diff(allhalfbeatsMag))))%case when there is more than one event
        
    maxDiffYaw = max(abs(diff(allhalfbeatsMag)))*180/pi;
    meanDiffYaw = nanmean(abs(diff(allhalfbeatsMag)))*180/pi;
    minDiffYaw = min(abs(diff(allhalfbeatsMag)))*180/pi;
    
    else%case when there is only one event
        
    maxDiffYaw = max(abs(allhalfbeatsMag))*180/pi;  
    meanDiffYaw = nanmean(abs(allhalfbeatsMag))*180/pi;  
    minDiffYaw = min(abs(allhalfbeatsMag))*180/pi;  
    
    end




%     %test picked half beats
%     hold off
%     plot(normalizedBodyAngles, '.')
%     hold on
%     plot(filteredBodyAngles, 'ro')
%     plot(xi, interpFilteredBodyAngles, 'g.')
%     %plot(xi, allPotentialPeaks, 'bo','LineWidth', 4)
%     halfBeats = allPotentialPeaks*0;
%     halfBeats(allhalfbeatsPos) = allhalfbeatsMag;
%     plot(xi,halfBeats,'co','LineWidth', 4 )   
%     pause

    
    %     end
% end