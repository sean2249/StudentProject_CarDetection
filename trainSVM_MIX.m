%% Load the HOGFeatures and label from file "hogExtract.m" 
load('MIXFeatures.mat','MIXFeatures');
load('MIXLabel.mat','MIXLabel');

%% Setting the parameter of LibSVM
option = '-t 0 -d 2 -g 2 -c 1 -e 0.1';

%% Start to SVMtrain and save the file whose filename is corresponding to the parameter
model_MIX = svmtrain(double(MIXLabel), double(MIXFeatures), option);

C = strsplit(option, {' ','-','.'});
par = strcat(C{:});

svmName=['model_MIX_Final' par '.mat'];
save(svmName,'model_MIX');
fprintf('----SVM Done!\n');
