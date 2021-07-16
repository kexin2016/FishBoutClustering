 function [rTrue,rFalse] = rTrue_rFalse_Estimator_1(dataLabelsAll,clusterAssignment,makeplot)

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


for h = 1 : size(clusterAssignment,3)%loop thrugh different datasets
    
dataLabels = dataLabelsAll(:,:,h);
clusterAssignmentThis = clusterAssignment(:,:,h);

for n=1:(size(dataLabels,2)-1)
    for m=n+1:size(dataLabels,2)
        if (dataLabels(n)==dataLabels(m))
         %should be same pair   
            if (clusterAssignmentThis(n)==clusterAssignmentThis(m))
            samecorr=samecorr+1;
            else 
            samewrong=samewrong+1;  
            end
        else
            %two points from different groups
             if (clusterAssignmentThis(n)==clusterAssignmentThis(m))
            diffwrong=diffwrong+1;
            else 
            diffcorr=diffcorr+1;  
            end
                
        end
        
    end
end


rTrue(h) = samecorr/(samecorr+samewrong).*100;
rFalse(h) = diffwrong/(diffcorr+diffwrong).*100;


end

%%
%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if makeplot == 1
    
  figure  
    plot(rFalse,rTrue,'o')
    axis square 
%     axis([0 rFalse+1 0 100])
xlabel('rFalse (%)')
ylabel('rTrue (%)')

if max(rFalse) < 5
    axis([0 5 0 100])
    
else
        axis([0 max(rFalse) 0 100])

    
end

end