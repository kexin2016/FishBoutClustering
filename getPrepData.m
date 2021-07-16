function [boutAngle,eyeConv,whichFish,whichBout,deltaRadius,deltaAngle,age,species,exptype] = getPrepData(filepath,fishname)
% function [boutAngle,eyeConv,whichFish,whichBout,deltaRadius,deltaAngle] = getPrepData(filepath,fishname)
    boutAngle = [];
    eyeConv = [];
    whichFish = [];
    whichBout = [];
    deltaRadius = [];
    deltaAngle = [];
    age = [];
    species = [];
    exptype = [];
    if ~exist(fullfile(filepath,'tail_swing_tail.mat'),'file') || ~exist(fullfile(filepath,'eyes_analysis.mat'),'file')
        return;
    end
    load(fullfile(filepath,'tail_swing_tail.mat'),'angle_data2','sum_curv','wrong_tail','curvdata');
    load(fullfile(filepath,'eyes_analysis.mat'),'THREConvergenceAngle','headingAngle','head');
    %%
    len_short = length(sum_curv);
    len_long = length(head);
    if len_short<len_long
        [THREConvergenceAngle,headingAngle,head] = samfnmultvar(@(x) x(1:len_short,:),THREConvergenceAngle,headingAngle,head);
    elseif len_short>len_long
        [angle_data2,sum_curv,wrong_tail,curvdata] = samfnmultvar(@(x) x(1:len_long,:),angle_data2,sum_curv,wrong_tail,curvdata);
    end
    %%
    angle_data = angle_data2;
    angle_data = angle_data - median(angle_data,2);
    angle_data = angle_data - angle_data(:,1);
%     angle_data = angle_data(:,11:20);
    angle_data = angle_data(:,2:2:end);% which segment to select for further kinematic feature extraction
    angle_data = remove_average(30,angle_data);
    intPoints = ones(10,1);
    %     smoothedTailCurvature = TailSmoother_6(angle_data,intPoints,1,1);
%     if strcmpi(,'20201223_0849')
%         sum_curv(abs(sum_curv)>2.7) = 0;%outlier data
%     end
    sum_curv=sum(curvdata(:,2:2:18),2);
    sum_curv(find(wrong_tail==1))=0;
    window=1000;
    sum_curv=remove_average(window,sum_curv);
    sum_curv(abs(sum_curv)>2.7) = sign(sum_curv(abs(sum_curv)>2.7))*2.7;
    disp(['detected nnz ' num2str(nnz(isnan(sum_curv)))]);
    sum_curv(isnan(sum_curv)) = 0;
    smoothedTailCurvature = abs(hilbert(sum_curv));
    [boutStart,boutEnd] = BoutDetectorCurvatureFunction(smoothedTailCurvature',1);
    bout_idx = [boutStart boutEnd];
    size(bout_idx,1)
    delay_idx = 7;
    good_bout = zeros(length(bout_idx),1);
    for iBout=1:length(bout_idx)
        if nnz(wrong_tail(max(bout_idx(iBout,1)-delay_idx,1):min(bout_idx(iBout,2)+delay_idx,length(sum_curv))))>0
            good_bout(iBout) = 0;
        else
            good_bout(iBout) = 1;
        end
    end
    bout_idx(good_bout==0,:) = [];
    headingAngle_bout = arrayfun(@(i) abs(maxabs(diff(headingAngle(bout_idx(i,1):bout_idx(i,2))))),1:size(bout_idx,1));
    headPos_bout = arrayfun(@(i) max(sqrt(sum(diff(head(bout_idx(i,1):bout_idx(i,2),:),1,1).^2,2))),1:size(bout_idx,1));
    bout_idx(headingAngle_bout<3&headPos_bout<3,:) = [];
    %     bout_idx((bout_idx(:,2)-bout_idx(:,1))<6 | (bout_idx(:,2)-bout_idx(:,1))>30,:) = [];
    nBout = size(bout_idx,1);
    %     angle_data = interp1(1:size(angle_data,1),angle_data,1:0.5:size(angle_data,1));
    %     new_bout_idx = 2*bout_idx - 1;
    
    boutAngle = arrayfun(@(i) -(angle_data(max(1,bout_idx(i,1)-delay_idx):min(bout_idx(i,2)+delay_idx,size(angle_data,1)),:)),1:nBout,'un',0);
    boutAngle = row2col(boutAngle,1);
    size(boutAngle,1)
    %%
    headPos_bout = arrayfun(@(i) diff(head([max(1,bout_idx(i,1)-5) min(bout_idx(i,2)+5,size(head,1))],:),1,1),1:size(bout_idx,1),'un',0);
    deltaRadius = row2col(cellfun(@(x) sqrt(x(1)^2+x(2)^2),headPos_bout),1);
    headAngle_bout = arrayfun(@(i) unwrap(deg2rad(headingAngle([max(1,bout_idx(i,1)-5) min(bout_idx(i,2)+5,size(head,1))],:))),1:size(bout_idx,1),'un',0);
    deltaAngle = row2col(cellfun(@(x) diff(x),headAngle_bout),1);
    %%
    THREConvergenceAngle(THREConvergenceAngle==0) = nan;
    eyeConv = THREConvergenceAngle;
    eyeConv = eyeConv - nanmedian(eyeConv);
    %     eyeConv = row2col(interp1(1:size(eyeConv,1),eyeConv,1:0.5:size(eyeConv,1)),1);
    eyeConv = arrayfun(@(i) deg2rad(eyeConv(max(1,bout_idx(i,1)-delay_idx):min(bout_idx(i,2)+delay_idx,size(angle_data,1)),:)),1:nBout,'un',0);
    
    
    whichFish = repmat({fishname},length(boutAngle),1);
    whichBout = bout_idx;
    
    [~,name,~] = fileparts(filepath);
    str = split(name,'_');
    species = repmat(str(3),length(boutAngle),1);
    age = repmat(str2num(str{4}(1:end-3)),length(boutAngle),1);
    exptype = repmat(str(5),length(boutAngle),1);
    
    eyeConv = row2col(eyeConv,1);
    
    save(fullfile(filepath,'tail_swing_tail.mat'),'bout_idx','deltaAngle','deltaRadius','-append');

end

