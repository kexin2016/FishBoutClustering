
g =3;
numbDim =3;
densityType = 'local';
% scallingFactor = 1.75;
scallingFactor = 1;


thisInds = indStructure(g).thisInds;
%  kdedens = indStructure(g).kdedens;
% originalBandWidths = indStructure(g).originalBandWidths;
densities = indStructure(g).densities;
thisIndRand = indStructure(g).thisIndRand;
% kdedensCutOff = indStructure(g).kdedensCutOff;
% bandWidthsScalled = indStructure(g).bandWidthsScalled;
densitiesScalled = indStructure(g).densitiesScalled;
% scallingFactor = indStructure(g).scallingFactor;

clearvars kdedens kdedensCutOff  bandWidthsScalled  originalBandWidths

%%
%%%%%%%%%%%%%% recalculate kedens %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %get all data for this data set
 dataThisDataSet = boutDataPCASample(thisInds, 1:numbDim);

kdedens = kde(dataThisDataSet',densityType);
 %get original bandwiths
    originalBandWidths = getBW(kdedens);

%   adjustBW(kdedens,originalBandWidths);

    densities2 = evaluate(kdedens,dataThisDataSet');
    densities3 = evaluate(kdedens,boutDataPCASample(thisIndRand,1:numbDim)');
    
    
%%
%%%%%%%%%%%%%% apply cut off %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
 densityType = 'local';
makeplot = 1;

[kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBW_1(dataThisDataSet,kdedens,scallingFactor,densityType,makeplot);

%  adjustBW(kdedensCutOff,bandWidthsScalled);

  densitiesScalled2 = evaluate(kdedensCutOff,dataThisDataSet');
   densitiesScalled3 = evaluate(kdedensCutOff,boutDataPCASample(thisIndRand,1:numbDim)');



 %%
%%%%%%%%%%%%%%%%% make plot thisIndRand%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densities,'.','color','k')
hold on
% plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densitiesScalled,'.','color','g')
hold on
plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densities3,'.','color','r')
hold on
plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densitiesScalled3,'.','color','c')


%  axis([-10 20 -15 15 -15 15])  
 axis square
