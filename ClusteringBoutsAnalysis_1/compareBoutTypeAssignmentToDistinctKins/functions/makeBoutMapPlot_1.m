
function [] = makeBoutMapPlot_1(boutCatGood,boutDataPCASampleGood,col,numberOfBouts)
%%
%%%%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % boutCatGood
% % boutDataPCASampleGood
% col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;
% 
% numberOfBouts = 1000;
%%
%%%%%%%%%%%%% pick random numb of bouts from each cluster %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uniqueBoutCatGood = unique(boutCatGood);

thisIndRandAll = [];
boutCatRandAll = [];

for n = 1 : length(uniqueBoutCatGood)
    
    
 indThisCluster = find(boutCatGood == uniqueBoutCatGood(n));
 
 %pick random bouts
indPerm = randperm(length(indThisCluster));
thisIndRand = indThisCluster(indPerm(1:numberOfBouts));


boutCatRand = boutCatGood(thisIndRand);

thisIndRandAll = [thisIndRandAll' thisIndRand']';
    
 boutCatRandAll = [boutCatRandAll' boutCatRand']';
 
end



%%
%%%%%%%%%%%%%% make color vector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colVector = zeros(size(boutCatRandAll,1),3);

for n = 1 : length(uniqueBoutCatGood)
    
    
    indThisCluster = boutCatRandAll == uniqueBoutCatGood(n);
    
    for nn = 1 : 3
    colVector(indThisCluster,nn) = col(n,nn);
    end

%  colVector(indThisCluster,:) = col(n,:);
    
end

% colVector = zeros(size(boutCatGood,1),3);
% 
% for n = 1 : length(uniqueBoutCat)
%     
%     
%     indThisCluster = boutCatGood == uniqueBoutCatGood(n);
%     
%     for nn = 1 : 3
%     colVector(indThisCluster,nn) = col(n,nn);
%     end
% 
% %  colVector(indThisCluster,:) = col(n,:);
%     
% end
% 


%%
%%%%%%%%%%%% make scatter plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indPerm = randperm(length(thisIndRandAll));
thisIndRandAllRand = thisIndRandAll(indPerm(1:end));

colVectorRand = colVector*0;

%   for nn = 1 : 3  
%   colVectorRand(indAllRand,:) = colVector(indAllRand,:);
%   end

% subplot(1,2,1)
% scatter(boutDataPCASampleGood(thisIndRandAll,1),boutDataPCASampleGood(thisIndRandAll,2),5,colVector,'filled')
% axis square

% subplot(1,2,2)
scatter(boutDataPCASampleGood(thisIndRandAllRand,1),boutDataPCASampleGood(thisIndRandAllRand,2),20,colVector(indPerm,:),'filled')
axis square
xlabel('PC 1')
ylabel('PC 2')

axis square

