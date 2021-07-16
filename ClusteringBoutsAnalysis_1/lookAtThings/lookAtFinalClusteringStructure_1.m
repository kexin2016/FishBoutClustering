


idx = finalClustering.idx;

col = finalClustering.col;
clusterAssignmentInMap = finalClustering.clusterAssignmentInMap;
dataToDoMap = finalClustering.dataToDoMap;


uniqueBoutCat = unique(clusterAssignmentInMap);

figure
 col = jet(13);
plot3(dataToDoMap(:,1),dataToDoMap(:,2),dataToDoMap(:,3), 'k.')
hold on

for n = 1 : length(uniqueBoutCat)
    
   indThisBoutType = find(clusterAssignmentInMap == uniqueBoutCat((n)));
   
     

   plot3(dataToDoMap(indThisBoutType,1),dataToDoMap(indThisBoutType,2),dataToDoMap(indThisBoutType,3), '.', 'color', col(n,:))
    
    hold on
    axis square
    axis([-20 25, -15 15, -7 10])
    title(n)
     pause
end





 