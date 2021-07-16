function pos = tailAngle2pos(tailAngle,sizeSegment)
%function pos = tailAngle2pos(tailAngle,sizeSegment)
%sizeSegment could be any number denoting the length of one tail segment
%pos: time x tail segment x 2(x,y)
if nargin<2
    sizeSegment = 10;
end
for nn=1:size(tailAngle,2)
    [tailPosNormX,tailPosNormY] = pol2cart(tailAngle(:,nn),sizeSegment);
    if nn == 1
        
        tailPosX(:,1) = tailPosNormX;
        tailPosY(:,1) = tailPosNormY;
%         tailPosX(:,nn) = tailPosNormX;
%         tailPosY(:,nn) = tailPosNormY;
        
    else
        tailPosX(:,nn) = tailPosX(:,(nn-1)) + tailPosNormX;
        tailPosY(:,nn) = tailPosY(:,(nn-1)) + tailPosNormY;
        %
    end
end
pos = cat(3,tailPosY,tailPosX);
end

