function [boutFeature,del_sample_idx,del_feature_idx] = clean_boutKinematicParams(boutFeature)
% boutFeature(:,end-3:end) = [];
del_sample_idx = find(sum(isnan(boutFeature),2)>size(boutFeature,2)/5);
boutFeature(del_sample_idx,:) = [];
del_feature_idx = find(sum(isnan(boutFeature),1)>size(boutFeature,1)*0.1);
boutFeature(:,del_feature_idx) = [];
disp(['remaining feature numbers: ' num2str(size(boutFeature,2))]);
for i=1:size(boutFeature,2)
    tmp = boutFeature(:,i);
    tmp(isnan(tmp)) = nanmedian(tmp);
    tmp(isinf(tmp)) = nanmedian(tmp);
%     tmp(isoutlier(tmp)) = nanmedian(tmp);
    boutFeature(:,i) = tmp;
end
categoryVar = find(arrayfun(@(i) length(unique(boutFeature(:,i)))<4,1:size(boutFeature,2)));
boutFeature(:,categoryVar) = [];%remove categorical variable
del_feature_idx = [row2col(del_feature_idx,1);row2col(categoryVar,1)];
end

