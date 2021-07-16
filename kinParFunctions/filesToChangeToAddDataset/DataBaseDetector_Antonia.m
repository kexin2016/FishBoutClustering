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


     %data set OMRturns2
        TF = strcmp(dataSetName,'groupmotionGrRaised');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.groupmotionGrRaised;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        TF = strcmp(dataSetName,'groupmotionIsoRaised');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.groupmotionIsoRaised;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
        TF = strcmp(dataSetName,'singlemotionGrRaised');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.singlemotionGrRaised;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        TF = strcmp(dataSetName,'singlemotionIsoRaised');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.singlemotionIsoRaised;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
        TF = strcmp(dataSetName,'pairmotionGrRaised');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.pairmotionGrRaised;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        TF = strcmp(dataSetName,'pairmotionIsoRaised');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.pairmotionIsoRaised;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
                TF = strcmp(dataSetName,'pairmotion4groups');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.pairmotionIsoRaised;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
        
        
        
                        TF = strcmp(dataSetName,'PairMotionGrFam');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionGrFam;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
                
                        TF = strcmp(dataSetName,'PairMotionGrUnfam');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionGrUnfam;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
        TF = strcmp(dataSetName,'PairMotionIsoNacre');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionIsoNacre;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
        TF = strcmp(dataSetName,'PairMotionIsoNorm');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionIsoNorm;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
                
        TF = strcmp(dataSetName,'PairMotionIsoVis');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionIsoVis;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
%         PairMotionTuGr = 167; % same as PairMotionGrFam
%         PairMotionTuN = 168; % same as PairMotionIsoNacre
%         
%         PairMotionNaGr = 169; % nacre fish group raised
%         PairMotionNaT = 170; % nacre fish raised with Tu
        
        TF = strcmp(dataSetName,'PairMotionTuGr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionTuGr;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
         TF = strcmp(dataSetName,'PairMotionTuN');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionTuN;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
         TF = strcmp(dataSetName,'PairMotionNaGr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionNaGr;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
         TF = strcmp(dataSetName,'PairMotionNaT');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionNaT;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
        TF = strcmp(dataSetName,'PairMotionNaIso');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.PairMotionNaIso;
            protocolNumb = EnumeratorProtocol.lightSquareContinous_20000;
            
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
        
        
         TF = strcmp(dataSetName,'LoomingIsoRaised');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingIsoRaised;
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
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         TF = strcmp(dataSetName,'LoomingGrRaised');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.LoomingGrRaised;
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
            numbFishInSquare = a(:,29);%not completelly sure it is correct...
            frameNumber = a(:,1);
            

        end
        
        
         TF = strcmp(dataSetName,'ChasingDotGr');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.ChasingDotGr;
            protocolNumb = EnumeratorProtocol.antoniaDotTestDiameterSpeedTest_slow4sides_2minITI;
            
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
        
        TF = strcmp(dataSetName,'ChasingDotGr2');
         
        if TF == 1

            dataSetNumbr = EnumeratorDataSet.ChasingDotGr2;
            protocolNumb = EnumeratorProtocol.antoniaDotTestDiameterSpeedTest_slow4sides_2minITI_2;
            
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