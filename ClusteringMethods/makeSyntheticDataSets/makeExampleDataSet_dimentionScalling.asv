% clear all
% close all
% 

 mu = [-1 -1 -1 -1 -1 -1 -1;1 1 1 1 1 1 1];
%  mu = [-1 1 1 1 1 1 1;1 1 1 1 1 1 1];
% mu = [-1 1;1 1 ];

uniSigma = 0.1;
 sigma = [uniSigma uniSigma uniSigma uniSigma uniSigma uniSigma uniSigma];
%  sigma = [uniSigma uniSigma];



p = ones(1,2)/2;
obj = gmdistribution(mu,sigma,p);


data = random(obj,300);

figure
% plot3(data(:,1),data(:,2),data(:,3), 'k.')
plot(data(:,1),data(:,2), 'k.')

axis square
box off
% ezsurf(@(x,y)pdf(obj,[x y]),[-10 10],[-10 10])
groundTruth = [];


 save('mix2Gaussian7dim_5','data','groundTruth')
