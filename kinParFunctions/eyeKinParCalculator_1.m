function [eyeConv20FramesBeforeBoutThis,eyeConv20FramesAfterBoutThis,eyeConvDiff2This] = eyeKinParCalculator_1(convergengePar,bouSpace,indBoutStartAllData,indBoutEndAllData)



%%
%%%%%%%%%%%% avoid being bout starting in beggining of data %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

          if indBoutStartAllData - bouSpace < 1
             
              bouSpace1 = indBoutStartAllData;
              
          else
              
              bouSpace1 = bouSpace;

          end
         
%%
%%%%%%%%%%% avoid  bout ending with end of data %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

          if indBoutEndAllData + bouSpace > size(convergengePar,1)
              
              bouSpace2 = size(convergengePar,1) - indBoutEndAllData;

          else
              bouSpace2 = bouSpace;

          end
          
%%
%%%%%%%%%%%%%%%%%%% calculate eye kin par %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
          indBoutStartAllDataWithSpace = indBoutStartAllData - bouSpace1+1;
          indBoutEndAllDataWithSpace = indBoutEndAllData + bouSpace2;
          convergengeParThisBout = convergengePar(indBoutStartAllDataWithSpace:indBoutEndAllDataWithSpace);
          
            if bouSpace1 > 1
                
            eyeConv20FramesBeforeBoutThis = nanmean(convergengeParThisBout(1:bouSpace1));
            
            else
                
            eyeConv20FramesBeforeBoutThis = convergengeParThisBout(1);
            
            end
            
            
            if bouSpace2 > 1
             
            eyeConv20FramesAfterBoutThis = nanmean(convergengeParThisBout((end-bouSpace2):end));   
                
            else
                
            eyeConv20FramesAfterBoutThis = convergengeParThisBout(end); 
            
            end
            
            
            eyeConvDiff2This = eyeConv20FramesAfterBoutThis - eyeConv20FramesBeforeBoutThis;
