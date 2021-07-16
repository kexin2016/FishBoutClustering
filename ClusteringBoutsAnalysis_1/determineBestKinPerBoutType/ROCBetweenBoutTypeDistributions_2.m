clear all
close all

%%
%%%%%%%%%%%% load bout map with raw data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('C:\Joao analysis\BoutMapWithRaw_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')

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
%%%%%%%%%%%%%%%% calcualte ROC for heading kin pars %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutCat = unique(boutCatFinalArray);
ROCKinMatrix = zeros(length(uniqueBoutCat),length(indKinParsFinal));

for n =  1 : length(uniqueBoutCat)%loop throough kin pars

    n
%     n = 1
indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(n));

indOtherBoutTypes = 1:1:length(boutCatFinalArray);
indOtherBoutTypes(indThisBoutType) = [];


for nn  = 1 : length(indKinParsFinal)% loop through kin pars
% nn
    
    thisKinThisBoutType = BoutKinematicParametersFinalArray(indThisBoutType,indKinParsFinal(nn));
    thisKinOtherBoutType = BoutKinematicParametersFinalArray(indOtherBoutTypes,indKinParsFinal(nn));
    
    dataTogether = [thisKinThisBoutType' thisKinOtherBoutType']';

    indsDist = [(zeros(1,length(thisKinThisBoutType))-1) (zeros(1,length(thisKinOtherBoutType))+1)];

    [ROCareaThis,~,~,~,~,~,~,~,~] = roc_sv(dataTogether,indsDist,'nofigure');
    
    ROCKinMatrix(n,nn) = abs(ROCareaThis - 0.5) + 0.5;
    
end



end

%calcualte average ROC between bout types
ROCKinMatrixAvr =  nanmean(ROCKinMatrix,1);

%%
%%%%%%%%%%% reorder kin pars according to avr ROC %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indKinParsFinal = [indKinParsBoutHeading indKinPars1stHalfBeatHeading indKinPars2ndHalfBeatHeading indKinPars3rdHalfBeatHeading...
    indKinParsBoutTail  indKinPars1stHalfBeatTail indKinPars2ndHalfBeatTail  indKinPars3rdHalfBeatTail];


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



ROCKinMatrixSorted = ROCKinMatrix*0;
indsSortedAll = [];
for h = 1 : length(indStructure)
%    h =1 
    
    
    inds = indStructure(h).inds;
    
  [sortedVals,indsSorted]= sort(ROCKinMatrixAvr(inds),'descend');
  indsSorted = inds(indsSorted);
  
  indStructure(h).indsSorted = indsSorted;
  
  ROCKinMatrixSorted(:,inds) = ROCKinMatrix(:,indsSorted);
  indsSorted = indsSorted';
  indsSortedAll = [indsSortedAll' indsSorted']';
  
end

indKinNamesSorted = indKinNames(indsSortedAll);

%%
%%%%%%%%%%% find best kin pars for all bout types %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ROCKinMatrixSortedAvr = nanmean(ROCKinMatrixSorted,1);
[bestKinForAllBouts,bestKinForAllBoutsIdx] = sort(ROCKinMatrixSortedAvr,'descend');

indKinNamesSorted(bestKinForAllBoutsIdx(1:3))
%%
%%%%%%%%%%%%%% find best kin par for each bout type %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ROCKinMatrixHeading = ROCKinMatrixSorted(:,indHeading);
ROCKinMatrixTail = ROCKinMatrixSorted(:,indTail);

indKinNamesHeading = indKinNamesSorted(indHeading);
indKinNamesTail = indKinNamesSorted(indTail);

bestHeadingKin = {};
bestTailKin = {};
bestHeadingKinROC = zeros(1,length(uniqueBoutCat));
bestTailKinROC = zeros(1,length(uniqueBoutCat));


for n =  1 : length(uniqueBoutCat)%loop throough kin pars
    
    
    [valHeading,indHeadingSorted] = sort(ROCKinMatrixHeading(n,:),'descend');
    [valTail,indTailSorted] = sort(ROCKinMatrixTail(n,:),'descend');
    
    bestHeadingKinROC(n) = valHeading(1);
    bestTailKinROC(n) = valTail(1);

    bestHeadingKin{n} = indKinNamesHeading{indHeadingSorted(1)};
    bestTailKin{n} = indKinNamesTail{indTailSorted(1)};
end


%%
%%%%%%%%%%%%%%% plot roc kin par panels %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



spaceVector = zeros(1,11) + 1;

ROCKinMatrixWithSpacesHeading = [ROCKinMatrixSorted(:,1:14) spaceVector'  ROCKinMatrixSorted(:,15:21) spaceVector' ...
    ROCKinMatrixSorted(:,22:28) spaceVector'  ROCKinMatrixSorted(:,29:35) spaceVector' spaceVector'];

ROCKinMatrixWithSpacesTail = [ ROCKinMatrixSorted(:,36:47) spaceVector' ROCKinMatrixSorted(:,48:56) spaceVector'...
    ROCKinMatrixSorted(:,57:65) spaceVector' ROCKinMatrixSorted(:,66:74)];




figure
subplot(1,2,1)
imagesc(ROCKinMatrixWithSpacesHeading')
colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off

subplot(1,2,2)
imagesc(ROCKinMatrixWithSpacesTail')
colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off



