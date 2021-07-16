function [distanceFish] = calculateDistance( fishPosX,fishPosY )




distanceFish=sqrt((diff(fishPosX).*diff(fishPosX)+diff(fishPosY).*diff(fishPosY)));%calculates distance between two ajacente points
distanceFish=[(distanceFish)' 0];


end

