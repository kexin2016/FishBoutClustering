clear all
close all


%%
%%%%%%%%%%%%%% load data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%by hand 
%C:\Joao analysis\BehaviorDataAnalysis_160422\ClusteringMethods\finalDataSetsToAnalyse\evalClust\original\real\ASTRAL-small-sized-mammoth-sims-geq-2.txt


%%
%%%%%%%%%%%%%% erase lines without any data from the txt var%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

textdataCut = textdata;


textdataCut(1:5,:) = [];



%%
%%%%%%%%%%%% find different types of proteins %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


uniqueproteins1 = unique(textdataCut(:,1));

uniqueproteins2 = unique(textdataCut(:,2));


uniqueTotal = unique([uniqueproteins1 uniqueproteins2]);

%%
%%%%%%%%%%%%%% make distance matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comparissonMatrix = zeros(length(uniqueTotal));

for n = 1 : length(uniqueTotal)
%      n =1

n
   indThisProtein =  find(strcmp(textdataCut(:,1), uniqueTotal(n)));
   
   for nn = 1: length(uniqueTotal)
%          nn =3
          indThisProtein2 =  find(strcmp(textdataCut(:,2), uniqueTotal(nn)));


            indThisComparisson = intersect(indThisProtein,indThisProtein2);
           
           if ~isempty(indThisComparisson)
               
          comparissonMatrix(n,nn) = data(indThisComparisson);
          
           else
               
          comparissonMatrix(n,nn) = nan;

           end
          
   end
   
  
%     uniqueproteins1(n)
    
    
end
