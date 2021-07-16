
function [kdedensCutOff,bandWidthsCutOff,cutOff] = calculateLocalDensitiesWithCutOff_2(data,kdedens,percentile,cutOff,densityType,makeplot)



%%
% %%%%%%%%%%%%%%%%%%% test function  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% densityType = 'localp';
% percentile = 0;
% makeplot = 1;

%%
%%%%%%%%%%%%%% calculate densities and use cutOff %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcualte kde obj with it is not inputes
if isempty(kdedens)

kdedens = kde(data',densityType);


end

if makeplot == 1

densities = evaluate(kdedens,data');

end




%get band witdths
bandWidths = getBW(kdedens);


%calcualte cut off by percentile
% cutOff = zeros(1,size(bandWidths,1));
bandWidthsCutOff = bandWidths;

for n = 1 : size(bandWidths,1)
    
    if ~isempty(percentile)
    
cutOff(n) = prctile(bandWidths(n,:),percentile);
    end
    
indToCange = find((bandWidths(n,:)) < cutOff(n));

bandWidthsCutOff(n,indToCange) = cutOff(n);

end

%change kdedens
kdedensCutOff = kdedens;

tf = isequal(bandWidths,bandWidthsCutOff)

if tf ~= 1
    
adjustBW(kdedensCutOff,bandWidthsCutOff);

end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if makeplot == 1

% densities = evaluate(kdedens,data');
densitiesCutOff = evaluate(kdedensCutOff,data');

figure
subplot(2,2,1)
% hist(bandWidths',20)
plot3(data(:,1),data(:,2),densities, '.')

subplot(2,2,2)
hold on
plot3(data(:,1),data(:,2),densitiesCutOff, 'r.')

subplot(2,2,3)
scatter(data(:,1),data(:,2),10,densities, 'filled')

subplot(2,2,4)
scatter(data(:,1),data(:,2),10,densitiesCutOff, 'filled')

end

