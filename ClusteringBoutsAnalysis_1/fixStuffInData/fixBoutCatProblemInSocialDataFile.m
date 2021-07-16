
  close all
clear all



folderName = 'C:\Joao analysis\FreeData\socialData\final\';
 filename = 'socialAvoid7fishLight_merged11BoutMap.mat';
%  filename = 'socialAvoid7fishDark_merged11BoutMap.mat';

path1 = strcat(folderName,filename);

 load(path1);       
       
%%
%%%%%%%%%%%%%%%% fix bout cat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BoutInfAll(:,EnumeratorBoutInf.boutCat) = newAssignmentSocialDataAll;


%%
%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PathName = 'C:\Joao analysis\FreeData\socialData\final\';
FileName = 'socialAvoid7fishLight_merged11BoutMap_2.mat';



save(strcat(PathName,FileName),'dataThisFishAll','dataThisFishRandAll','collisionVectorAll','collisionVectorRandAll','BoutInfAll','BoutKinematicParametersAll','newAssignmentSocialDataAll', '-v7.3')



