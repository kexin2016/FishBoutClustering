% clear all
% close all
% 
%%
%%%%%%%%%%%% load bout map with raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')

%%
%%%%%%%%%%%%% put bout map into space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get vars out of structure
meanAllVar = behavioralSpaceStructure.meanAllVar;
stdAllVar = behavioralSpaceStructure.stdAllVar;
COEFF = behavioralSpaceStructure.COEFF;
latent = behavioralSpaceStructure.latent;
maxKinPars = behavioralSpaceStructure.maxKinPars;
indKinPars = behavioralSpaceStructure.indKinPars;
meanPCASpace = behavioralSpaceStructure.meanPCASpace;

%%
%%%%%%%%%%%%%%% pick kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %26 + 1st beat kin pars + 2nd beat kin pars + 3rd beat kin pars
indKinParsBoutHeading = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed...
EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle...
EnumeratorBoutKinPar.boutDistanceY EnumeratorBoutKinPar.boutSpeedY...   
EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C1MaxAngularSpeed EnumeratorBoutKinPar.C2MaxAngularSpeed...
EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration];
 
indKinParsBoutTail = [EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max...
EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max EnumeratorBoutKinPar.boutAmplitude5Max...
EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max...
EnumeratorBoutKinPar.maxBoutFreqCorr EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax...
EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.boutDuration];
    

indKinPars1stHalfBeatHeading  = [EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle...
EnumeratorBoutKinPar.beat1beatMaxAngularSpeed EnumeratorBoutKinPar.beat1beatDistanceX EnumeratorBoutKinPar.beat1beatDistanceY...
EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY];    

indKinPars1stHalfBeatTail  = [EnumeratorBoutKinPar.beat1beatAmplitude1...
EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4...
EnumeratorBoutKinPar.beat1beatAmplitude5 EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7...
EnumeratorBoutKinPar.beat1maxTailChange EnumeratorBoutKinPar.beat1beatDuration];
    
indKinPars2ndHalfBeatHeading = [EnumeratorBoutKinPar.beat2beatAngle...
EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed...
EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX...
EnumeratorBoutKinPar.beat2beatSpeedY];

indKinPars2ndHalfBeatTail = [EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2...
EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7 EnumeratorBoutKinPar.beat2maxTailChange...
EnumeratorBoutKinPar.beat2beatDuration];

indKinPars3rdHalfBeatHeading = [EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX...
EnumeratorBoutKinPar.beat3beatSpeedY];
    
indKinPars3rdHalfBeatTail = [EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 ...
EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3maxTailChange...
EnumeratorBoutKinPar.beat3beatDuration];

indKinParsBoutHeadingNames = {'boutMaxAngularSpeed','boutAvrAngularSpeed'...
,'headMaxYaw','headMeanYaw','boutMaxAngle','boutAngle'...
,'boutDistanceY','boutSpeedY'...   
,'C1Angle','C2Angle','C1MaxAngularSpeed','C2MaxAngularSpeed'...
,'C1Duration','C2Duration'};
 
indKinParsBoutTailNames = {'boutAmplitude1Max ','boutAmplitude2Max'...
,'boutAmplitude3Max' ,'boutAmplitude4Max ','boutAmplitude5Max'...
,'boutAmplitude6Max','boutAmplitude7Max'...
,'maxBoutFreqCorr','maxTailChangeMax','meanTailChangeMax'...
,'boutAmplitudeDiff','boutDuration'};
    

indKinPars1stHalfBeatHeadingNames  = {'beat1beatAngle','beat1beatMaxAngle'...
,'beat1beatMaxAngularSpeed ','beat1beatDistanceX ','beat1beatDistanceY'...
,'beat1beatSpeedX ','beat1beatSpeedY '};    

indKinPars1stHalfBeatTailNames  = {'beat1beatAmplitude1'...
,'beat1beatAmplitude2','beat1beatAmplitude3','beat1beatAmplitude4'...
,'beat1beatAmplitude5','beat1beatAmplitude6','beat1beatAmplitude7'...
,'beat1maxTailChange','beat1beatDuration'};
    
indKinPars2ndHalfBeatHeadingNames = {'beat2beatAngle'...
,'beat2beatMaxAngle ','beat2beatMaxAngularSpeed'...
,'beat2beatDistanceX  ','beat2beatDistanceY ','beat2beatSpeedX'...
,'beat2beatSpeedY '};

