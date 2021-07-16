function index = extractMultiVideo(fishName,boutframe,filename,countflag)
%function index = extractMultiVideo(fishName,boutframe,filename,countflag)
%note
if nargin<4
    countflag = false;
end
fishID = unique(fishName);
if exist(fullfile(getpath('result'),[filename '.avi']),'file')
    warning('file already exist,press to continue....');
    pause;
end
VW = VideoWriter(fullfile(getpath('result'),[filename '.avi']));
open(VW);
boutcount = 0;
index = [];
for iFish = 1:length(unique(fishName))
    tmp_fishname = fishID{iFish};
    videopath = dir(fullfile('Z:\freemoving-fish-virtual-param\data\rawData',tmp_fishname(1:6),[tmp_fishname(1:8) '_' tmp_fishname(9:end) '*.avi']));
%     videopath = dir(fullfile('Z:\freemoving-fish-virtual-param\data\rawData','keyDataSet',[tmp_fishname(1:8) '_' tmp_fishname(9:end) '*.avi']));
    v = VideoReader(fullfile(videopath.folder,videopath.name));
    index = [index;row2col(find(ismember(fishName,fishID{iFish})),1)];
    tmp_boutframe = boutframe(ismember(fishName,fishID{iFish}),:);
    for iFrame = 1:size(tmp_boutframe,1)
        boutcount = boutcount + 1;
        try 
        frames = read(v,[max(1,tmp_boutframe(iFrame,1)-7) min(tmp_boutframe(iFrame,2)+7,v.NumFrames)]);
        catch ME
            if strcmp(ME.message,'Unable to seek to position Reason: 给定了无效的时间戳。')
                disp('one bout ignored');
                continue;
            else
                rethrow(ME);
            end
        end
        if countflag
            figure('Position',[1 1 size(frames,1) size(frames,2)],'Visible','off');
            title(num2str(boutcount));
            frame_plot = getframe(gcf);
            frame_plot = frame_plot.cdata;
            writeVideo(VW,frame_plot);
            close(gcf);
        end
        writeVideo(VW,frames);
        
    end
end
close(VW);
end

