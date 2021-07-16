AddFunctionToPath

close all
clear all

%%
%%%%%%%%%%%%%% defien number of workers to use %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%matlabpool('close');

%close matlabpool if it is already opened
if matlabpool('size') ~= 0 % checking to see if my pool is already open
    
    matlabpool close
%     matlabpool open numberOfWorkers
    
    
end

%start matlab pool with number of corrers
matlabpool open 4

 %%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick file of data set to analyse
%allBoutDataPCA1stAnd2ndBeatKins_1.mat

[FileName,PathName] =  uigetfile('*.*');

load(strcat(PathName,FileName));

% pause

%%
%%%%%%%%%%%%% exclude broken bouts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pickFirstBout = 0;
edgeLim = 50;

[exclusionBoutStructure,indBadBouts,indBoutsForPCA] = boutExcluder_1(BoutInf,pickFirstBout,edgeLim);


 mistakesIn74KinSpace = BoutInf(:,EnumeratorBoutInf.mistakesIn74KinSpace);

indMistakes = find(mistakesIn74KinSpace == 1);

indBadBouts = unique([indBadBouts',indMistakes']');

indGoodBouts = 1 : length(boutDataPCASample);

indGoodBouts(indBadBouts) = [];


% figure
% plot3(boutDataPCASample(:,1),boutDataPCASample(:,2),boutDataPCASample(:,3), '.k')
% hold on
% plot3(boutDataPCASample(indGoodBouts,1),boutDataPCASample(indGoodBouts,2),boutDataPCASample(indGoodBouts,3), 'og')

%%
% %%%%%%%%%%%%%%%%%%%%% create indStructure test%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %it creats indStructure for 1st stim
% 
% % [indStructure] = indStructureCreator_test(BoutInf,indGoodBouts);
% makeplot = 0;
% [indStructure] = indStructureCreator_OMRTurns2Test(BoutInf,indGoodBouts,boutDataPCASample,makeplot);
% 

%%
%%%%%%%%%%%%%%%%%%%%% create indStructure test%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makeplot =0;

[indStructure] = indStructureCreator_LightTransitions4_2(BoutInf,indGoodBouts,boutDataPCASample,makeplot);

%%
%%%%%%%%%%%%% look at size of data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for g =  1 : length(indStructure)

    
thisInds = indStructure(g).thisInds;

sizeOfDataSet(g) = length(thisInds);

end
 
 
 max(sizeOfDataSet)
 
 disp('clustering...')
% pause

%%
%%%%%%%%%%%%%%% calcualte kde obj with all the bouts %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numberOfBouts = 10000;%medium
% numberOfBouts = 5000;%slow ?
numberOfBouts = 3000;%slow ?

col = jet(length(indStructure));
numbOfDims = 3;
scallingFactor =1.75;

% figure
% pause
% tic
for g =  1 : length(indStructure)
% g = 78
%     g = 1

densityType = 'local';

% g =1

thisInds = indStructure(g).thisInds;
g
length(thisInds)

 if ~isempty(thisInds) %avoid datasets that were not done yet 

%%
%%%%%%%%%%%%% make kde obj %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%it uses all the bouts

%     tic
    kdedens = kde(boutDataPCASample(thisInds,1:numbOfDims)',densityType);
%     toc
  
    
    originalBandWidths = getBW(kdedens);

    
    %%
    %%%%%%%%%%%%% small data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %sample 5000 bouts for big data sets    
    
       if length(thisInds) < numberOfBouts
       
           numberOfBouts2 = length(thisInds);
           
       else
       
       
        numberOfBouts2 = numberOfBouts;
        
       end

    
    
    %pick random bouts
    indPerm = randperm(length(thisInds));
    thisIndRand = thisInds(indPerm(1:numberOfBouts2));
%     end
    
dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:numbOfDims);

    %calcualte densities
     densities = evaluate(kdedens,dataThisDataSetRand');
%      densitiesCutOff = evaluate(kdedensCutOff,boutDataPCASample(thisIndRand,1:3)');


     
%%
%%%%%%%%%%%%%%% save stuff in structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indStructure(g).kdedens =  kdedens;
indStructure(g).originalBandWidths = originalBandWidths;
indStructure(g).densities = densities;
indStructure(g).thisIndRand = thisIndRand;


%%
%%%%%%%%%%%%%%%% apply kde cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adjustBW(kdedens,originalBandWidths);


% densityType = 'local';
makeplot = 0;

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBW_1(dataThisDataSetRand',kdedens,scallingFactor,densityType,makeplot);

densitiesScalled = evaluate(kdedensCutOff,boutDataPCASample(thisIndRand,1:numbOfDims)');

%%
%%%%%%%%%%%% save stuff scalled densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indStructure(g).kdedensCutOff = kdedensCutOff;
indStructure(g).bandWidthsScalled = bandWidthsScalled;
indStructure(g).densitiesScalled = densitiesScalled;
indStructure(g).scallingFactor = scallingFactor;

     %%
%      %%%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     subplot(1,2,1)
%     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densities,'.','color',col(g,:))
%     hold on
%     axis([-10 15 -10 10 0 0.07])
% 
% %     subplot(1,2,2)
% %     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densitiesCutOff,'.','color',col(g,:))
% %     hold on
% %     axis([-10 15 -10 10 0 0.07])

%%
%%%%%%%%%%%%%% calcualte funnymeasure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
densityType = 'local';
linedensityMethod = 'slowPar';
numextra = sqrt(length(dataThisDataSetRand));
nsamps = 10;
multirep = 0;
makeplot = 0;
numbPointsToShow = 40;
clusterThreshold = 0.000001;%sometimes is has really small numbers - don't know why

 tic
[rho,realRho,delta,funnymeasure,funnymeasureSorted,maxjump,rhoRand,realRhoRand,deltaRand,funnymeasureRand,funnymeasureRandSorterAvr,clusterCentersSortedIdx] = findClusterCentersDensityValley_2(dataThisDataSetRand,kdedensCutOff,densityType,linedensityMethod,numextra,nsamps,multirep,numbPointsToShow,clusterThreshold,makeplot);
 toc

%%
%%%%%%%%%%%% Add variables to indStructure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indStructure(g).rho = rho;
indStructure(g).realRho = realRho;
indStructure(g).delta = delta;
indStructure(g).maxjump = maxjump;
indStructure(g).funnymeasure = funnymeasure;
indStructure(g).clusterCentersSortedIdx = clusterCentersSortedIdx;


end
  
end

% toc 



% pause

%%
%%%%%%%%%%%%%%% look at data sets in multiple dimentions %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
col = jet(length(indStructure));
for g = 1 : length(indStructure)
    
    thisIndRand = indStructure(g).thisIndRand;
    densities = indStructure(g).densities;
     densitiesScalled = indStructure(g).densitiesScalled;
%   clf    
subplot(1,2,1)
 plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densities,'.','color',col(g,:))
 hold on
%  axis([-10 20 -15 15 -15 15])  
 title(g)   
    
 subplot(1,2,2)
 plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densitiesScalled,'.','color',col(g,:))
 hold on
%  axis([-10 20 -15 15 -15 15])  
 title(g)   
end




%%
%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('funnymeasure_LightTransitions4_74Kins3dims_1.75Smooth_slow_3000_pairs.mat','BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')



matlabpool('close');











