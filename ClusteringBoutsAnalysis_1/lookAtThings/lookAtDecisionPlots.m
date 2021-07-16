% close all

numbDim = 3;
%  indDataSet = 1 :1: 86;%All
%      indDataSet = [1 2 3 4 5 6 7 8 9 10 11 12 13];%omr turns
%      indDataSet = [14 15 16 17 18 19 20 21 22 23];%omr speed
%   
%     indDataSet = [24 25];
%   
%      indDataSet = 32:1:41;
%         indDataSet = 42:1:51;
%   
%
%  indDataSet = 52:1:53;%indPhototaxis4
%   
% % 
% % %   indDataSet = [24 25 29 31 52 53 55 57 59];%spont swimming
% % % 
% % %   indDataSet = [ 8 9 10 11 12 13];%maybe two slow siwms
% % %     indDataSet = [ 1 2 3 4 5];%only slow 2
% % %  
% 
%      indDataSet = 54:1:59;%prey All
%     indDataSet = 54:1:55;%prey par
%       indDataSet = 56:1:57;%prey naive
%      indDataSet = 58:1:59;%spont
% 
% % indDataSet = 1:59
indDataSet =1
for n = 1:length(indDataSet)%length(indStructure)%loop through each data set
    
    
    funnymeasure = indStructure(indDataSet(n)).funnymeasure;
    realRho = indStructure(indDataSet(n)).realRho;
     indChoosenClusterCenters = indStructure(indDataSet(n)).indChoosenClusterCenters;
    
    col = jet(length(indChoosenClusterCenters));

    
    figure
    plot(realRho,funnymeasure, '.k')
    hold on
    
    for nn = 1 : length(indChoosenClusterCenters)
         
     plot(realRho(indChoosenClusterCenters(nn)),funnymeasure(indChoosenClusterCenters(nn)), 'o','MarkerEdgeColor','k','MarkerFaceColor',col(nn,:),'MarkerSize',10) 
         
     end
    title(indDataSet(n))
    axis square
    axis([0 max(realRho) -0.1 1])
    
end
