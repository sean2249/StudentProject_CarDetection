%% Calutate the sample number of Negative and Positive image
neg_count = 0; pos_count = 0;
testRound = [negTest posTest]; 
for neg = negTest
    neg_count = neg_count + carSet(neg).Count;
end
for pos=posTest
    pos_count = pos_count + carSet(pos).Count;
end
fprintf('NegativeImageUsed: %d\n',neg_count);
fprintf('PositiveImageUsed: %d\n',pos_count);
%% Negative Folder Construction
% trainCascade negative sample must match the variable of imageLocation or
% the folder name
% 'Cause we implenmnet in different negative folders
% So we use imageLocation instead and this part is doing this process
negDir={};k=1;
for digit=negTest
    for i=1:carSet(digit).Count
        negDir{k} = char(fullfile(carSet(digit).ImageLocation(i)));
        k=k+1;
    end
end
negDir = negDir';
%% Positive Imageset 
% Need the imageLocation and its boundingbox
for digit=posTest
    dataCount = carSet(digit).Count;
    for i=1:dataCount
        fname = char(carSet(digit).ImageLocation(i));
        
        % Transform image to gray to find its size
        % and we slightly choose a smaller box to train
        img = imread(fname);
        [Y X] = size(rgb2gray(img));
        bbox = [1 1 X-1 Y-1];
        
        PosData(i).imageFilename = fname;
        PosData(i).objectBoundingBoxes = bbox;
    end

end
save('PosData.mat', 'PosData');
fprintf('---startCacade\n');
%% TrainCascadeObjectDector
% The parameter setting of function is in the Main Function
s_stage = num2str(stage);
s_FARate = num2str(falsAlarmRate*10);

detectorName = ['VehicleDetector_KITTI_F_' s_FARate 'S' s_stage '_' num2str(countNum) '_HOG.xml'];
trainCascadeObjectDetector(detectorName,PosData,negDir,'FalseAlarmRate',falsAlarmRate,'NumCascadeStages',stage, 'FeatureType', 'HOG');

detector = vision.CascadeObjectDetector(detectorName);
save('detector.mat','detector');

fprintf('----trainDetector Done!\n');
