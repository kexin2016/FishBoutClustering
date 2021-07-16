% close all
% clear all
% 

%%
% % load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat')
%   load('C:\Joao analysis\FreeData\clusteringData\final\BoutMapWithRawWithHalfbeats_kNN4_74Kins5dims_1.75Smooth_slow_3000_auto_12ClusterSolution.mat');
% 

  
  
%%
%%%%%%%%%%%%%%%%%% look at half beats by seq in bout %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



numbBeatInBout = BeatKinematicParametersFinalArray(:,EnumeratorBeatKinPar.numbBeatInBout);

indStruct(1).inds = find(numbBeatInBout == 1);
indStruct(2).inds = find(numbBeatInBout == 2);
indStruct(3).inds = find(numbBeatInBout == 3);
indStruct(4).inds = find(numbBeatInBout > 3);

indperm = randperm(5000);


figure
for n = 1 : length(indStruct)
    
    subplot(2,2,n)
    
    inds = indStruct(n).inds;
plot( BeatKinematicParametersFinalArray(inds(indperm),EnumeratorBeatKinPar.beatAmplitude8),BeatKinematicParametersFinalArray(inds(indperm),EnumeratorBeatKinPar.beatDuration), 'k.')
axis square
axis([-300 300 0 70])


    
end


  
%%
%%%%%%%%%%%%%%%%%% look at half beats by bout type %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutType = unique(BoutCatInHalfBeatFinalArray);

col = jet(length(indStruct));
indperm = randperm(500);
boutName = {'Slow 2','Routine turn','Burst swim','Approach swim','Slow 1','Routine turn2','SAR','LLC','C start','HAT','O bend','J turn'};
idx = [4 5 1 3 12 10 2 6 7 11 8 9];
figure
for n = 1 : length(uniqueBoutType)
    
    
    indThisBoutType = find( BoutCatInHalfBeatFinalArray == uniqueBoutType(idx(n)));
   
    subplot(2,6,n)
    
    for nn = 1 : length(indStruct)
        
    inds = indStruct(5-nn).inds;
    
    indThisBoutTypeThisSeq = intersect(indThisBoutType,inds);

    plot( BeatKinematicParametersFinalArray(indThisBoutTypeThisSeq(indperm),EnumeratorBeatKinPar.beatAmplitude8),BeatKinematicParametersFinalArray(indThisBoutTypeThisSeq(indperm),EnumeratorBeatKinPar.beatDuration), '.', 'color', col(nn,:))
    hold on
    axis square
    axis([-300 300 0 70])

    
        
    end
    title(boutName{(idx(n))})
 
end

xlabel('Half beat duration (ms)')
ylabel('Half beat max amplitude 8 (°)')