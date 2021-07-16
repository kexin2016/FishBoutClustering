

%close all


function [objPixelReal] = ObjDetector_2(stats,cumsumInterpolatedAnglesGray)


% stats = statsPos;
% stats = statsNeg;

%% %%%%%%%%%%%Calculate parameters of shapes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% centroidStats = regionprops(stats, 'centroid');
areaStats = regionprops(stats, 'area');
% majorAxisLengthStats = regionprops(stats, 'MajorAxisLength');
% minorAxisLengthStats = regionprops(stats, 'MinorAxisLength');
objPixel = regionprops(stats, 'PixelList');
% objOrientation = regionprops(stats, 'Orientation');


%% %%%%%%%%%%%%%erase objects that are too small%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indRealObj = [areaStats.Area] > 3;

%erase data from fake objs
% centroidStatsReal = centroidStats(indRealObj);
% areaStatsReal = areaStats(indRealObj);
% majorAxisLengthStatsReal = majorAxisLengthStats(indRealObj);
% minorAxisLengthStatsReal = minorAxisLengthStats(indRealObj);

if ~isempty(indRealObj)%avoid case where all objects are too small

objPixelReal = objPixel(indRealObj);
% objOrientationReal = objOrientation(indRealObj);


%% %%%%%%%%%%%%erase obj that are not long enouth%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


realObj = zeros(1,length(objPixelReal));
 for ii = 1 : length(objPixelReal)
     
     if max(objPixelReal(ii).PixelList(:,1)) == size(cumsumInterpolatedAnglesGray,2)%erase segments that don't exist in last segment
         
     realObj(ii) = length(unique(objPixelReal(ii).PixelList(:,1)));
     
     else 
         
     realObj(ii) = 0;%it will be detected as short and erased
     
     end
 end

indRealObj = realObj>=2;

%erase data from fake objs
% centroidStatsReal = centroidStatsReal(indRealObj);
% areaStatsReal = areaStatsReal(indRealObj);
% majorAxisLengthStatsReal = majorAxisLengthStatsReal(indRealObj);
% minorAxisLengthStatsReal = minorAxisLengthStatsReal(indRealObj);

if ~isempty(indRealObj)

objPixelReal = objPixelReal(indRealObj);
% objOrientationReal = objOrientationReal(indRealObj);
else

    objPixelReal = [];
    
    
end

else 
    
    objPixelReal = [];
    
end


%% %%%%%%%%%%Calculate center of mass for each segment in shape%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CM_All_Ind_one = [];
% CM_All_Ind_two = [];
% CM_All_Ind_three = [];

% %loop through each obj 
%  for ii = 1 : length(objPixelReal)
%   %%
%     %%%%%%%%%%%%%%%%%erase obj that don't exist in last segment%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if max(objPixelReal(ii).PixelList(:,1)) == size(cumsumInterpolatedAnglesGray,2)
%         
%         
        
        
%      %%%%%%%%%%Calculate center of mass for each segment in shape%%%%%%%%%%%%%%%
%      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      
%      %ii =2
%      %retrieve values of pixels for this obj
% %      thisObjImage = cumsumInterpolatedAnglesGray*0;
%      
%      objXY = objPixelReal(ii).PixelList;
%      objX = objXY(:,1);
%      objY = objXY(:,2);
%      
%      %transform index to linear index
%      objInd = sub2ind(size(cumsumInterpolatedAnglesGray),objY, objX);
%      objVal = cumsumInterpolatedAnglesGray(objInd);
%      
%      %calculate center of mass for each segment
%      CM_X = nan(1,10);
%      CM_Y = nan(1,10);
%      
%      
%      [uniqueSegmentsVal ~] = unique(objX, 'first');
%      
%      for iiii = 1 : length(uniqueSegmentsVal)
%         indThisSegment =  find(objX == uniqueSegmentsVal(iiii));
%      
%      CM_X(uniqueSegmentsVal(iiii)) = sum(objVal(indThisSegment).*objX(indThisSegment))/(sum(objVal(indThisSegment)));
%      CM_Y(uniqueSegmentsVal(iiii)) = sum(objVal(indThisSegment).*objY(indThisSegment))/(sum(objVal(indThisSegment)));
%      
%      end
     
     %%
     %%%%%%%%%%%%%%%%%%%%%%%save peaks of bout%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
     %test obj detection and CM detection
     %create image
%   thisObjImage(objInd) = cumsumInterpolatedAnglesGray(objInd);
     
     %make rpg image
%      grayScaleImage = mat2gray(thisObjImage);
     
%      my_image = zeros((size(grayScaleImage,1)),size(grayScaleImage,2),3); %initialize the image
%      my_image(:,:,1) = grayScaleImage;
%      my_image(:,:,2) = grayScaleImage;
%      my_image(:,:,3) = grayScaleImage;

     %erase nans
%      CM_X_NoNaN = CM_X(isfinite(CM_X));
%      CM_Y_NoNaN = CM_Y(isfinite(CM_Y));
     
     %transform index to linear index
%      CM_Ind_one = sub2ind(size(my_image), round(CM_Y_NoNaN), round(CM_X_NoNaN),(zeros(1,length(CM_X_NoNaN)) + 1));
%      CM_Ind_two = sub2ind(size(my_image), round(CM_Y_NoNaN), round(CM_X_NoNaN),(zeros(1,length(CM_X_NoNaN)) + 2));
%      CM_Ind_three = sub2ind(size(my_image), round(CM_Y_NoNaN), round(CM_X_NoNaN),(zeros(1,length(CM_X_NoNaN)) + 3));
%      
     
     
     %CM_Ind_one = sub2ind(size(my_image), CM_Y_NoNaN, CM_X_NoNaN,(zeros(1,length(CM_X_NoNaN)) + 1));
     %CM_Ind_two = sub2ind(size(my_image), CM_Y_NoNaN, CM_X_NoNaN,(zeros(1,length(CM_X_NoNaN)) + 2));
     %CM_Ind_three = sub2ind(size(my_image), CM_Y_NoNaN, CM_X_NoNaN,(zeros(1,length(CM_X_NoNaN)) + 3));
     
     %lable image
%      my_image(round(CM_Ind_one)) = 1;
%      my_image(round(CM_Ind_two)) = 0;
%      my_image(round(CM_Ind_three)) = 0;
    
%      %test each obj 
%      figure
%      imagesc(my_image)
%      colormap gray

%      CM_All_Ind_one = [CM_All_Ind_one CM_Ind_one];
%      CM_All_Ind_two = [CM_All_Ind_two CM_Ind_two];
%      CM_All_Ind_three = [CM_All_Ind_three CM_Ind_three];
     
     
     
%     else
% %      CM_All_Ind_one = CM_All_Ind_one;
% %      CM_All_Ind_two = CM_All_Ind_two;
% %      CM_All_Ind_three = CM_All_Ind_three;
%      objPixelReal(ii).PixelList = NaN;
%         
%     end
 %end
 
 
     


 
 