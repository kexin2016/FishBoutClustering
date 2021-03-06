%this function detects when fish collide and when are close together

 function [indNoCollisionStartAll,indNoCollisionEndAll,indFishInSquareStartAll,indFishInSquareEndAll,noCollision,fishInSquare] = CollisionDetector_2(aThisFish,numbFishInSquare)






%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%% fish square detection %%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %find when fish were close together
        indFishInSquare = numbFishInSquare >= 2;
        
        %make 0 1 vector 
        fishInSquare = zeros(1,size(aThisFish,1));
        fishInSquare(indFishInSquare) = 1;
        
        %case where fish are never together
       if isempty(indFishInSquare)
           
        indFishInSquareStartAll = [];
        indFishInSquareEndAll = [];
        
       else
           
        %find start and end of when fish were close together
        indFishInSquareStartAll = find(diff(fishInSquare) == 1 )+ 1;
        indFishInSquareEndAll = find(diff(fishInSquare) == -1);
        
       end
        
        
        %case when fish start close together - the first start is missing
        if length(indFishInSquareEndAll) > length(indFishInSquareStartAll)
            
            indFishInSquareStartAll = [1 indFishInSquareStartAll];
            
        end
        
        %case when fish end close together the last end is missing
        if length(indFishInSquareEndAll) < length(indFishInSquareStartAll)
            
            indFishInSquareEndAll = [indFishInSquareEndAll length(numbFishInSquare)];
            
        end
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%non Collision detection %%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %100 is when fish collide
        indNoCollision = numbFishInSquare < 100;
        indCollision = find(numbFishInSquare >= 100);



        %make vector of 0 and 1 for no collisions
        noCollision = zeros(1,size(aThisFish,1));
        collision = zeros(1,size(aThisFish,1));

        noCollision(indNoCollision) = 1;
        collision(indCollision) = 1.1;


%         %test collision vectors
%         plot(numbFishInSquare)
%         hold on
%         plot(noCollision*100, 'color','green')
%         plot(collision*100, 'color','red')
        
        if isempty(indCollision)
        %%
        %%%%%%%%%%Case when there are no collisions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %add start and end break
        indNoCollisionStartAll = 1;
        indNoCollisionEndAll = length(aThisFish);

    
        else
            
        %find start and end of no collisions
        indNoCollisionStartAll = find(diff(noCollision) == 1 )+ 1;
        indNoCollisionEndAll = find(diff(noCollision) == -1);
        
        end

        %%
%%%%%%%% create first no collision start for first file %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if indNoCollisionStartAll(1) ~= 1  %if there is no collision in first frame
       
       
       indNoCollisionStartAll = [1 indNoCollisionStartAll];
       
   end%if there is no collision in first frame
    
    


%%
%%%%%%%%%%%%%%% create last no collision end for end file %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
   if indNoCollisionEndAll(end) ~= length(aThisFish)  %if there is no collision in last frame
       
       
       indNoCollisionEndAll = [indNoCollisionEndAll length(aThisFish)];
%        disp('last file or collision in last frame')
   end%if there is no collision in first frame

   
   
   %%
%%%%%%%%%%%%%%erase no collisions that are smaller than 700 frames%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%!!! not implemented, maybe not needed
   
   

% %test start and end of collisions blocks
% noCollisionStartAll = noCollision*0;
% noCollisionStartAll(indNoCollisionStartAll) = 1;
% 
% noCollisionEndAll = noCollision*0;
% noCollisionEndAll(indNoCollisionEndAll) = 1;
% 
% 
% subplot(1,2,1)
% hold off
% plot(noCollision)
% plot(collision,'c.')
% hold on
% plot(noCollisionStartAll,'o','color','green','LineWidth',4)
% plot(noCollisionEndAll,'o','color','red','LineWidth',4)
% plot(noCollision, '.')
% 
% 
% fishInSquareStartAll = noCollision*0;
% fishInSquareStartAll(indFishInSquareStartAll) = 1;
% 
% fishInSquareEndAll = noCollision*0;
% fishInSquareEndAll(indFishInSquareEndAll) = 1;
% 
% 
% subplot(1,2,2)
% plot(fishInSquare)
% hold on
% plot(fishInSquareStartAll,'o','color','green','LineWidth',4)
% plot(fishInSquareEndAll,'o','color','red','LineWidth',4)
