function [delta,ordrho,nneigh] = calculateDelta_1(distanceSquare,rho)



%%
%%%%%%%%%%%% calculate (distance from point of highest density) delta %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ND = size(distanceSquare,1);

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


