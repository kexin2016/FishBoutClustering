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
%%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[boutDataPCASampleFinalArray] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParametersFinalArray,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);




%%
%%%%%%%%%%%%% calculate ROC for PCs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numbOfPCs = 10;
% 
% uniqueBoutCat = unique(boutCatFinalArray);
% 
% ROCPCMatrix = zeros(length(uniqueBoutCat),numbOfPCs);
% 
% 
% for n =  1 : length(uniqueBoutCat)%loop throough kin pars
% 
%     n
% %     n = 1
% indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(n));
% 
% indOtherBoutTypes = 1:1:length(boutCatFinalArray);
% indOtherBoutTypes(indThisBoutType) = [];
% 
% 
% for nn  = 1 : numbOfPCs% loop through kin pars
% %     tic
%      thisPCThisBoutType = boutDataPCASampleFinalArray(indThisBoutType,nn);
%      thisPCOtherBoutType = boutDataPCASampleFinalArray(indOtherBoutTypes,nn);
%      
%       dataTogether = [thisPCThisBoutType' thisPCOtherBoutType']';
% 
%     indsDist = [(zeros(1,length(thisPCThisBoutType))-1) (zeros(1,length(thisPCOtherBoutType))+1)];
% 
%     
%     [ROCareaThis,~,~,~,~,~,~,~,~] = roc_sv(dataTogether,indsDist,'nofigure');
%     
%     ROCPCMatrix(n,nn) = abs(ROCareaThis - 0.5) + 0.5;
% %     toc
% 
% end
% end


%%
%%%%%%%%%%%%%%% pick kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %26 + 1st beat kin pars + 2nd beat kin pars + 3rd beat kin pars
indKinParsBoutHeading = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed...
EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle...
EnumeratorBoutKinPar.boutDistanceY EnumeratorBoutKinPar.boutSpeedY...   
EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C1MaxAngularSpeed EnumeratorBoutKinPar.C2MaxAngularSpeed...
EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration ];
 
indKinParsBoutTail = [EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max...
EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max EnumeratorBoutKinPar.boutAmplitude5Max...
EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max...
EnumeratorBoutKinPar.maxBoutFreqCorr EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax...
EnumeratorBoutKinPar.boutAmplitudeDiff];
    

indKinPars1stHalfBeatHeading  = [EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle...
EnumeratorBoutKinPar.beat1beatMaxAngularSpeed EnumeratorBoutKinPar.beat1beatDistanceX EnumeratorBoutKinPar.beat1beatDistanceY...
EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY EnumeratorBoutKinPar.beat1beatDuration];    

indKinPars1stHalfBeatTail  = [EnumeratorBoutKinPar.beat1beatAmplitude1...
EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4...
EnumeratorBoutKinPar.beat1beatAmplitude5 EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7...
EnumeratorBoutKinPar.beat1maxTailChange ];
    
indKinPars2ndHalfBeatHeadig = [EnumeratorBoutKinPar.beat2beatAngle...
EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed...
EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX...
EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2beatDuration];

indKinPars2ndHalfBeatTail = [EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2...
EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7 EnumeratorBoutKinPar.beat2maxTailChange...
];

indKinPars3rdHalfBeatHeading = [EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX...
EnumeratorBoutKinPar.beat3beatSpeedY EnumeratorBoutKinPar.beat3beatDuration];
    
indKinPars3rdHalfBeatTail = [EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 ...
EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3maxTailChange...
];

indKinParsFinal = [indKinParsBoutHeading indKinParsBoutTail indKinPars1stHalfBeatHeading indKinPars1stHalfBeatTail indKinPars2ndHalfBeatHeadig...
    indKinPars2ndHalfBeatTail indKinPars3rdHalfBeatHeading indKinPars3rdHalfBeatTail];



%%
%%%%%%%%%%%%%%%% calcualte ROC for heading kin pars %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutCat = unique(boutCatFinalArray);

