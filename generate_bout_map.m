%% 1.prepare data
% assuming we already have several datasets (key_dataset) for training
%config 
new_name = 'freeMovingFishBoutKine_v15';
key_dataset = {'202012171120','202012230849','202101060921','202012231022','202101051417',...
    '202012230816','202101051502','202101061048'};% 12dpf, 10dpf, 10dpf
boutKine = cell(length(key_dataset),1);
eyeConv = cell(length(key_dataset),1);
whichFish = cell(length(key_dataset),1);
whichBout= cell(length(key_dataset),1);
angle = cell(length(key_dataset),1);
radius = cell(length(key_dataset),1);
age = cell(length(key_dataset),1);
species = cell(length(key_dataset),1);
exptype = cell(length(key_dataset),1);
for idata = 1:length(key_dataset)
    [boutKine{idata},eyeConv{idata},whichFish{idata},whichBout{idata},radius{idata},angle{idata},age{idata},species{idata},exptype{idata}]...
        = getPrepData(resolveFilepath(key_dataset{idata}),key_dataset{idata});
end
[boutKine,eyeConv,whichFish,whichBout,radius,angle,age,species,exptype] = samfnmultvar(@(x) cat(1,x{:}),boutKine,eyeConv,whichFish,whichBout,radius,angle,age,species,exptype);
%% 2.generate kinematic feature
boutKinematicParams_pos = boutKine_calc(boutKine,eyeConv,1,10,'batch');
boutKinematicParams_neg = boutKine_calc(cellfun(@(x) -x,boutKine,'un',0),eyeConv,1,10,'batch');
boutKinematicParams = nan(size(boutKinematicParams_pos));
boutKinematicParams(boutKinematicParams_pos(:,48)==0&boutKinematicParams_neg(:,48)==1,:) = boutKinematicParams_pos(boutKinematicParams_pos(:,48)==0&boutKinematicParams_neg(:,48)==1,:);
boutKinematicParams(boutKinematicParams_pos(:,48)==1&boutKinematicParams_neg(:,48)==0,:) = boutKinematicParams_neg(boutKinematicParams_pos(:,48)==1&boutKinematicParams_neg(:,48)==0,:);
newfeature = extractFrequencyDomainFeature(boutKine);
boutKinematicParams = [boutKinematicParams newfeature];
% save(fullfile(getpath('result'),new_name),'ori_boutKinematicParams','boutKine','eyeConv','whichFish','whichBout','radius','angle','age','species','exptype');
%% 3.preliminary clustering
[BoutKinematicParametersGood,del_idx,del_feature_idx] = clean_boutKinematicParams(boutKinematicParams);
[whichFish,whichBout,boutKine,eyeConv,boutKinematicParams,angle,radius] = samfnmultvar(@(x) x(setdiff(1:length(x),del_idx),:),whichFish,whichBout,boutKine,eyeConv,boutKinematicParams,angle,radius);

makeplot = 1;
indKinPars = 1:size(BoutKinematicParametersGood,2);
[boutDataPCASample,meanAllVar,stdAllVar,COEFF,SCORE,latent,maxKinPars] = PCAforBehavior_4(BoutKinematicParametersGood,indKinPars,makeplot);
meanPCASpace = mean(SCORE,1);

numPC = 70;
opts = struct('initialization',boutDataPCASample(:,1:numPC));
Y = fast_tsne(boutDataPCASample(:,1:numPC),opts);
% %J turn enhancement
% newIndex = lookup_labeled_J_turn(whichFish_labeled_j_turn,whichBout_labeled_j_turn,whichFish,whichBout);
% Y = [Y;repmat(Y(newIndex),1,1)];

[cluster_watershed,pdf,I,clusterC,nC,color,symbol,x,y] = watershed_segment(Y,3.0);
o_cluster_watershed = cluster_watershed;
%% 4.refine clustering
%%%4.1 delete abnormal clusters
click_gscatter(Y,cluster_watershed,color,symbol,boutKine);
abnormal_class = input('please click on this figure to check if there are some clusters whose tail dynamics is abnormal:');
% abnormal_class = [7];
cluster_watershed(ismember(cluster_watershed,abnormal_class)) = nan;
%%%4.2 select J turn out
[convRate,eye_conv] = eye_conv_group(eyeConv,Y,cluster_watershed);
realLabel = col2row(unique(cluster_watershed(~isnan(cluster_watershed))),1);
cluster_watershed(ismember(cluster_watershed,realLabel(find(convRate>0.3)))) = nan;
%%%4.3 recommend reassignment
reAssignment(boutKine,cluster_watershed,angle,radius,pdf,I,Y,x,y);
group = input('please indicate the suitable group combining the tail dynamics and hierarchical tree (e.g., {[1 2 3],[4 5 6],[7 8 9]}):');
%%%4.4 reassignment
n_cluster_watershed = o_cluster_watershed;
nI = nan(size(I));
for ig = 1:length(group)
    n_cluster_watershed(ismember(o_cluster_watershed,group{ig})) = ig;
    nI(ismember(I,group{ig})) = ig;
end
n_cluster_watershed(~ismember(o_cluster_watershed,cat(2,group{:}))) = nan;
nI(~ismember(I,cat(2,group{:}))) = nan;
figure,
gscatter(Y(:,1),Y(:,2),n_cluster_watershed,color,symbol);
className = {'HAT','RT','C-turn','slow 2','slow 1','J-turn'};
legend({'HAT','RT','C-turn','slow 2','slow 1','J-turn'});
%% 5.class Center of new cluster assignment
[figlist,axeslist,classCenter] = plot_class_tail_dynamics(pdf,nI,n_cluster_watershed,Y,x,y,boutKine);
%% 6.evaluation 
% angle-distance plane distribution
cmpKinematic_class(n_cluster_watershed,radius,angle,[color 0.1*ones(size(color,1),1)],symbol);
[~,pdf,pdf_corr]= density_similartiy([angle radius],n_cluster_watershed);
figure,imagesc(pdf_corr);colorbar;colormap('jet');
title('pdf simialrity on angle-distance plane');
%% 7.extract class video
for i=col2row(unique(n_cluster_watershed(~isnan(n_cluster_watershed))),1)
    extractMultiVideo(whichFish(n_cluster_watershed==i),whichBout(n_cluster_watershed==i,:),['nclass ' num2str(i)],false);
end
save('bout_map','boutKinematicParams','n_cluster_watershed',...
    'boutDataPCASample','meanAllVar','stdAllVar','COEFF','SCORE','latent',...
    'maxKinPars','numPC','del_idx','del_feature_idx');