function [eyeConvDiffThisBout] = eyeConvDiffCalculator_1(convergengePar,bouSpace,indBoutStartAllData,indBoutEndAllData)


%%
%%%%%%%%%%%%%%%%%% avoid being out of data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if indBoutStartAllData- bouSpace < 1 || indBoutEndAllData + bouSpace > size(convergengePar,1)
             
              bouSpace1 = 0;
              
else
              
              bouSpace1 = bouSpace;
              
 end
   

 
indBoutStartAllDataWithSpace = indBoutStartAllData - bouSpace1;
indBoutEndAllDataWithSpace = indBoutEndAllData + bouSpace1;
convergengeParThisBout = convergengePar(indBoutStartAllDataWithSpace:indBoutEndAllDataWithSpace)*180/pi;


if length(convergengeParThisBout) > 140
indend = 135;
else
                
indend = length(convergengeParThisBout)-5;

        
end


eyeConvDiffThisBout = nanmean(convergengeParThisBout(indend:(indend+5))) - nanmean(convergengeParThisBout(1:5));