ROCKinMatrix = zeros(length(uniqueBoutCat),length(indKinPars));

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

indKinParsFinal = [indKinParsBoutHeading indKinParsBoutTail indKinPars1stHalfBeatHeading indKinPars1stHalfBeatTail indKinPars2ndHalfBeatHeadig...
    indKinPars2ndHalfBeatTail indKinPars3rdHalfBeatHeading indKinPars3rdHalfBeatTail];

indHeading = [indKinParsBoutHeading  indKinPars1stHalfBeatHeading  indKinPars2ndHalfBeatHeadig...
     indKinPars3rdHalfBeatHeading];

indTail = [ indKinParsBoutTail  indKinPars1stHalfBeatTail ...
    indKinPars2ndHalfBeatTail  indKinPars3rdHalfBeatTail];

% indTotal = [1:15 16:23 24:31 32:39 40:47 48:55 56:63 64:71]


indStructure(1).inds = 1:14;%heading bout kins
indStructure(2).inds = 27:33;%heading 1st half beat kins
indStructure(3).inds = 43:49;%heading 2nd half beat kins
indStructure(4).inds = 59:65;%heading 3rd half beat kins

indStructure(5).inds = 15:26;%tail bout kins
indStructure(6).inds = 34:42;%tail 1st half beat kins
indStructure(7).inds = 50:58;%tail 2nd half beat kins
indStructure(8).inds = 66:74;%tail 3rd half beat kins

indHeading = [1:14 27:33 43:49 59:65];
indTail= [15:26 34:42 50:58 66:74];



ROCKinMatrixSorted = ROCKinMatrix*0;
for h = 1 : length(indStructure)
%    h =1 
    
    
    inds = indStructure(h).inds;
    
  [sortedVals,indsSorted]= sort(ROCKinMatrixAvr(inds),'descend');
  indsSorted = inds(indsSorted);
  
  indStructure(h).indsSorted = indsSorted;
  
  ROCKinMatrixSorted(:,inds) = ROCKinMatrix(:,indsSorted);
  
end




