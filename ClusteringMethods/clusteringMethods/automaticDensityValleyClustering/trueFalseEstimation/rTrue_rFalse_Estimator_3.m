 function [rTrue,rFalse] = rTrue_rFalse_Estimator_3(dataLabelsAll,clusterAssignment,haloVector,makeplot)

%%
% %%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dataLabelsAll = groundTruthRand;
% makeplot = 1

%%



samecorr=0;
samewrong=0;
diffcorr=0;
diffwrong=0;
allSameInt = 0;
allDiffInt = 0;

for h = 1 : size(clusterAssignment,3)%loop thrugh different datasets
    
dataLabels = dataLabelsAll(:,:,h);
clusterAssignmentThis = clusterAssignment(:,:,h);

for n=1:(size(dataLabels,2)-1)%loop through each point
    
    for m=n+1:size(dataLabels,2)%loop through each point
        
        if (dataLabels(n)==dataLabels(m))%if 2 points have same label
            
            if haloVector(n) == 0%do not inclusde halo points
                
            if (clusterAssignmentThis(n)==clusterAssignmentThis(m))%if this 2 points are in same cluster - corr
                
            samecorr = samecorr+1;
            
            else %if this 2 points are in different clusters - wrong
                
            samewrong=samewrong+1;  
            
            end
            
            end
            
            %sum all interactions
            allSameInt = allSameInt + 1;
            
        else%if 2 points have different labels
            
             if haloVector(n) == 0
            %two points from different groups
             if (clusterAssignmentThis(n)==clusterAssignmentThis(m))%if this 2 points are in same cluster - wrong
                 
            diffwrong=diffwrong+1;
            
            else  %if this 2 points are in different clusters - correct
                
            diffcorr = diffcorr+1;  
            
             end
             end
             
             %sum all interactions
              allDiffInt = allDiffInt + 1;  
        end
        
    end
end


rTrue(h) = samecorr/(allSameInt).*100;
rFalse(h) = diffwrong/(allDiffInt).*100;


end

%%
%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if makeplot == 1
    
  figure  
    plot(rFalse,rTrue,'o')
    axis square 
%     axis([0 rFalse+1 0 100])
ylabel('rTrue (%)')
xlabel('rFalse (%)')

if max(rFalse) < 5
    axis([0 5 0 100])
    
else
        axis([0 max(rFalse) 0 100])

    
end

end