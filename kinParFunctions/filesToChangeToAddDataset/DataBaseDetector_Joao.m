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



 function [stim,lag,tailAngles,tailValues,bodyAngles,xPos,yPos,blobVal,pixelSize,headToBladderLength,tailSegmentLength,distanceEyesToBlob,dataSetNumbr,arenaX,arenaY,protocolNumb,leftEyeAngle,rightEyeAngle,numbFishInSquare,parameciaCounter,frameNumber] = DataBaseDetector_Joao(a,dataSetName)


%% 
%%%%%%%%%%%%%%%%%%%% Joao data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        %%%%%%%%%%%%%%%retrieve important variables from a array%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %this depends of the type of data set because order is diferent
        
        %data set OMRSpeed1
        TF = strcmp(dataSetName,'OMRSpeed1');
         
        if TF == 1
            
            dataSetNumbr = EnumeratorDataSet.OMRSpeed1;
            protocolNumb = EnumeratorProtocol.Speed2_ForwardGratings_protocol_1;
            
            
            distanceEyesToBlob = 288.5611;%in um
            stim = a(:,39);
            lag = a(:,41);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 130;%in uM
            headToBladderLength = 5.5;%in pixels
            tailSegmentLength = 3.0;%in pixels
            arenaX = 1130;%in pixels
            arenaY = 144;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
           
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        %data set OMRSpeed2
        TF = strcmp(dataSetName,'OMRSpeed2');
         
        if TF == 1
            
            dataSetNumbr = EnumeratorDataSet.OMRSpeed2;
            protocolNumb = EnumeratorProtocol.Speed2_ForwardGratings_protocol_2;
            
            distanceEyesToBlob = 288.5611;%in um
            stim = a(:,40);
            lag = a(:,43);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 76;%in uM
            headToBladderLength = 10;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 2320;%in pixels
            arenaY = 190;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
   
        
        %data set OMRSpeed3
        TF = strcmp(dataSetName,'OMRSpeed3');
         
        if TF == 1
          
            dataSetNumbr = EnumeratorDataSet.OMRSpeed3;
            protocolNumb = EnumeratorProtocol.Speed2_ForwardGratings_protocol_5;
            
            distanceEyesToBlob = 288.5611;%in um
            stim = a(:,40);
            lag = a(:,43);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 69.83;%in uM
            headToBladderLength = 10;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 2320;%in pixels
            arenaY = 190;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
                 
        %data set OMRSpeed4
        TF = strcmp(dataSetName,'OMRSpeed4');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeed4;
            protocolNumb = EnumeratorProtocol.Speed2_ForwardGratings_protocol_5;
            
            distanceEyesToBlob = 288.5611;%in um
            stim = a(:,40);
            lag = a(:,43);
            tailAngles = a(:,23:38);
            tailValues = a(:,6:21);
            bodyAngles = a(:,22);
            xPos = a(:,5);
            yPos = a(:,4);
            blobVal =  a(:,2);
            pixelSize = 69.83;%in uM
            headToBladderLength = 10;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 2320;%in pixels
            arenaY = 190;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'OMRTurns2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurns2;
            protocolNumb = EnumeratorProtocol.OpenField1_TurnGratings_protocol_11;
            
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
        
        
         TF = strcmp(dataSetName,'3minLightDark2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LightDark3min2;
            protocolNumb = EnumeratorProtocol.LightDark3minPreyCapture_59cm_protocol_25;
            
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
        
         TF = strcmp(dataSetName,'3minLightDarkPrey2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LightDarkPrey3min2;
            protocolNumb = EnumeratorProtocol.LightDark3minPreyCapture_59cm_protocol_25;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
        TF = strcmp(dataSetName,'3minLightDark1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LightDark3min1;
            protocolNumb = EnumeratorProtocol.LightDark3minPreyCapture_59cm_protocol_25;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
        TF = strcmp(dataSetName,'LightDarkFlash1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LightDarkFlash1;
            protocolNumb = EnumeratorProtocol.LightDarkFlash_protocol_27;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
        
        TF = strcmp(dataSetName,'AcousticStartle1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.AcousticStartle1;
            protocolNumb = EnumeratorProtocol.AcousticStartle1_protocol_40;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
        TF = strcmp(dataSetName,'LightFlashAcousticStartle1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LightFlashAcousticStartle1;
            protocolNumb = EnumeratorProtocol.LightFlashAcousticStartle1_protocol_41;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
        TF = strcmp(dataSetName,'OMRSpeed5');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeed5;
            protocolNumb = EnumeratorProtocol.OpenField1_ForwardGratings_protocol_6;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
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
        
        TF = strcmp(dataSetName,'AcusticStartle2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.AcusticStartle2;
            protocolNumb = EnumeratorProtocol.OpenField1_AcusticStartle2;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
  
        TF = strcmp(dataSetName,'multiFishLight1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiFishLight1;
            protocolNumb = EnumeratorProtocol.OpenField1_multiFishLight1;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'MultiFishAcousticStartle1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.MultiFishAcousticStartle1;
            protocolNumb = EnumeratorProtocol.MultiFishAcousticStartle1_protocol_44;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'MultiFishDarkFlash1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.MultiFishDarkFlash1;
            protocolNumb = EnumeratorProtocol.MultiFishDarkFlash1_33;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
            
        end
        
        TF = strcmp(dataSetName,'PreyCaptureMini');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureMini;
            protocolNumb = EnumeratorProtocol.PreyCaptureMini_protocol1;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        
         TF = strcmp(dataSetName,'multiFlash3min1sManyInt');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiFlash3min1sManyInt;
            protocolNumb = EnumeratorProtocol.multiFlash3min1s6Intensities_2005;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        
         TF = strcmp(dataSetName,'multiStartle1000hz100msLightFlash1min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiStartle1000hz100msLightFlash1min;
            protocolNumb = EnumeratorProtocol.multi_LightFlash_Beep_1000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'multiStartle500hz100msLightFlash1min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiStartle500hz100msLightFlash1min;
            protocolNumb = EnumeratorProtocol.multi_LightFlash_Beep_1001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
          TF = strcmp(dataSetName,'multiStartle500hz100msLightFlash15s');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiStartle500hz100msLightFlash15s;
            protocolNumb = EnumeratorProtocol.multi_LightFlash_Beep_1002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
          TF = strcmp(dataSetName,'multiStartle500hz100msLightFlash3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiStartle500hz100msLightFlash3min;
            protocolNumb = EnumeratorProtocol.multi_LightFlash_Beep3min_1004;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
          TF = strcmp(dataSetName,'multiStartleFlashLearning');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiStartleFlashLearning;
            protocolNumb = EnumeratorProtocol.multi_LightFlash_Beep3min_Learning_1007;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
           TF = strcmp(dataSetName,'multiStartleFlashInversed');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiStartleFlashInversed;
            protocolNumb = EnumeratorProtocol.multi_LightFlash_Beep3min_Inversed_1008;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
           TF = strcmp(dataSetName,'multiBeap200Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap200Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
          TF = strcmp(dataSetName,'multiBeap400Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap400Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
          TF = strcmp(dataSetName,'multiBeap600Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap600Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'multiBeap800Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap800Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeap1000Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap1000Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        
        TF = strcmp(dataSetName,'multiBeap1200Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap1200Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeap1400Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap1400Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeap1600Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap1600Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeap1800Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap1800Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeap2000Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeap2000Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'multiLightFlash3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiLightFlash3min;
            protocolNumb = EnumeratorProtocol.multi_LightFlash_3min_2001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'multiBeapFlash200Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash200Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
               
        TF = strcmp(dataSetName,'multiBeapFlash400Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash400Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeapFlash600Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash600Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeapFlash800Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash800Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'multiBeapFlash1000Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash1000Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeapFlash1200Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash1200Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeapFlash1400Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash1400Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeapFlash1600Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash1600Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeapFlash1800Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash1800Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'multiBeapFlash2000Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiBeapFlash2000Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_BeapFlash_3min_2003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'uniBeap600Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.uniBeap600Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_Beap_3min_2002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'OMRTurnSpeed1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRTurnSpeed1;
            protocolNumb = EnumeratorProtocol.OpenField1_TurnGratingsSpeed1_protocol_2004;
            
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
        
        
         TF = strcmp(dataSetName,'multiFlash3min1sManyInt2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiFlash3min1sManyInt2;
            protocolNumb = EnumeratorProtocol.multiFlash3min1s6Intensities2_2006;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        
        TF = strcmp(dataSetName,'uniLightBeap1000Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.uniLightBeap1000Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_LightBeap_3min_2007;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        
        TF = strcmp(dataSetName,'multiLightBeap1000Hz100ms3min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiLightBeap1000Hz100ms3min;
            protocolNumb = EnumeratorProtocol.multi_LightBeap_3min_2007;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        
        TF = strcmp(dataSetName,'spontaneousSwimming');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontaneousSwimming;
            protocolNumb = EnumeratorProtocol.spontaneousSwimming_protocol_50;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        
         TF = strcmp(dataSetName,'multiFlash3min1sManyInt3');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.multiFlash3min1sManyInt3;
            protocolNumb = EnumeratorProtocol.multiFlash3min1s6Intensities3_2008;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'Phototaxis4');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Phototaxis4;
            protocolNumb = EnumeratorProtocol.Phototaxis4_protocol_53_Intensities_2009;
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
        
        
        TF = strcmp(dataSetName,'PreyCapture');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCapture;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        
         TF = strcmp(dataSetName,'SpontanousEyeTracking');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontanousEyeTracking;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'SpontanousComp');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontanousComp;
            protocolNumb = EnumeratorProtocol.RGB70_2011;
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
        
         TF = strcmp(dataSetName,'PreyCaptureNaive');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureNaive;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'SpontaneousMultiFishGray');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontaneousMultiFishGray;
            protocolNumb = EnumeratorProtocol.RGB70_2011;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'SpontaneousMultiFishBlack');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontaneousMultiFishBlack;
            protocolNumb = EnumeratorProtocol.RGB70_2012;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
        
        TF = strcmp(dataSetName,'SpontaneousMultiFishBlack2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontaneousMultiFishBlack2;
            protocolNumb = EnumeratorProtocol.RGB70_2012;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'preyCaptureNaiveDark2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.preyCaptureNaiveDark2;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_0000;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
        TF = strcmp(dataSetName,'preyCaptureNaiveLight2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.preyCaptureNaiveLight2;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'preyCaptureParLight2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.preyCaptureParLight2;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
         TF = strcmp(dataSetName,'preyCaptureParDark2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.preyCaptureParDark2;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_0000;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            
        end
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'Beeps200to2000');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Beeps200to2000;
            protocolNumb = EnumeratorProtocol.multi_Beep_3000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'FlashBeeps200to2000');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.FlashBeeps200to2000;
            protocolNumb = EnumeratorProtocol.multi_FlashBeap_3001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'ShortLightFlash');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.ShortLightFlash;
            protocolNumb = EnumeratorProtocol.multi_Flash_3002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'uniFishLighDarkBeeps2min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.uniFishLighDarkBeeps2min;
            protocolNumb = EnumeratorProtocol.lighDarkBeeps_5000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
                    
        %data set OMRturns2
        TF = strcmp(dataSetName,'uniFishLighDarkBeeps90s');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.uniFishLighDarkBeeps90s;
            protocolNumb = EnumeratorProtocol.lighDarkBeeps_5001;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'uniFishLighDarkBeeps2minPar');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.uniFishLighDarkBeeps2minPar;
            protocolNumb = EnumeratorProtocol.lighDarkBeeps_5000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
                    
        %data set OMRturns2
        TF = strcmp(dataSetName,'VisualEscapesShadow2directions');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.VisualEscapesShadow2directions;
            protocolNumb = EnumeratorProtocol.VisualEscapesShadow2directions_5002;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'VisualEscapesShadow2directionsWithSpace');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.VisualEscapesShadow2directionsWithSpace;
            protocolNumb = EnumeratorProtocol.VisualEscapesShadow2directionsWithSpace_5003;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'bigCircleDiferentDirections2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.bigCircleDiferentDirections2;
            protocolNumb = EnumeratorProtocol.bigCircleDiferentDirections2_6000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
                   
        %data set OMRturns2
        TF = strcmp(dataSetName,'virtualPrey2Directions');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.virtualPrey2Directions;
            protocolNumb = EnumeratorProtocol.virtualprey2directions_6003;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,82);% in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 27.95;%in uM maybe 30....
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
                    
        %data set OMRturns2
        TF = strcmp(dataSetName,'virtualPreyFront');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.virtualPreyFront;
            protocolNumb = EnumeratorProtocol.virtualPreyFront_6004;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,82);% in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 27.95;%in uM maybe 30....
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
                    
        %data set OMRturns2
        TF = strcmp(dataSetName,'BeepsLightDarkEyeConv');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.BeepsLightDarkEyeConv;
            protocolNumb = EnumeratorProtocol.BeepsLightDarkEyeConv_6005;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,82);% in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 27.95;%in uM maybe 30....
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'LoomingDiferentSpeeds');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingDiferentSpeeds;
            protocolNumb = EnumeratorProtocol.LoomingDiferentSpeeds_6007;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'lightDarkBeeps9Nacre1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightDarkBeeps9Nacre1;
            protocolNumb = EnumeratorProtocol.lighDarkBeeps_5000;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,25);
            lag = a(:,27);
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
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontMultiFish10LightInt');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMultiFish10LightInt;
            protocolNumb = EnumeratorProtocol.lightDark11Int_6008;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,25);
            lag = a(:,27);
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
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontMultiFish10LightIntInd');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMultiFish10LightIntInd;
            protocolNumb = EnumeratorProtocol.lightDark11Int_6008;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,25);
            lag = a(:,27);
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
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'manyLightMainRig1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.manyLightMainRig1;
            protocolNumb = EnumeratorProtocol.smoothLight1_6011;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,25);
            lag = a(:,27);
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
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'manyLightMainRig2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.manyLightMainRig2;
            protocolNumb = EnumeratorProtocol.smoothLight1_6011;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,25);
            lag = a(:,27);
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
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'manyLightParRig1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.manyLightParRig1;
            protocolNumb = EnumeratorProtocol.smoothLight2_6012;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'manyLightParRig2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.manyLightParRig2;
            protocolNumb = EnumeratorProtocol.smoothLight2_6012;
            
            distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'manyLightParRig3');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.manyLightParRig3;
            protocolNumb = EnumeratorProtocol.smoothLight2_6012;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
          
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig0000Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig0000Lux1;
            protocolNumb = EnumeratorProtocol.RGB70_2012;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig0100Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig0100Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig100Lux_6015;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
              
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig0150Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig0150Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig150Lux_6016;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
                  
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig0200Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig0200Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig200Lux_6017;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
                      
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig0300Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig0300Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig300Lux_6018;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig0500Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig0500Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig500Lux_6019;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
          
           %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig1000Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig1000Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig1000Lux_6020;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
           
           %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig2000Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig2000Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig2000Lux_6021;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
             
           %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig4000Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig4000Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig4000Lux_6022;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
                    
           %data set OMRturns2
        TF = strcmp(dataSetName,'spontMainRig8000Lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontMainRig8000Lux1;
            protocolNumb = EnumeratorProtocol.spontMainRig8000Lux_6023;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig0000lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig0000lux1;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_0000;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig0100lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig0100lux1;
            protocolNumb = EnumeratorProtocol.spontParRig0100_6024;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
          
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig0150lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig0150lux1;
            protocolNumb = EnumeratorProtocol.spontParRig0150_6025;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
        
           
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig0200lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig0200lux1;
            protocolNumb = EnumeratorProtocol.spontParRig0200_6026;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
        
            
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig0300lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig0300lux1;
            protocolNumb = EnumeratorProtocol.spontParRig0300_6027;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
        
               
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig0500lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig0500lux1;
            protocolNumb = EnumeratorProtocol.spontParRig0500_6028;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
        
                
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig1000lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig1000lux1;
            protocolNumb = EnumeratorProtocol.spontParRig1000_6029;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
        
                  
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig2000lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig2000lux1;
            protocolNumb = EnumeratorProtocol.spontParRig2000_6030;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
        
                     
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig4000lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig4000lux1;
            protocolNumb = EnumeratorProtocol.spontParRig4000_6031;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
                     
         %data set OMRturns2
        TF = strcmp(dataSetName,'spontUniParRig5000lux1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.spontUniParRig5000lux1;
            protocolNumb = EnumeratorProtocol.spontParRig8000_6032;
            
           distanceEyesToBlob = 40.315;%in um
            stim = a(:,1)*0 + -1;%not in array
            lag = a(:,88);%correct
            tailAngles = a(:,33:48);%correct 
            tailValues = a(:,16:31);%correct
            bodyAngles = a(:,2);%correct 
            xPos = a(:,8);%correct
            yPos = a(:,7);%correct
            blobVal =  NaN;
            pixelSize = 30;%in uM
            headToBladderLength = 30;%in pixels
            tailSegmentLength = 10;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = a(:,6);%correct
            rightEyeAngle = a(:,5);%correct
            
            parameciaCounter = a(:,49:79);%correct
            numbFishInSquare = NaN;
            frameNumber = a(:,1);
            

        end
        
            %data set OMRturns2
        TF = strcmp(dataSetName,'timEscapes4directions1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.timEscapes4directions1;
            protocolNumb = EnumeratorProtocol.timEscapes4directions_6033;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
         
            %data set OMRturns2
        TF = strcmp(dataSetName,'timEscapes4directions2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.timEscapes4directions2;
            protocolNumb = EnumeratorProtocol.timEscapes4directions2_6034;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
          
            %data set OMRturns2
        TF = strcmp(dataSetName,'lightStress1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightStress1;
            protocolNumb = EnumeratorProtocol.lightStress1_6050;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
          
            %data set OMRturns2
        TF = strcmp(dataSetName,'DarkLightTransitions1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkLightTransitions1;
            protocolNumb = EnumeratorProtocol.DarkLightTransions_6052;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
         
            %data set OMRturns2
        TF = strcmp(dataSetName,'DarkLightTransitions2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkLightTransitions2;
            protocolNumb = EnumeratorProtocol.DarkLightTransions_6052;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
            %data set OMRturns2
        TF = strcmp(dataSetName,'DarkLightTransitions3');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkLightTransitions3;
            protocolNumb = EnumeratorProtocol.DarkLightTransions_6064;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
            %data set OMRturns2
        TF = strcmp(dataSetName,'DarkLightTransitions4');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkLightTransitions4;
            protocolNumb = EnumeratorProtocol.DarkLightTransions4_6065;%
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
         
            %data set OMRturns2
        TF = strcmp(dataSetName,'lightStress2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightStress2;
            protocolNumb = EnumeratorProtocol.lightStress2_6066;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
         
            %data set OMRturns2
        TF = strcmp(dataSetName,'stress10beeps1000lux1000Hz');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.stress10beeps1000lux1000Hz;
            protocolNumb = EnumeratorProtocol.stress10beeps1000lux1000Hz_6067;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
        
         
            %data set OMRturns2
        TF = strcmp(dataSetName,'lightStress3');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightStress3;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
          
            %data set OMRturns2
        TF = strcmp(dataSetName,'stressBeepDark1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.stressBeepDark1;
            protocolNumb = EnumeratorProtocol.stressBeepDark1_6069;%projector off
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);
            lag = a(:,46);
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
            numbFishInSquare = a(:,44);
            frameNumber = a(:,1);
            

        end
        
         
         %data set OMRturns2
        TF = strcmp(dataSetName,'lightStress9Fish1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightStress9Fish1;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
        
        %data set OMRturns2
        TF = strcmp(dataSetName,'lightStress8Fish1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightStress8Fish1;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
        
        %data set OMRturns2
        TF = strcmp(dataSetName,'lightStress8FishDMSO1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightStress8FishDMSO1;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
        
        %data set OMRturns2
        TF = strcmp(dataSetName,'lightStress8FishMIF1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightStress8FishMIF1;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
        
        %data set OMRturns2
        TF = strcmp(dataSetName,'LightDark30min1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LightDark30min1;
            protocolNumb = EnumeratorProtocol.LightDark30min1_6070;
            
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
        
        
        
        %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightBefore1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightBefore1;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
         
        %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightBefore2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightBefore2;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
          
        %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightPartial1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightPartial1;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
           
        %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightPartial2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightPartial2;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
           
        %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightRepeat1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightRepeat1;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
           
        %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightRepeat2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightRepeat2;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
            
        %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightSham1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightSham1;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
           
        %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightSham2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightSham2;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
        
            
       
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightBiMelc');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightBiMelc;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightBiMelr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightBiMelr;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightUniMelc');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightUniMelc;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
          %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightUniMelr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightUniMelr;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
          %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightBiMelcUniMelr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightBiMelcUniMelr;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightUniMelcBiMelr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightUniMelcBiMelr;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightUniMelcUniMelr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightUniMelcUniMelr;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'lightTransitionsBeepsBefore1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightTransitionsBeepsBefore1;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6071;
            
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
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'lightTransitionsBeepsAfter1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightTransitionsBeepsAfter1;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6071;
            
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
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblations3minLightBiMelcBiMelr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblations3minLightBiMelcBiMelr;
            protocolNumb = EnumeratorProtocol.lightStress3_6068;
            
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
        
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'lightTransitionsBeeps5D');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightTransitionsBeeps5D;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6073;
            
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
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'lightTransitionsBeepsAB');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightTransitionsBeepsAB;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6073;
            
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
        
          %data set OMRturns2
        TF = strcmp(dataSetName,'lightTransitionsBeepsLeo');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightTransitionsBeepsLeo;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6073;
            
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
        
        
          %data set OMRturns2
        TF = strcmp(dataSetName,'lightTransitionsBeepsTL');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightTransitionsBeepsTL;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6073;
            
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
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'lightTransitionsBeepsTu');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightTransitionsBeepsTu;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6073;
            
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
        
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'lightTransitionsBeepsWik');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.lightTransitionsBeepsWik;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6073;
            
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
        
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'OMRSpeedForReview');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OMRSpeedForReview;
            protocolNumb = EnumeratorProtocol.OMRSpeedForReview_10003;        
                      
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
        
            %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblationslightTransitionsBeepsBefore');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblationslightTransitionsBeepsBefore;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6071;
            
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
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblationslightTransitionsBeepsAfter');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblationslightTransitionsBeepsAfter;
            protocolNumb = EnumeratorProtocol.lightTransitionsBeeps1_6071;
            
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
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblationsOMRSpeedBefore');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblationsOMRSpeedBefore;
            protocolNumb = EnumeratorProtocol.OMRSpeed5Speeds_10002;
            
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
        
            %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblationsOMRSpeedAfter');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblationsOMRSpeedAfter;
            protocolNumb = EnumeratorProtocol.OMRSpeed5Speeds_10002;
            
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
        
         %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblationsPreyCaptureBefore');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblationsPreyCaptureBefore;
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
        
          %data set OMRturns2
        TF = strcmp(dataSetName,'nmlfAblationsPreyCaptureAfter');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.nmlfAblationsPreyCaptureAfter;
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
        
        
      
        
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'PreyCaptureSmallRot5dNaive');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureSmallRot5dNaive;
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
        
          
           %data set OMRturns2
        TF = strcmp(dataSetName,'PreyCaptureSmallRotAbNaive');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureSmallRotAbNaive;
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
        
          
           %data set OMRturns2
        TF = strcmp(dataSetName,'PreyCaptureSmallRotLeoNaive');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureSmallRotLeoNaive;
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
        
           
           %data set OMRturns2
        TF = strcmp(dataSetName,'PreyCaptureSmallRotTLNaive');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureSmallRotTLNaive;
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
        
           
           %data set OMRturns2
        TF = strcmp(dataSetName,'PreyCaptureSmallRotTuNaive2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureSmallRotTuNaive2;
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
        
           
           %data set OMRturns2
        TF = strcmp(dataSetName,'PreyCaptureSmallRotWikNaive');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureSmallRotWikNaive;
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
        
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'social2FishLightSq');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.social2FishLightSq;
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
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'social2FishDarkSq');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.social2FishDarkSq;
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
        
           %data set OMRturns2
        TF = strcmp(dataSetName,'PreyCaptureSmallRotTuNaive');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureSmallRotTuNaive;
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
        
        
             %data set OMRturns2
        TF = strcmp(dataSetName,'PreyCaptureSmallRotTuWithRot');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PreyCaptureSmallRotTuWithRot;
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
        
        
              %data set OMRturns2
        TF = strcmp(dataSetName,'SpontLightControl');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontLightControl;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
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
        
        
               %data set OMRturns2
        TF = strcmp(dataSetName,'SpontLightControlStart');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontLightControlStart;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
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
        
        
                 %data set OMRturns2
        TF = strcmp(dataSetName,'SpontLightMK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontLightMK801;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
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
        
                  %data set OMRturns2
        TF = strcmp(dataSetName,'SpontLightMK801Start');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.SpontLightMK801Start;
            protocolNumb = EnumeratorProtocol.PreyCapture_protocol_2010;
            
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