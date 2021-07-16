
AddFunctionToPath

  close all
clear all


%%
%%%%%%%%%%%%%%%%%%%%%% load all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PathName = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\';
FileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated3.mat';


 load(strcat(PathName,FileName),'BoutInf')
 load(strcat(PathName,FileName),'finalClustering')
 load(strcat(PathName,FileName),'boutDataPCASample')
 load(strcat(PathName,FileName),'BoutKinematicParameters')


%%
%%%%%%%%%%%%%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_corr_1(BoutInf,pickFirstBout,edgeLim);

mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);

indKinSpaceMistake = find(mistakesIn74KinSpace);

indExcludedBoutsAll  = unique([indBadBouts' indKinSpaceMistake']');

indAllGoodBouts = 1 : length(BoutInf);
indAllGoodBouts(indExcludedBoutsAll) = [];


% BoutKinematicParametersGood = BoutKinematicParameters(indAllGoodBouts,:);
% BoutInfGood  = BoutInf(indAllGoodBouts,:);


%%
%%%%%%%%%%%%%%%%%%%%% choose behaviours %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[indStimSctructure,stimNameAll] = makeIndStimSctructure_ForBehaviours(BoutInf,BoutKinematicParameters);



%%
%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kinPar1 = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutMaxAngle);
kinPar2 = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutMaxAngularSpeed);

kinPar3 = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutAngle);
kinPar4 = BoutKinematicParameters(:,EnumeratorBoutKinPar.boutDistanceX);

kinPar5 = BoutKinematicParameters(:,EnumeratorBoutKinPar.C2MaxAngularSpeed);
kinPar6 = BoutKinematicParameters(:,EnumeratorBoutKinPar.C2Angle);

numbBouts = 2000;

counter = 1;
for n = 1 :length(indStimSctructure)
    
    
    thisInds = indStimSctructure(n).ind;
    
    indPerm = randperm(length(thisInds));
    thisIndsRand = thisInds(indPerm(1:numbBouts));

    figure
%     subplot(9,3,counter)
    plot(kinPar1(thisIndsRand),kinPar2(thisIndsRand), 'k.', 'markersize',1)
    hold on
    axis square
        axis([0 360 -10 30])
        axis off

        figure
%      subplot(9,3,counter+1)
     plot(kinPar3(thisIndsRand),kinPar4(thisIndsRand), 'k.', 'markersize',1)
    hold on
    axis square
        axis([-200 200 -10 20])
        axis off

%         subplot(9,3,counter+2)
figure
     plot(kinPar5(thisIndsRand),kinPar6(thisIndsRand), 'k.', 'markersize',1)
    hold on
    axis square
    axis([0 20 0 360])
    axis off

    
    
    
    
    counter = counter +3;
end

