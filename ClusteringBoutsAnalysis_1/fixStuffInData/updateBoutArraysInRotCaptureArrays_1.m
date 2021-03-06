% AddFunctionToPath

close all
clear all


%%
% %%%%%%%%%%%%%% define number of workers to use %%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %matlabpool('close');
% 
% %close matlabpool if it is already opened
% if matlabpool('size') ~= 0 % checking to see if my pool is already open
%     
%     matlabpool close
% %     matlabpool open numberOfWorkers
%     
%     
% end
% 
% %start matlab pool with number of corrers
% matlabpool open 4


%%
%%%%%%%%%%%%%% load bout array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%4d prey capture uncov bouts
folder = 'C:\Joao analysis\FreeData\clusteringData\assignAllData\final\';
fileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated3.mat';


path2 = strcat(folder,fileName);

%%
%%%%%%%%%%%%%%%%%%%% save all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load(path2,'BoutKinematicParameters');
% BoutKinematicParameters = T.BoutKinematicParameters;
% clearvars T;

load(path2,'BoutInf');
% BoutInf = T.BoutInf;
% clearvars T;

%%
%%%%%%%%%%%%%% load rot data array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%4d prey capture uncov bouts
folder = 'C:\Joao analysis\FreeData\RotData\';
fileName = 'rotAlldata_merged11BoutMap.mat';


path3 = strcat(folder,fileName);

load(path3);

%%
%%%%%%%%%%%% make rot arrays the proper size %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%make boutInfAll
if size(BoutInfAll,2) <  size(BoutInf,2)
        
          vectorWithZeros = zeros(size(BoutInfAll,1),1);
          
          for k = 1 : (size(BoutInf,2) - size(BoutInfAll,2))
              
              BoutInfAll = [BoutInfAll vectorWithZeros];
              
              
          end
           
 end


%make BoutKinematicParametersAll
if size(BoutInfAll,2) <  size(BoutKinematicParameters,2)
        
          vectorWithZeros = zeros(size(BoutKinematicParametersAll,1),1);
          
          for k = 1 : (size(BoutKinematicParameters,2) - size(BoutKinematicParametersAll,2))
              
              BoutKinematicParametersAll = [BoutKinematicParametersAll vectorWithZeros];
              
              
          end
           
 end




%%
%%%%%%%%%%%%%%%% updade rot arrays %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boutUniqueNumberRot = BoutInfAll(:,EnumeratorBoutInf.boutUniqueNumber);
boutUniqueNumberAllData = BoutInf(:,EnumeratorBoutInf.boutUniqueNumber);

boutCatNew = BoutInfAll(:,EnumeratorBoutInf.boutCat);


indThisBoutAll = zeros(1,length(boutUniqueNumberRot));
parfor n = 1 : length(boutUniqueNumberRot)
    
    if mod(n, 10000) == 0
        n
    end
       
     indThisBoutAll(n) = find(boutUniqueNumberAllData == boutUniqueNumberRot(n));
      
    
end

 BoutInfAll(:,:) = BoutInf(indThisBoutAll,:);
 BoutKinematicParametersAll(:,:) = BoutKinematicParameters(indThisBoutAll,:);
 BoutInfAll(:,EnumeratorBoutInf.boutCat) = boutCatNew; 

clearvars -except BoutKinematicParameters BoutInf
%%
%%%%%%%%%%%%%%%%%%%% save all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pause
disp('saving array')

load(path2,'boutDataPCASample');
%boutDataPCASample = T.boutDataPCASample;
%clearvars T;

load(path2,'indStructure');
% indStructure = T.indStructure;
% clearvars T;

load(path2,'ROCareaNormDimProjtestNoNans');
% ROCareaNormDimProjtestNoNans = T.ROCareaNormDimProjtestNoNans;
% clearvars T;

load(path2,'clusterStructure');
% clusterStructure = T.clusterStructure;
% clearvars T;

load(path2,'groupClusterSctructure');
% groupClusterSctructure = T.groupClusterSctructure;
% clearvars T;

load(path2,'finalClustering');
% finalClustering = T.finalClustering;
% clearvars T;

load(path2,'behavioralSpaceStructure');
% behavioralSpaceStructure = T.behavioralSpaceStructure;
% clearvars T;



%%
%%%%%%%%%%%%%%%%%%%%%%%% save data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

newFileName = 'BoutCat_kNN4_74Kins4dims_1.75Smooth_slow_3000_auto_4roc_merged11_updated3.mat';


% save(strcat(folder,fileName),'BoutKinematicParameters','BoutInf','boutDataPCASample','behavioralSpaceStructure','indStructure','-v7.3')

save(strcat(folder,newFileName),'BoutInf','BoutKinematicParameters','ROCareaNormDimProjtestNoNans','behavioralSpaceStructure','boutDataPCASample','clusterStructure','groupClusterSctructure','indStructure','finalClustering','-v7.3')



