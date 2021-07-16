

AddFunctionToPath
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% load tail data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[FileName,PathName,~] = uigetfile;
pathFishName = strcat(PathName,FileName);

load(pathFishName)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% cat bouts manually %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stimNumber = BoutInfAll(:,EnumeratorBoutInf.stimNumber);
numberOfBoutInStim  = BoutInfAll(:,EnumeratorBoutInf.numberOfBoutInStim);
dataSetNumber = BoutInfAll(:,EnumeratorBoutInf.dataSetNumber);
previousStimNumber = BoutInfAll(: ,EnumeratorBoutInf.previousStimNumber);


boutMaxAngularSpeedAll = BoutKinematicParametersAll(:,EnumeratorBoutUsedKinPar.boutMaxAngularSpeed);
meanTailChangeMaxAll  = BoutKinematicParametersAll(:,EnumeratorBoutUsedKinPar.meanTailChangeMax);
boutAmplitude7MaxAll  = BoutKinematicParametersAll(:,EnumeratorBoutUsedKinPar.boutAmplitude7Max);


%%
%%%%%%%%%%%%%%%%%%%%%%%% Pick escapes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Escapes
indPreviousStim = find(previousStimNumber == 0);
indFirstBouts = find(numberOfBoutInStim == 1);
indEscapeDataSet = find(dataSetNumber == EnumeratorDataSet.LightFlashAcousticStartle1);
indHighMaxAngularSpeed = find(boutMaxAngularSpeedAll > 15);


m=@intersect;
indEscapes1 = m(indEscapeDataSet,m(indPreviousStim,indFirstBouts));
indEscapes = m(indEscapes1,indHighMaxAngularSpeed);


%%
%%%%%%%%%%%%%%%%%%%%%%%% Pick O bends %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%O bends
% indPreviousStim = find(previousStimNumber == 0);
% indFirstBouts = find(numberOfBoutInStim == 1);
indObendDataSet1 = find(dataSetNumber == EnumeratorDataSet.LightDark3min2);
indObendDataSet2 = find(dataSetNumber == EnumeratorDataSet.LightDarkPrey3min2);

indObendDataSet = [indObendDataSet1' indObendDataSet2']';

indOBend = m(indObendDataSet,m(indPreviousStim,indFirstBouts));


%%
%%%%%%%%%%%%%%%%%%%%%%%% Pick turns %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indStim = find(stimNumber >= 7);% find all stims
indSpeed = find(dataSetNumber == EnumeratorDataSet.OMRSpeed5);
indTurnsAll = find(meanTailChangeMaxAll > 5);


m=@intersect;
indTurns = m(indSpeed,m(indStim,indTurnsAll));
% indTurns = intersect(indSpeed, indTurnsAll);



%%
%%%%%%%%%%%%%%%%%%%%%%%% slow swims %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%slow swims
indSpeed = find(dataSetNumber == EnumeratorDataSet.OMRSpeed5);
indStim = find(stimNumber >= 7);% find all stims
indForwardAll = find(meanTailChangeMaxAll < 5);
indSlowAll = find(boutMaxAngularSpeedAll < 5);

m=@intersect;
indSlowBouts = m(indSpeed,m(indStim,m(indForwardAll,indSlowAll)));



%%
%%%%%%%%%%%%%%%%%%%%%%%% fast swims %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indSpeed = find(dataSetNumber == EnumeratorDataSet.OMRSpeed5);
indStim = find(stimNumber >= 7);% find all stims
indForwardAll = find(meanTailChangeMaxAll < 5);
indFastAll = find(boutMaxAngularSpeedAll > 5);

m=@intersect;
indFastBouts = m(indSpeed,m(indStim,m(indForwardAll,indFastAll)));

