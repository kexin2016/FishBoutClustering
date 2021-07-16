%% 1.load bout map
load('bout_map','boutKinematicParams','n_cluster_watershed',...
    'boutDataPCASample','meanAllVar','stdAllVar','COEFF','SCORE','latent',...
    'maxKinPars','numPC','del_idx','del_feature_idx');
boutKinematicParams_training = boutKinematicParams;
%%
test_dataset = '202101061455';
[boutKine,eyeConv,whichFish,whichBout,radius,angle,age,species,exptype]...
        = getPrepData(resolveFilepath(test_dataset),test_dataset);
boutKinematicParams_test = generate_kinematic_feature(boutKine,eyeConv);
%% 2.preprocess data
[t_del_idx,boutDataPCASample_test] = preprocessing(boutKinematicParams_test,del_feature_idx,maxKinPars,meanAllVar,stdAllVar,COEFF);

[t_del_idx,boutDataPCASample_training] = preprocessing(boutKinematicParams_training,del_feature_idx,maxKinPars,meanAllVar,stdAllVar,COEFF);
[boutDataPCASample_tmp,n_cluster_watershed_tmp] = normalize_class(boutDataPCASample,n_cluster_watershed,false);
%% 3.classification
idx = knnsearch(boutDataPCASample_tmp(:,1:numPC),boutDataPCASample_test(:,1:numPC),'k',20);
clusterLabel_t = mode(n_cluster_watershed_tmp(idx),2);
figure,histogram(clusterLabel_t);ylabel('# detection');
%%
opts = struct('initialization',boutDataPCASample(:,1:numPC));
Y_t = fast_tsne(boutDataPCASample_test(:,1:numPC),opts);
figure,
gscatter(Y_t(:,1),Y_t(:,2),clusterLabel_t,color,symbol);



%% preprocessing
function [t_del_idx,boutDataPCASample_test] = preprocessing(boutKinematicParams_test,del_feature_idx,maxKinPars,meanAllVar,stdAllVar,COEFF)
boutKinematicParams_test(:,del_feature_idx) = [];
t_del_idx = find(sum(isnan(boutKinematicParams_test),2)>0.5*size(boutKinematicParams_test,2));
boutKinematicParams_test(t_del_idx,:) = [];
boutKinematicParams_test = abs(boutKinematicParams_test);
boutKinematicParams_test = arrayfun(@(i) boutKinematicParams_test(:,i)+maxKinPars(i),1:size(boutKinematicParams_test,2),'un',0);
boutKinematicParams_test = log(cat(2,boutKinematicParams_test{:}));
boutKinematicParams_test = (boutKinematicParams_test - meanAllVar)./stdAllVar;
boutKinematicParams_test(isnan(boutKinematicParams_test)) = 0;
boutDataPCASample_test = boutKinematicParams_test*COEFF;
end
%% Normalize class
function [boutDataPCASample_tmp,n_cluster_watershed_tmp] = normalize_class(boutDataPCASample,n_cluster_watershed,flag)
if flag
    %normalize the number of samples for each class
    nC = histcounts(n_cluster_watershed);
    nBout = min(nC);
    boutDataPCASample_tmp = zeros(nBout*length(nC),size(boutDataPCASample,2));
    for iC=1:length(nC)
        tmp_idx = find(n_cluster_watershed==iC);
        boutDataPCASample_tmp((iC-1)*nBout+(1:nBout),:) = boutDataPCASample(tmp_idx(randperm(length(tmp_idx),nBout)),:);
    end
    % boutDataPCASample_tmp = boutDataPCASample;
    n_cluster_watershed_tmp = reshape(repmat(1:6,nBout,1),[],1);
else
    boutDataPCASample_tmp = boutDataPCASample;
    n_cluster_watershed_tmp = n_cluster_watershed;
end
end