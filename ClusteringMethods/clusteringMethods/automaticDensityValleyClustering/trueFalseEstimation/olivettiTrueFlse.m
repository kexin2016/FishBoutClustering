samecorr=0;
samewrong=0;
diffcorr=0;
diffwrong=0;


for n=1:399
    for m=n+1:400
        if (olivettiLabels(n)==olivettiLabels(m))
         %should be same pair   
            if (clusterAssignment(n)==clusterAssignment(m))
            samecorr=samecorr+1;
            else 
            samewrong=samewrong+1;  
            end
        else
            %two points from different groups
             if (clusterAssignment(n)==clusterAssignment(m))
            diffwrong=diffwrong+1;
            else 
            diffcorr=diffcorr+1;  
            end
                
        end
        
    end
end

samecorr/(samecorr+samewrong)
 diffwrong/(diffcorr+diffwrong)