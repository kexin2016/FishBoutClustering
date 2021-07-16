clear all 
close all



%%
%%%%%%%%%%%%%%%%%%%%%%%% make sq %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbPointsFactor = 2;
% space = 0.2;
% xlength = 25*numbPointsFactor;
% ylength = 25*numbPointsFactor;

space = 0.1675;
xlength = 3.75*numbPointsFactor*1.5;
ylength = 3.75*numbPointsFactor*1.5;


dataSqAllX = [];
dataSqAllY = [];
counter1 = 0;

for n = 1 : xlength
    
    counter2 = 0;

    for nn = 1 : ylength
        
        dataSqX = counter1;
        dataSqY = counter2;

%         
%         plot(dataSqX,dataSqY,'.')
%         hold on
%         pause
        dataSqAllX = [dataSqAllX dataSqX];
        dataSqAllY = [dataSqAllY dataSqY];

    counter2 = counter2 + space;

    end
    counter1 = counter1 + space;

end

%%
%%%%%%%%%%%%%%% make elongated cluster %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

space = 0.1;
xlength = 6.25*numbPointsFactor*1.5;
ylength = 18.75*numbPointsFactor*1.5;

dataSqAllX2 = [];
dataSqAllY2 = [];
counter1 = 0;

for n = 1 : xlength
    
    counter2 = 0;

    for nn = 1 : ylength
        
        dataSqX2 = counter1;
        dataSqY2 = counter2;

%         
%         plot(dataSqX2,dataSqY2,'.')
%         hold on
%          pause
        dataSqAllX2 = [dataSqAllX2 dataSqX2];
        dataSqAllY2 = [dataSqAllY2 dataSqY2];

    counter2 = counter2 + space;

    end
    counter1 = counter1 + space;

end




%%
%%%%%%%% assemble data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


dataAll1 = [];
dataAll1(:,1) = dataSqAllX;
dataAll1(:,2) = dataSqAllY;

dataAll2 = [];
dataAll2(:,1) = dataSqAllX2;
dataAll2(:,2) = dataSqAllY2 + 1.5*1.5;%orignal value is 13

% dataAll3 = [];
% dataAll3(:,1) = dataSqAllX + 0.5;
% dataAll3(:,2) = dataSqAllY + 45;



dataAll = [];
% dataAll = [dataAll1' dataAll2' dataAll3']';
dataAll = [dataAll1' dataAll2']';

%center in y
dataAll(:,2) = dataAll(:,2);
dataAll(:,1) = dataAll(:,1)-5;


%%
%%%%%%%%%%% pick rand numbers from distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indperm = randperm(length(dataAll));
data = dataAll(indperm(1:750),:);%orignal is 500



figure
subplot(1,2,1)
plot(dataAll(:,1),dataAll(:,2), '.')
axis square
axis([-27.5 27.5 -5 50])


subplot(1,2,2)
plot(data(:,1),data(:,2), '.')
axis square
axis([-27.5 27.5 -5 50])

%%
%%%%%%%%%%%%%% save data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('C:\JoaoStuff\boutTypeStuff\clusterDvPackage\exclamationMarkUnif_20.mat' ,'data')

