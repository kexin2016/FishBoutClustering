function [cluster_watershed,pdf,I,clusterC,nC,color,symbol,x,y] = watershed_segment(Y,density_index)
xx = min(Y(:,1))-4:2:max(Y(:,1))+4;
yy = min(Y(:,2))-4:2:max(Y(:,2))+4;
% xx = 0:2:178;
% yy = 0:2:80;
% xx = -56:2:62;
% yy = -50:2:50;
% xx = -80:2:80;
% yy = -80:2:80;
[x,y] = meshgrid(xx,yy);
[pdf,xi,bw] = ksdensity(Y,[x(:) y(:)],'Bandwidth',density_index);
figure,ksdensity(Y,[x(:) y(:)],'Bandwidth',density_index);
%baseline correction
% N = histcounts(Y(:,1),'BinWidth',2,'Normalization','probability');
% lm= fit([5 9 17 27]',N([5 9 17 27])','exp1');
% baseline = lm.a*exp(lm.b*[1:90]);
pdf = reshape(pdf,length(yy),length(xx));
figure,imagesc(pdf)
% pdf to gray
gray=pdf*100000;
% pdf = pdf./col2row(baseline,1);
% figure,imagesc(pdf);
bw = imbinarize(pdf,'adaptive');
figure,imshow(bw);
% bw = imbinarize(pdf,2e-04);
% thresh=adaptthresh(pdf,0.5,'statistic','mean','NeighborhoodSize',[9 9],'ForegroundPolarity','bright');
% thresh=adaptthresh(pdf,0.5,'statistic','mean','NeighborhoodSize',[11 11],'ForegroundPolarity','bright');
% bw=imbinarize(pdf,thresh);




% bw=~bw;
% d=bwdist(bw);
I=watershed(gray);

% I=bwlabel(bw);

w=I==0;
g=bw&~w|(pdf==0);
I(pdf<5e-05) = 0;
rgb = label2rgb(I,'jet');
figure,imshow((rgb));
figure,imshow(flipud(g));
nI = flipud(I);
nI = rot90(nI,3);
% nI = fliplr(nI);
% figure,histogram(I);
%gridded label to sample label
cluster_watershed = nan(size(Y,1),1);
for iRow = 1:length(xx)
    for iCol = 1:length(yy)
        tmpIdx = Y(:,1)>=(xx(iRow)-1)&Y(:,1)<(xx(iRow)+1)&Y(:,2)>=(yy(iCol)-1)&Y(:,2)<(yy(iCol)+1);
        disp(['x:' num2str(xx(iRow)) ' y:' num2str(yy(iCol)) ' sample number:' num2str(nnz(tmpIdx))]);
        cluster_watershed(tmpIdx)=nI(iRow,iCol);
    end
end
cluster_watershed(cluster_watershed==0) = nan;
clusterC = unique(cluster_watershed(~isnan(cluster_watershed)));
nC = histcounts(cluster_watershed,[0.5:1:clusterC(end)+0.5]);
while nnz(find(nC==0))>0
    tmp = find(nC==0,1);
    for i=tmp+1:max(cluster_watershed)
        cluster_watershed(cluster_watershed==i) = i-1;
        I(I==i) = i-1;
    end
    nC = histcounts(cluster_watershed);
end
[color,symbol] = getColorSymbol(length(nC));
% color(1,:) = [1 1 1];
% color(1,:) = [0 0 0];
figure,gscatter(Y(:,1),Y(:,2),cluster_watershed,color,symbol);
figure,scatter(Y(:,1),Y(:,2),5,'filled')
hold on;scatter(x(I(:)==0),y(I(:)==0),5,'r');

x = x(:);y = y(:);
end

