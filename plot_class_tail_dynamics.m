function [figlist,axeslist,classCenter,del_idx] = plot_class_tail_dynamics(pdf,nI,n_cluster_watershed,Y,x,y,boutKine)
%function figlist = plot_class_tail_dynamics(pdf,nI,n_cluster_watershed,Y)
%%
% [~,clusterCenterIdx] = arrayfun(@(i) max(pdf(I==i)),col2row(clusterC,1),'un',0);
[maxpdf,clusterCenterIdx] = arrayfun(@(i) max(pdf(nI==i)),col2row(unique(n_cluster_watershed(~isnan(n_cluster_watershed))),1),'un',0);
xtmp = arrayfun(@(i) x(nI(:)==i),col2row(unique(n_cluster_watershed(~isnan(n_cluster_watershed))),1),'un',0);
ytmp = arrayfun(@(i) y(nI(:)==i),col2row(unique(n_cluster_watershed(~isnan(n_cluster_watershed))),1),'un',0);
centerPos = cellfun(@(x,y,z) [x(z) y(z)],xtmp,ytmp,clusterCenterIdx,'un',0);
centerPos = cat(1,centerPos{:});
% centerPos = [-28 -23;-16 -12;-46 -2;21 7;-23 31;54 -2];
figlist = [];
axeslist = [];
del_idx=[];
classCenter = cell(length(centerPos),1);
for i=1:length(centerPos)
    tmpIdx = Y(:,1)>=centerPos(i,1)-2 & Y(:,1)<centerPos(i,1)+2 & Y(:,2)>=centerPos(i,2)-2 & Y(:,2)<centerPos(i,2)+2;
    %     plot_end_tail_angle(boutKine(tmpIdx),'register',num2str(i));
    if nnz(tmpIdx)==0
        tmpIdx = Y(:,1)>=centerPos(i,1)-4 & Y(:,1)<centerPos(i,1)+4 & Y(:,2)>=centerPos(i,2)-4 & Y(:,2)<centerPos(i,2)+4;
        del_idx = [del_idx;i];
        continue;
    end
    classCenter{i} = find(tmpIdx);
    
    %     plot(boutKine{find(tmpIdx,1)});
    plot_end_tail_angle(boutKine(tmpIdx),'register',num2str(i));
    
%     title(class_name{i});
    set(gcf,'Visible','off');
    figlist = [figlist gcf];
    axeslist = [axeslist gca];
end