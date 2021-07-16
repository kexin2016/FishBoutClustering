


boutCatGoodNewSpace
boutCatGood

%%
%%%%%%%%%%%%% count TP, FP,FN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



stats = confusionmatStats(boutCatGood,boutCatGoodNewSpace);
confusionMat = stats.confusionMat;
recall = stats.recall;
specificity = stats.specificity;
precision = stats.precision;
Fscore = stats.Fscore;


%%
%%%%%%%%%%%%%%% calcualte precision %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
%%%%%%%%%%%%%%% calcualte recall %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
%%%%%%%%%%%%%%%% calcualte F1 score %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% F1_Score = 2*(precision*recall)/(precision + recall);
% 
% F2_Score = 5*(precision*recall)/(5*precision + recall);
% 


G = sqrt(precision*recall);