figure
subplot(1,2,1)
imagesc(ROCKinMatrixSorted(:,indHeading)')
colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off

subplot(1,2,2)
imagesc(ROCKinMatrixSorted(:,indTail)')
colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off



%%
%%%%%%%%%%%%%% make heat plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% max(ROCKinMatrix(:,n))
spaceVector = zeros(1,11) + 1;

% ROCMatricHeading = [ROCKinMatrixSorted(:,1:14) spaceVector' ROCKinMatrixSorted(:,27:33) spaceVector'...
%     ROCKinMatrixSorted(:,43: 49) spaceVector' ROCKinMatrixSorted(:,59 : 65) spaceVector'];
% 
% ROCMatrictail = [ spaceVector' ROCKinMatrixSorted(:,15:26 ) spaceVector' ROCKinMatrixSorted(:,34 : 42) spaceVector'...
%     ROCKinMatrixSorted(:,50 : 58) spaceVector' ROCKinMatrixSorted(:,66 : 74) spaceVector'];
% 

% ROCMatricTail = [ROCPCMatrix(:,1:3) spaceVector' ROCKinMatrix(:,1:13) spaceVector' ROCKinMatrix(:,14:26) spaceVector' ROCKinMatrix(:,14:26)];
ROCKinMatrixWithSpacesHeading = [ROCKinMatrixSorted(:,1:14) spaceVector'  ROCKinMatrixSorted(:,27:33) spaceVector' ...
    ROCKinMatrixSorted(:,43: 49) spaceVector'  ROCKinMatrixSorted(:,59 : 65) ];

ROCKinMatrixWithSpacesTail = [ ROCKinMatrixSorted(:,15:26 ) spaceVector' ROCKinMatrixSorted(:,34 : 42) spaceVector'...
    ROCKinMatrixSorted(:,50 : 58) spaceVector' ROCKinMatrixSorted(:,66 : 74)];


figure
 subplot(1,2,1)
imagesc(ROCKinMatrixWithSpacesHeading')
colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off



% figure
 subplot(1,2,2)
imagesc(ROCKinMatrixWithSpacesTail')
colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off


%%
%%%%%%%%%%%%%% find best kinpar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kinPars1stHalfBeatNames  = {'boutMaxAngularSpeed', 'boutAvrAngularSpeed',...
'headMaxYaw', 'headMeanYaw', 'boutMaxAngle', 'boutAngle',...
'boutDistanceY', 'boutSpeedY'...   
'C1Angle', 'C2Angle', 'C1MaxAngularSpeed', 'C2MaxAngularSpeed',...
'C1Duration', 'C2Duration','boutAmplitude1Max', 'boutAmplitude2Max',...
'boutAmplitude3Max', 'boutAmplitude4Max', 'boutAmplitude5Max',...
'boutAmplitude6Max', 'boutAmplitude7Max',...
'maxBoutFreqCorr', 'maxTailChangeMax', 'meanTailChangeMax',...
'boutAmplitudeDiff', 'boutDuration','beat1beatAngle', 'beat1beatMaxAngle',...
'beat1beatMaxAngularSpeed', 'beat1beatDistanceX', 'beat1beatDistanceY',...
'beat1beatSpeedX', 'beat1beatSpeedY','beat1beatAmplitude1',...
'beat1beatAmplitude2', 'beat1beatAmplitude3', 'beat1beatAmplitude4',...
'beat1beatAmplitude5', 'beat1beatAmplitude6', 'beat1beatAmplitude7',...
'beat1maxTailChange', 'beat1beatDuration','beat2beatAngle',...
'beat2beatMaxAngle', 'beat2beatMaxAngularSpeed',...
'beat2beatDistanceX',  'beat2beatDistanceY', 'beat2beatSpeedX',...
'beat2beatSpeedY','beat2beatAmplitude1', 'beat2beatAmplitude2',...
'beat2beatAmplitude3', 'beat2beatAmplitude4', 'beat2beatAmplitude5',...
'beat2beatAmplitude6', 'beat2beatAmplitude7', 'beat2maxTailChange',...
'beat2beatDuration','beat3beatAngle', 'beat3beatMaxAngle', 'beat3beatMaxAngularSpeed', ...
'beat3beatDistanceX',  'beat3beatDistanceY', 'beat3beatSpeedX', 'beat3beatSpeedY' ,'beat3beatAmplitude1', 'beat3beatAmplitude2', ...
'beat3beatAmplitude3', 'beat3beatAmplitude4', 'beat3beatAmplitude5',...
'beat3beatAmplitude6', 'beat3beatAmplitude7', 'beat3maxTailChange',...
'beat3beatDuration'};




bestHeadingKin = {};
bestTailKin = {};
bestHeadingKinROC = zeros(1,length(uniqueBoutCat));
bestTailKinROC = zeros(1,length(uniqueBoutCat));

for n =  1 : length(uniqueBoutCat)%loop throough kin pars

%     n = 1
    
[valHeading,indHeading] = sort(ROCKinMatrix(n,indsTypeOfKinHeading),'descend');
[valTail,indTail] = sort(ROCKinMatrix(n,indsTypeOfKinTail),'descend');

indHeadingSorted = indsTypeOfKinHeading(indHeading);
indTailSorted = indsTypeOfKinTail(indTail);

bestHeadingKinROC(n) = valHeading(1);
bestTailKinROC(n) = valTail(1);

bestHeadingKin{n} = kinPars1stHalfBeatNames{indHeadingSorted(1)};
bestTailKin{n} = kinPars1stHalfBeatNames{indTailSorted(1)};


end

figure
plot(bestHeadingKinROC, 'bo')
hold on
plot(bestTailKinROC, 'ro')
axis square
axis([0 12 0.5 1])

%%
%%%%%%%%%%%%%% make distribution plot of most seperable kin par  %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