indKinPars2ndHalfBeatTailNames = {'beat2beatAmplitude1','beat2beatAmplitude2'...
,'beat2beatAmplitude3 ','beat2beatAmplitude4 ','beat2beatAmplitude5'...
,'beat2beatAmplitude6 ','beat2beatAmplitude7 ','beat2maxTailChange'...
,'beat2beatDuration'};

indKinPars3rdHalfBeatHeadingNames = {'beat3beatAngle ','beat3beatMaxAngle','beat3beatMaxAngularSpeed' ...
,'beat3beatDistanceX  ','beat3beatDistanceY ','beat3beatSpeedX'...
,'beat3beatSpeedY '};
    
indKinPars3rdHalfBeatTailNames = {'beat3beatAmplitude1 ','beat3beatAmplitude2' ...
,'beat3beatAmplitude3 ','beat3beatAmplitude4 ','beat3beatAmplitude5'...
,'beat3beatAmplitude6 ','beat3beatAmplitude7 ','beat3maxTailChange'...
,'beat3beatDuration'};

indKinParsFinal = [indKinParsBoutHeading indKinPars1stHalfBeatHeading indKinPars2ndHalfBeatHeading indKinPars3rdHalfBeatHeading...
    indKinParsBoutTail  indKinPars1stHalfBeatTail indKinPars2ndHalfBeatTail  indKinPars3rdHalfBeatTail];


indKinNames= [indKinParsBoutHeadingNames indKinPars1stHalfBeatHeadingNames indKinPars2ndHalfBeatHeadingNames indKinPars3rdHalfBeatHeadingNames...
    indKinParsBoutTailNames indKinPars1stHalfBeatTailNames indKinPars2ndHalfBeatTailNames  indKinPars3rdHalfBeatTailNames];


%%
%%%%%%%%%%%%%%%% do abs log to kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kinData = abs(kinData);
maxKinPars = zeros(1,size(kinData,2));

for n = 1 : size(kinData,2)
    
    maxKinPars(n) = max(kinData(~isinf(kinData(:,n)),n))/100;
    
    kinData(:,n) = kinData(:,n) + maxKinPars(:,n);
    
end

%do log
              kinData = log(kinData);


%%
%%%%%%%%%%%%%%%% calcualte ROC for heading kin pars %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutCat = unique(boutCatFinalArray);
ROCKinMatrix = zeros(length(uniqueBoutCat),length(indKinParsFinal));
percNaNs  = zeros(length(uniqueBoutCat),length(indKinParsFinal));

for n =  1 : length(uniqueBoutCat)%loop throough kin pars
n

indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(n));

indOtherBoutTypes = 1:1:length(boutCatFinalArray);
indOtherBoutTypes(indThisBoutType) = [];


for nn  = 1 : length(indKinParsFinal)% loop through kin pars
% nn
    
%     thisKinThisBoutType = BoutKinematicParametersFinalArray(indThisBoutType,indKinParsFinal(nn));
%     thisKinOtherBoutType = BoutKinematicParametersFinalArray(indOtherBoutTypes,indKinParsFinal(nn));


    thisKinThisBoutType = kinData(indThisBoutType,indKinParsFinal(nn));
    thisKinOtherBoutType = kinData(indOtherBoutTypes,indKinParsFinal(nn));

%   thisKinThisBoutType = kinData(indThisBoutType,EnumeratorBoutKinPar.maxBoutFreqCorr);
%     thisKinOtherBoutType = kinData(indOtherBoutTypes,EnumeratorBoutKinPar.maxBoutFreqCorr);

%exclude bout kins that have many nans - these are not present for this
%bout type

   indNaNs =  find(isnan(thisKinThisBoutType));
   percNaNs(n,nn) = length(indNaNs)/length(thisKinThisBoutType);
   
   if  percNaNs(n,nn) < 0.1%exclude kin pars that have many mistakes
    
    dataTogether = [thisKinThisBoutType' thisKinOtherBoutType']';

    indsDist = [(zeros(1,length(thisKinThisBoutType))-1) (zeros(1,length(thisKinOtherBoutType))+1)];

    [ROCareaThis,~,~,~,~,~,~,~,~] = roc_sv(dataTogether,indsDist,'nofigure');
    
    ROCKinMatrix(n,nn) = abs(ROCareaThis - 0.5) + 0.5;
   
   else
       
       ROCKinMatrix(n,nn) = 0.5;
       
   end
    
