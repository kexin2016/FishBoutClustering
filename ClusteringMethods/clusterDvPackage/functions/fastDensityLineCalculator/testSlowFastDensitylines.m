a=datasets(2).data;
kdedens=kde(a','localp');
distfun=pdist(a);
rho=evaluate(kdedens,a');
thisdata=a;
tic;[densityLineMapFast]=fastDensityLinesCalc(thisdata,kdedens,rho,distfun,'both',20,1);toc;
tic;[densityLineMapMed]=mediumDensityLinesCalc(a,kdedens,rho,distfun,'extra',20,round(sqrt(length(rho))),1);toc;
tic;[densityLineMapSlow]=slowDensityLinesCalc(thisdata,kdedens,rho,distfun,'both',20,1);toc;

figure
subplot(1,3,1)
imagesc(densityLineMapFast)
subplot(1,3,2)
imagesc(densityLineMapMed)
subplot(1,3,3)
imagesc(densityLineMapSlow)

tic

maxDensity = max(rho);
% maxDensity = max(max(density));
densityNorm = maxDensity - densityLineMapFast;
for n=1:length(rho)
densityNorm(n,n)=0;
end
%densitysq = squareform(densityNorm);

t = linkage(squareform(densityNorm));
[c,D] = cophenet(t,squareform(densityNorm));

maxjumpFast = squareform(D,'tomatrix');




densityNorm = maxDensity - densityLineMapSlow;
for n=1:length(rho)
densityNorm(n,n)=0;
end
%densitysq = squareform(densityNorm);

t = linkage(squareform(densityNorm));
[c,D] = cophenet(t,squareform(densityNorm));

maxjumpSlow = squareform(D,'tomatrix');



densityNorm = maxDensity - densityLineMapMed;
for n=1:length(rho)
densityNorm(n,n)=0;
end
%densitysq = squareform(densityNorm);

t = linkage(squareform(densityNorm));
[c,D] = cophenet(t,squareform(densityNorm));

maxjumpMed = squareform(D,'tomatrix');



figure
subplot(1,3,1)
imagesc(maxjumpFast)
subplot(1,3,2)
imagesc(maxjumpMed)
subplot(1,3,3)
imagesc(maxjumpSlow)

deltaSlow = calculateDelta(rho,maxjumpSlow);
deltaMed = calculateDelta(rho,maxjumpMed);
deltaFast = calculateDelta(rho,maxjumpFast);
figure
plot(maxjumpSlow(:)./maxjumpMed(:),'r.')
hold on
plot(maxjumpSlow(:)./maxjumpFast(:),'b.')


