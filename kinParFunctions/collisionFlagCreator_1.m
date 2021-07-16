function [collisionflag] = collisionFlagCreator_1(numbFishInFile,numbColumns,a)


 %1 fish case          
   if numbFishInFile == 1      
       
   collisionflag=logical(zeros(size(a,1),1));
   
   end
   
   %7 fish case    
   if (numbFishInFile>1 && numbFishInFile <=7)
       
   if 1 + numbFishInFile*37 + 8 == numbColumns;    
       
       collisionflag=logical(zeros(size(a,1),numbFishInFile));

       for fish=1:numbFishInFile

       startx=a(:,4+(fish-1)*37);
       starty=a(:,5+(fish-1)*37);
       startth=a(:,22+(fish-1)*37);
       
       for fish2=1:numbFishInFile

       if (fish2~=fish)

       nextx=a(:,4+(fish2-1)*37);
       nexty=a(:,5+(fish2-1)*37);
       dx=nextx-startx;
       dy=nexty-starty;
       [theta,rho]=cart2pol(dx,dy);
       theta=theta - startth;
       [dx dy]=pol2cart(theta,rho);
       
%        collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish)=1;
%        collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish2)=1;
       collisionflag(((dx<20)&(dx>-5)&(abs(dy)<5)),fish)=1;
       collisionflag(((dx<20)&(dx>-5)&(abs(dy)<5)),fish2)=1;


       end
       end

       end
   end
    
   if 1 + numbFishInFile*23 + 8 == numbColumns;
        collisionflag=logical(zeros(size(a,1),numbFishInFile));

       for fish=1:numbFishInFile

       startx=a(:,4+(fish-1)*23);
       starty=a(:,5+(fish-1)*23);
       startth=a(:,15 + (fish-1)*23);
       for fish2=1:numbFishInFile

       if (fish2~=fish)

       nextx=a(:,4+(fish2-1)*23);
       nexty=a(:,5+(fish2-1)*23);
       dx=nextx-startx;
       dy=nexty-starty;
       [theta,rho]=cart2pol(dx,dy);
       theta=theta-startth;
       [dx dy]=pol2cart(theta,rho);
%        collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish)=1;
%        collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish2)=1;

       collisionflag(((dx<20)&(dx>-5)&(abs(dy)<5)),fish)=1;
       collisionflag(((dx<20)&(dx>-5)&(abs(dy)<5)),fish2)=1;

       
       end
       end

       end
       
   end
   
               
   end
   
   
   %9 fish tracker case
   if numbFishInFile >= 8
       
       collisionflag=logical(zeros(size(a,1),numbFishInFile));

       for fish=1:numbFishInFile

       startx=a(:,4+(fish-1)*23);
       starty=a(:,5+(fish-1)*23);
       startth=a(:,15 + (fish-1)*23);
       for fish2=1:numbFishInFile

       if (fish2~=fish)

       nextx=a(:,4+(fish2-1)*23);
       nexty=a(:,5+(fish2-1)*23);
       dx=nextx-startx;
       dy=nexty-starty;
       [theta,rho]=cart2pol(dx,dy);
       theta=theta - startth;
       [dx dy]=pol2cart(theta,rho);
       
%        collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish)=1;
%        collisionflag(((dy<20)&(dy>-5)&(abs(dx)<5)),fish2)=1;

       collisionflag(((dx<20)&(dx>-5)&(abs(dy)<5)),fish)=1;
       collisionflag(((dx<20)&(dx>-5)&(abs(dy)<5)),fish2)=1;


       end
       end

       end

   end
       
       if isnan(a(end,end)) 
           
       collisionflag(end,:) = [];
       
       end
        