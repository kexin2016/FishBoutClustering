function [outputArg1,outputArg2] = click_gscatter(Y,cluster_watershed,color,symbol,boutKine,j_turn_idx)
nC = unique(cluster_watershed(~isnan(cluster_watershed)));
figure,hold on,arrayfun(@(i) ...
    scatter(Y(cluster_watershed==i,1),Y(cluster_watershed==i,2),10,color(i,:),symbol(i),...
    'UserData',struct('boutKine',{boutKine(cluster_watershed==i)},'index',find(cluster_watershed==i)),...
    'ButtonDownFcn',@(src,evt) plotKine(src,evt)),...
    1:length(nC),'un',0);
legend(arrayfun(@(i) num2str(i),1:length(nC),'un',0));
if nargin>5
    scatter(Y(j_turn_idx,1),Y(j_turn_idx,2),15,'k','filled');
end
legend([arrayfun(@(i) num2str(i),1:length(nC),'un',0),'J-turn']);
end

