classdef EnumeratorDataSet
    properties (Constant)
 
%%
%%%%%%%%%%%%%%%%%%%%%% joao data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        OMRSpeed1 = 1;
        OMRSpeed2 = 2;
        OMRSpeed3 = 3;
        OMRSpeed4 = 4;
        OMRTurns2 = 5;
        LightDark3min2 = 6;
        LightDarkPrey3min2 = 7;
        LightDark3min1 = 8;
        LightDarkFlash1 = 9;
        AcousticStartle1 = 10;
        LightFlashAcousticStartle1 = 11;
        OMRSpeed5 = 12;
        AcousticStartle2 = 13;
        multiFishLight1 = 14;
        MultiFishAcousticStartle1 = 15;
        MultiFishDarkFlash1 = 16;
        PreyCaptureMini = 17;
        multiFlash3min1sManyInt = 18;
        multiStartle1000hz100msLightFlash1min = 19;
        multiStartle500hz100msLightFlash15s = 20;
        multiStartle500hz100msLightFlash1min = 21;
        multiStartle500hz100msLightFlash3min = 22;
        multiStartleFlashLearning = 22;
        multiStartleFlashInversed = 23;
        multiBeap200Hz100ms3min = 24;
        multiBeap400Hz100ms3min = 25;
        multiBeap600Hz100ms3min = 26;
        multiBeap800Hz100ms3min = 27;
        multiBeap1000Hz100ms3min = 28;
        multiBeap1200Hz100ms3min = 29;
        multiBeap1400Hz100ms3min = 30;
        multiBeap1600Hz100ms3min = 31;
        multiBeap1800Hz100ms3min = 32;
        multiBeap2000Hz100ms3min = 33;
        multiLightFlash3min = 34;
        multiBeapFlash200Hz100ms3min = 35;
        multiBeapFlash400Hz100ms3min = 36;
        multiBeapFlash600Hz100ms3min = 37;
        multiBeapFlash800Hz100ms3min = 38;
        multiBeapFlash1000Hz100ms3min = 39;
        multiBeapFlash1200Hz100ms3min = 40;
        multiBeapFlash1400Hz100ms3min = 41;
        multiBeapFlash1600Hz100ms3min = 42;
        multiBeapFlash1800Hz100ms3min = 43;
        multiBeapFlash2000Hz100ms3min = 45;
        uniBeap600Hz100ms3min = 46; 
        OMRTurnSpeed1 = 47;
        multiFlash3min1sManyInt2 = 48;
        multiLightBeap1000Hz100ms3min = 49;
        uniLightBeap1000Hz100ms3min = 50;
        spontaneousSwimming = 51;
        multiFlash3min1sManyInt3 = 52;
        Phototaxis4 = 53;
        PreyCapture = 55;
        SpontanousEyeTracking = 56;
        SpontanousComp = 57;
        PreyCaptureNaive = 58;
        SpontaneousMultiFishGray = 59;
        SpontaneousMultiFishBlack = 60;
        preyCaptureNaiveDark2 = 61;
        preyCaptureNaiveLight2 = 62;
        preyCaptureParLight2 = 63;
        preyCaptureParDark2 = 64;
        Beeps200to2000 = 65;
        FlashBeeps200to2000 = 66;
        ShortLightFlash = 67;
        SpontaneousMultiFishBlack2 = 68;
        uniFishLighDarkBeeps2min = 69;
        uniFishLighDarkBeeps90s = 70;
        uniFishLighDarkBeeps2minPar = 71;
        VisualEscapesShadow2directions = 72;
        VisualEscapesShadow2directionsWithSpace = 73;
        bigCircleDiferentDirections2 = 74;
        virtualPrey2Directions = 75;
        virtualPreyFront = 76;
        BeepsLightDarkEyeConv = 77;
        LoomingDiferentSpeeds = 78;
        lightDarkBeeps9Nacre1 = 79;
        
        %ind fish...
        spontMultiFish10LightInt = 80;
        spontMultiFish10LightIntInd = 81;
        manyLightMainRig1 = 82;
        manyLightMainRig2 = 84;
        manyLightParRig1 = 85;
        manyLightParRig2 = 86;
        manyLightParRig3 = 87;
        
        %spont data sets main rig
        spontMainRig0000Lux1 = 88;
        spontMainRig0100Lux1 = 89;
        spontMainRig0150Lux1 = 90;
        spontMainRig0200Lux1 = 91;
        spontMainRig0300Lux1 = 92;
        spontMainRig0500Lux1 = 93;
        spontMainRig1000Lux1 = 94;
        spontMainRig2000Lux1 = 95;
        spontMainRig4000Lux1 = 96;
        spontMainRig8000Lux1 = 97;
        
        %spont data sets mpr rig
        spontUniParRig0000lux1 = 98;
        spontUniParRig0100lux1 = 99;
        spontUniParRig0150lux1 = 100;
        spontUniParRig0200lux1 = 101;
        spontUniParRig0300lux1 = 102;
        spontUniParRig0500lux1 = 103;
        spontUniParRig1000lux1 = 104;
        spontUniParRig2000lux1 = 105;
        spontUniParRig4000lux1 = 106;
        spontUniParRig5000lux1 = 107;
        
        %tim's escapes
        timEscapes4directions1 = 108;
        timEscapes4directions2 = 109;

        lightStress1 = 110;
        
        %dark light transitions
        DarkLightTransitions1 = 111;
        DarkLightTransitions2 = 112;
        DarkLightTransitions3 = 113;
        DarkLightTransitions4 = 114;
        
        %stress
        lightStress2 = 115;
        stress10beeps1000lux1000Hz = 116;
        lightStress3 = 117;
        stressBeepDark1 = 118;
        lightStress9Fish1 = 119;
        lightStress8Fish1 = 120;
        lightStress8FishDMSO1 = 121;
        lightStress8FishMIF1 = 122;
        
        %fish individuality
        LightDark30min1 = 123;
        
        %nmlf ablations
        nmlfAblations3minLightBefore1 = 124;
        nmlfAblations3minLightBefore2 = 125;
        nmlfAblations3minLightPartial1 = 126;        
        nmlfAblations3minLightRepeat1 = 127;
        nmlfAblations3minLightRepeat2 = 128;
        nmlfAblations3minLightSham1 = 129;
        nmlfAblations3minLightSham2 = 130;
        
        nmlfAblations3minLightBiMelc = 131;
        
        
        
        nmlfAblations3minLightBiMelr = 133;
        
        nmlfAblations3minLightUniMelc = 134;
        nmlfAblations3minLightUniMelr = 135;

        
        nmlfAblations3minLightBiMelcUniMelr = 136;
        nmlfAblations3minLightUniMelcBiMelr = 137;
        nmlfAblations3minLightUniMelcUniMelr = 138;
        nmlfAblations3minLightBiMelcBiMelr = 141;

        
        %all beahaviors data sets
        lightTransitionsBeepsAfter1 = 139;
        lightTransitionsBeepsBefore1 = 140;
        

 
        %all strains data sets
        lightTransitionsBeeps5D = 142;
        lightTransitionsBeepsAB = 143;
        lightTransitionsBeepsLeo = 144;
        lightTransitionsBeepsTL = 145;
        lightTransitionsBeepsTu = 146;
        lightTransitionsBeepsWik = 147;
        
        %review speed data set
        OMRSpeedForReview = 148;
        
        %new ablation data sets
        nmlfAblationslightTransitionsBeepsBefore = 149;
        nmlfAblationslightTransitionsBeepsAfter = 150;
        
        nmlfAblationsOMRSpeedBefore = 151;
        nmlfAblationsOMRSpeedAfter = 152;
        
        nmlfAblationsPreyCaptureBefore = 153;
        nmlfAblationsPreyCaptureAfter = 154;
        
        
        
        %prey capture different strains
        PreyCaptureSmallRot5dNaive = 157;
        PreyCaptureSmallRotAbNaive = 158;
        PreyCaptureSmallRotLeoNaive = 159;
        PreyCaptureSmallRotTLNaive = 160;
        PreyCaptureSmallRotTuNaive2 = 161;
        PreyCaptureSmallRotWikNaive = 162;
        
        
        %traking 2 fish in round arenas
        social2FishLightSq = 163;
        social2FishDarkSq = 164;
        
        PreyCaptureSmallRotTuNaive = 165;
        PreyCaptureSmallRotTuWithRot = 166;
      
        %MK801 eye tracking data sets
        SpontLightControl = 167;
        SpontLightControlStart = 168;
        SpontLightMK801 = 169;
        SpontLightMK801Start = 170;
        
        
        %%
        %%%%%%%%%%%%%% simone data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %simone 30min ligh dark spont swimming
        D30mAD30mLD3Rep = 1101;
        
        %simone genetic ablation data sets 3min on off
        ath5NtrA = 1102;
        ath5NtrB = 1103;
        hcrtNtrA = 1104;
        hcrtNtrB = 1105;
        hcrtNtrC = 1106;
        hcrtNtrD = 1107;
        
        %simone 30min ligh dark spont swimming
        D30mAD30mLD3Rep0MK801Test1 = 1108;%not in dataBaseDetector
        D30mAD30mLD3Rep20MK801Test1 = 1109;%not in dataBaseDetector
        D30mAD30mLD3Rep50MK801Test1 = 1110;%not in dataBaseDetector
        D30mAD30mLD3Rep0MK801Test2 = 1111;%not in dataBaseDetector
        D30mAD30mLD3Rep70MK801Test2 = 1112;%not in dataBaseDetector
        
        BiasObend8 = 1113;
        D3minLightDark4sq = 1114;
        LD3minIWR1sq4f = 1115;
        LD3minNoIWR1sq4f = 1116;
        Dark15min = 1117;
        Dark15minPrey = 1118;
        Light15min = 1119;
        Light15minPrey = 1120;
        
        BiasObend1 = 1121;
        BiasObend3 = 1122;
        BiasObend4 = 1123;
        BiasObend5 = 1124;
        BiasObend6 = 1125;
        BiasObend7 = 1126;
        
        DarkFlash05Interval1 = 1127;
        DarkFlash05InterVal2 = 1128;
        DarkFlash10Interval1 = 1129;
        DarkFlash10InterVal2 = 1130;
        DarkFlash15InterVal1 = 1131;
        DarkFlash15InterVal2 = 1132;
        DarkFlash20InterVal1 = 1133;
        DarkFlash20InterVal2 = 1134;
        DarkFlash25InterVal1 = 1135;
        DarkFlash25InterVal2 = 1136;
        DarkFlash30InterVal1 = 1137;
        DarkFlash30InterVal2 = 1138;
        
        
        D30mAD30mLD3Rep0MK801 = 1139;
        D30mAD30mLD3Rep70MK801 = 1140;
        D30mAD30mLD3Rep35MK801 = 1141;
        
        pet1NtrA = 1142;
        pet1NtrB = 1143;
        pet1NtrC = 1144;
        pet1NtrD = 1145;
        tph2NtrAC = 1146;
        tph2NtrBD = 1147;
        
        DL3min0MK801 = 1148;
        DL3min05MK801 = 1149;
        DL3min1MK801 = 1150;
        DL3min2MK801 = 1151;
        DL3min4MK801 = 1152;
        DL3min8MK801 = 1153;
        DL3min16MK801 = 1154;
        DL3min32MK801 = 1155;
        
        OnOffRed8sec = 1156;
        OnOffRed15sec = 1157;
        OnOffRed30sec = 1158;
        OnOffRed60sec = 1159;
        OnOffRed120sec = 1160;
        OnOffRed180sec = 1161;
        
        OnOffRed8sec2 = 1162;
        OnOffRed15sec2 = 1163;
        OnOffRed30sec2 = 1164;
        OnOffRed60sec2 = 1165;
        OnOffRed120sec2 = 1166;
        OnOffRed180sec2 = 1167;
        
        
        
        Social2FishDarkAth5 = 1168;
        Social2FishDarkAth5Ntr = 1169;
        Social2FishLightAth5 = 1170;
        Social2FishLightAth5Ntr = 1171;
        
        Social2FishLightRig1 = 1172;
        Social2FishLightRig2 = 1173;
        Social2FishDarkRig1 = 1174;
        Social2FishDarkRig2 = 1175;
        
        Social2FishLight = 1176;
        Social2FishDark = 1177;
        
        
        %%
        %%%%%%%%%%%%%%%% Antonia data sets %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        groupmotionGrRaised = 11155;
        groupmotionIsoRaised = 11156;
        
        pairmotionGrRaised = 11157;
        pairmotionIsoRaised = 11158;
        
        singlemotionGrRaised = 11159;
        singlemotionIsoRaised = 11160;
        
        pairmotion4groups = 11161;
        
        PairMotionGrFam = 11162;
        PairMotionGrUnfam = 11163;
        
        PairMotionIsoNacre = 11164;
        PairMotionIsoNorm = 11165;
        
        PairMotionIsoVis = 11166;
        
        PairMotionTuGr = 11167; % same as PairMotionGrFam
        PairMotionTuN = 11168; % same as PairMotionIsoNacre
        
        PairMotionNaGr = 11169; % nacre fish group raised
        PairMotionNaT = 11170; % nacre fish raised with Tu
        
        PairMotionNaIso = 11171;
       
        LoomingIsoRaised = 11172;
        LoomingGrRaised = 11173;
        
        ChasingDotGr = 11174;
        ChasingDotGr2 = 11175;
        
       %%
       %%%%%%%%%%%%%%% Rita Felix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
       
       
       DarkLightTransitionsTu = 111031;
       LoomingSpeedsTuSave = 111032;
       PreyCaptureVideo = 111033;
       PreyCaptureNaiveTu = 111034;
       PreyCaptureExpTu = 111035;
       OMRSpontaneousTu = 111036;
       OMRSpontaneousTu2 = 111037;
       PreyCaptureNaiveTu2 = 111038;
       PreyCaptureExpTu2 = 111039;
       
   
       % video stuff
       DarkSocial7FishCapVideo = 111040;
       LightSocial7FishCapVideo = 111041;
       DarkSocial7FishCapVideo2 = 111042;
        
