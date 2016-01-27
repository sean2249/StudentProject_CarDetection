%% initialImageSet
initialImageSet
clear;
%% HOG Feature & SVM
initialImageSet
negTest =[4 5 6 10]
posTest =[3 8]
hogExtract
trainSVM_MIX
svmName
clear;
%% Train Detector
initialImageSet
negTest =[4 5 6 10]
posTest =[3 8]

stage = 11;
falsAlarmRate = 0.4;

countNum =1;
trainDetector
detectorName

%% Score 
load('model_MIX_Finalt0d2g2c1e01.mat');
% load('model2_MIX_t0d2g2c1e01.mat');
detector = vision.CascadeObjectDetector('VehicleDetector_KITTI_F_3S10_1_70++HOG.xml','ScaleFactor',1.06);
% detector = vision.CascadeObjectDetector('VehicleDetector_mix_F5S15HOG_70up_2.xml','ScaleFactor',1.06);
% load('detector.mat');
detectingAndGenerateBbox
clear;
%% Test SVM model
initialImageSet
negTest =[1];
posTest =[3];
selectData = 4000;
load ('model_MIX_Kiwit0d2g2c1e01.mat');
hogExtractTestSVM
clear
%% Loop for data analysis and save the F1 result into .txt
for st=16:20
    for fal=0.4:0.1:0.8
        countNum=1
        initialImageSet
        negTest =[1];
        posTest =[3];
        stage = st;
        falsAlarmRate = fal;
        trainDetector
        detectorName
        % clear;
        % Score
        for countNum=1:2
            load('model_MIX_t0d2g2c1e01.mat');
            % detector = vision.CascadeObjectDetector('VehicleDetector_mix_F5S15HOG_70up_2.xml');
            load('detector.mat');
            detectingAndGenerateBbox
            filename =['data_' num2str(st) '_' num2str(fal*10) '_' num2str(countNum) '.txt'];
            fID = fopen(filename, 'w');
            %             fprintf(fID,'stage = %d  falsAlarmRate = %d  F1 = %d ',stage, falsAlarmRate, F1);
            fprintf(fID,'%d\n%d\n%d\n%d\n ',stage, falsAlarmRate, countNum,F1);
            fclose(fID);
            
        end
    end
end

%% Train Detector 2 
initialImageSet
negTest =[10 6 5 4 1];
posTest =[8 3 2];
stage = 11;
falsAlarmRate = 0.3;

countNum =1;
trainDetector
detectorName

% clear;
%% Score  2
load('model_MIX_t0d2g2c1e01.mat');
% detector = vision.CascadeObjectDetector('VehicleDetector_KITTI_F_3S11_1_HOG.xml');
load('detector.mat');
detectingAndGenerateBbox
clear;