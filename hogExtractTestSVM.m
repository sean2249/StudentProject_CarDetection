%% Initial setting for function extractHOGFeature
cellSize = [8 8];
blockSize = [2 2];
img = read(carSet(1),100);
img = rgb2gray(img); 
img = imresize(img, [100 100], 'bicubic');        
fea1 = extractHOGFeatures(img,'CellSize', cellSize);
HOGsize = size(fea1,2);

%% Start to extract 
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
MIXFeatures = [];
MIXLabel=[];
for digit = testRound
    fprintf('Start %d extract\n', digit);
    dataCount = round(carSet(digit).Count*0.95);
    if dataCount<selectData
        selectData = dataCount ;
    end
        xx = randperm(dataCount,selectData);
    for i=xx
        img = read(carSet(digit),i);
        % prepocessing
        img = rgb2gray(img); 
        img = imresize(img, [100 100], 'bicubic');
        
        fea1 = extractHOGFeatures(img,'CellSize', cellSize);
        
        MIXFeatures = [MIXFeatures; fea1];
        if(mod(i,1000)==0)
            fprintf('Finish %d data\n',i);
        end
    end
    tag = strfind(carSet(digit).Description,compareTag);
    if(tag)
        MIXLabel =[MIXLabel;zeros(size(xx,2),1)];
    else
        MIXLabel =[MIXLabel;ones(size(xx,2),1)];
    end
    
    fprintf('End of %d extract\n', digit);
end

save('MIXFeaturesTest.mat','MIXFeatures');
save('MIXLabelTest.mat','MIXLabel');

[predict_label, accuracy, dec_values] = svmpredict(double(MIXLabel),double(MIXFeatures),model_MIX);
