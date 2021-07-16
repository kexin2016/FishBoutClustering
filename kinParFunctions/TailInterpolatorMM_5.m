


%this function interpolates data so that the first segment is 0mm of tail and the last is x mm of tail
% it takes into account localization of segments between data sets
% needs boxcarf to work


%%



%  function [interpFixedSegmentAngles,xPerc,xi,intPoints] = TailInterpolatorMM_5(fixedSegmentAngles, pixelSize, tailLength,tailLengthToInterpolate, interpolationModel,tailStartCorrection)

    function [interpFixedSegmentAngles,xPerc,xi,intPoints] = TailInterpolatorMM_Mike3(fixedSegmentAngles, interpolationModel,xPerc)

%%
% %%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fixedSegmentAnglesThis = fixedSegmentAngles(:,1:numbSegments);
% 
% 
fixedSegmentAnglesThis = fixedSegmentAngles;
%%
        %%%%%%%%%%%%%smooths tail data but only a bit%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         clear smoothtail
% 
%         
%         smoothtail=fixedSegmentAnglesThis*0;
% 
%         for nn=1:size(fixedSegmentAnglesThis,2)
%              smoothtail(:,nn)=conv(fixedSegmentAnglesThis(:,nn),boxcarf(1),'same');
%         end

%         %test smoothing
%         hold on
%         plot(fixedSegmentAnglesThis(:,6),'.') 
%         plot(smoothtail(:,6), 'r.')

        %not smoothing data
        smoothtail = fixedSegmentAnglesThis;
        
        %%
        %%%%%%%%%%%%calculate cumSum%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %cumsumSmoothtail = cumsumSmoothtail;
        cumsumSmoothtail = cumsum(smoothtail')';
        
        
       
        
        %%
        %%%%%%%%%%%%% strange problem with nans %%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        indNan = find(isnan(cumsumSmoothtail));
        
        cumsumSmoothtail2 = cumsumSmoothtail;
        cumsumSmoothtail2(indNan) = 0;
        
       
        
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%interpolate tail data%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        xi = 310:310:3100;
        
%         xPerc
%         xi
%         size(cumsumSmoothtail')
        interpFixedSegmentAngles = interp1(xPerc,cumsumSmoothtail2',xi, interpolationModel)';
        
        
%         %%
%         
%          %test interpolation
%          for ii = 8000: size(smoothtail,1)
%              
%          hold off
%          plot(xPerc,cumsum(smoothtail(ii,:)))
%          hold on
%          plot(xi,interpFixedSegmentAngles(ii,:), 'ro')
%          axis([0 100 -1.5 1.5])
%          pause
%          
%          end

%%
%%%%%%%%%%make vector with segments interpolated%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1 is inside data
%0 is outside data

% lastValX = xPerc(end);
% indLastValX = find(xPerc == lastValX);
% 
% lastValXi = xi(indLastValX);
% 
% intPoints = xi.*0;
% intPoints(1:length(xi)) = 1;
% intPoints(indLastValX:end) = 0;
% 
% %check if last value is interpolates or ectrapolated
% if lastValX >= lastValXi
%     
%     intPoints(indLastValX) = 1;
%    
%     
% end



intPoints = ones(size(xi));
intPoints(xi>xPerc(end)) = 0;