%%
%%%%%%%%%%%%%%%%% strains rita %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       OMRSpeedTl = 111001;
       OMRSpeedTu = 111002;
       OMRSpeedWik = 111003;
       OMRSpeedAb = 111004;
       OMRSpeed5D = 111005;
       OMRSpeedLeoNewProjector = 111006;
       
       LoomingSpeedsTl = 111007;
       LoomingSpeedsTu = 111008;
       LoomingSpeedsWik = 111009;
       LoomingSpeedsAb = 111010;
       LoomingSpeeds5D = 111011;
       LoomingSpeedsLeo = 111012;
       
       OMRTurnTl = 111013;
       OMRTurnTu = 111014;
       OMRTurnWik = 111015;
       OMRTurnAb = 111016;
       OMRTurn5D = 111017;
       OMRTurnLeo = 111018;
       OMRTurnLeoNewProjector = 111043;

       Social2FishLightTl = 111019;
       Social2FishLightTu = 111020;
       Social2FishLightWik = 111021;
       Social2FishLightAb = 111022;
       Social2FishLight5D = 111023;
       Social2FishLightLeo = 111024;
       
       Social2FishDarkTl = 111025;
       Social2FishDarkTu = 111026;
       Social2FishDarkWik = 111027;
       Social2FishDarkAb = 111028;
       Social2FishDark5D = 111029;
       Social2FishDarkLeo = 111030;
      
       OMRSpeedLeoNewProjector2 = 111044;
       OMRSpeedTuNewProjector2 = 111045;
       OMRTurnLeoNewProjector2 = 111046;
          %last number until now is 111043

    end

    methods (Access = private)    % private so that you cant instantiate
        function out = EnumeratorDataSet
        end
    end
end