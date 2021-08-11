
function [boutDataPCASample,meanAllVar,stdAllVar,COEFF,SCORE,latent,maxKinPars] = PCAforBehavior_4(BoutKinematicParameters,indKinPars,makeplot)




%%
%%%%%%%%%%%% pick kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
%     EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
%     EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
%     EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
%     EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
%     EnumeratorBoutKinPar.boutDuration];



%%

%%
indThisStim = 1:size(BoutKinematicParameters,1);
BoutKinematicParametersGood =  BoutKinematicParameters(indThisStim,indKinPars);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% plot bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if makeplot == 1
%
%
% subplot(1,2,1)
% % plot3(boutAmplitude6Max(indThisStim),boutMaxAngularSpeed(indThisStim),maxBoutFreqCorr(indThisStim), 'k.')
% %  axis([-360 360,0 30,0 150])
% plot3()
%
% end
% % pause
%%
%%%%%%%%%%%%%%%%%%%%%%%% do log abs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kinData = abs(BoutKinematicParametersGood);
maxKinPars = zeros(1,size(kinData,2));

for n = 1 : size(kinData,2)
    
    maxKinPars(n) = max(kinData(~isinf(kinData(:,n)),n))/100;
    
    kinData(:,n) = kinData(:,n) + maxKinPars(:,n);
    
end

%do log
kinData = log(kinData);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% do z-score %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%uses nanZscore function
[zScore,meanAllVar,stdAllVar] = nanZScore_parOutput(kinData);

%erase nans
zScore(isnan(zScore))=0;

%%
%%%%%%%%%%%%%%%%% do PCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbPCs = 0;

%   [U,S,V] = svd(zScore,'econ');
[COEFF,SCORE,latent] = pca(zScore, 'Economy',true);


if numbPCs == 0
    
    
    %    indPC = find(latent > 1);
    indPC = length(latent);
    %   indPC = 2;
    
    
    if indPC == 1
        indPC = 2;
        
    end
    
    boutDataPCASample = SCORE(:,1:indPC(end));
    
else
    
    indPC = 1:1:numbPCs;
    boutDataPCASample = SCORE(:,1:indPC(end));
    
    
end

% figure
% plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3),'.k')


%%
%%%%%%%%%%%%%% make latent percentage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




latentPerc = (latent./sum(latent))*100;

if makeplot == 1
    
    figure
    % subplot(2,2,2)
    plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), 'k.')
    axis([-10 20 -10 10 -10 10])
    
    figure
    subplot(2,2,1)
    plot(latent, '.')
    
    subplot(2,2,2)
    plot(cumsum(latent), '.')
    
    subplot(2,2,3)
    plot(latentPerc, '.')
    
    subplot(2,2,4)
    plot(cumsum(latentPerc), '.')
    
end