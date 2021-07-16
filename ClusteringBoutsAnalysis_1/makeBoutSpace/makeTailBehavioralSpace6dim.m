


%%
%%%%%%%%%%%%%%5 import PCA data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



load('C:\Joao analysis\FreeData\clusteringData\PCA\PCA_kNN4_74Kins3dim.mat')


%%
%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

BoutKinematicParametersGood = BoutKinematicParameters(indBoutsForPCA,:);
BoutInfGood  = BoutInf(indBoutsForPCA,:);



%%
%%%%%%%%%%%%%%%%% chooose kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %26 + 1st beat kin pars + 2nd beat kin pars + 3rd beat kin pars


indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
    EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
    EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
    EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
    EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
    EnumeratorBoutKinPar.boutDuration...
    EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
    EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7 EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY EnumeratorBoutKinPar.beat1maxTailChange...    
    EnumeratorBoutKinPar.beat2beatDuration EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2 EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
    EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7 EnumeratorBoutKinPar.beat2beatAngle EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2maxTailChange...
    EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
    EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
    EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY EnumeratorBoutKinPar.beat3maxTailChange];


% %tail kins
% indKinPars = [EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
%     EnumeratorBoutKinPar.maxBoutFreqCorr ...
%     EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
%     EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff...
%     EnumeratorBoutKinPar.boutDuration...
%     EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
%     EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7...
%     EnumeratorBoutKinPar.beat1maxTailChange...    
%     EnumeratorBoutKinPar.beat2beatDuration EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2 EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
%     EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7...
%     EnumeratorBoutKinPar.beat2maxTailChange...
%     EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
%     EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 ...
%     EnumeratorBoutKinPar.beat3maxTailChange];



% indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed  ...
%     EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle ...
%      EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
%     EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
%     EnumeratorBoutKinPar.boutDuration...
%     EnumeratorBoutKinPar.beat1beatDuration ...
%     EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY...    
%     EnumeratorBoutKinPar.beat2beatDuration    ...
%     EnumeratorBoutKinPar.beat2beatAngle EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY...
%     EnumeratorBoutKinPar.beat3beatDuration  ...
%     EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY];



% 
%%
%%%%%%%%%%%%%%%%% do PCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makeplot = 0;

[boutDataPCASample,meanAllVar,stdAllVar,COEFF,SCORE,latent,maxKinPars] = PCAforBehavior_4(BoutKinematicParametersGood,indKinPars,makeplot);

meanPCASpace = mean(SCORE,1);

%save behavioral space vars in structure
% behavioralSpaceStructure.boutDataPCASample = boutDataPCASample;
behavioralSpaceStructure.meanAllVar = meanAllVar;
behavioralSpaceStructure.stdAllVar = stdAllVar;
behavioralSpaceStructure.COEFF = COEFF;
% behavioralSpaceStructure.SCORE = SCORE;
behavioralSpaceStructure.latent = latent;
behavioralSpaceStructure.maxKinPars = maxKinPars;
behavioralSpaceStructure.indKinPars = indKinPars;
behavioralSpaceStructure.meanPCASpace = meanPCASpace;


%%
%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot3(boutDataPCASample(1:500:end,1),boutDataPCASample(1:500:end,2),boutDataPCASample(1:500:end,3), 'k.')
axis square


latentPerc = (latent./sum(latent))*100;

figure
subplot(2,2,1)
plot(latent, '.')

subplot(2,2,2)
plot(cumsum(latent), '.')

subplot(2,2,3)
plot(latentPerc, '.')

subplot(2,2,4)
plot(cumsum(latentPerc), '.')

%%
%%%%%%%%%%%% put all data in PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[boutDataPCASampleAllData] = placeDataIntoFixedBehavioralSpace_1(BoutKinematicParameters,indKinPars,maxKinPars,meanAllVar,stdAllVar,meanPCASpace,COEFF);

boutDataPCASampleAllData = boutDataPCASampleAllData(:,1:6);




%%
%%%%%%%%%%%%%%%%%%%% look at individual data sets %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



figure
for n = 1:length(indStructure)
    
    thisInds = indStructure(n).thisInds;
    clf
    plot(boutDataPCASampleAllData(thisInds,1),boutDataPCASampleAllData(thisInds,2),'.k')
    axis square
    pause
end


%%
%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BoutKinematicParameters = BoutKinematicParametersGood;
% BoutInf = BoutInfGood;

boutDataPCASample = boutDataPCASampleAllData;

save('PCA_kNN4_74Kins6dim.mat','boutDataPCASample','BoutInf','BoutKinematicParameters','indBoutsForPCA','behavioralSpaceStructure','indStructure','-v7.3')

%%
%%%%%%%%%%%%% save only behavioral space structure %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('BehavioralSpace_FinalData_74Kins6dim_1','behavioralSpaceStructure','-v7.3')

