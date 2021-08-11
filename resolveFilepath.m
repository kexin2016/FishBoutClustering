function filepath = resolveFilepath(fishname,datapath)
%filepath = resolveFilepath(fishname,datapath)
%format of fishname: 20001212_1290
if nargin<2
%     datapath = 'Z:\freemoving-fish-virtual-param\data\tailCenterline';
datapath = '\\211.86.157.231\WenLabStorage2\freemoving-fish-virtual-param\data\210605NewTailCenterline';
end
filestruct = dir(fullfile(datapath,[fishname(1:6) '_' fishname(7:11) '*']));
% filestruct = dir(fullfile(datapath,fishname(1:6),[fishname(1:8) '_' fishname(9:end) '*']));
if isempty(filestruct)
    disp([fishname ' not found!']);
    filepath = [];
    return;
end
filepath = fullfile(filestruct.folder,filestruct.name);
end

