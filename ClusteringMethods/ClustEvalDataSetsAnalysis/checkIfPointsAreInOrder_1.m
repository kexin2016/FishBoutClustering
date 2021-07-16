


sizedata = size(data,1);

numbCluster = 2;

groundTruth = zeros(length(data),1);

chunk = floor(sizedata/numbCluster);

starts = 1 : chunk : sizedata;

if length(starts) > numbCluster
    
    starts(numbCluster+1:end) = [];
end


ends = starts + 1;

ends(1) = [];
ends(numbCluster) = sizedata;


col = jet(numbCluster);
figure
for n = 1 : length(starts)
    
    indThisCluster = starts(n) : 1 : ends(n);
    if size(data,2) == 2
        
    plot(data(indThisCluster,1),data(indThisCluster,2),'.','color', col(n,:))
    
    hold on
    axis square
    box off
    
    else
    plot3(data(indThisCluster,1),data(indThisCluster,2),data(indThisCluster,3),'.','color', col(n,:))
    
    hold on
    axis square
    box off   
    
    end
    
    
    pause
end





