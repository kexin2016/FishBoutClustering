function [convRate,eye_conv] = eye_conv_group(eyeConvergence,Y,cluster_watershed)
% function eye_conv_group(eyeConvergence,Y,cluster_watershed)
eye_conv = cellfun(@(x) quantile(x,0.75),eyeConvergence);
figure,
scatter(Y(:,1),Y(:,2),5,eye_conv>0.3,'filled');colormap('cool');
convRate = arrayfun(@(i) nanmedian(eye_conv(cluster_watershed==i)),col2row(unique(cluster_watershed(~isnan(cluster_watershed))),1));
figure,
boxplot(eye_conv,cluster_watershed);
ylabel('eye convergence angle');
end