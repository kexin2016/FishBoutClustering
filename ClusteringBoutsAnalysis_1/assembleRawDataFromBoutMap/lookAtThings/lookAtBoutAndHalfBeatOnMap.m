
clear all 
close all


%%
folder = 'C:\JoaoStuff\boutTypeStuff\FreeData\boutTypeProject\boutClustering\boutMaps\14Solution\';
filename = 'BoutMapCentersWithRaw_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_withChasingDots_2.mat';

load(strcat(folder,filename))


%%
figure

plot(FishDataMap(:,3:9))
hold on
% plot(FishDataMap(:,3), '-k')


oneArray = zeros(1,length(indBoutStartAllDataInFinalArray)) + 2;

plot(indBoutStartAllDataInFinalArray + 20,oneArray, 'og')
hold on
plot(indBoutEndAllDataInFinalArray - 20,oneArray, 'or')
axis([1 300 -2 2])


upDown = BeatKinematicParametersFinalArray(:,EnumeratorBeatKinPar.upDown);

indZero = find(upDown == 0);
indOne = find(upDown == 1);

oneArrayBeats = zeros(1,length(indBeatStartAllDataInFinalArray(indZero))) + 0.5;
minusOneArrayBeats = zeros(1,length(indBeatStartAllDataInFinalArray(indOne))) - 0.5;

plot(indBeatStartAllDataInFinalArray(indZero),oneArrayBeats, '.g')
plot(indBeatEndAllDataInFinalArray(indZero),oneArrayBeats, '.r')

plot(indBeatStartAllDataInFinalArray(indOne),minusOneArrayBeats, '.g')
plot(indBeatEndAllDataInFinalArray(indOne),minusOneArrayBeats, '.r')


%%

indBoutStartAllData2 = BoutInf(:,EnumeratorBoutInf.indBoutStartAllData);
indBoutEndAllData2 = BoutInf(:,EnumeratorBoutInf.indBoutEndAllData);

indBeatStartAllData2 = BeatInf(:,EnumeratorBeatInf.indBeatStartAllData);
indBeatEndAllData2 = BeatInf(:,EnumeratorBeatInf.indBeatEndAllData); 

upDown = BeatKinematicParameters(:,EnumeratorBeatKinPar.upDown);

indZero = find(upDown == 0);
indOne = find(upDown == 1);

oneArrayBeats = zeros(1,length(indBeatStartAllData2(indZero))) + 0.5;
minusOneArrayBeats = zeros(1,length(indBeatEndAllData2(indOne))) - 0.5;


figure
plot(FishData(:,3:9))
hold on
% plot(FishData(:,3), '-k')

oneArray = zeros(1,length(indBoutStartAllData2)) + 2;

plot(indBoutStartAllData2,oneArray, 'og')
hold on
plot(indBoutEndAllData2,oneArray, 'or')
axis([1 1000 -2 2])


    
plot(indBeatStartAllData2(indZero),oneArrayBeats, '.g')
plot(indBeatEndAllData2(indZero),oneArrayBeats, '.r')

plot(indBeatStartAllData2(indOne),minusOneArrayBeats, '.g')
plot(indBeatEndAllData2(indOne),minusOneArrayBeats, '.r')


