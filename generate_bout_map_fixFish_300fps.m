%% 1.prepare data
% assuming we already have several datasets (key_dataset) for training
%config 
new_name = 'fixFish210813';
key_dataset = {'210813fish1'};
boutKine = cell(length(key_dataset),1);
eyeConv = cell(length(key_dataset),1);
whichFish = cell(length(key_dataset),1);
whichBout= cell(length(key_dataset),1);
age = cell(length(key_dataset),1);

species = cell(length(key_dataset),1);
exptype = cell(length(key_dataset),1);
for idata = 1:length(key_dataset)
    [boutKine{idata},eyeConv{idata},whichFish{idata},whichBout{idata},age{idata},species{idata},exptype{idata}]...
        = getPrepData(resolveFilepath(key_dataset{idata},'F:\Kexin\zebrafish_hunting\data\analysis_result\'),key_dataset{idata});
end
[boutKine,eyeConv,whichFish,whichBout,age,species,exptype] = samfnmultvar(@(x) cat(1,x{:}),boutKine,eyeConv,whichFish,whichBout,age,species,exptype);


%% 2.generate kinematic feature
boutKinematicParams_pos = boutKine_calc(boutKine,eyeConv,3,10,'batch');
boutKinematicParams_neg = boutKine_calc(cellfun(@(x) -x,boutKine,'un',0),eyeConv,3,10,'batch');
boutKinematicParams = nan(size(boutKinematicParams_pos));
% boutKine全部为nan  这一步没有赋值 导致后面删除了这个bout
% 0和1代表什么？？？第48列代表什么？？
% 第一个检测出来的beat是朝上还是朝下
boutKinematicParams(boutKinematicParams_pos(:,48)==0&boutKinematicParams_neg(:,48)==1,:) = boutKinematicParams_pos(boutKinematicParams_pos(:,48)==0&boutKinematicParams_neg(:,48)==1,:);
boutKinematicParams(boutKinematicParams_pos(:,48)==1&boutKinematicParams_neg(:,48)==0,:) = boutKinematicParams_neg(boutKinematicParams_pos(:,48)==1&boutKinematicParams_neg(:,48)==0,:);
% newfeature = extractFrequencyDomainFeature(boutKine);
% boutKinematicParams = [boutKinematicParams newfeature];

% boutKinematicParams=boutKinematicParams_pos;

%% 3.preliminary clustering
[BoutKinematicParametersGood,del_idx,del_feature_idx] = clean_boutKinematicParams(boutKinematicParams);
[whichFish,whichBout,boutKine,eyeConv,boutKinematicParams,angle,radius] = samfnmultvar(@(x) x(setdiff(1:size(x,1),del_idx),:),whichFish,whichBout,boutKine,eyeConv,boutKinematicParams,angle,radius);

makeplot = 1;
indKinPars = 1:size(BoutKinematicParametersGood,2);
[boutDataPCASample,meanAllVar,stdAllVar,COEFF,SCORE,latent,maxKinPars] = PCAforBehavior_4(BoutKinematicParametersGood,indKinPars,makeplot);
meanPCASpace = mean(SCORE,1);

numPC = 50;
opts = struct('initialization',boutDataPCASample(:,1:numPC));
Y = fast_tsne(boutDataPCASample(:,1:numPC),opts);

[cluster_watershed,pdf,I,clusterC,nC,color,symbol,x,y] = watershed_segment(Y,3);
o_cluster_watershed = cluster_watershed;

%% 3.4 check bout plot
%     check bout
boutDetCheck=zeros(length(sum(tailAngle,2)),1);
for i=1:length(whichBout)
    boutDetCheck(whichBout(i,1):whichBout(i,2))=1;
end
figure
plot(sum(tailAngle,2));
hold on
plot(sum(tailAngle,2).*boutDetCheck)

%% 3.5  check bouts video
videoPath='F:\Kexin\zebrafish_hunting\data\analysis_result\210106_fish1_h2bg6f_9dpf\20210106_fish1_h2bg6f_9dpf_low_all.avi';
video=VideoReader(videoPath);
writePath='F:\Kexin\zebrafish_hunting\data\analysis_result\clusterTest2\';
for i=1:length(whichBout)
    clusterName=cluster_watershed(i);
    if(~isnan(clusterName))
        clusterPath=[writePath int2str(clusterName)];
    else
        clusterPath=[writePath 'nan'];
    end
    if(~exist(clusterPath))
        mkdir(clusterPath)
    end
    writeObj=VideoWriter([clusterPath '\' num2str(i,'%03d') '.avi']);
    open(writeObj);
    boutS=whichBout(i,1);
    boutE=whichBout(i,2);
    for j=boutS:boutE
        f=read(video,j);
        writeVideo(writeObj,f);
    end
    close(writeObj);
end

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