end



end


% %look at bout types with nans
% percNaNsLinear = reshape(percNaNs,1,size(perceNaNs,1)*size(perceNaNs,2));
% 
% figure
% subplot(1,2,1)
% imagesc(percNaNs)
% axis square
% 
% subplot(1,2,1)
% hist(percNaNsLinear,25);
% axis square

%calcualte average ROC between bout types
ROCKinMatrixAvr =  nanmean(ROCKinMatrix,1);

%%
%%%%%%%%%%% reorder kin pars according to avr ROC %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indKinParsFinal = [indKinParsBoutHeading indKinPars1stHalfBeatHeading indKinPars2ndHalfBeatHeading indKinPars3rdHalfBeatHeading...
    indKinParsBoutTail  indKinPars1stHalfBeatTail indKinPars2ndHalfBeatTail  indKinPars3rdHalfBeatTail];

indStructure = [];
indStructure(1).inds = 1:14;%heading bout kins
indStructure(2).inds = 15:21;%heading 1st half beat kins
indStructure(3).inds = 22:28;%heading 2nd half beat kins
indStructure(4).inds = 29:35;%heading 3rd half beat kins

indStructure(5).inds = 36:47;%tail bout kins
indStructure(6).inds = 48:56;%tail 1st half beat kins
indStructure(7).inds = 57:65;%tail 2nd half beat kins
indStructure(8).inds = 66:74;%tail 3rd half beat kins


indHeading = 1:35;
indTail= 36:74;



ROCKinMatrixSortedAll = [];
indsSortedAll = [];
for h = 1 : length(indStructure)
%    h =1 
    
    
    inds = indStructure(h).inds;
    
  [sortedVals,indsSorted]= sort(ROCKinMatrixAvr(inds),'descend');
  indsSorted = inds(indsSorted);
  
  indStructure(h).indsSorted = indsSorted;
  
  ROCKinMatrixSorted = ROCKinMatrix(:,indsSorted);
  ROCKinMatrixSorted = ROCKinMatrixSorted';
  ROCKinMatrixSortedAll = [ROCKinMatrixSortedAll' ROCKinMatrixSorted']';
  
  indsSorted = indsSorted';
  indsSortedAll = [indsSortedAll' indsSorted']';
  
end
ROCKinMatrixSortedAll = ROCKinMatrixSortedAll';
indKinNamesSorted = indKinNames(indsSortedAll);

%%
%%%%%%%%%%% find best kin pars for all bout types %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ROCKinMatrixSortedAvr = nanmean(ROCKinMatrixSortedAll,1);
[bestKinForAllBouts,bestKinForAllBoutsIdx] = sort(ROCKinMatrixSortedAvr,'descend');

indKinNamesSorted(bestKinForAllBoutsIdx(1:3))
%%
%%%%%%%%%%%%%% find best kin par for each bout type %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ROCKinMatrixHeading = ROCKinMatrixSortedAll(:,indHeading);
ROCKinMatrixTail = ROCKinMatrixSortedAll(:,indTail);

indKinNamesHeading = indKinNamesSorted(indHeading);
indKinNamesTail = indKinNamesSorted(indTail);

bestHeadingKin = {};
bestTailKin = {};
bestTailKinROC = zeros(1,length(uniqueBoutCat));
bestHeadingKinROC = zeros(1,length(uniqueBoutCat));
bestKinROC = zeros(1,length(uniqueBoutCat));

for n =  1 : length(uniqueBoutCat)%loop throough kin pars
    
    [valAll,indAllSorted] = sort(ROCKinMatrixSortedAll(n,:),'descend');
    
    [valHeading,indHeadingSorted] = sort(ROCKinMatrixHeading(n,:),'descend');
    [valTail,indTailSorted] = sort(ROCKinMatrixTail(n,:),'descend');
    
    bestKinROC(n) = valAll(1);
    bestHeadingKinROC(n) = valHeading(1);
    bestTailKinROC(n) = valTail(1);

    bestHeadingKin{n} = indKinNamesHeading{indHeadingSorted(1)};
    bestTailKin{n} = indKinNamesTail{indTailSorted(1)};
    bestKinAll{n} = indKinNamesSorted{indAllSorted(1)};
