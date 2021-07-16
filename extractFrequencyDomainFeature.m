%extract frequency domain feature
function newFeature = extractFrequencyDomainFeature(boutKine)
% function newFeature = extractFrequencyDomainFeature(boutKine)
%%
%obtain the PCs
% boutKineflat = cat(1,boutKine{:});
% [coeff,projected_boutKineflat,latent,~,explained,~] = pca(boutKineflat);
% projected_boutKineflat = projected_boutKineflat(:,1:3);
% %%
% newFeature = zeros(length(boutKine),100);
fs = 100;
bin = [0:5:50];
%%
for iBout = 1:length(boutKine)
   [f,fx] = smartFFT( boutKine{iBout},fs);
   %every 5Hz
   fbin = discretize(f,bin);
   fxbin = zeros(length(bin)-1,size(fx,2));
   for j=1:size(fx,2)
       tmp = fx(:,j);
       tmp = accumarray(fbin',tmp);
       tmp(tmp==0) = nan;
       fxbin(:,j) = tmp;
   end
%    fxbin = cat(2,fxbin{:});
   newFeature(iBout,:) = fxbin(:);
end
% cwtfilterbank('SignalLength',size(projected_boutKineflat,1),'')
%%
end
