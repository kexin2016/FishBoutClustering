

%%
%%%%%%%%%%%%%%% import firle with PCA space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ex: PCA_FinalData_74Kins3dim_1


%%
%%%%%%%%%%%%%% kin pars to use %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % %26 + 1st beat kin pars + 2nd beat kin pars + 3rd beat kin pars
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
% 
%%
%%%%%%%%%%%%%%%%%% place raw data on normalized space %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%get inf to reconstruct space
meanAllVar = behavioralSpaceStructure.meanAllVar;
stdAllVar = behavioralSpaceStructure.stdAllVar;
maxKinPars = behavioralSpaceStructure.maxKinPars;
indKinPars = behavioralSpaceStructure.indKinPars;

%choose kin pars
 inputDataThisKins =  BoutKinematicParameters(:,indKinPars);

%reconstruct log abs
 kinData = abs(inputDataThisKins);

for i = 1 : size(kinData,2)
    
    
    kinData(:,i) = kinData(:,i) + maxKinPars(i);
    
end

%do log
    

kinData = log(kinData);
 

%reconstruct z score
zScoreThisData = zeros(size(kinData,1),size(kinData,2));

for ii = 1 : size(kinData,2)
 
     kinDataThis = kinData(:,ii);
     
     
     
     
    zScoreThisData(:,ii) = (kinDataThis  -  meanAllVar(ii))/(stdAllVar(ii));
    
    

end

%erase nans
zScoreThisData(isnan(zScoreThisData)) = 0;  



%%
%%%%%%%%%%%%%% pick part of data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


numberOfBouts = 200;
 %pick random bouts
 
 thisInds = 1 : 1 : length(boutDataPCASample);
 
 indPerm = randperm(length(thisInds));
 thisIndRand = thisInds(indPerm(1:numberOfBouts));

 
boutDataPCASampleRand = boutDataPCASample(thisIndRand,:);
zScoreThisDataRand = zScoreThisData(thisIndRand,:);


numberOfBouts2 = 200;
 %pick random bouts
 
 thisInds = 1 : 1 : length(boutDataPCASample);
 
 indPerm2 = randperm(length(thisInds));
 thisIndRand2 = thisInds(indPerm2(1:numberOfBouts2));

 
boutDataPCASampleRand2 = boutDataPCASample(thisIndRand2,:);
zScoreThisDataRand2 = zScoreThisData(thisIndRand,:);


%%
%%%%%%%%%%%%%%%% make par tsne %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % Set perplexity and network structure
    perplexity = 30;
    layers = [500 500 200 3];

    train_labels = zeros(1,length(zScoreThisDataRand));
    test_labels= zeros(1,length(zScoreThisDataRand2));
%     test_labels = zeros(1,length(zScoreThisDataRand));
    
     % Train the parametric t-SNE network
    [network, err] = train_par_tsne(zScoreThisDataRand,train_labels', zScoreThisDataRand2, test_labels', layers, 'CD1');
    
%       % Train the parametric t-SNE network
%     [network] = train_par_tsne(zScoreThisDataRand,[], [], [], layers, 'CD1');
%     
    
    % Construct training and test embeddings
    mapped_train_X = run_data_through_network(network, zScoreThisDataRand);
 
%%
%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure
subplot(1,2,1)
plot(boutDataPCASampleRand(:,1),boutDataPCASampleRand(:,2),'.')
 axis square

subplot(1,2,2)
plot(mapped_train_X(:,1),mapped_train_X(:,2), '.')
axis square