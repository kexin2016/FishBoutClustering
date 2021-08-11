function reAssignment(boutKine,cluster_watershed,deltaAngle,deltaRadius,pdf,I,Y,x,y)
% function reAssignment(boutKine,cluster_watershed,deltaAngle,deltaRadius,pdf,I,Y,x,y)
sum_angle = cellfun(@(x) sum(x(:,8)),boutKine);
max_angle = cellfun(@(x) maxabs(x(:,8)),boutKine);
class_sum_angle = arrayfun(@(i) abs(sum_angle(cluster_watershed==i)),col2row(unique(cluster_watershed(~isnan(cluster_watershed))),1),'un',0);
m_class_sum_angle = cellfun(@(x) median(x),class_sum_angle);
r_class_sum_angle = cellfun(@(x) quantile(x,0.75)-median(x),class_sum_angle);
class_max_angle = arrayfun(@(i) abs(max_angle(cluster_watershed==i)),col2row(unique(cluster_watershed(~isnan(cluster_watershed))),1),'un',0);
m_class_max_angle = cellfun(@(x) median(x),class_max_angle);
r_class_max_angle = cellfun(@(x) quantile(x,0.75)-median(x),class_max_angle);
[~,I_sum_angle] = sort(m_class_sum_angle,'descend');
% 
% class_deltaAngle = arrayfun(@(i) abs(deltaAngle(cluster_watershed==i)),col2row(unique(cluster_watershed(~isnan(cluster_watershed))),1),'un',0);
% m_class_deltaAngle = cellfun(@(x) median(x),class_deltaAngle);
% class_deltaRadius = arrayfun(@(i) abs(deltaRadius(cluster_watershed==i)),col2row(unique(cluster_watershed(~isnan(cluster_watershed))),1),'un',0);
% m_class_deltaRadius = cellfun(@(x) median(x),class_deltaRadius);

uniLabel = unique(cluster_watershed(~isnan(cluster_watershed)));
comb = nchoosek(1:length(uniLabel),2);
sum_angle_diff = zeros(length(uniLabel),length(uniLabel));
max_angle_diff = sum_angle_diff;
p_sum_angle = zeros(length(uniLabel),length(uniLabel));
p_max_angle = zeros(length(uniLabel),length(uniLabel));
for i=1:length(uniLabel)
    for j=1:length(uniLabel)
        sum_angle_diff(i,j) = abs(m_class_sum_angle(i)-m_class_sum_angle(j));
        max_angle_diff(i,j) = abs(m_class_max_angle(i)-m_class_max_angle(j));
        p_sum_angle(i,j) = ranksum(class_sum_angle{i},class_sum_angle{j});
        p_max_angle(i,j) = ranksum(class_max_angle{i},class_max_angle{j});
    end
end
% Z = linkage([row2col(atan(rescale(m_class_sum_angle,0,1)),1) row2col(atan(rescale(m_class_max_angle,0,1)),1) ...
%     row2col(atan(rescale(m_class_deltaAngle,0,1)),1) row2col(atan(rescale(m_class_deltaRadius,0,1)),1)],'average');
Z = linkage([row2col(atan(rescale(m_class_sum_angle,0,1)),1) row2col(atan(rescale(m_class_max_angle,0,1)),1)],'average');
realLabel = col2row(unique(cluster_watershed(~isnan(cluster_watershed))),1);
[figlist,axeslist,classCenter,del_idx] = plot_class_tail_dynamics(pdf,I,cluster_watershed,Y,x,y,boutKine);
figure('Position',[3 610 1793 369]),
t = tiledlayout(2,length(uniLabel),'TileSpacing','none','Padding','compact'),
nexttile([1 length(uniLabel)]);
[~,~,outperm] = dendrogram(Z,'labels',arrayfun(@(i) num2str(i),col2row(unique(cluster_watershed(~isnan(cluster_watershed))),1),'un',0));
for i=1:length(axeslist)
    nexttile([1 1]),
    tmp = findall(axeslist(outperm(i)));
    copyobj(tmp(2:end-1),gca);
    set(gca,'YLim',[-1.5 ,2.5]);
    title(num2str(realLabel(outperm(i))))
end
close(figlist);
[color,symbol] = getColorSymbol(length(classCenter));
% figure,hold on;
% gscatter(Y(:,1),Y(:,2),cluster_watershed,color,symbol);
% arrayfun(@(i) scatter(Y(classCenter{i},1),Y(classCenter{i},2),5,'k','x'),1:length(classCenter),'un',0);
end