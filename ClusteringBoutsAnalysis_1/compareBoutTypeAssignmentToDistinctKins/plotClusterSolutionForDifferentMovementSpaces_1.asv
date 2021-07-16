
%%
%%%%%%%%%%%%%%%% plot 74 kin 4 dim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto_final.mat','boutDataPCASample')


 load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins3dims_1.75Smooth_slow_3000_auto_final.mat','finalClustering')

%%
%%%%%%%%%%%%%%%%%%%%%% plot bout map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

idx = [5 4 9 8 11 10 2 1 7 6 3];

indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
boutMapAssignment = finalClustering.assignment;

uniqueBoutTypes = unique(boutMapAssignment);

figure
for n = 1 : length(uniqueBoutTypes)
    
   indThisCluster = find(boutMapAssignment == uniqueBoutTypes(n));
   
   plot(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),'.','color', col(idx(n),:))
   hold on
   axis square
%    pause 
    
    
end
box off
xlabel('Dim 1')
ylabel('Dim 2')
axis([-20 22 -10 13])

%%
%%%%%%%%%%%%%%%%%% load 4 dim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc.mat','boutDataPCASample','finalClustering')



col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

idx = [3     5     7     8     4    11    10     1     2     6     9];

indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
boutMapAssignment = finalClustering.assignment;

uniqueBoutTypes = unique(boutMapAssignment);

figure
for n = 1 : length(uniqueBoutTypes)
    
   indThisCluster = find(boutMapAssignment == uniqueBoutTypes(n));
   
   plot(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),'.','color', col(idx(n),:))
   hold on
   axis square
%    pause 
    
    
end
box off
xlabel('Dim 1')
ylabel('Dim 2')
axis([-20 22 -10 13])

%%
%%%%%%%%%%%%%%%%%% load 5 dim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins5dims_1.75Smooth_slow_3000_auto_5roc.mat','finalClustering')
% load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins6dims_1.75Smooth_slow_3000_auto_6roc.mat','finalClustering')



col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

idx = [9 3 4 6 1 11 10 8 7 5 2];

indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
boutMapAssignment = finalClustering.assignment;

uniqueBoutTypes = unique(boutMapAssignment);

figure
for n = 1 : length(uniqueBoutTypes)
    
   indThisCluster = find(boutMapAssignment == uniqueBoutTypes(n));
   
 
   
     plot3(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),boutDataPCASample(indsBoutMapInAllData(indThisCluster),5),'.','color', col(idx(n),:))
     
%       plot(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),'.','color', col(idx(n),:))
 
   hold on
   axis square
%       pause 
    
    
end


box off
xlabel('Dim 1')
ylabel('Dim 2')
zlabel('Dim 5')

axis([-20 22 -10 13])

%%
%%%%%%%%%%%%%%%%%%%% make 5d plot thesis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
for n = 1 : length(uniqueBoutTypes)
    
   indThisCluster = find(boutMapAssignment == uniqueBoutTypes(n));
   
   if n == 2 || n == 9
   
     plot3(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),boutDataPCASample(indsBoutMapInAllData(indThisCluster),5),'o','MarkerFaceColor', col(idx(n),:),'MarkerEdgeColor', col(idx(n),:) ,'markersize',5)
     
%       plot(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),'.','color', col(idx(n),:))
   else
            plot3(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),boutDataPCASample(indsBoutMapInAllData(indThisCluster),5),'o','MarkerFaceColor', [0.5 0.5 0.5],'MarkerEdgeColor',[0.5 0.5 0.5],'markersize',2)

   end
   hold on
   axis square
%       pause 
    
    
end


box off
xlabel('Dim 1')
ylabel('Dim 2')
zlabel('Dim 5')

axis([-20 22 -10 13])


%%
%%%%%%%%%%%%%%%%%% load 5 dim 12 cluster solutiuon %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins5dims_1.75Smooth_slow_3000_auto_12ClusterSolution.mat','finalClustering')
% load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins6dims_1.75Smooth_slow_3000_auto_6roc.mat','finalClustering')


col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50; 0 0 0])./255;

idx = [3 7 4 1 2 12 8 10 11 6 9 5];
% idx = 1:12;

indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
boutMapAssignment = finalClustering.assignment;

uniqueBoutTypes = unique(boutMapAssignment);

figure
for n = 1 : length(uniqueBoutTypes)
    
   indThisCluster = find(boutMapAssignment == uniqueBoutTypes(n));
   
 
   
     plot3(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),boutDataPCASample(indsBoutMapInAllData(indThisCluster),3),'.','color', col(idx(n),:))
     
%       plot(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),'.','color', col(idx(n),:))
 
   hold on
   axis square
%       pause 
    
    
end


box off
xlabel('Dim 1')
ylabel('Dim 2')
zlabel('Dim 5')

axis([-20 22 -10 13])


%%
%%%%%%%%%%%%%%%%%% load 6 dim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 load('C:\Joao analysis\FreeData\clusteringData\final\BoutCat_kNN4_74Kins6dims_1.75Smooth_slow_3000_auto_6roc.mat','finalClustering')



col = ([102 255 255;0 150 255;  0 0 200;255 170 0;250 128 114;105 255 102;0 153 0;147 112 219;220 0 220;255 255 0;255 0 50])./255;

idx = [10 3 1 4 7 11 9 6 8 2 5];

indsBoutMapInAllData = finalClustering.indsBoutMapInAllData;
boutMapAssignment = finalClustering.assignment;

uniqueBoutTypes = unique(boutMapAssignment);

figure
for n = 1 : length(uniqueBoutTypes)
    
   indThisCluster = find(boutMapAssignment == uniqueBoutTypes(n));
   
     plot(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),'.','color', col(idx(n),:))
%        plot3(boutDataPCASample(indsBoutMapInAllData(indThisCluster),1),boutDataPCASample(indsBoutMapInAllData(indThisCluster),2),boutDataPCASample(indsBoutMapInAllData(indThisCluster),6),'.','color', col(idx(n),:))

   hold on
   axis square
%       pause 
    
    
end

box off
xlabel('Dim 1')
ylabel('Dim 2')
zlabel('Dim 5')

axis([-20 22 -10 13])