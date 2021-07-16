% AddFunctionToPath
% 
%  close all
% clear all


%%
% %%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));


%%
%%%%%%%%%%%%% clear variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 clearvars clusterStructure indStructure

%%
%%%%%%%%%%% choosen kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%26 + 1st beat kin pars + 2nd beat kin pars
% indKinPars = [EnumeratorBoutKinPar.boutMaxAngularSpeed EnumeratorBoutKinPar.boutAvrAngularSpeed EnumeratorBoutKinPar.maxTailChangeMax EnumeratorBoutKinPar.meanTailChangeMax  ...
%     EnumeratorBoutKinPar.headMaxYaw EnumeratorBoutKinPar.headMeanYaw EnumeratorBoutKinPar.boutMaxAngle EnumeratorBoutKinPar.boutAngle EnumeratorBoutKinPar.maxBoutFreqCorr ...
%     EnumeratorBoutKinPar.boutAmplitude1Max EnumeratorBoutKinPar.boutAmplitude2Max EnumeratorBoutKinPar.boutAmplitude3Max EnumeratorBoutKinPar.boutAmplitude4Max...
%     EnumeratorBoutKinPar.boutAmplitude5Max EnumeratorBoutKinPar.boutAmplitude6Max EnumeratorBoutKinPar.boutAmplitude7Max EnumeratorBoutKinPar.boutAmplitudeDiff EnumeratorBoutKinPar.C1Angle EnumeratorBoutKinPar.C1MaxAngularSpeed...
%     EnumeratorBoutKinPar.C2Angle EnumeratorBoutKinPar.C2MaxAngularSpeed EnumeratorBoutKinPar.C1Duration EnumeratorBoutKinPar.C2Duration EnumeratorBoutKinPar.boutSpeedY EnumeratorBoutKinPar.boutDistanceY...
%     EnumeratorBoutKinPar.boutDuration...
%     EnumeratorBoutKinPar.beat1beatDuration EnumeratorBoutKinPar.beat1beatAmplitude1 EnumeratorBoutKinPar.beat1beatAmplitude2 EnumeratorBoutKinPar.beat1beatAmplitude3 EnumeratorBoutKinPar.beat1beatAmplitude4 EnumeratorBoutKinPar.beat1beatAmplitude5...
%     EnumeratorBoutKinPar.beat1beatAmplitude6 EnumeratorBoutKinPar.beat1beatAmplitude7 EnumeratorBoutKinPar.beat1beatAngle EnumeratorBoutKinPar.beat1beatMaxAngle EnumeratorBoutKinPar.beat1beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat1beatDistanceX  EnumeratorBoutKinPar.beat1beatDistanceY EnumeratorBoutKinPar.beat1beatSpeedX EnumeratorBoutKinPar.beat1beatSpeedY EnumeratorBoutKinPar.beat1maxTailChange...    
%     EnumeratorBoutKinPar.beat2beatDuration EnumeratorBoutKinPar.beat2beatAmplitude1 EnumeratorBoutKinPar.beat2beatAmplitude2 EnumeratorBoutKinPar.beat2beatAmplitude3 EnumeratorBoutKinPar.beat2beatAmplitude4 EnumeratorBoutKinPar.beat2beatAmplitude5...
%     EnumeratorBoutKinPar.beat2beatAmplitude6 EnumeratorBoutKinPar.beat2beatAmplitude7 EnumeratorBoutKinPar.beat2beatAngle EnumeratorBoutKinPar.beat2beatMaxAngle EnumeratorBoutKinPar.beat2beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat2beatDistanceX  EnumeratorBoutKinPar.beat2beatDistanceY EnumeratorBoutKinPar.beat2beatSpeedX EnumeratorBoutKinPar.beat2beatSpeedY EnumeratorBoutKinPar.beat2maxTailChange...
%     EnumeratorBoutKinPar.beat3beatDuration EnumeratorBoutKinPar.beat3beatAmplitude1 EnumeratorBoutKinPar.beat3beatAmplitude2 EnumeratorBoutKinPar.beat3beatAmplitude3 EnumeratorBoutKinPar.beat3beatAmplitude4 EnumeratorBoutKinPar.beat3beatAmplitude5...
%     EnumeratorBoutKinPar.beat3beatAmplitude6 EnumeratorBoutKinPar.beat3beatAmplitude7 EnumeratorBoutKinPar.beat3beatAngle EnumeratorBoutKinPar.beat3beatMaxAngle EnumeratorBoutKinPar.beat3beatMaxAngularSpeed ...
%     EnumeratorBoutKinPar.beat3beatDistanceX  EnumeratorBoutKinPar.beat3beatDistanceY EnumeratorBoutKinPar.beat3beatSpeedX EnumeratorBoutKinPar.beat3beatSpeedY EnumeratorBoutKinPar.beat3maxTailChange];
%     
   
