 classdef (Sealed) EnumeratorProtocol
    properties (Constant)
 
        %%
        %%%%%%%%%%%%%%%%%% joao protocols %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        Speed2_ForwardGratings_protocol_1 = 1;
        Speed2_ForwardGratings_protocol_2 = 2;
        Speed2_ForwardGratings_protocol_3 = 3;
        Speed2_ForwardGratings_protocol_4 = 4;
        Speed2_ForwardGratings_protocol_5 = 5;
        OpenField1_ForwardGratings_protocol_6 = 6;
        OpenField1_TurnGratings_protocol_11 = 11;
        OpenField1_TurnGratings_protocol_8 = 12;
        LightDark3minPreyCapture_59cm_protocol_25 = 25
        LightDark3min_54cm_protocol_26 = 26;
        LightDarkFlash_protocol_27 = 27;
        AcousticStartle1_protocol_40 = 28;
        LightFlashAcousticStartle1_protocol_41 = 29;
        OpenField1_AcusticStartle2 = 30;%not sure about this
        MultiFishDarkFlash1_33 = 33;
        MultiFishAcousticStartle1_protocol_44 = 44;
        OpenField1_multiFishLight1 = 35;
        PreyCaptureMini_protocol1 = 128;
        multi_LightFlash_Beep_1000 = 1000;
        multi_LightFlash_Beep_1001 = 1001;
        multi_LightFlash_Beep_1002 = 1002;
        multi_LightFlash_Beep3min_1004 = 1004;
        multi_LightFlash_Beep3min_Learning_1007 = 1007;
        multi_LightFlash_Beep3min_Inversed_1008 = 1008;
        multi_Beap_3min_2002 = 2002;
        multi_LightFlash_3min_2001 = 2001;
        multi_BeapFlash_3min_2003 = 2003;
        OpenField1_TurnGratingsSpeed1_protocol_2004 = 2004;
        multiFlash3min1s6Intensities_2005 = 2005;
        multiFlash3min1s6Intensities2_2006 = 2006;
        multi_LightBeap_3min_2007 = 2007;
        spontaneousSwimming_protocol_50 = 50;
        multiFlash3min1s6Intensities3_2008 = 2008;
        Phototaxis4_protocol_53_Intensities_2009 = 2009
        PreyCapture_protocol_2010 = 2010;
        RGB70_2011 = 2011;
        RGB70_2012 = 2012;%projector off
        PreyCapture_protocol_0000 = 0000;%proj off - dark
        multi_Beep_3000 = 3000;
        multi_FlashBeap_3001 = 3001;
        multi_Flash_3002 = 3002;
        lighDarkBeeps_5000 = 5000;
        lighDarkBeeps_5001 = 5001;
        VisualEscapesShadow2directions_5002 = 5002;
        VisualEscapesShadow2directionsWithSpace_5003 = 5003;
        bigCircleDiferentDirections2_6000 = 6000;
        virtualprey2directions_6003  = 6003;
        virtualPreyFront_6004 = 6004;
        BeepsLightDarkEyeConv_6005 = 6005;
        LoomingDiferentSpeeds_6007 = 6007;
        lightDark11Int_6008 = 6008;
        smoothLight1_6011 = 6011;
        smoothLight2_6012 = 6012;
        
        
        spontMainRig100Lux_6015 = 6015;
        spontMainRig150Lux_6016 = 6016;
        spontMainRig200Lux_6017 = 6017;
        spontMainRig300Lux_6018 = 6018;
        spontMainRig500Lux_6019 = 6019;
        spontMainRig1000Lux_6020 = 6020;
        spontMainRig2000Lux_6021 = 6021;
        spontMainRig4000Lux_6022 = 6022;
        spontMainRig8000Lux_6023 = 6023;
        
        spontParRig0100_6024 = 6024;
        spontParRig0150_6025 = 6025;
        spontParRig0200_6026 = 6026;
        spontParRig0300_6027 = 6027;
        spontParRig0500_6028 = 6028;
        spontParRig1000_6029 = 6029;
        spontParRig2000_6030 = 6030;
        spontParRig4000_6031 = 6031;
        spontParRig8000_6032 = 6032;
        
        timEscapes4directions_6033  = 6033;
        timEscapes4directions2_6034  = 6034;
        
        lightStress1_6050 = 6050;
        DarkLightTransions_6052 = 6052;
        
        DarkLightTransions_6064 = 6064;
        
        DarkLightTransions4_6065 = 6065;
        
        %stress
        lightStress2_6066 = 6066;
        stress10beeps1000lux1000Hz_6067 = 6067;
        lightStress3_6068 = 6068;
        stressBeepDark1_6069 = 6069;
        
        %fish individuality
        LightDark30min1_6070 = 6070;
        
        %simone 30min ligh dark spont swimming
        D30mAD30mLD3Rep_1014 = 1014;
        
        %all bout types data sets
        lightTransitionsBeeps1_6071 = 6071;
        
        lightTransitionsBeeps1_6073 = 6073;
        OMRSpeedForReview_10003 = 10003;
        OMRSpeed5Speeds_10002 = 10002;
        RoomIllumination_1111 = 1111;
        
      
        
        %%
        %%%%%%%%%%%%%%%%% Simone protocols %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        NTRLightDark3min_protocol_80 = 80;
        BiasObend8_protocol_1167 = 1167;
        D3minLightDark4sq_protocol_20154 = 20154;
        LD3min_protocol_1132 = 1132;
        Dark15min_protocol_1136 = 1136;
        Light15min_protocol_1135 = 1135;
        BiasObend1_protocol_1160 = 1160;
        BiasObend3_protocol_1162 = 1162;
        BiasObend4_protocol_1163 = 1163;
        BiasObend5_protocol_1164 = 1164;
        BiasObend6_protocol_1165 = 1165;
        BiasObend7_protocol_1166 = 1166;
        DarkFlash05Interval1_protocol_11135 = 11135;
        DarkFlash05InterVal2_protocol_11300 = 11300;
        DarkFlash10Interval1_protocol_11136 = 11136;
        DarkFlash10InterVal2_protocol_11301 = 11301;
        DarkFlash15InterVal2_protocol_11302 = 11302;
        DarkFlash20InterVal1_protocol_1138 = 1138;
        DarkFlash20InterVal2_protocol_11303 = 11303;
        DarkFlash25InterVal1_protocol_1139 = 1139;
        DarkFlash25InterVal2_protocol_11304 = 11304;
        DarkFlash30InterVal1_protocol_1141 = 1141;
        DarkFlash30InterVal2_protocol_11305 = 11305;
        D30mAD30mLD3RepMK801_1511 = 1511;
        OnOffRed8sec_protocol_201601 = 201601;
        lightSquare_11000 = 11000;    
        
        
        %%
        %%%%%%%%%%%%%%% Antonia protocols %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        lightSquareContinous_20000 = 20000;     
        lightSquareContinous_11000 = 11000;
        
        antoniaDotTestDiameterSpeedTest_slow4sides_2minITI = 90001;
        antoniaDotTestDiameterSpeedTest_slow4sides_2minITI_2 = 90002;

        %%
        %%%%%%%%%%%%%%%% Rita Felix Protocols %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        OMRSpeed10speeds_1000000 = 1000000;
        LoomingDiferentSpeeds_10005 = 10005;
        OMRTurns8Dir_1000001 = 1000001;
        DarkLight3minNew_1000002 = 1000002;
        
        projectorOffInOldRig_00000 = 00000;%projector of in in old rig
    end

    methods (Access = private)    % private so that you cant instantiate
        function out = EnumeratorProtocol
        end
    end
end