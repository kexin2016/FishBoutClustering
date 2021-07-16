function fig = plot_end_tail_angle(boutAngle,mode,labelname)
%function plot_end_tail_angle(boutAngle,mode)
% idx_1 = randperm(length(boutAngle),100);
idx_1 = 1:length(boutAngle);
boutAngle = boutAngle(idx_1);
end_tail = cellfun(@(x) x(:,8),boutAngle,'un',0);
dur = cellfun(@(x) size(x,1),end_tail);
% end_tail(dur>30 | dur<20) = [];
end_tail = cellfun(@(x) x-x(1),end_tail,'un',0);
if strcmpi(mode,'register')
    thld = quantile(abs(cat(1,end_tail{:})),0.9);
    idx = cellfun(@(x) find(abs(x)>thld,1),end_tail,'un',0);
    end_tail(cellfun(@isempty,idx)) = [];
    idx(cellfun(@isempty,idx)) = [];
    idx = cell2mat(idx);
    slope = zeros(length(end_tail),1);
    for i=1:length(end_tail)
        if idx(i)+1<=length(end_tail{i})
            slope(i) = abs(diff(end_tail{i}(idx(i):idx(i)+1)));
        end
        if end_tail{i}(idx(i))<0
            end_tail{i} = -end_tail{i};
        end
        if idx(i)>median(idx)
            end_tail{i} = end_tail{i}(idx(i)-ceil(median(idx))+1:end);
        elseif idx(i)<median(idx)
            end_tail{i} = [zeros(ceil(median(idx))-idx(i),1);end_tail{i}];
        end
    end
    numBout = length(end_tail);
    dist = zeros(numBout,numBout);
    % for iRow=1:length(end_tail)
    %     parfor iCol = iRow+1:length(end_tail)
    %         d1 = dtw(end_tail{iRow},end_tail{iCol});
    %         d2  =dtw(end_tail{iRow},-end_tail{iCol});
    %         dist(iRow,iCol) = min(d1,d2);
    %     end
    % end
    % dist = dist+dist';
    % [~,bout_idx] = min(sum(dist));
elseif strcmpi(mode,'peak')
    [value,pos] = cellfun(@(x) max(abs(x)),end_tail);
    idx_1 = idx_1(pos==10);
    end_tail = end_tail(pos==10);
end
if isempty(end_tail)
    return;
end
fig=figure,hold on;
arrayfun(@(i) plot(end_tail{i},'k','LineWidth',0.1,'ButtonDownFcn',@(src,evt) displaytext(src,evt,gca,idx_1(i))),1:length(end_tail));
set(gca,'XLim',[0 max(1,quantile(cellfun(@length,end_tail),0.75))],'YLim',[-2 2]);
plot(end_tail{randperm(length(end_tail),1)},'r','LineWidth',1);
title(labelname);
grid on;
% plot(end_tail{bout_idx},'r','LineWidth',1);
end
function displaytext(src,eventdata,axeshandle,id)
    [y,I] = max(abs(src.YData));
    x = src.XData(I);
    text(axeshandle,x,y,num2str(id));
    title(gca,num2str(id));
%     src.Color = 'red';
end

