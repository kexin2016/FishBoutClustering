     function [C1Angle,C1Duration,C1MaxAngularSpeed,C2Angle,C2Duration,C2MaxAngularSpeed] = C1C2Calculator_5(halfBeatStructure,interpBodyAngles)

% interpBodyAngles = interpBodyAnglesLessSmooth2;
%%
%%%%%%%%%%%%%%% calcualte C1 parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indBeatStart = zeros(1,length(halfBeatStructure));
indBeatEnd = zeros(1,length(halfBeatStructure));
indPeaksCorr = zeros(1, length(indBeatStart));
indPeak = zeros(1, length(indBeatStart));

upDown = [halfBeatStructure.upDown];



        for i = 1:length(halfBeatStructure)
            
            
        
%              i=2   
        halfBeatInd = halfBeatStructure(i).halfBeatInd;
        firstDetectedSegment = min(halfBeatInd(:,1));
        
        
        %don't use beats with very caudal segments
        if firstDetectedSegment <= 4

        indBeatFirstSegment = find(halfBeatInd(:,1) == firstDetectedSegment);
        indBeatSecondSegment = find(halfBeatInd(:,1) == firstDetectedSegment+2);%don't know what does to put 2 instead of 3....!!!
%         indBeatSecondSegment = find(halfBeatInd(:,1) == firstDetectedSegment+3);%previously

        if ~isempty(indBeatSecondSegment) && ~isempty(indBeatFirstSegment)

        indBeatStart(i) = halfBeatInd(indBeatFirstSegment(1),2);
        indBeatEnd(i) = halfBeatInd(indBeatSecondSegment(end),2);
        
        %case where ind and starts don't match
        if indBeatStart(i) < indBeatEnd(i)
        
        if upDown(i) == 1%up beat
            
        [~,indPeak(i)] = max(interpBodyAngles(indBeatStart(i):indBeatEnd(i)));
        indPeaksCorr(i) = indBeatStart(i) + indPeak(i);   
     
        
        else%down beat 
         
        [~,indPeak(i)] = min(interpBodyAngles(indBeatStart(i):indBeatEnd(i)));
        indPeaksCorr(i) = indBeatStart(i) + indPeak(i);    
         
        

        end
        
        else
        
        indBeatStart(i) = NaN;
        indBeatEnd(i) = NaN;
        indPeaksCorr(i)  = NaN;
        indPeak(i) = NaN;   
        
        end
        
        else
            
        indBeatStart(i) = NaN;
        indBeatEnd(i) = NaN;
        indPeaksCorr(i)  = NaN;
        indPeak(i) = NaN;
        end
        
        else
        indBeatStart(i) = NaN;
        indBeatEnd(i) = NaN;
        indPeaksCorr(i)  = NaN;
        indPeak(i) = NaN;
        end
        end
        
        
         
        %erase nans
        indPeak(isnan(indBeatStart)) = [];
        upDown(isnan(indBeatStart)) = [];
        indBeatStart(isnan(indBeatStart)) = [];
        indBeatEnd(isnan(indBeatEnd)) = [];
        indPeaksCorr(isnan(indPeaksCorr)) = [];
        
        
  if ~isempty(indPeaksCorr)
      
       indIntC1 = indPeaksCorr(1);
       
       
  else
    
      indIntC1 = NaN;
      indIntC2 = NaN;
      
  end
  
  if length(indPeaksCorr) >= 2
  
       indIntC2 = indPeaksCorr(2);
       
       
  
  else
      
      
      indIntC2 = NaN;
      
  end
    
%   %strange case where C1 = C2
%   if indIntC1 == indIntC2 
%      
%       indPeak(1) = [];
%       upDown(1) = [];
%       indBeatStart(1) = [];
%       indBeatEnd(1) = [];
%       indPeaksCorr(1) = [];
%       
%       
%       indIntC1 = indPeaksCorr(1);
%       indIntC2 = indPeaksCorr(2);
%       
%   end
  
  %%
        %%%%%%%%%%%%%% problem with C2 being befor C1 %%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %This may not be the best way to do it - I'm now pickng the middle ind !!!! Think about it
        
        if indIntC2 <= indIntC1
            
            
            indIntC1 = NaN;
            indIntC2  = NaN;
            
            indPeak = NaN;
            upDown = NaN;
            indBeatStart = NaN;
            indBeatEnd = NaN;
            indPeaksCorr = NaN;
        
            
