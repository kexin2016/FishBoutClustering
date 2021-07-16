
function [rho, delta,ordrho,nneigh] = calculateRhoAndDelta_2Mike(distanceSquare,dc)






%%
%%%%%%%%%%%%%% calculate local density (rho) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
ND = size(distanceSquare,1);
rho = zeros (1, size(distanceSquare,1));

for nn = 1:ND-1
%      nn
  for ff = nn+1:ND
      
     rho(nn) = rho(nn)+exp(-(distanceSquare(nn,ff)/dc)*(distanceSquare(nn,ff)/dc));
     rho(ff) = rho(ff)+exp(-(distanceSquare(nn,ff)/dc)*(distanceSquare(nn,ff)/dc));
     
      if (distanceSquare(nn,ff)<dc)
     rho(nn) = rho(nn)+1;
     rho(ff) = rho(ff)+1;
      end
  end
  
end

% %look at rho
% figure
% subplot(2,2,1)
% hist(rho)

%%
%%%%%%%%%%%% calculate (distance from point of highest density) delta %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxd = max(max(distanceSquare));

[~,ordrho] = sort(rho,'descend');
delta(ordrho(1)) = -1.;
nneigh(ordrho(1)) = 0;

for ii = 2 : ND%loop through all points except 1 that is already assigned
%     ii
   delta(ordrho(ii)) = maxd;
   
   for jj=1:ii-1
       
     if(distanceSquare(ordrho(ii),ordrho(jj)) < delta(ordrho(ii)))
         
        delta(ordrho(ii)) = distanceSquare(ordrho(ii),ordrho(jj));
        nneigh(ordrho(ii)) = ordrho(jj);
        
     end
     
   end
end



delta(ordrho(1)) = max(delta(:));%in paper is max delta: but in theur code they put the same delta as the second point
%%
%%%%%%%%%%%%%%% plot rho delta %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% plot(rho, delta, '.')