indKinNames = {'boutMaxAngularSpeed', 'boutAvrAngularSpeed', 'maxTailChangeMax', 'meanTailChangeMax',  ...
    'headMaxYaw', 'headMeanYaw', 'boutMaxAngle' ,'boutAngle', 'maxBoutFreqCorr', ...
    'boutAmplitude1Max' 'boutAmplitude2Max' 'boutAmplitude3Max' 'boutAmplitude4Max'...
    'boutAmplitude5Max' 'boutAmplitude6Max' 'boutAmplitude7Max' 'boutAmplitudeDiff' 'C1Angle' 'C1MaxAngularSpeed'...
    'C2Angle' 'C2MaxAngularSpeed' 'C1Duration' 'C2Duration' 'boutSpeedY' 'boutDistanceY'...
    'boutDuration'...
    'beat1beatDuration' 'beat1beatAmplitude1' 'beat1beatAmplitude2' 'beat1beatAmplitude3' 'beat1beatAmplitude4' 'beat1beatAmplitude5'...
    'beat1beatAmplitude6' 'beat1beatAmplitude7' 'beat1beatAngle' 'beat1beatMaxAngle' 'beat1beatMaxAngularSpeed' ...
    'beat1beatDistanceX'  'beat1beatDistanceY' 'beat1beatSpeedX' 'beat1beatSpeedY' 'beat1maxTailChange'...    
    'beat2beatDuration' 'beat2beatAmplitude1' 'beat2beatAmplitude2' 'beat2beatAmplitude3' 'beat2beatAmplitude4' 'beat2beatAmplitude5'...
    'beat2beatAmplitude6' 'beat2beatAmplitude7' 'beat2beatAngle' 'beat2beatMaxAngle' 'beat2beatMaxAngularSpeed' ...
    'beat2beatDistanceX'  'beat2beatDistanceY' 'beat2beatSpeedX' 'beat2beatSpeedY' 'beat2maxTailChange'...
    'beat3beatDuration' 'beat3beatAmplitude1' 'beat3beatAmplitude2' 'beat3beatAmplitude3' 'beat3beatAmplitude4' 'beat3beatAmplitude5'...
    'beat3beatAmplitude6' 'beat3beatAmplitude7' 'beat3beatAngle' 'beat3beatMaxAngle' 'beat3beatMaxAngularSpeed' ...
    'beat3beatDistanceX'  'beat3beatDistanceY' 'beat3beatSpeedX' 'beat3beatSpeedY' 'beat3maxTailChange'};
    
   
%%

meanAllVar = behavioralSpaceStructure.meanAllVar;
stdAllVar = behavioralSpaceStructure.stdAllVar;
COEFF = behavioralSpaceStructure.COEFF;
latent = behavioralSpaceStructure.latent;
indKinPars = behavioralSpaceStructure.indKinPars;
meanPCASpace = behavioralSpaceStructure.meanPCASpace;


%%
%%%%%%%%%%% look at loadings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% figure
% bar(COEFF(1:3,:)')


[loadingsOfPC1,idxLoadingsOfPC1] = sort(abs(COEFF(:,1)),'descend');
[loadingsOfPC2,idxLoadingsOfPC2] = sort(abs(COEFF(:,2)),'descend');
[loadingsOfPC3,idxLoadingsOfPC3] = sort(abs(COEFF(:,3)),'descend');
[loadingsOfPC4,idxLoadingsOfPC4] = sort(abs(COEFF(:,4)),'descend');
[loadingsOfPC5,idxLoadingsOfPC5] = sort(abs(COEFF(:,5)),'descend');
[loadingsOfPC6,idxLoadingsOfPC6] = sort(abs(COEFF(:,6)),'descend');

% for n = 1 : size(COEFF,2)
%     
%     sum(COEFF(:,n));
%     
%     
% end

% col = jet(6);
% figure
% plot(loadingsOfPC1,'-','color',col(6,:))
% hold on
% plot(loadingsOfPC2,'-','color',col(5,:))
% hold on
% plot(loadingsOfPC3,'-','color',col(4,:))
% hold on
% plot(loadingsOfPC4,'-','color',col(3,:))
% hold on
% plot(loadingsOfPC5,'-','color',col(2,:))
% hold on
% plot(loadingsOfPC6,'-','color',col(1,:))
% 

% box off

% xlabel('')\

numbOfBestKinPars = 5;


contributionKinParPC1 = indKinNames(idxLoadingsOfPC1(1:numbOfBestKinPars))
contributionKinParPC2 = indKinNames(idxLoadingsOfPC2(1:numbOfBestKinPars))
contributionKinParPC3 = indKinNames(idxLoadingsOfPC3(1:numbOfBestKinPars))
contributionKinParPC4 = indKinNames(idxLoadingsOfPC4(1:numbOfBestKinPars))
contributionKinParPC5 = indKinNames(idxLoadingsOfPC5(1:numbOfBestKinPars))
contributionKinParPC6 = indKinNames(idxLoadingsOfPC6(1:numbOfBestKinPars))

