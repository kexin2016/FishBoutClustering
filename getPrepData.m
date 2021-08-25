function [boutAngle,eyeConv,whichFish,whichBout,age,species,exptype] = getPrepData(filepath,fishname)
% function [boutAngle,eyeConv,whichFish,whichBout,deltaRadius,deltaAngle] = getPrepData(filepath,fishname)
    boutAngle = [];
    eyeConv = [];
    whichFish = [];
    whichBout = [];
    age = [];
    species = [];
    exptype = [];
    if ~exist(fullfile(filepath,'300fpsTailAngle.mat'),'file') || ~exist(fullfile(filepath,'high_analysis.mat'),'file')
        return;
    end
    load(fullfile(filepath,'300fpsTailAngle.mat'),'tailAngle');
    load(fullfile(filepath,'high_analysis.mat'),'converge_angle');
    converge_angle=repelem(converge_angle,6);  % high:50fps   low:300fps
    %%
    len_short = length(tailAngle);
    len_long = length(converge_angle);
    if len_short<len_long
        [converge_angle] = samfnmultvar(@(x) x(1:len_short,:),converge_angle);
    elseif len_short>len_long
        [tailAngle] = samfnmultvar(@(x) x(1:len_long,:),tailAngle);
    end
    %%
    tailAngle = tailAngle - median(tailAngle,2);
    tailAngle = tailAngle - tailAngle(:,1);
%     angle_data = angle_data(:,11:20);
%     tailAngle = tailAngle(:,11:20);% which segment to select for further kinematic feature extraction
    tailAngle = remove_average(30,tailAngle);
    intPoints = ones(10,1);
    %     smoothedTailCurvature = TailSmoother_6(angle_data,intPoints,1,1);
%     if strcmpi(,'20201223_0849')
%         sum_curv(abs(sum_curv)>2.7) = 0;%outlier data
%     end
%     sum_curv=sum(curvdata(:,12:20),2);
%     sum_curv(find(wrong_tail==1))=0;
%     window=1000;
%     sum_curv=remove_average(window,sum_curv);
    sum_curv=sum(tailAngle,2);
    sum_curv=medfilt1(sum_curv,5);
    sum_curv(abs(sum_curv)>2.7) = sign(sum_curv(abs(sum_curv)>2.7))*2.7;
    disp(['detected nnz ' num2str(nnz(isnan(sum_curv)))]);
    sum_curv(isnan(sum_curv)) = 0;
    sum_curv(96100:119200)=0;
    sum_curv(138500:155100)=0;
    smoothedTailCurvature = abs(hilbert(sum_curv));
    [boutStart,boutEnd] = BoutDetectorCurvatureFunction(smoothedTailCurvature',1);
    bout_idx = [boutStart boutEnd];
    size(bout_idx,1)
    
    % 如果bout前后有几帧检测错误，删除这些bout
    delay_idx = 1;
%     good_bout = zeros(length(bout_idx),1);
%     for iBout=1:length(bout_idx)
%         if nnz(wrong_tail(max(bout_idx(iBout,1)-delay_idx,1):min(bout_idx(iBout,2)+delay_idx,length(sum_curv))))>0
%             good_bout(iBout) = 0;
%         else
%             good_bout(iBout) = 1;
%         end
%     end
%     bout_idx(good_bout==0,:) = [];
    

    

%     headingAngle_bout = arrayfun(@(i) abs(maxabs(diff(headingAngle(bout_idx(i,1):bout_idx(i,2))))),1:size(bout_idx,1));
%     headPos_bout = arrayfun(@(i) max(sqrt(sum(diff(head(bout_idx(i,1):bout_idx(i,2),:),1,1).^2,2))),1:size(bout_idx,1));
%     bout_idx(headingAngle_bout<3&headPos_bout<3,:) = [];
    %     bout_idx((bout_idx(:,2)-bout_idx(:,1))<6 | (bout_idx(:,2)-bout_idx(:,1))>30,:) = [];
    nBout = size(bout_idx,1);
    %     angle_data = interp1(1:size(angle_data,1),angle_data,1:0.5:size(angle_data,1));
    %     new_bout_idx = 2*bout_idx - 1;
    
    boutAngle = arrayfun(@(i) -(tailAngle(max(1,bout_idx(i,1)-delay_idx):min(bout_idx(i,2)+delay_idx,size(tailAngle,1)),:)),1:nBout,'un',0);
    boutAngle = row2col(boutAngle,1);
    size(boutAngle,1)
    %% check bout idx
    figure
    boutDetCheck=zeros(length(sum_curv),1);
    for i=1:length(bout_idx)
        boutDetCheck(bout_idx(i,1):bout_idx(i,2))=1;
    end
    plot(sum(tailAngle,2));
    hold on
    plot(sum(tailAngle,2).*boutDetCheck)
    
    %%
%     headPos_bout = arrayfun(@(i) diff(head([max(1,bout_idx(i,1)-5) min(bout_idx(i,2)+5,size(head,1))],:),1,1),1:size(bout_idx,1),'un',0);
%     deltaRadius = row2col(cellfun(@(x) sqrt(x(1)^2+x(2)^2),headPos_bout),1);
%     headAngle_bout = arrayfun(@(i) unwrap(deg2rad(headingAngle([max(1,bout_idx(i,1)-5) min(bout_idx(i,2)+5,size(head,1))],:))),1:size(bout_idx,1),'un',0);
%     deltaAngle = row2col(cellfun(@(x) diff(x),headAngle_bout),1);
    %%
    converge_angle(converge_angle==0) = nan;
    eyeConv = converge_angle;
    eyeConv = eyeConv - nanmedian(eyeConv);
    %     eyeConv = row2col(interp1(1:size(eyeConv,1),eyeConv,1:0.5:size(eyeConv,1)),1);
    eyeConv = arrayfun(@(i) deg2rad(eyeConv(max(1,bout_idx(i,1)-delay_idx):min(bout_idx(i,2)+delay_idx,size(tailAngle,1)),:)),1:nBout,'un',0);
    
    
    whichFish = repmat({fishname},length(boutAngle),1);
    whichBout = bout_idx;
    
    [~,name,~] = fileparts(filepath);
    str = split(name,'_');
    species = repmat(str(3),length(boutAngle),1);
    age = repmat(str2num(str{4}(1:end-3)),length(boutAngle),1);
%     exptype = repmat(str(5),length(boutAngle),1);
    
    eyeConv = row2col(eyeConv,1);
    
    save(fullfile(filepath,'tail_swing_tail.mat'),'bout_idx');

end