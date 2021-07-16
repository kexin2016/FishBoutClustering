
clear all 
close all

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% load stuff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change path hweere bout map is

folder = 'C:\JoaoStuff\boutTypeStuff\FreeData\boutTypeProject\boutClustering\boutMaps\14Solution\';
filename = 'BoutMapCentersWithRaw_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_withChasingDots_2.mat';

load(strcat(folder,filename))


%%
%%%%%%%%%%%%% choose bout type %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%cat numbers in boutCatFinalArray:
%AS - 3
%slow 1 -  12
%slow 2 -  10
%sbort capture swim - 1
%long capture swim - 2
%burst swim - 14
%J-turn - 4
%High angle turn - 13
%Routine turn -  9
%Spot avoidance turn - 7
%O-bend - 6 
%Long latency C-start -  11
%Short latency C-start - 8
%Visual C-start - 5

choosenBoutType = 5;


%%
%%%%%%%%%%%%%%%%%%%% calculate end of bouts in frames %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


boutDuration = BoutKinematicParametersFinalArray(:, EnumeratorBoutKinPar.boutDuration);
distBoutDuration = BoutKinematicParametersFinalArray(:, EnumeratorBoutKinPar.distBoutDuration);


boutDurationInFrames = boutDuration*0.7;
boutDurationInFrames = boutDurationInFrames';

distBoutDurationInFrames = distBoutDuration*0.7;
distBoutDurationInFrames = distBoutDurationInFrames';

%end by tail
indBoutEndByTail = indBoutStartAllDataInFinalArray  + boutDurationInFrames;

%end by gliding - 10 frames different that actual concatenation
indBoutEndByGliding = indBoutStartAllDataInFinalArray  + distBoutDurationInFrames;


%%
%%%%%%%%%%%%%%%%% plot raw data by bout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% idx = finalClustering.idx;%to order bout types
% idx = finalClustering.col;


indThisBoutType = find(boutCatFinalArray == choosenBoutType);


figure
for n = 1 : length(indThisBoutType)
    clf
    
    tailDataThis = FishDataMap((indBoutStartAllDataInFinalArray(indThisBoutType(n))):(indBoutEndByTail(indThisBoutType(n))),3:9)*180/pi;
    plot(tailDataThis)
    
    
    ylim([-300, 300])
    xlim([0, 200])

    pause
end


