function [kdedensCutOff,bandWidthsScalled] = calculateLocalDensitiesScallingBWCORRECT_2(data,kdedens,scallingFactor,densityType,makeplot)



%%
% %%%%%%%%%%%%%%%%%%% test function  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% densityType = 'localp';
% percentile = 0;
% makeplot = 1;




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

%reorder stuff
ndz=size(bandWidths,1);
npz=size(bandWidths,2);
  
testbandwidths=repmat(1:npz,ndz,1);
adjustBW(kdedens,testbandwidths);
changedBandWidths = getBW(kdedens);


%if there is only one bandwidth
if length(scallingFactor) <= 1

bandWidthsScalled = bandWidths*scallingFactor;
bandWidthsScalled(:,changedBandWidths(1,:)) = bandWidthsScalled;

else
    
    %multiple bandwidths    
    for j = 1 : size(data,2)
    
    bandWidthsScalled(j,:) = bandWidths(j,:).*scallingFactor(j);

    end
    bandWidthsScalled(:,changedBandWidths(1,:)) = bandWidthsScalled;

    
end

%%
%%%%%%%%%%%% apply new scalled bandwidths %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%change kdedens
kdedensCutOff = kdedens;

tf = isequal(bandWidths,bandWidthsScalled);

if tf ~= 1
    
adjustBW(kdedensCutOff,bandWidthsScalled);

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