%             if upDown(2) == 1%up beat
%                 
%                 C2Inds = indBeatStart(2):indBeatEnd(2);
%                 
%                 indMiddle = round(length(C2Inds)/2);
%                 
% %                 indPeak(2) = C2Inds(indMiddle);
%                 
% %                  [~,indPeak(2)] = max(interpBodyAngles(C2Inds));
%                  indPeaksCorr(2) = indMiddle;   
%                 
%             else
%                  C2Inds = indBeatStart(2):indBeatEnd(2);
%                 
%                 indMiddle = round(length(C2Inds)/2);   
%                 
%             end
%             
%             indIntC2 = indPeaksCorr(2);
        end
        
        
       %%
       %%%%%%%%%%%%% calculate accurate indIntC1 start %%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
%        startAmp = cumsumInterpolatedAnglesGray(1,i);
       
       %%
       %%%%%%%%%%%%%% calculate C1 kin parameters %%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
       interpBodyAnglesNorm = interpBodyAngles-interpBodyAngles(1);
       
       if ~isnan(indIntC1)
    
        C1Angle = interpBodyAnglesNorm(indIntC1)*180/pi;
        C1Duration = (indIntC1-indBeatStart(1))/7;
        C1MaxAngularSpeed = max(abs(diff(interpBodyAnglesNorm(indBeatStart(1):indIntC1))))*(180/pi)/0.14;%deg per ms

       else
    
        C1Angle = NaN;
        C1Duration = NaN;
        C1MaxAngularSpeed = NaN; 

       end
       
       
       %%
%%%%%%%%%%%%%%% calcualte C2 parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ~isnan(indIntC2)  && ~isnan(indIntC1)
    
        C2Angle = (abs(interpBodyAnglesNorm(indIntC1)) + abs(interpBodyAnglesNorm(indIntC2)))*180/pi;%degrees
        C2Duration = (indIntC2 - indIntC1)/7;
        C2MaxAngularSpeed = max(abs(diff(interpBodyAnglesNorm(indIntC1:indIntC2))))*(180/pi)/0.14;%deg per ms

        else
    
        C2Angle = NaN;    
        C2Duration = NaN;
        C2MaxAngularSpeed = NaN;
        
        
        end
       
        
        
        
        
         %%
%        %%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        
% clf
% col = jet(length(indBeatStart));
% plot(interpBodyAngles-interpBodyAngles(1),'ok')
% hold on   
%   for i = 1 : length(indBeatStart)
%         
%       if upDown(i) == 1
%       hold on
%         plot(indBeatStart(i):indBeatEnd(i),(interpBodyAngles(indBeatStart(i):indBeatEnd(i))-i/10)-interpBodyAngles(1), 'color',col(i,:),'linewidth',2)
%         plot(indPeaksCorr(i),interpBodyAngles(indPeaksCorr(i))-interpBodyAngles(1)-i/10,'oc', 'linewidth',5)
%         plot(indPeaksCorr(i),interpBodyAngles(indPeaksCorr(i))-interpBodyAngles(1),'oc', 'linewidth',5)
% 
%         
%       else
%       hold on
%         plot(indBeatStart(i):indBeatEnd(i),(interpBodyAngles(indBeatStart(i):indBeatEnd(i))-i/10)-interpBodyAngles(1), 'color',col(i,:),'linewidth',2)
%         plot(indPeaksCorr(i),interpBodyAngles(indPeaksCorr(i))-interpBodyAngles(1)-i/10,'om', 'linewidth',5)
%         plot(indPeaksCorr(i),interpBodyAngles(indPeaksCorr(i))-interpBodyAngles(1),'om', 'linewidth',5)
%     
%       end
% %       pause
%   end
%   pause