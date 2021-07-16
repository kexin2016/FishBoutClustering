function [] = AddFunctionToPath()


%%
%%%%%%%add to path the folders and subfolders where functions are %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get path + name of where this script is
thisScriptName = mfilename('fullpath');

%get path
thisPath = fileparts(thisScriptName);

%move one subfolder down
[mainFolderPath, ~, ~] = fileparts(thisPath);


%get all subfolders in path
allSubfolders = genpath(mainFolderPath);

addpath(allSubfolders);



