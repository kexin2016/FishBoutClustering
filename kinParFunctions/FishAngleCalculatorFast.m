
function [fishAngle,fishAngularVelocity]=FishAngleCalculatorFast(fishAngle)
%function that calculates head angle of fish


turnThreshold=pi;

% figure
% plot(fishAngle)

anglesToAdd=zeros(size(fishAngle));
piMoments=diff(fishAngle);
%piMoments2=piMoments*0;
%piMoments2(piMoments>1)=4;
% figure
% plot(piMoments,'o')
% hold on
% plot(piMoments2,'o','color','red')
% indPiMomentsPos=find(piMoments>4);
% indPiMomentsNeg=find(piMoments<-4);
 
anglesToAdd((find(piMoments>turnThreshold)+1))=-2*pi;
anglesToAdd((find(piMoments<-turnThreshold)+1))=2*pi;

fishAngle=fishAngle+cumsum(anglesToAdd);

fishAngularVelocity=[diff(fishAngle)' 0];
