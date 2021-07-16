 function   [densityLineMap]=slowDensityLinesCalc(thisdata,kdedens,rho,distfun,whichMethod,nsamps,doplot);

%%
%%%%%%%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% thisdata = data;

%%
count=1;
startpoints=zeros((size(thisdata,1)*(size(thisdata,1)-1))/2,2);
endpoints=zeros((size(thisdata,1)*(size(thisdata,1)-1))/2,2);
starti=zeros((size(thisdata,1)*(size(thisdata,1)-1))/2,1);
endi=zeros((size(thisdata,1)*(size(thisdata,1)-1))/2,1);
for n=1:size(thisdata,1)-1
n;
for nn=n+1:size(thisdata,1)
    starti(count)=n;
startpoints(count,:)=thisdata(n,:);
    endi(count)=nn;
endpoints(count,:)=thisdata(nn,:);
count=count+1;
end
end

for n=1:nsamps
n
densitylines(:,n)=evaluate(kdedens,(startpoints*n/(nsamps+1)+endpoints*(nsamps+1-n)/(nsamps+1))');
end

densitylines=[rho(starti)' densitylines rho(endi)'];

density=min(densitylines');


densityLineMap=squareform(density);



