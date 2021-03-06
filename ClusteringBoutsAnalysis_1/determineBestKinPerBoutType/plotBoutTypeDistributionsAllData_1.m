
% AddFunctionToPath
% 
% close all
% clear all


%%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %pick file of data set to analyse ROC_PreliminaryData74Kins3dimWithCutOffMedium_moreDivided
% [FileName,PathName] =  uigetfile('*.*');
% 
% load(strcat(PathName,FileName));


%  load('C:\Joao analysis\FreeData\clusteringData\assignAllData\BoutCat_AllDataWithLightTransitionsNoIndPrey_74Kins3dims_1.75Smooth_slow_100thres_tsne3_kNeighbor4.mat');

% col = ([147 112 219; 102 255 255; 255 170 0; 220 0 220; 255 0 50; 250 128 114;105 255 102;0 150 255; 0 0 200;0 153 0;255 255 0])./255;
col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;



%%
%%%%%%%%%%%%% plot bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

finalData = finalClustering.dataToDoMap;
mapAssignment = finalClustering.assignment;
indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;

uniqueBoutType = unique(mapAssignment);
% col = jet(length(uniqueBoutType));
% figure
% for h = 1 : length(uniqueBoutType)
%     
%     indThisBoutType = find(mapAssignment == uniqueBoutType(h));
% %     subplot(3,4,h)
% %     plot3(finalData(indThisBoutType,1),finalData(indThisBoutType,2),finalData(indThisBoutType,3),'.','color',col(h,:))
%     plot(finalData(indThisBoutType,1),finalData(indThisBoutType,2),'.','color',col(h,:))
% 
%     hold on
%     axis([-15 22 -10 15])
%     axis square
%     title(h)
% %      pause
% end
% axis square

%%
%%%%%%%%%%%%%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);

mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);

indKinSpaceMistake = find(mistakesIn74KinSpace);

indExcludedBoutsAll  = unique([indBadBouts' indKinSpaceMistake']');

indGoodBouts = 1 : length(BoutInf);
indGoodBouts(indExcludedBoutsAll) = [];


%%
%%%%%%%%%%%%%%% log of all kin pars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kinData = abs(BoutKinematicParameters);
maxKinPars = zeros(1,size(kinData,2));

for n = 1 : size(kinData,2)
    
    maxKinPars(n) = max(kinData(~isinf(kinData(:,n)),n))/100;
    
    kinData(:,n) = kinData(:,n) + maxKinPars(:,n);
    
end

%do log
              kinData = log(kinData);


%%
%%%%%%%%%%%%%%%% pick data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%AS against slow 1
indKinPars = EnumeratorBoutKinPar.boutAmplitude3Max;
boutType1 = 1;
boutType2 = 2;
lowerBoundery = 5.2;
higherBoundery = 5.5;

%slow 1 against slow 2
indKinPars = EnumeratorBoutKinPar.maxTailChangeMax;
boutType1 = 2;
boutType2 = 3;
lowerBoundery = 3;
higherBoundery = 3.3;

%O bends against SARS
indKinPars = EnumeratorBoutKinPar.boutAmplitude2Max;
boutType1 = 8;
boutType2 = 9;
lowerBoundery = 5;
higherBoundery = 5.6;


% %Hat against RT
% indKinPars = EnumeratorBoutKinPar.boutAmplitude2Max;
% boutType1 = 6;
% boutType2 = 7;
% lowerBoundery = 4.8;
% higherBoundery = 5.4;


numbOfHistDivisions = 100;

boutCat = BoutInf(:,EnumeratorBoutInf.boutCat);
thisKinPar = kinData(:,indKinPars);


xVector = lowerBoundery:(higherBoundery/numbOfHistDivisions):higherBoundery;

xVector = linspace(lowerBoundery,higherBoundery,numbOfHistDivisions)

indThisBoutType1 = intersect(indGoodBouts,find(boutCat == boutType1));
indThisBoutType2 = intersect(indGoodBouts,find(boutCat == boutType2));

thisKinThisBoutType1 = thisKinPar(indThisBoutType1);
thisKinThisBoutType2 = thisKinPar(indThisBoutType2);

[N1]= hist(thisKinThisBoutType1,xVector);
[N2]= hist(thisKinThisBoutType2,xVector);

figure
plot(xVector,N1/sum(N1),'color',col(boutType1,:),'linewidth',2)
hold on
plot(xVector,N2/sum(N2),'color',col(boutType2,:),'linewidth',2)
axis square


%%
%%%%%%%%%%%%% test ROC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inds1 = 1 : length(thisKinThisBoutType1);
indPerm1 = randperm(length(inds1));
indRand1 = inds1(indPerm1(1:1000));

inds2 = 1 : length(thisKinThisBoutType2);
indPerm2 = randperm(length(inds2));
indRand2 = inds2(indPerm2(1:1000));


thisKinThisBoutType1Rand = thisKinThisBoutType1(indRand1);
thisKinThisBoutType2Rand = thisKinThisBoutType2(indRand2);

  dataTogether = [thisKinThisBoutType1Rand' thisKinThisBoutType2Rand']';

    indsDist = [(zeros(1,length(thisKinThisBoutType1Rand))-1) (zeros(1,length(thisKinThisBoutType2Rand))+1)];

    [ROCareaThis,~,~,~,~,~,~,~,~] = roc_sv(dataTogether,indsDist,'nofigure');
    
    ROCKinMatrixAllComp = abs(ROCareaThis - 0.5) + 0.5
   

