%%
    %%%%%%%%%%%%% calculate end of bout by min distance %%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %get start ind of next bout
    endThresh = 0.025;

    if indsA(nn) <  size(BoutInf,1)%case that there is no next bout
    indBoutStartAllDataNext = BoutInf((indsA(nn)+1),EnumeratorBoutInf.indBoutStartAllData);
    
    interboutregion = filteredDistanceThisFish(indBoutEndAllData(nn):indBoutStartAllDataNext-1);
    else
          interboutregion = filteredDistanceThisFish(indBoutEndAllData(nn):(end-1));
  
    end
    
    
    [Y,I] = min(interboutregion);
    I2=find(interboutregion<endThresh,1,'first');
    
    if (~isempty(I2))
        
           indRealEnds = indBoutEndAllData(nn)+min(I,I2)-1;
    else
           indRealEnds = indBoutEndAllData(nn) + I-1;
       
    end