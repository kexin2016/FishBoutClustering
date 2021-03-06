% AddFunctionToPath
% 
close all
clear all


 %%
%%%%%%%%%%%%%%%%%%%%pick data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pick file of data set to analyse
%allBoutDataPCA1stAnd2ndBeatKins_1.mat

[FileName,PathName] =  uigetfile('*.*');

load(strcat(PathName,FileName));

%%
%%%%%%%%%%%%%% from spont pick all %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 indDataSet = 1:10; 
titleName = {'spontMainRig0000Lux1','spontMainRig0100Lux1','spontMainRig0150Lux1','spontMainRig0200Lux1','spontMainRig0300Lux1','spontMainRig0500Lux1',...
        'spontMainRig1000Lux1','spontMainRig2000Lux1','spontMainRig4000Lux1','spontMainRig8000Lux1'};
        
%%
%%%%%%%%%%%%%%%% from all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% spont swimming light
%     indDataSet = [24 55 57 59];

%% spont swimming dark
%      indDataSet = [25];

   
%    %% multifish 1000 lux
%    indDataSet = 79:1:82;

%% multifish 0 lux
%          indDataSet = 83:1:86;
 

%% prey seq
%   indDataSet = [54 56 58];

 %%
% %%%%%%%%%%%%% look at spont in boutFilesFinal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% indDataSet = [54 24 25 79 83 55 57];
%  titleName = {'prey capture','3 min light','3 min dark','multifish 1000 lux','multifish 0 lux','spont Prey Naive','spont Prey Par'};

%% omr turns
%        indDataSet = [1 2 3 4 5 6 7 8 9 10 11 12 13];
% 
% titleName = {'0','15','30','45','60','75','90','105','120','135','150','165','180'};
%% omr speed
%       indDataSet = [14 15 16 17 18 19 20 21 22 23];
% 
% titleName = {'0','2.5','5','7.5','10','15','20','30','40','50'};

%% spont Beeps
% indDataSet = 1:22;
% 
% titleName = {'before','before','before','before','before','before','before','before','before','before','beforeAll','After','After','After','After','After','After','After','After','After','After','AfterAll'};

%%
%%%%%%%%%%%%%%% look at data sets in multiple dimentions %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% g = []
figure
col = jet(length(indDataSet));
for g = 1 : length(indDataSet)
%     g =1
    thisIndRand = indStructure(indDataSet(g)).thisIndRand;
    densities = indStructure(indDataSet(g)).densities;
    densitiesScalled = indStructure(indDataSet(g)).densitiesScalled;

%   clf  

%%
% %%%%%%%%%%%%% look at slow swims %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       subplot(2,5,g)
%      plot(boutDataPCASample(thisIndRand,1),densitiesScalled,'.','color',col(g,:))
% 
% hold on
% %   axis([-10 20 -15 15 0 max(densitiesScalled)])  
% 
% %     axis([-10 20 -15 15])  
% axis([-20 10 0 max(densitiesScalled)])  
% line([-5 -5],[0 max(densitiesScalled)],'color','k')
% line([-10 -10],[0  max(densitiesScalled)],'color','k')
% 
% line([0 0],[0  max(densitiesScalled)],'color','k')
% line([5 5],[0  max(densitiesScalled)],'color','k')
% 
% 
%   title(titleName(g))   
    
  
  %%
  %%%%%%%%%%%%%%%%% look at 2 dims %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      subplot(2,5,g)
     plot3(boutDataPCASample(thisIndRand,1),boutDataPCASample(thisIndRand,2),densitiesScalled,'.','color','k')
hold on
axis([-15 20 -10 10 0 max(densitiesScalled)])  
  title(titleName(g))   


end

