%% Initalize the setting: check what folders is in our workspace and which need to add 
% Your workspace and change current place to this

root = 'c:\users\kiwi\documents\PR'; cd c:\users\kiwi\documents\PR;
% root = 'E:\PR\PR_FinalProject_Data'; cd e:\pr\pac;"

%% upload file into imageSet and seperate the folder into two label 
% Positive: we want to detect/verification in image
% Negative: ignore/miss 
fprintf('------Start------\n');
carSet = imageSet(root, 'recursive');
fprintf('Class types count: %d\n', numel(carSet));
negSet =[]; posSet =[];  compareTag ='Negative';
for i=1:size(carSet,2)
    tag = strfind(carSet(i).Description,compareTag);
    if(tag)
        fprintf('%d-Negative::%d___%s\n',i,carSet(i).Count, carSet(i).Description);
        negSet =[negSet i];
    else
        fprintf('%d-Positive::%d___%s\n',i,carSet(i).Count,carSet(i).Description );
        posSet =[posSet i];
    end
end

fprintf('NegSet: ');
fprintf('%d ',negSet(:));
fprintf('\nPosSet: ');
fprintf('%d ',posSet(:));
fprintf('\n');