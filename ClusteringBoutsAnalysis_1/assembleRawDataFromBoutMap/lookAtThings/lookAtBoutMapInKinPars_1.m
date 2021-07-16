
clear all 
close all


%%
folder = 'C:\JoaoStuff\boutTypeStuff\FreeData\boutTypeProject\boutClustering\boutMaps\14Solution\';
filename = 'BoutMapCentersWithRaw_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_withChasingDots_2.mat';

load(strcat(folder,filename))


%%
boutAmplitude7Max = BoutKinematicParametersFinalArray(:, EnumeratorBoutKinPar.boutAmplitude7Max);

maxBoutFreqCorr = BoutKinematicParametersFinalArray(:, EnumeratorBoutKinPar.maxBoutFreqCorr);


col = finalClustering.col;
idx = finalClustering.idx;

uniqueBoutCat = unique(boutCatFinalArray);


figure
for n = 1 : length(uniqueBoutCat)
    
    
   indThisBoutType = find(boutCatFinalArray == uniqueBoutCat(idx(n))); 
   
   plot(boutAmplitude7Max(indThisBoutType),maxBoutFreqCorr(indThisBoutType), '.', 'color', col(n,:))
    
    hold on
    pause
end


axis([-300 300 0 100 ])
axis square

