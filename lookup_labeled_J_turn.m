function newIndex = lookup_labeled_J_turn(whichFish_labeled_j_turn,whichBout_labeled_j_turn,whichFish,whichBout)

newIndex = zeros(length(whichFish_labeled_j_turn),1);
for i=1:length(whichFish_labeled_j_turn)
    large_pool = find(ismember(whichFish,whichFish_labeled_j_turn{i}));
    bout_idx = whichBout(large_pool,:);
    bout_idx = [bout_idx(:,1)-7 bout_idx(:,2)+7];
    idx_tmp = find(whichBout_labeled_j_turn(i)>bout_idx(:,1)&whichBout_labeled_j_turn(i)<bout_idx(:,2));
    if isempty(idx_tmp)
        newIndex(i) = 0;
    else
        newIndex(i) = large_pool(idx_tmp);
    end
end

