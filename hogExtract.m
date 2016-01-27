%% Extract HOG Feature and inital setting for function "extractHOGFeature
cellSize = [8 8];
blockSize = [2 2];
%% HOG feature length is related to imageSize and cellSize 
% transform the data into grayScale for better histogram of gradients to caculate
% normalize the image into setting size using the method of bicubic
% and then use extractHOGFeature to get the feature
img = read(carSet(1),100);
img = rgb2gray(img); 
img = imresize(img, [100 100], 'bicubic');        
fea1 = extractHOGFeatures(img,'CellSize', cellSize);
HOGsize = size(fea1,2);

%% Calutate the sample number of Negative and Positive image
neg_count = 0; pos_count = 0;
for neg = negTest
    neg_count = neg_count + carSet(neg).Count;
end
for pos=posTest
    pos_count = pos_count + carSet(pos).Count;
end
fprintf('NegativeImageUsed: %d\n',neg_count);
fprintf('PositiveImageUsed: %d\n',pos_count);

%% Start to extracct
MIXFeatures = [];
MIXLabel=[];

testRound = [negTest posTest];
for digit = testRound
    fprintf('Start %d extract\n', digit);
    dataCount = round(carSet(digit).Count*0.95); % Extract part of date 
    for i=1:dataCount
        img = read(carSet(digit),i);
        % prepocessing
        img = rgb2gray(img); 
        img = imresize(img, [50 50], 'bicubic');
        
        fea1 = extractHOGFeatures(img,'CellSize', cellSize);
        
        MIXFeatures = [MIXFeatures; fea1];
        if(mod(i,1000)==0)
            fprintf('Finish %d data\n',i);
        end
    end
    % Seperate the data into two label 
    tag = strfind(carSet(digit).Description,compareTag);
    if(tag)
        MIXLabel =[MIXLabel;zeros(dataCount,1)];
    else
        MIXLabel =[MIXLabel;ones(dataCount,1)];
    end
    
    fprintf('End of %d extract\n', digit);
end

save('MIXFeatures.mat','MIXFeatures');
save('MIXLabel.mat','MIXLabel');

fprintf('----HOG Extract Done!\n');