end

%%
%%%%%%%%%%%%%% plot distributions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indKinParsBest = [EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.C2Angle...
%     EnumeratorBoutKinPar.maxBoutFreqCorr...
%     EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.C2Duration ...
%     EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngle ...
%     EnumeratorBoutKinPar.beat2beatMaxAngularSpeed];

indKinParsBest = [EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude1...
    EnumeratorBoutKinPar.maxBoutFreqCorr...
    EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude1 ...
    EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngle ...
    EnumeratorBoutKinPar.beat2beatMaxAngularSpeed];



% 
numbOfHistDivisions = 25;
% lowerBoundery =zeros(1,length(uniqueBoutCat));
lowerBoundery =[3 -1 -1 2 -1.5 0 -0.5 3 1 1 -1];

% higherBoundery = [360,360,360,80,20,50,30,360,250,100,20];
% higherBoundery = [100,100,100,80,5,50,30,360,250,100,20];
higherBoundery = [6.5,4.5,4.5,5,3.5,5.5,4.5,6.5,6,5,4];

figure
for n =  1 : length(uniqueBoutCat)%loop throough kin pars
%     n =1
%        n = 1
%     n = 1
indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(n));

indOtherBoutTypes = 1:1:length(boutCatFinalArray);
indOtherBoutTypes(indThisBoutType) = [];


thisKinThisBoutType = kinData(indThisBoutType,indKinParsBest(n));
thisKinOtherBoutType = kinData(indOtherBoutTypes,indKinParsBest(n));

  xVector = lowerBoundery(n):higherBoundery(n)/numbOfHistDivisions:higherBoundery(n);
% xVector = 1:100;

% [nout]= hist(thisKinThisBoutType,xVector);
% [noutAll]= hist(thisKinOtherBoutType,xVector);
[nout,xVector] = hist(thisKinThisBoutType,xVector);
[noutAll,xVector] = hist(thisKinOtherBoutType,xVector);


   subplot(2,6,n)
   plot(xVector,nout/sum(nout),'color',col(n,:),'linewidth',2)
   hold on
   plot(xVector,noutAll/sum(noutAll),'color','k','linewidth',2)
   
axis square
box off
end



%%
%%%%%%%%%%%%%%% plot roc kin par panels %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indStructure = [];
%sort by half beat
indStructure(1).inds = [1:14 36:47];%heading bout kins
indStructure(2).inds = [15:21 48:56];%heading bout kins
indStructure(3).inds = [22:28 57:65];%heading bout kins
indStructure(4).inds = [29:35 66:74];%heading bout kins

ROCKinMatrixSortedAll = [];
indsSortedAll2 = [];
markerVectorAll = [];

for h = 1 : length(indStructure)
%    h =1 
    
    
    inds = indStructure(h).inds;
    
  [sortedVals,indsSorted]= sort(ROCKinMatrixAvr(inds),'descend');
  indsSorted = inds(indsSorted);
  
  indStructure(h).indsSorted = indsSorted;
  
  ROCKinMatrixSorted2 = ROCKinMatrix(:,indsSorted);
  
  
  ROCKinMatrixSorted2 = ROCKinMatrixSorted2';
  ROCKinMatrixSortedAll = [ROCKinMatrixSortedAll' ROCKinMatrixSorted2']';
  
  markerVector = zeros(length(ROCKinMatrixSorted2),1)+ h;
%    markerVector = markerVector';
  markerVectorAll = [markerVectorAll' markerVector']';
  
  
  indsSorted = indsSorted';
  indsSortedAll2 = [indsSortedAll2' indsSorted']';
  
end

indKinNamesSorted2 = indKinNames(indsSortedAll2);



indKinNamesSorted = indKinNames(indsSortedAll2);


spaceVector = zeros(1,11) + 1;

ROCKinMatrixSortedAll = ROCKinMatrixSortedAll';

% find([diff(markerVectorAll) 0]);


ROCKinMatrixSortedAllWithSpaces = [ROCKinMatrixSortedAll(:,1:26) spaceVector' ROCKinMatrixSortedAll(:,27:42) spaceVector' ...
    ROCKinMatrixSortedAll(:,43:58) spaceVector' ROCKinMatrixSortedAll(:,59:74)];



figure
imagesc(ROCKinMatrixSortedAllWithSpaces)
colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off



