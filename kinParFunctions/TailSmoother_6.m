%this function smoothes tail data so that it can used by bout detector



 function [smootherTailCurveMeasure] = TailSmoother_6(cumsumInterpFixedSegmentAngles,intPoints,makeplot,fps)


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%invert cumsum%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%invert cumsum

%testtailsmooth
smoothedCumsumInterpFixedSegmentAngles=cumsumInterpFixedSegmentAngles;
% size(cumsumInterpFixedSegmentAngles)
for n=2:size(cumsumInterpFixedSegmentAngles,2)-1;
    smoothedCumsumInterpFixedSegmentAngles(:,n)=mean(cumsumInterpFixedSegmentAngles(:,n-1:n+1)');
end
% size(smoothedCumsumInterpFixedSegmentAngles)

% interpFixedSegmentAngles = [smoothedCumsumInterpFixedSegmentAngles(:,1) diff(smoothedCumsumInterpFixedSegmentAngles')'];

% length(intPoints)
% size(diff(smoothedCumsumInterpFixedSegmentAngles))
% size(diff(cumsumInterpFixedSegmentAngles')')
% interpFixedSegmentAngles = [zeros(length(intPoints),1)'; diff(cumsumInterpFixedSegmentAngles)];
interpFixedSegmentAngles = [zeros(length(intPoints),1)'; unwrap(diff(smoothedCumsumInterpFixedSegmentAngles))];
%time x segment  

%%%%%%%%%%%%%%choose tail points with real data%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 realDataSegments = find(intPoints == 1,1, 'last');

 realSegmentAngles = interpFixedSegmentAngles(:,1:realDataSegments);




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Filter angles%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bcsize=10;
lsize=100;

filteredSegmentAngle = realSegmentAngles*0;
for n = 1 : (size(realSegmentAngles,2))
% 
%     filteredSegmentAngle(:,n) = conv(realSegmentAngles(:,n),ones(bcsize,1)/bcsize,'same')-conv(realSegmentAngles(:,n),ones(lsize,1)/lsize,'same');

% filteredSegmentAngle(:,n) = conv(realSegmentAngles(:,n),ones(bcsize,1)'/bcsize,'same');
filteredSegmentAngle(:,n) = realSegmentAngles(:,n);
if  (n==5)
figure
plot(realSegmentAngles(:,n),'b')
hold on
plot(filteredSegmentAngle(:,n),'r')
drawnow
end

end



% %test filteredSegmentAngle
% hold on
% plot(filteredSegmentAngle(:,6), 'color', 'k')
% plot(cumsumSegmentAngles(:,6), 'color', 'red')


%%

%%%%%%%%%%%%%%%%%%%%%%%%%make cumsum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%cumsum of filtereed angles
cumFilteredSegmentAngle = cumsum(filteredSegmentAngle')';


%%
%%%%%%%%%%%%%%%%%%%%%%%%%Calculate cumsum of cumsum%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Mike changed here and then changed back again

% cumFilteredSegmentAngle=cumsum(filteredSegmentAngle);
% superCumSegAngle = abs(cumFilteredSegmentAngle')';
superCumSegAngle = cumsum(abs(cumFilteredSegmentAngle)')';


%%
%%%%%%%%%%%%%%%%%%%%%%%%%Calculate tail curvature%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%it convolves all the segments in one
bcFilt=10;

tailCurveMeasure = conv(superCumSegAngle(:,end),boxcarf(bcFilt),'same');

%%
%%%%%%%%%%%%%%%%%%%%%%min max filter to smooth data%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%min filter decreases baseline
%max filter transforms max into plateau
smootherTailCurveMeasure = maxFilterFast(tailCurveMeasure(:,end),2) - minFilterFast(tailCurveMeasure(:,end),100);
% smootherTailCurveMeasure = tailCurveMeasure;
%%
%%%%%%%%%%%%%%%%%%% fix size bug of smootherTailCurveMeasure %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(smootherTailCurveMeasure) ~= length(cumsumInterpFixedSegmentAngles)


    smootherTailCurveMeasure(end) = [];
    
end
%%
if makeplot == 1
hold off
% %test smootherTailCurveMeasure
% figure
%plot(filteredSegmentAngle(:,6), 'color', 'cyan')
% plot(cumsumInterpFixedSegmentAngles(:,1:realDataSegments), 'color', 'red')
% plot(cumsumInterpFixedSegmentAngles(:,1:realDataSegments), 'color', 'red')
plot(smoothedCumsumInterpFixedSegmentAngles(:,1:realDataSegments), 'color', 'green')
hold on
% plot(interpFixedSegmentAngles(:,1:realDataSegments), 'color', 'magenta')

% plot(filteredSegmentAngle(:,1:realDataSegments), 'color', 'blue')
plot(cumFilteredSegmentAngle(:,1:realDataSegments), 'color', 'yellow')
plot(superCumSegAngle(:,1:realDataSegments), 'color', 'cyan')
plot(tailCurveMeasure, 'color', 'magenta')
plot(smootherTailCurveMeasure , 'color', 'k', 'linewidth', 2)
drawnow
% pause
end



