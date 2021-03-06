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

indKinParsBoutHeadingNames = {'Max angular speed','Mean angular speed'...
,'Max head yaw','Mean head yaw','Max angle','Bout end angle'...
,'Bout lateral distance','Bout lateral speed'...   
,'C1 angle','C2 angle','C1 max angular speed','C2 max angular speed'...
,'C1 duration','C2 duration'};
 
indKinParsBoutTailNames = {'Tail max amplitude 1','Tail max amplitude 2'...
,'Tail max amplitude 3' ,'Tail max amplitude 4 ','Tail max amplitude 5'...
,'Tail max amplitude 6','Tail max amplitude 7'...
,'Max bout frquency','Max til change','Mean tail change'...
,'Difference in tail amplitude','Bout duration'};
    

indKinPars1stHalfBeatHeadingNames  = {'End angle','Max angle'...
,'Max angular speed','Forward distance','lateral distance'...
,'Forward distance','Lateral speed'};    

indKinPars1stHalfBeatTailNames  = {'Tail max amplitude 1'...
,'Tail max amplitude 2','Tail max amplitude 3','Tail max amplitude 4'...
,'Tail max amplitude 5','Tail max amplitude 6','Tail max amplitude 7'...
,'Max tail cahnge','Duration'};
    
indKinPars2ndHalfBeatHeadingNames = {'End angle','Max angle'...
,'Max angular speed','Forward distance','lateral distance'...
,'Forward distance','Lateral speed'};  

indKinPars2ndHalfBeatTailNames = {'Tail max amplitude 1'...
,'Tail max amplitude 2','Tail max amplitude 3','Tail max amplitude 4'...
,'Tail max amplitude 5','Tail max amplitude 6','Tail max amplitude 7'...
,'Max tail cahnge','Duration'};

indKinPars3rdHalfBeatHeadingNames = {'End angle','Max angle'...
,'Max angular speed','Forward distance','lateral distance'...
,'Forward distance','Lateral speed'};  
    
indKinPars3rdHalfBeatTailNames = {'Tail max amplitude 1'...
,'Tail max amplitude 2','Tail max amplitude 3','Tail max amplitude 4'...
,'Tail max amplitude 5','Tail max amplitude 6','Tail max amplitude 7'...
,'Max tail cahnge','Duration'};

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
%%%%%%%%%%%%%%%% calculate ROC compare bout type with other bout type %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueBoutCat = unique(boutCatFinalArray);
ROCKinMatrixAllComp = zeros(length(uniqueBoutCat),length(uniqueBoutCat),length(indKinParsFinal));
% percNaNsAllComp  = zeros(length(uniqueBoutCat),,length(uniqueBoutCat),length(indKinParsFinal));
    
for n =  1 : length(uniqueBoutCat)%loop throough kin pars
n

indThisBoutType1 = find(boutCatFinalArray == uniqueBoutCat(n));
tic
for nn =  1 : length(uniqueBoutCat)%loop throough kin pars

    indThisBoutType2 = find(boutCatFinalArray == uniqueBoutCat(nn));

    for nnn  = 1 : length(indKinParsFinal)% loop through kin pars
% nn
    
%     thisKinThisBoutType = BoutKinematicParametersFinalArray(indThisBoutType,indKinParsFinal(nn));
%     thisKinOtherBoutType = BoutKinematicParametersFinalArray(indOtherBoutTypes,indKinParsFinal(nn));


    thisKinThisBoutType1 = kinData(indThisBoutType1,indKinParsFinal(nnn));
    thisKinThisBoutType2 = kinData(indThisBoutType2,indKinParsFinal(nnn));

     indNaNs1 =  find(isnan(thisKinThisBoutType1));
     indNaNs2 =  find(isnan(thisKinThisBoutType2));
     

   percNaNs1 = length(indNaNs1)/length(thisKinThisBoutType1);
   percNaNs2 = length(indNaNs2)/length(thisKinThisBoutType2);

   percNaNsBoth = min([percNaNs1 percNaNs2]);
    
    if  percNaNsBoth < 0.05%exclude kin pars that have many mistakes
        
    dataTogether = [thisKinThisBoutType1' thisKinThisBoutType2']';

    indsDist = [(zeros(1,length(thisKinThisBoutType1))-1) (zeros(1,length(thisKinThisBoutType2))+1)];

    [ROCareaThis,~,~,~,~,~,~,~,~] = roc_sv(dataTogether,indsDist,'nofigure');
    
    ROCKinMatrixAllComp(n,nn,nnn) = abs(ROCareaThis - 0.5) + 0.5;
   
    else
       
    ROCKinMatrixAllComp(n,nn,nnn) = 0.5;
    
    end
    end
end
toc
end

%%
%%%%%%%%%%%% reorder kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indStructure(1).inds = [1:14 36:47];%heading bout kins
indStructure(2).inds = [15:21 48:56];%heading bout kins
indStructure(3).inds = [22:28 57:65];%heading bout kins
indStructure(4).inds = [29:35 66:74];%heading bout kins


ROCKinMatrixAllCompSorted =[];
indKinNamesSorted =[];
indsAll = [];
for i = 1 : length(indStructure)
    
     inds = indStructure(i).inds;
    
     ROCKinMatrixAllCompThis = ROCKinMatrixAllComp(:,:,inds);
     indKinNamesThis = indKinNames(inds);
     
%      ROCKinMatrixAllCompSorted = [ROCKinMatrixAllCompSorted ROCKinMatrixAllCompThis];

%      ROCKinMatrixAllCompSorted = permute( [permute(ROCKinMatrixAllCompSorted,[3,1,2]), permute(ROCKinMatrixAllCompThis,[3,1,2])],[3,1,2]);
ROCKinMatrixAllCompSorted = cat(3, ROCKinMatrixAllCompSorted, ROCKinMatrixAllCompThis);
% indsAll = [indsAll inds];
indKinNamesSorted = [indKinNamesSorted indKinNamesThis];
end


%%
%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spaceVector = zeros(1,11) + 1;



% figure
for n = 1 : 11
    
    ROCKinMatrixAllCompSortedThis = squeeze(ROCKinMatrixAllCompSorted(n,:,:))';
    
    ROCKinMatrixAllCompSortedThis = ROCKinMatrixAllCompSortedThis';

% find([diff(markerVectorAll) 0]);


ROCKinMatrixSortedAllWithSpaces = [ROCKinMatrixAllCompSortedThis(:,1:26) spaceVector' ROCKinMatrixAllCompSortedThis(:,27:42) spaceVector' ...
    ROCKinMatrixAllCompSortedThis(:,43:58) spaceVector' ROCKinMatrixAllCompSortedThis(:,59:74)];

    
    
    
%     subplot(2,6,n)
figure
    imagesc(ROCKinMatrixSortedAllWithSpaces);
    colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off

end



%%
%%%%%%%%%%%%%%%% determine distributions to plot %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%determine best bout kin for pairs of bout types
[bestKinVals,bestKInInds] = max(ROCKinMatrixAllComp, [],3);


figure
% subplot(1,2,1)
imagesc(bestKinVals)
colormap('gray')
axis equal 
box off
caxis([0.5 1])
axis off


indKinNamesSorted(bestKInInds(6,7))

