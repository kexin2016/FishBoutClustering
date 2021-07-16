

%%
%%%%%%%%%%%%% load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('C:\Joao analysis\FreeData\clusterAssignmentStruct3.mat')
% load('C:\Joao analysis\FreeData\indGoodBouts.mat')
% 
%%
%%%%%%%%%%%%%%%%%%%%% choose data sets and number of clusters %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numorig= 11;
numnew= 12;

Y1=clusterAssignmentStruct(4).clusterAssignmentAll(numorig-1,indGoodBouts);
Y2=clusterAssignmentStruct(6).clusterAssignmentAll(numnew-1,indGoodBouts);
Y3=Y2(randperm(length(Y2)));


%%
thistestsquare = zeros(numorig,numnew);

for n=1:numorig
   for m=1:numnew
       
    thistestsquare(n,m)=length(find((Y1 == n)&(Y2 == m)));
    
   end
   
thistestsquare(n,:)=thistestsquare(n,:)/sum(thistestsquare(n,:));
end

% 
% figure
% imagesc(thistestsquare)
% colormap('gray')

newtestsquare = zeros(numorig,numnew);
clear i
for n=1:numorig
    [y,i(n)]=max(thistestsquare(n,:)); 
end
[y,ii]=sort(i);

newtestsquare=thistestsquare(ii,:);

figure
imagesc(newtestsquare)
colormap('gray')
axis square
box off

return

skipz = 100;
%true positives = same in dataset 2 and was same in dataset 1
%false positives = same in dataset 2 not same in dataset 1
%false negatives = differen in dataset 2 sam in dataset 1
tp=0;
fp=0;
fn=0;


for n=1:skipz:length(Y1)-skipz
   for m=n+skipz:skipz:length(Y1)
    if (Y2( n)==Y2(m))
        if (Y1( n)==Y1(m))
        tp=tp+1;
        
        else
        fp=fp+1;
        end
        
    else
        if (Y1( n)==Y1(m))
        fn=fn+1;
        end
    end
    
   end
end

pr=tp/(tp+fp)
rc=tp/(tp+fn)

tp=0;
fp=0;
fn=0;

for n=1:skipz:length(Y1)-skipz
   for m=n+skipz:skipz:length(Y1)
    if (Y3( n)==Y3(m))
        if (Y1( n)==Y1(m))
        tp=tp+1;
        
        else
        fp=fp+1;
        end
        
    else
        if (Y1( n)==Y1(m))
        fn=fn+1;
        end
    end
    
   end
end

pr=tp/(tp+fp)
rc=tp/(tp+fn)



