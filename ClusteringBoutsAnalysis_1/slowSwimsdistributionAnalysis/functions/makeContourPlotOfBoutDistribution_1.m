function [] = makeContourPlotOfBoutDistribution_1(boutDataPCASample,indStructure,indDataSet,axisVector,titleName,subplotRow,subplotCol,nBins,contourEdge,contourLevels)

%%
%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% indDataSet= [51 53 55 52 54 56];
% 
% titleName = {'Prey Capture eye conv','Prey Capture Naive eye conv ','spont eye conv',...
%     'Prey Capture non eye conv','Prey Capture Naive non eye conv ','spont non eye conv'};
% 
% axisVector = [-15 0 -5 5];
% subplotRow = 2;
% subplotCol = 3;
% nBins = 20;
% axisVector = [-15 0 -5 5];
% contourEdge = 0.5;
% contourLevels = 5;

%%
%%%%%%%%%%%%%% make bins %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xb = linspace(axisVector(1) - contourEdge,axisVector(2) + contourEdge,nBins);
yb = linspace(axisVector(3) - contourEdge,axisVector(4) + contourEdge,nBins);

edges{1} = xb;
edges{2} = yb;


%%
%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 figure
 
for i = 1:length(indDataSet)%length(indStructure)%loop through each data set
%     i =1
%      figure
% 
%       clf

 if indDataSet(i) >= 1
      subplot(subplotRow,subplotCol,i)

    thisIndRand = indStructure(indDataSet(i)).thisIndRand;
     realRho = indStructure(indDataSet(i)).realRho;
    dataThisDataSetRand = boutDataPCASample(thisIndRand, 1:3);
    
%     subplot(1,3,1)
%     plot(dataThisDataSetRand(:,1),dataThisDataSetRand(:,2), '.')
%     axis square
%     axis(axisVecto)
    
    
%    subplot(1,3,2)
% 
%    scatter(dataThisDataSetRand(:,1),dataThisDataSetRand(:,2),3,realRho,'filled')
%     axis square
% %     axis([6 20 -6 8]) 
%      axis(axisVector) 
    
    
  [N,~] = hist3([dataThisDataSetRand(:,1),dataThisDataSetRand(:,2)],'Edges',edges);
  
  %make frequency to peak
    NNorm = N./max(max(N));
    
%   subplot(1,3,3)

 contourf(xb,yb,NNorm.',contourLevels)
axis square  
axis(axisVector)
title(titleName{i});
box off

if i == 1
   xlabel('PC 1')
   ylabel('PC 2')
end

 end
 end