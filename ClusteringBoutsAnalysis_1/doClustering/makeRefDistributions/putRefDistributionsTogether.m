



%%
%%%%%%%%%%%% import first %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

referenceDistributionInfAll = referenceDistributionInf;


%%
%%%%%%%%%%%% import second %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

referenceDistributionInfAll(2).resampleNumber = referenceDistributionInf.resampleNumber;
referenceDistributionInfAll(2).resampleMethod = referenceDistributionInf.resampleMethod;
referenceDistributionInfAll(2).clusteringResamplingNumber = referenceDistributionInf.clusteringResamplingNumber;
referenceDistributionInfAll(2).numbOfRepetitions = referenceDistributionInf.numbOfRepetitions;
referenceDistributionInfAll(2).densityType = referenceDistributionInf.densityType;
referenceDistributionInfAll(2).scallingFactor = referenceDistributionInf.scallingFactor;
referenceDistributionInfAll(2).linedensityMethod = referenceDistributionInf.linedensityMethod;
referenceDistributionInfAll(2).nsamps = referenceDistributionInf.nsamps;
referenceDistributionInfAll(2).clusterThreshold = referenceDistributionInf.clusterThreshold;
referenceDistributionInfAll(2).funnymeasureRandThreshold = referenceDistributionInf.funnymeasureRandThreshold;
referenceDistributionInfAll(2).funnymeasureRandThresholdDist = referenceDistributionInf.funnymeasureRandThresholdDist;
referenceDistributionInfAll(2).All = referenceDistributionInf.All;

referenceDistributionInf = referenceDistributionInfAll;



save('resampleDist_Onion_Slow_1.75_until1500.mat','referenceDistributionInf')


