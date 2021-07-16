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



 function [stim,lag,tailAngles,tailValues,bodyAngles,xPos,yPos,blobVal,pixelSize,headToBladderLength,tailSegmentLength,distanceEyesToBlob,dataSetNumbr,arenaX,arenaY,protocolNumb,leftEyeAngle,rightEyeAngle,numbFishInSquare,parameciaCounter,frameNumber] = DataBaseDetector_Simone(a,dataSetName)


 
 
 
 
 
   %% 
        %%%%%%%%%%%%%%%%%% Simone data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'D30mAD30mLD3Rep');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.D30mAD30mLD3Rep;
            protocolNumb = EnumeratorProtocol.D30mAD30mLD3Rep_1014;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);
            lag = a(:,28);
            tailAngles = a(:,16:24);
            tailValues = a(:,6:14);
            bodyAngles = a(:,15);
            xPos = a(:,5);
            yPos = a(:,4);%
            blobVal =  a(:,2);%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        TF = strcmp(dataSetName,'ath5NtrA');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.ath5NtrA;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        TF = strcmp(dataSetName,'ath5NtrB');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.ath5NtrB;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        TF = strcmp(dataSetName,'hcrtNtrA');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.hcrtNtrA;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        TF = strcmp(dataSetName,'hcrtNtrB');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.hcrtNtrB;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         TF = strcmp(dataSetName,'hcrtNtrC');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.hcrtNtrC;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        TF = strcmp(dataSetName,'hcrtNtrD');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.hcrtNtrD;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
        
                                  %data set simone multifush program
        TF = strcmp(dataSetName,'BiasObend8');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.BiasObend8;
            protocolNumb = EnumeratorProtocol.BiasObend8_protocol_1167;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
                                           %data set simone multifush program
        TF = strcmp(dataSetName,'D3minLightDark4sq');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.D3minLightDark4sq;
            protocolNumb = EnumeratorProtocol.D3minLightDark4sq_protocol_20154;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end

         TF = strcmp(dataSetName,'LD3minIWR1sq4f');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LD3minIWR1sq4f;
            protocolNumb = EnumeratorProtocol.LD3min_protocol_1132;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'LD3minNoIWR1sq4f');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LD3minNoIWR1sq4f;
            protocolNumb = EnumeratorProtocol.LD3min_protocol_1132;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'Dark15min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Dark15min;
            protocolNumb = EnumeratorProtocol.Dark15min_protocol_1136;
            
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
        
         TF = strcmp(dataSetName,'Dark15minPrey');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Dark15minPrey;
            protocolNumb = EnumeratorProtocol.Dark15min_protocol_1136;
            
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
        
        
        TF = strcmp(dataSetName,'Light15min');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Light15min;
            protocolNumb = EnumeratorProtocol.Light15min_protocol_1135;
            
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
        
                
        TF = strcmp(dataSetName,'Light15minPrey');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Light15minPrey;
            protocolNumb = EnumeratorProtocol.Light15min_protocol_1135;
            
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
        
        
                                  %data set simone multifush program
        TF = strcmp(dataSetName,'BiasObend1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.BiasObend1;
            protocolNumb = EnumeratorProtocol.BiasObend1_protocol_1160;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
        TF = strcmp(dataSetName,'BiasObend3');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.BiasObend3;
            protocolNumb = EnumeratorProtocol.BiasObend3_protocol_1162;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'BiasObend4');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.BiasObend4;
            protocolNumb = EnumeratorProtocol.BiasObend4_protocol_1163;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'BiasObend5');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.BiasObend5;
            protocolNumb = EnumeratorProtocol.BiasObend5_protocol_1164;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'BiasObend6');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.BiasObend6;
            protocolNumb = EnumeratorProtocol.BiasObend6_protocol_1165;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        TF = strcmp(dataSetName,'BiasObend7');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.BiasObend7;
            protocolNumb = EnumeratorProtocol.BiasObend7_protocol_1166;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'DarkFlash05Interval1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash05Interval1;
            protocolNumb = EnumeratorProtocol.DarkFlash05Interval1_protocol_11135;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'DarkFlash05Interval2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash05Interval2;
            protocolNumb = EnumeratorProtocol.DarkFlash05InterVal2_protocol_11300;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
          TF = strcmp(dataSetName,'DarkFlash10Interval1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash10Interval1;
            protocolNumb = EnumeratorProtocol.DarkFlash10Interval1_protocol_11136;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'DarkFlash10Interval2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash10Interval2;
            protocolNumb = EnumeratorProtocol.DarkFlash10InterVal2_protocol_11301;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'DarkFlash15Interval2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash15Interval2;
            protocolNumb = EnumeratorProtocol.DarkFlash15InterVal2_protocol_11302;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'DarkFlash20Interval1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash20Interval1;
            protocolNumb = EnumeratorProtocol.DarkFlash20InterVal1_protocol_1138;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'DarkFlash20Interval2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash20Interval2;
            protocolNumb = EnumeratorProtocol.DarkFlash20InterVal2_protocol_11303;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'DarkFlash25Interval1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash25Interval1;
            protocolNumb = EnumeratorProtocol.DarkFlash25InterVal1_protocol_1139;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         TF = strcmp(dataSetName,'DarkFlash25Interval2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash25Interval2;
            protocolNumb = EnumeratorProtocol.DarkFlash25InterVal2_protocol_11304;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
           TF = strcmp(dataSetName,'DarkFlash30Interval1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash30Interval1;
            protocolNumb = EnumeratorProtocol.DarkFlash30InterVal1_protocol_1140;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
          TF = strcmp(dataSetName,'DarkFlash30Interval2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DarkFlash30Interval2;
            protocolNumb = EnumeratorProtocol.DarkFlash30InterVal2_protocol_11305;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'D30mAD30mLD3Rep0MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.D30mAD30mLD3Rep0MK801;
            protocolNumb = EnumeratorProtocol.D30mAD30mLD3RepMK801_1511;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'D30mAD30mLD3Rep70MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.D30mAD30mLD3Rep70MK801;
            protocolNumb = EnumeratorProtocol.D30mAD30mLD3RepMK801_1511;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
            %data set simone multifush program
        TF = strcmp(dataSetName,'D30mAD30mLD3Rep35MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.D30mAD30mLD3Rep35MK801;
            protocolNumb = EnumeratorProtocol.D30mAD30mLD3RepMK801_1511;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
                          %data set simone multifush program
        TF = strcmp(dataSetName,'pet1NtrA');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.pet1NtrA;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        TF = strcmp(dataSetName,'pet1NtrB');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.pet1NtrB;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
          TF = strcmp(dataSetName,'pet1NtrC');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.pet1NtrC;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        TF = strcmp(dataSetName,'pet1NtrD');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.pet1NtrD;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
                            %data set simone multifush program
        TF = strcmp(dataSetName,'tph2NtrAC');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.tph2NtrAC;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         TF = strcmp(dataSetName,'tph2NtrBD');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.tph2NtrBD;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,40);%%%%
            lag = a(:,46);%%%%
            tailAngles = a(:,23:38);%%%%
            tailValues = a(:,6:21);%%%%
            bodyAngles = a(:,22);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,44);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'DL3min0MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DL3min0MK801;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'DL3min05MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DL3min05MK801;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'DL3min1MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DL3min1MK801;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'DL3min2MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DL3min2MK801;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
 
 %data set simone multifush program
        TF = strcmp(dataSetName,'DL3min4MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DL3min4MK801;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
 
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'DL3min8MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DL3min8MK801;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'DL3min16MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DL3min16MK801;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'DL3min32MK801');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.DL3min32MK801;
            protocolNumb = EnumeratorProtocol.NTRLightDark3min_protocol_80;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed8sec');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed8sec;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed15sec');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed15sec;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed30sec');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed30sec;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            
        end
        
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed60sec');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed60sec;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed120sec');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed120sec;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed180sec');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed180sec;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,28);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
            pixelSize = 62;%in uM
            headToBladderLength = 15;%in pixels
            tailSegmentLength = 5.0;%in pixels
            arenaX = 950;%in pixels
            arenaY = 950;%in pixels
            leftEyeAngle = NaN;
            rightEyeAngle = NaN;
            
            parameciaCounter = zeros(length(a),31);
            parameciaCounter(:,:) = NaN;
            numbFishInSquare = a(:,27);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed8sec2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed8sec2;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,32);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
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
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed15sec2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed15sec2;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,32);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
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
        
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed30sec2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed30sec2;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            distanceEyesToBlob = 105.7468;%in um
            stim = a(:,26);%%%%
            lag = a(:,32);%%%%
            tailAngles = a(:,16:24);%%%%
            tailValues = a(:,6:14);%%%%
            bodyAngles = a(:,15);%%%%
            xPos = a(:,5);%%%%
            yPos = a(:,4);%%%
            blobVal =  a(:,2);%%%
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
        
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed60sec2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed60sec2;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            
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
        
         %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed120sec2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed120sec2;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
            
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
        
        %data set simone multifush program
        TF = strcmp(dataSetName,'OnOffRed180sec2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.OnOffRed180sec2;
            protocolNumb = EnumeratorProtocol.OnOffRed8sec_protocol_201601;
            
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
        TF = strcmp(dataSetName,'Social2FishDarkAth5');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkAth5;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishDarkAth5Ntr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkAth5Ntr;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishLightAth5');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightAth5;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishLightAth5Ntr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightAth5Ntr;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishLightRig1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightRig1;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishLightRig1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightRig1;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishLightRig2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLightRig2;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishDarkRig1');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkRig1;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishDarkRig2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDarkRig2;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
           %data set OMRturns2
        TF = strcmp(dataSetName,'Social2FishLight');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishLight;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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
        TF = strcmp(dataSetName,'Social2FishDark');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.Social2FishDark;
            protocolNumb = EnumeratorProtocol.lightSquare_11000;
            
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