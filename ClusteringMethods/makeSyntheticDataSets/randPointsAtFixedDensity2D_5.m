function [pointXScaledCenter,pointYScaledCenter] = randPointsAtFixedDensity2D_5(desiredDensityAvr,gridSize,numberOfPoints,rad,MakePlot)


%%
% %%%%%%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% area only works until 29 for 10 points - there is no more space woth 30
% 
% 
% 
% rad = 0.2;
% numberOfPoints = 3;
% gridSize = 100;
% MakePlot = 1;
% desiredDensityAvr = 0.5;


%%
%%%%%%%%%%% choose random points at min distance %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rad = rad*100;



indOutside = 1;
counter3 = 1;
 while ~isempty(indOutside) || counter3 == 100000
    
%     counter
%define grid
grid = zeros(gridSize,gridSize);

pointX = zeros(1,numberOfPoints);
pointY = zeros(1,numberOfPoints);

counter = 0;


for n = 1 : numberOfPoints
% n
%%
%%%%%%%%%%%%%%%% make rand point in grid %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = rand(1);
y = rand(1);
    
    
%%
%%%%%%%%%%%%%%%%%%%%%% find where point is in grid %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indX = ceil(x*100);
indY = ceil(y*100);

%%
%%%%%%%%%%%%% make new point if area is already taken %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counter3 = 1;
while grid(indY,indX) == 1
    
%make rand point in grid
x = rand(1);
y = rand(1);
    
    
%find where point is in grid
indX = ceil(x*100);
indY = ceil(y*100);

% disp('point in neighborhood')

counter3 = counter3 + 1;

% pause
if counter3 == 100000

    
    
   disp('solution impossible: point in neighborhood')
   
   break
end

end

if counter3 == 100000

    
    
   disp('solution impossible: point in neighborhood')
   
   break
end



%%
%%%%%%%%%%%%%%%%% make circle with 1s around point %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sample grayscale image
[imgH,imgW,~] = size(grid);

%# circle params
t = linspace(0, 2*pi, 100);   %# approximate circle with 50 points
                      %# radius
c = [indX indY];               %# center

%# get circular mask
BW = poly2mask(rad*cos(t)+c(1), rad*sin(t)+c(2), imgH, imgW);

%label grid with area next to choosen point
grid(BW == 1) = 1;

% %lable circle
% gridWithPoints(BW == 1) = 1;
% gridWithPoints(indY,indX) = 0;

%%
%%%%%%%%%%%%%%%%%% show grid %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%# show cropped image
% imshow( gridWithPoints )
% axis on
%%
%%%%%%%%%%%%%%%% save points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pointX(n) = x;
pointY(n) = y;

%make cirvle

%%
%%%%%%%%% make point and cirle plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if MakePlot == 1
% 
% plot(x,y, '.')
% hold on
% circle([x,y],rad/100,10)
% % axis([0 1 0 1])
% axis square
% % pause
% end

end

%%
%%%%%%%%%%%%% calcuate density of solution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%if there only one ponts there is no need to scale it
if numberOfPoints == 1
   
convexHullInd = 1;    
kToScaleCluster = 1;    
    
end

%3 points or more scale it using convex hull
if numberOfPoints >= 3

[convexHullInd,convexHullVol] = convhull(pointX,pointY);


firstDensity = numberOfPoints/convexHullVol;

%scale cluster to be of this density
clusterVolume = numberOfPoints/desiredDensityAvr;


kToScaleCluster = sqrt(clusterVolume/convexHullVol);


end

%2 points do by distance
if numberOfPoints == 2

    %make extra non colinear point
%     newPointX = nanmean(pointX);
%     newPointY = nanmean(pointY)+0.01;
  newPointX = pointX(1);
 newPointY = pointY(2);

    
    pointXAll = [pointX newPointX];
    pointYAll = [pointY newPointY];
    
    [~,convexHullVol] = convhull(pointXAll,pointYAll);


    firstDensity = 3/convexHullVol;

    %scale cluster to be of this density
    clusterVolume = 3/desiredDensityAvr;


    kToScaleCluster = sqrt(clusterVolume/convexHullVol);
    
    convexHullInd = [1,2];
end

pointXScaled = pointX.*kToScaleCluster;
pointYScaled = pointY.*kToScaleCluster;


%%
%%%%%%%%%%%%%%%%% center on  0 0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pointXScaledAvr = nanmean(pointXScaled);
pointYScaledAvr = nanmean(pointYScaled);
pointXScaledCenter = pointXScaled - pointXScaledAvr;
pointYScaledCenter = pointYScaled - pointYScaledAvr;


%%
%%%%%%%%%%%%%%%%%%%% find points outside screen %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indOutsideX = find(pointXScaledCenter > 10 | pointXScaledCenter < -10);
indOutsideY = find(pointYScaledCenter > 10 | pointYScaledCenter < -10);

indOutside = unique([indOutsideX indOutsideY]);


%%
%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if MakePlot == 1
    clf
% 
subplot(1,2,1)
plot(pointX,pointY, 'k.')
hold on
plot(pointX(convexHullInd),pointY(convexHullInd), '-')
title(firstDensity)
axis square
axis([-10 10 -10 10])

subplot(1,2,2)
plot(pointXScaledCenter,pointYScaledCenter, 'k.')
hold on
plot(pointXScaledCenter(indOutside),pointYScaledCenter(indOutside), 'ro')
title(desiredDensityAvr)
axis square
axis([-10 10 -10 10])
% pointX(n) = x;
% pointY(n) = y;
%  pause
end

counter = counter + 1;

if counter == 10000
   
  
    disp('solution impossible')
     break
end

end

%%
%%%%%%%%%%%%%%%%%% plot points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure
% plot(pointX,pointY, '.')
% axis([0 1 0 1])
% axis square


