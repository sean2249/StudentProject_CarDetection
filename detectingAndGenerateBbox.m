%clear;
close all;
randIndex = randperm(500);
model = model_MIX;
featureLength = 4356;
predictTargetDir = 'matlab_evaluation\bbs_predictedBox\';

for c=1:100
    i = randIndex(c); 
%     i=c;
    n = c;
    filename = ['testfile_imlab\cutpic_' num2str(i) '.png'];
%     filename = ['testfile\' num2str(c) '.png'];
    
    sourceDir='matlab_evaluation\imLab_groundTruthCsv\groundTruthCsv\';
    targetDir='matlab_evaluation\bbs_groundTruth\';
    copyfile([sourceDir 'cutpic_' num2str(i) '.csv'] , [targetDir num2str(n) '.csv'], 'f');

    img = imread(filename);
    
    bbox = step(detector,img);

    %Test pruning small box
    tag = zeros(1, size(bbox,1));
    for j=1:size(bbox,1)
        if( bbox(j,3)*bbox(j,4)<150*100 )
            tag(1,j)=1;
        end
    end
    if(sum(tag)>0)
        bbox(find(tag==1),:)=[];
    end
    
    detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'vehicle');
    imshow(detectedImg);

    % output the box file
    num_bbox = size(bbox,1);
    % if some vehicles are detected
    if(num_bbox>0)
        counter_bbox = 1;
        features = zeros(num_bbox,featureLength);
        % preparing HOG features
        for k=1:num_bbox
            % get subimage of each boundingbox
            subIm = imcrop(img, bbox(k,:));
            subIm = rgb2gray(subIm);
            subImResize = imresize(subIm, [50 50], 'bicubic');

            % extrack HOG feature off current subimage
            features(k,:) = extractHOGFeatures(subImResize, 'CellSize', [8 8]);
        end
        predictionResult = svmpredict(ones(num_bbox,1), features, model);

        resultBbox = bbox(predictionResult==1,:);
        
        resultBbox(:,3) = resultBbox(:,1)+resultBbox(:,3);
        resultBbox(:,4) = resultBbox(:,2)+resultBbox(:,4);
        
        
        csvwrite([predictTargetDir num2str(n) '.csv'], resultBbox);
    else  % if no vehicle is detected then no need to do svmpredict
        csvwrite([predictTargetDir num2str(n) '.csv'], '');
    end
    c
end

addpath('matlab_evaluation\')
F1 = car_detect_Harmonic