%%
% %%%%%%%%%%%%%% look at picked bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %test escapes
% maxTailChangeMaxEscapes  =  BoutKinematicParametersAll(indEscapes  ,EnumeratorBoutUsedKinPar.maxTailChangeMax);
% boutMaxAngularSpeedEscapes =  BoutKinematicParametersAll(indEscapes ,EnumeratorBoutUsedKinPar.boutMaxAngularSpeed);
% boutAmplitude7MaxEscapes =  BoutKinematicParametersAll(indEscapes ,EnumeratorBoutUsedKinPar.boutAmplitude7Max);
% boutMaxAngleEscapes = abs(BoutKinematicParametersAll(indEscapes ,EnumeratorBoutUsedKinPar.boutMaxAngle));
% 
% hold on
% plot3(boutAmplitude7MaxEscapes,maxTailChangeMaxEscapes,boutMaxAngularSpeedEscapes, 'ro')
% axis([-300 300 0 20 0 40])
% 
% %test O bends
% maxTailChangeMaxOBends  =  BoutKinematicParametersAll(indOBend  ,EnumeratorBoutUsedKinPar.maxTailChangeMax);
% boutMaxAngularSpeedOBends =  BoutKinematicParametersAll(indOBend ,EnumeratorBoutUsedKinPar.boutMaxAngularSpeed);
% boutAmplitude7MaxOBends =  BoutKinematicParametersAll(indOBend ,EnumeratorBoutUsedKinPar.boutAmplitude7Max);
% boutMaxAngleOBends = abs(BoutKinematicParametersAll(indOBend ,EnumeratorBoutUsedKinPar.boutMaxAngle));
% 
% plot3(boutAmplitude7MaxOBends,maxTailChangeMaxOBends,boutMaxAngularSpeedOBends, 'co')
% axis([-300 300 0 20 0 40])
% 
% 
% %test turns
% maxTailChangeMaxTurns  =  BoutKinematicParametersAll(indTurns  ,EnumeratorBoutUsedKinPar.maxTailChangeMax);
% boutMaxAngularSpeedTurns =  BoutKinematicParametersAll(indTurns ,EnumeratorBoutUsedKinPar.boutMaxAngularSpeed);
% boutAmplitude7MaxTurns =  BoutKinematicParametersAll(indTurns ,EnumeratorBoutUsedKinPar.boutAmplitude7Max);
% 
% boutMaxAngleTurns = abs(BoutKinematicParametersAll(indTurns ,EnumeratorBoutUsedKinPar.boutMaxAngle));
% 
% plot3(boutAmplitude7MaxTurns,maxTailChangeMaxTurns,boutMaxAngularSpeedTurns, 'go')
% axis([-300 300 0 20 0 40])
% 
% 
% %test slow swims
% maxTailChangeMaxSlow =  BoutKinematicParametersAll(indSlowBouts  ,EnumeratorBoutUsedKinPar.maxTailChangeMax);
% boutMaxAngularSpeedSlow =  BoutKinematicParametersAll(indSlowBouts ,EnumeratorBoutUsedKinPar.boutMaxAngularSpeed);
% boutAmplitude7MaxSlow =  BoutKinematicParametersAll(indSlowBouts ,EnumeratorBoutUsedKinPar.boutAmplitude7Max);
% boutMaxAngleSlow = abs(BoutKinematicParametersAll(indSlowBouts ,EnumeratorBoutUsedKinPar.boutMaxAngle));
% 
% plot3(boutAmplitude7MaxSlow,maxTailChangeMaxSlow,boutMaxAngularSpeedSlow, 'bo')
% axis([-300 300 0 20 0 40])
% 
% 
% %test fast swims
% maxTailChangeMaxFast =  BoutKinematicParametersAll(indFastBouts  ,EnumeratorBoutUsedKinPar.maxTailChangeMax);
% boutMaxAngularSpeedFast =  BoutKinematicParametersAll(indFastBouts ,EnumeratorBoutUsedKinPar.boutMaxAngularSpeed);
% boutMaxAngleFast = abs(BoutKinematicParametersAll(indFastBouts ,EnumeratorBoutUsedKinPar.boutMaxAngle));
% boutAmplitude7MaxFast =  BoutKinematicParametersAll(indFastBouts ,EnumeratorBoutUsedKinPar.boutAmplitude7Max);
% 
% 
% plot3(boutAmplitude7MaxFast,maxTailChangeMaxFast,boutMaxAngularSpeedFast, 'mo')
% axis([-300 300 0 20 0 40])
% 

indBouts = indTurns;


for nn = 1 : length(indBouts)
    
    


%%
    %%%%%%%%%%%%%%%%%%%% plot tail positions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
 tailDataThisBout = BoutRawDataAll(indBouts(nn)).tailData(:,1:8);
 xPos = BoutRawDataAll(indBouts(nn)).xPos;
 yPos = BoutRawDataAll(indBouts(nn)).yPos;
 realBodyAngles = BoutRawDataAll(indBouts(nn)).realBodyAngles;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% detect beats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
        %%%%%%% Interpolate data 10 times for beat kin %%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %interpolate data in time domain

        %create x - frames in real data
        x = 1:1:length(tailDataThisBout);

        %create xi - parts of frames to interpolate
        xi = 1:0.1:length(tailDataThisBout);

        %interpolate tail data
        cumsumInterpolatedAngleByBout = zeros(length(xi), size(tailDataThisBout,2));

        for f = 1:size(tailDataThisBout,2)

    
        cumsumInterpolatedAngleByBout(:,f) = interp1(x,tailDataThisBout(:,f),xi, '*spline')';


        end





 [cumsum2DInterpolatedAngles,cumsumInterpolatedAnglesGray,indRealBoutStart,indRealBoutEnd,halfBeatStructure,numbBeats] = BeatDetector_20(cumsumInterpolatedAngleByBout,8);

