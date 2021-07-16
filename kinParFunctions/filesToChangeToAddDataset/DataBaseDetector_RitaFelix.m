%this function detects the data base and retrieves the data from variable a

%inputs
%1) a
%2) dataSetName

%outputs
%1) stim
%2) lag
%3) tailAngles 
%4) tailValues
%5) bodyAngles
%6) xPos
%7) yPos
%8) blobVal



 function [stim,lag,tailAngles,tailValues,bodyAngles,xPos,yPos,blobVal,pixelSize,headToBladderLength,tailSegmentLength,distanceEyesToBlob,dataSetNumbr,arenaX,arenaY,protocolNumb,leftEyeAngle,rightEyeAngle,numbFishInSquare,parameciaCounter,frameNumber] = DataBaseDetector_RitaFelix(a,dataSetName)


 
     
 
       
        
     
        
        
     
        
        
        
       %data set LoomingSpeeds
        TF = strcmp(dataSetName,'LoomingSpeedsTuSave');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingSpeedsTuSave;
            protocolNumb = EnumeratorProtocol.LoomingDiferentSpeeds_10005;
            
           distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         
        TF = strcmp(dataSetName,'PreyCaptureVideo');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureVideo;
            protocolNumb = EnumeratorProtocol.RoomIllumination_1111;
            
            %new prey capture rig with paramecia tracker and saving images
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,70);%not completelly sure it is correct... has some strange problem with -1 when stim changes... I think...
            lag = a(:,76);
            tailAngles = a(:,27:36);
            tailValues = a(:,16:25);
            bodyAngles = a(:,2);%correct
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM maybe 30....
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,37:67);
            numbFishInSquare = NaN;
            frameNumber = a(:,1);%correct
        
        end
         
    
        
                TF = strcmp(dataSetName,'PreyCaptureNaiveTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureNaiveTu;
            protocolNumb = EnumeratorProtocol.RoomIllumination_1111;
            
            %new prey capture rig with paramecia tracker and saving images
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,70);%not completelly sure it is correct... has some strange problem with -1 when stim changes... I think...
            lag = a(:,76);
            tailAngles = a(:,27:36);
            tailValues = a(:,16:25);
            bodyAngles = a(:,2);%correct
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM maybe 30....
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,37:67);
            numbFishInSquare = NaN;
            frameNumber = a(:,1);%correct
        
        end
        
        
         TF = strcmp(dataSetName,'PreyCaptureExpTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureExpTu;
            protocolNumb = EnumeratorProtocol.RoomIllumination_1111;
            
            %new prey capture rig with paramecia tracker and saving images
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,70);%not completelly sure it is correct... has some strange problem with -1 when stim changes... I think...
            lag = a(:,76);
            tailAngles = a(:,27:36);
            tailValues = a(:,16:25);
            bodyAngles = a(:,2);%correct
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM maybe 30....
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,37:67);
            numbFishInSquare = NaN;
            frameNumber = a(:,1);%correct
        
        end
        
        TF = strcmp(dataSetName,'OMRSpontaneousTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpontaneousTu;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
        
        
        end
        
        TF = strcmp(dataSetName,'OMRSpontaneousTu2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpontaneousTu2;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
        
        
        end
        
        
        TF = strcmp(dataSetName,'PreyCaptureNaiveTu2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureNaiveTu2;
            protocolNumb = EnumeratorProtocol.RoomIllumination_1111;
            
            %new prey capture rig with paramecia tracker and saving images
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,70);%not completelly sure it is correct... has some strange problem with -1 when stim changes... I think...
            lag = a(:,76);
            tailAngles = a(:,27:36);
            tailValues = a(:,16:25);
            bodyAngles = a(:,2);%correct
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM maybe 30....
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,37:67);
            numbFishInSquare = NaN;
            frameNumber = a(:,1);%correct
        
        end
        
        
        
        TF = strcmp(dataSetName,'PreyCaptureExpTu2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureExpTu2;
            protocolNumb = EnumeratorProtocol.RoomIllumination_1111;
            
            %new prey capture rig with paramecia tracker and saving images
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,70);%not completelly sure it is correct... has some strange problem with -1 when stim changes... I think...
            lag = a(:,76);
            tailAngles = a(:,27:36);
            tailValues = a(:,16:25);
            bodyAngles = a(:,2);%correct
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM maybe 30....
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,37:67);
            numbFishInSquare = NaN;
            frameNumber = a(:,1);%correct
        
        end
       
        
          TF = strcmp(dataSetName,'DarkSocial7FishCapVideo');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkSocial7FishCapVideo;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
             TF = strcmp(dataSetName,'LightSocial7FishCapVideo');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LightSocial7FishCapVideo;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
           TF = strcmp(dataSetName,'DarkSocial7FishCapVideo2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkSocial7FishCapVideo2;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end


%%
%%%%%%%%%%%%%%%%%% strain experiments %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        

           %data set Ospont swimming
        TF = strcmp(dataSetName,'DarkLightTransitionsTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkLightTransitionsTu;
            protocolNumb = EnumeratorProtocol.DarkLight3minNew_1000002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
  
%%
%%%%%%%%%%%%%%%%%% strain experiments speed %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
        
        %data set for OMR speed
        TF = strcmp(dataSetName,'OMRSpeedTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeedTu;
            protocolNumb = EnumeratorProtocol.OMRSpeed10speeds_1000000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
            
        end
        
        
           %data set for OMR speed
        TF = strcmp(dataSetName,'OMRSpeedTl');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeedTl;
            protocolNumb = EnumeratorProtocol.OMRSpeed10speeds_1000000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
            
        end
        
        
            %data set for OMR speed
        TF = strcmp(dataSetName,'OMRSpeedWik');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeedWik;
            protocolNumb = EnumeratorProtocol.OMRSpeed10speeds_1000000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
            
        end
        
        
             %data set for OMR speed
        TF = strcmp(dataSetName,'OMRSpeedAb');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeedAb;
            protocolNumb = EnumeratorProtocol.OMRSpeed10speeds_1000000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
            
        end
        
               %data set for OMR speed
        TF = strcmp(dataSetName,'OMRSpeed5D');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeed5D;
            protocolNumb = EnumeratorProtocol.OMRSpeed10speeds_1000000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
            
        end
        
               %data set for OMR speed
        TF = strcmp(dataSetName,'OMRSpeedLeoNewProjector');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeedLeoNewProjector;
            protocolNumb = EnumeratorProtocol.OMRSpeed10speeds_1000000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
            
        end
        
        
         TF = strcmp(dataSetName,'OMRSpeedLeoNewProjector2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeedLeoNewProjector2;
            protocolNumb = EnumeratorProtocol.OMRSpeed10speeds_1000000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
            
        end
        
        
         TF = strcmp(dataSetName,'OMRSpeedTuNewProjector2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeedTuNewProjector2;
            protocolNumb = EnumeratorProtocol.OMRSpeed10speeds_1000000;        
                      
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
            
        end
        
        
%%
%%%%%%%%%%%%%%%%%% strain experiments loomings %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
        
         %data set LoomingSpeeds
        TF = strcmp(dataSetName,'LoomingSpeedsTl');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingSpeedsTl;
            protocolNumb = EnumeratorProtocol.LoomingDiferentSpeeds_10005;
            
           distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
                %data set LoomingSpeeds
        TF = strcmp(dataSetName,'LoomingSpeedsTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingSpeedsTu;
            protocolNumb = EnumeratorProtocol.LoomingDiferentSpeeds_10005;
            
           distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
                   %data set LoomingSpeeds
        TF = strcmp(dataSetName,'LoomingSpeedsWik');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingSpeedsWik;
            protocolNumb = EnumeratorProtocol.LoomingDiferentSpeeds_10005;
            
           distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
                         %data set LoomingSpeeds
        TF = strcmp(dataSetName,'LoomingSpeedsAb');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingSpeedsAb;
            protocolNumb = EnumeratorProtocol.LoomingDiferentSpeeds_10005;
            
           distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
                                %data set LoomingSpeeds
        TF = strcmp(dataSetName,'LoomingSpeeds5D');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingSpeeds5D;
            protocolNumb = EnumeratorProtocol.LoomingDiferentSpeeds_10005;
            
           distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
                                     %data set LoomingSpeeds
        TF = strcmp(dataSetName,'LoomingSpeedsLeo');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingSpeedsLeo;
            protocolNumb = EnumeratorProtocol.LoomingDiferentSpeeds_10005;
            
           distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,26);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
%%
%%%%%%%%%%%%%%%%%% strain experiments OMR turns %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%               
        
           %data set for OMR turns
        TF = strcmp(dataSetName,'OMRTurnTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurnTu;
            protocolNumb = EnumeratorProtocol.OMRTurns8Dir_1000001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        
        
           %data set for OMR turns
        TF = strcmp(dataSetName,'OMRTurnTl');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurnTl;
            protocolNumb = EnumeratorProtocol.OMRTurns8Dir_1000001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        
                  %data set for OMR turns
        TF = strcmp(dataSetName,'OMRTurnWik');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurnWik;
            protocolNumb = EnumeratorProtocol.OMRTurns8Dir_1000001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        
                         %data set for OMR turns
        TF = strcmp(dataSetName,'OMRTurnAb');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurnAb;
            protocolNumb = EnumeratorProtocol.OMRTurns8Dir_1000001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        
                               %data set for OMR turns
        TF = strcmp(dataSetName,'OMRTurn5D');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurn5D;
            protocolNumb = EnumeratorProtocol.OMRTurns8Dir_1000001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end

        
        %data set for OMR turns
        TF = strcmp(dataSetName,'OMRTurnLeo');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurnLeo;
            protocolNumb = EnumeratorProtocol.OMRTurns8Dir_1000001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        %data set for OMR turns
        TF = strcmp(dataSetName,'OMRTurnLeoNewProjector');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurnLeoNewProjector;
            protocolNumb = EnumeratorProtocol.OMRTurns8Dir_1000001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
 %data set for OMR turns
        TF = strcmp(dataSetName,'OMRTurnLeoNewProjector2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurnLeoNewProjector2;
            protocolNumb = EnumeratorProtocol.OMRTurns8Dir_1000001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end


%%
%%%%%%%%%%%%%%%%%%%%%%% strain experiments social Light %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



            %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishLightTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightTu;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
        
        %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishLightTl');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightTl;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         
        %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishLightWik');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightWik;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
            %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishLightAb');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightAb;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
               %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishLight5D');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLight5D;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
                   %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishLightLeo');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightLeo;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_11000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
   
        
%%
%%%%%%%%%%%%%%%%%%%%%%% strain experiments social Dark %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        
        
        
               %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishDarkTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkTu;
            protocolNumb = EnumeratorProtocol.projectorOffInOldRig_00000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
             
               %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishDarkTl');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkTl;
            protocolNumb = EnumeratorProtocol.projectorOffInOldRig_00000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
                 %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishDarkWik');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkWik;
            protocolNumb = EnumeratorProtocol.projectorOffInOldRig_00000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
                    %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishDarkAb');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkAb;
            protocolNumb = EnumeratorProtocol.projectorOffInOldRig_00000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
                       %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishDark5D');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDark5D;
            protocolNumb = EnumeratorProtocol.projectorOffInOldRig_00000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
            
                       %data set for social avoidance
        TF = strcmp(dataSetName,'Social2FishDarkLeo');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkLeo;
            protocolNumb = EnumeratorProtocol.projectorOffInOldRig_00000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,32);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
        
        
   %%
        %%%%%%%%%%%%%%%% give all empty %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if  ~exist ('dataSetNumbr', 'var')
        
            dataSetNumbr = [];
            protocolNumb = [];
            
            distanceEyesToBlob = [];%in um
            stim = [];
            lag = [];
            tailAngles = [];
            tailValues = [];
            bodyAngles = [];
            xPos = [];
            yPos = [];
            blobVal = [];
            pixelSize = [];
            headToBladderLength = [];
            tailSegmentLength = [];
            arenaX  = [];
            arenaY = [];
            leftEyeAngle = [];
            rightEyeAngle = [];
            
            parameciaCounter = [];
            numbFishInSquare = [];
            frameNumber  = [];
            
            
            
        end