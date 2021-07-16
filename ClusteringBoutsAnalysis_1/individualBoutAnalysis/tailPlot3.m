

% AddFunctionToPath
% clear all 
% 
% close all

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% load tail data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [FileName,PathName,~] = uigetfile;
% pathFishName = strcat(PathName,FileName);

% load(pathFishName)
%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%% load tail data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% folder = 'C:\Joao analysis\FreeData\clusteringData\boutMap\finalMerged11\';
% filename = 'BoutMapWithRawCenters_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11.mat';
% 
% load(strcat(folder,filename));

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% cat bouts manually %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stimNumber = BoutInfFinalArray(:,EnumeratorBoutInf.stimNumber);
numberOfBoutInStim  = BoutInfFinalArray(:,EnumeratorBoutInf.numberOfBoutInStim);
dataSetNumber = BoutInfFinalArray(:,EnumeratorBoutInf.dataSetNumber);
previousStimNumber = BoutInfFinalArray(: ,EnumeratorBoutInf.previousStimNumber);


boutMaxAngularSpeedAll = BoutKinematicParametersFinalArray(:,EnumeratorBoutUsedKinPar.boutMaxAngularSpeed);
meanTailChangeMaxAll  = BoutKinematicParametersFinalArray(:,EnumeratorBoutUsedKinPar.meanTailChangeMax);
boutAmplitude7MaxAll  = BoutKinematicParametersFinalArray(:,EnumeratorBoutUsedKinPar.boutAmplitude7Max);

boutCat = BoutInfFinalArray(:, EnumeratorBoutInf.boutCat);

%%


idx = finalClustering.idx;

indThisBoutType = find(boutCat == idx(4));






for nn = 1 : length(indThisBoutType)
    
    


%%
    %%%%%%%%%%%%%%%%%%%% plot tail positions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%  tailDataThisBout = BoutRawDataAll(indBouts(nn)).tailData(:,1:8);
%  xPos = BoutRawDataAll(indBouts(nn)).xPos;
%  yPos = BoutRawDataAll(indBouts(nn)).yPos;
%  realBodyAngles = BoutRawDataAll(indBouts(nn)).realBodyAngles;
  

rawDataThisBout = FishDataMap(indBoutStartAllDataInFinalArray(indThisBoutType(nn)):indBoutEndAllDataInFinalArray(indThisBoutType(nn)),:);

%  tailDataThisBout = FishDataMap(indThisBoutType(nn), EnumeratorFishData.cumsumInterpFixedSegmentAngles);
 
 tailDataThisBout = rawDataThisBout(:,EnumeratorFishData.cumsumInterpFixedSegmentAngles);
  xPos = rawDataThisBout(:,EnumeratorFishData.xPos);
 yPos = rawDataThisBout(:,EnumeratorFishData.yPos);
 realBodyAngles = rawDataThisBout(:,EnumeratorFishData.realBodyAngles);

 
%  xPos = FishDataMap(indThisBoutType(nn), EnumeratorFishData.xPos);
%  yPos = FishDataMap(indThisBoutType(nn), EnumeratorFishData.yPos);
%  realBodyAngles = FishDataMap(indThisBoutType(nn), EnumeratorFishData.realBodyAngles);
% 

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





