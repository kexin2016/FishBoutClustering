
% clear all 
% close all


%%
% folder = 'C:\JoaoStuff\boutTypeStuff\FreeData\boutTypeProject\boutClustering\boutMaps\14Solution\';
% filename = 'BoutMapCentersWithRaw_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_withChasingDots_2.mat';
% 
% load(strcat(folder,filename))

boutDuration = BoutKinematicParametersFinalArray(:, EnumeratorBoutKinPar.boutDuration);
distBoutDuration = BoutKinematicParametersFinalArray(:, EnumeratorBoutKinPar.distBoutDuration);


boutDurationInFrames = boutDuration*0.7;
boutDurationInFrames = boutDurationInFrames';

distBoutDurationInFrames = distBoutDuration*0.7;
distBoutDurationInFrames = distBoutDurationInFrames';


indBoutEndByTail = indBoutStartAllDataInFinalArray  + boutDurationInFrames;
indBoutEndByGliding = indBoutStartAllDataInFinalArray  + distBoutDurationInFrames;




%%
figure

plot(FishDataMap(:,3:9))
hold on
% plot(FishDataMap(:,3), '-k')


oneArray = zeros(1,length(indBoutStartAllDataInFinalArray)) + 2;

plot(indBoutStartAllDataInFinalArray + 20,oneArray, 'og')
hold on
plot(indBoutEndAllDataInFinalArray - 20,oneArray, 'or')
plot(indBoutEndAllDataInFinalArrayByTail +20,oneArray, 'oc')
plot(indBoutEndByGliding -20,oneArray, 'ok')

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
% 
% indBoutStartAllData2 = BeatInfFinalArray(:,EnumeratorBoutInf.indBoutStartAllData);
% indBoutEndAllData2 = BeatInfFinalArray(:,EnumeratorBoutInf.indBoutEndAllData);
% 
% indBeatStartAllData2 = BeatInfFinalArray(:,EnumeratorBeatInf.indBeatStartAllData);
% indBeatEndAllData2 = BeatInfFinalArray(:,EnumeratorBeatInf.indBeatEndAllData); 
% 
% upDown = BeatKinematicParametersFinalArray(:,EnumeratorBeatKinPar.upDown);
% 
% indZero = find(upDown == 0);
% indOne = find(upDown == 1);
% 
% oneArrayBeats = zeros(1,length(indBeatStartAllData2(indZero))) + 0.5;
% minusOneArrayBeats = zeros(1,length(indBeatEndAllData2(indOne))) - 0.5;
% 
% 
% figure
% plot(FishDataMap(:,3:9))
% hold on
% % plot(FishData(:,3), '-k')
% 
% oneArray = zeros(1,length(indBoutStartAllData2)) + 2;
% 
% plot(indBoutStartAllData2,oneArray, 'og')
% hold on
% plot(indBoutEndAllData2,oneArray, 'or')
% axis([1 1000 -2 2])
% 
% 
%     
% plot(indBeatStartAllData2(indZero),oneArrayBeats, '.g')
% plot(indBeatEndAllData2(indZero),oneArrayBeats, '.r')
% 
% plot(indBeatStartAllData2(indOne),minusOneArrayBeats, '.g')
% plot(indBeatEndAllData2(indOne),minusOneArrayBeats, '.r')
% 
% 
