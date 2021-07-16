%this function calculates the zScore for data with nans 


 function [zScore,meanAllVar,stdAllVar] = nanZScore_parOutput(nanData)

% %test function
% nanData = boutKinematicParameters;

zScore = nanData*0;

meanAllVar = zeros(1,size(nanData,2));
stdAllVar = zeros(1,size(nanData,2));

 for n= 1 : size(nanData,2)
 
     nanDataThis = nanData(:,n);
     
     
     meanAllVar(n) = nanmean(nanDataThis);
     stdAllVar(n) = nanstd(nanDataThis);
     
     
    zScore(:,n) = (nanDataThis  -  meanAllVar(n))/(stdAllVar(n));
    
    

  end