if ~isnan(indRealBoutStart)
 
 indBeatAll = zeros(1, length(halfBeatStructure));
 
 for g  =  1 : length(halfBeatStructure)
     
halfBeatCMIndLenght = size(halfBeatStructure(g).halfBeatCMInd,1);
      
 indBeatAll(g) = halfBeatStructure(g).halfBeatCMInd(halfBeatCMIndLenght,2);
 
 
 
 
 end

 indBeats = ceil(indBeatAll/10);

 
 
 
%%
 %%%%%%%%%%%%%%%%%% normalize position of bout %%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 %start in point zero and tranform into mm
 xPosNorm = (xPos(1) - xPos)/19;
 yPosNorm = (yPos(1) - yPos)/19;
 
 %rotate position to start in angle zero
 [xPosRotated,yPosRotated] = rotate_matrix(xPosNorm,yPosNorm,90-realBodyAngles(1)*(180/pi));
 
 
%  plot(xPosNorm,yPosNorm)
%  hold on
%  plot(xPosRotated,yPosRotated,'color', 'red')
%make x - each semgent is 310uM


lengthTail = [0.310 0.310*2 0.310*3 0.310*4 0.310*5 0.310*6 0.310*7 0.310*8];
lengthTail  = fliplr(lengthTail);



xTail = zeros(size(tailDataThisBout,1),8);
yTail = zeros(size(tailDataThisBout,1),8);
 for n = 1 :1 : size(tailDataThisBout,1)
     
     for nnn = 1:8
     
         %calculate rho
          if nnn == 1
             Rho = -0.31;
             
          else
         
         [xTail(n,nnn),yTail(n,nnn)] = pol2cart(tailDataThisBout(n,nnn),Rho);
        
        
        % pause
          end
          
          %calculate length of tail - determine if pos is correct
%           dist(n) = sum(sqrt(power(xTail(n,:),2) + power(yTail(n,:),2)));
          
     end
 end
 
 
 
 cumsumXTail = cumsum(xTail(:,:),2);
 cumsumYTail = cumsum(yTail(:,:),2); 
 
 
 
 
 dispCumsumXTail = zeros(1,size(tailDataThisBout,1));
clf

col = jet(size(tailDataThisBout,1)*5);

kAll = zeros(size(tailDataThisBout,1),7);

 for n = 1 : 1 : size(tailDataThisBout,1)
%       subplot(2,2,2)
        hold on

         plot(cumsumXTail(n,:) + n/20,cumsumYTail(n,:) + 0, 'color',col(n*5,:), 'linewidth',2)
        
   
 axis equal    
 axis([-2 10 -2.2 2.2])   
 
%      pause
 
      
      
 end



 %%
 %%%%%%%%%%%% plot tail pos at beat max %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
 

%    for t = 1 : 1 : size(indBeats,2)  
%        
% % %%
% % %%%%%%%%%%%%%%% calculate sum of diffs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %      
% %        diffSumPosY = sum(diff(cumsumYTail(indBeats(t),:)));
%        
%        
%             plot(cumsumXTail(indBeats(t),:) + indBeats(t)/20,cumsumYTail(indBeats(t),:) + 0, 'color','k', 'linewidth', 2)
% %             title([diffSumPosY])
%             hold on
%             pause 
% 
% 
% 
% 
%    end
%  
 
%%
%%%%%%%%%%%%%%% plot cumsum tail %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
% subplot(2,2,1)
% plot(tailDataThisBout*180/pi)
% axis square
% axis([0 150 -150 150])
% % title([boutAngles(nn) boutDistX(nn) AThisBouts(nn) AUCThisBouts(nn)])
% hold on
% 
% 
% for t = 1 : 1 : size(indBeats,2)  
%        
%        
%            plot(indBeats(t),tailDataThisBout(indBeats(t),end)*180/pi, 'ok')
%      
%  
% end


% %%
% %%%%%%%%%%%%%%%%%%% calcualte first bending segment %%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maxDiffY = max(abs(diff(cumsumYTail(indBeats(t),:))));
% 
% %find first segment that has a bigger diff than half the max
% diffYThres = maxDiffY/2;
% indBendPos = find( maxDiffY >diffYThres,1,first);



set(gcf, 'color', 'none');
set(gca, 'color', 'none');



pause
end
end



