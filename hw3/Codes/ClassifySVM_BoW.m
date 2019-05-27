function [confusion,accuracy]=ClassifySVM_BoW

fid_train = fopen('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw3\scene_classification_data\train.txt');
tline = fgetl(fid_train);
pre='E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw3\scene_classification_data\';
training_image_cell={};
step_size=20;
size_param=10;

label_train=[];
while ischar(tline)
    %disp(tline);
    space = isspace(tline);
    idx = find(space~=0, 1, 'first');
    labelstring = extractBetween(tline,1,idx-1);
    imagestring=extractBetween(tline,idx+1,length(space));
    I=imread(strcat(pre,imagestring{1}));
    training_image_cell{end+1}=I;
    [label]=EncodeLabel(labelstring{1});
    label_train=[label_train;label];
    tline = fgetl(fid_train);
end
fclose(fid_train);



fid_test = fopen('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw3\scene_classification_data\test.txt');
tline = fgetl(fid_test);

label_test=[];
SIFT_feature_cell_test={};
while ischar(tline)
   % disp(tline);
    space = isspace(tline);
    idx = find(space~=0, 1, 'first');
    labelstring = extractBetween(tline,1,idx-1);
    imagestring=extractBetween(tline,idx+1,length(space));
    I=imread(strcat(pre,imagestring{1}));
    [frames,descrs] = vl_dsift(single(I),'fast','step',step_size,'size',size_param);
    SIFT_feature_cell_test{end+1}=descrs';
    [label]=EncodeLabel(labelstring{1});
    label_test=[label_test;label];  
    tline = fgetl(fid_test);
end
fclose(fid_test);




dic_size=50;
[vocab] = BuildVisualDictionary(training_image_cell, dic_size);
SIFT_feature_cell_train=load('SIFT_feature_cell_train.mat');

feature_train_BOW=[];
feature_test_BOW=[];

for i=1:size(SIFT_feature_cell_train.SIFT_feature_cell_train,2)
[bow_feature]=ComputeBoW(SIFT_feature_cell_train.SIFT_feature_cell_train{1,i},vocab);
feature_train_BOW=[feature_train_BOW;bow_feature];
end


for i=1:size(SIFT_feature_cell_test,2)
[bow_feature]=ComputeBoW(SIFT_feature_cell_test{1,i},vocab);
feature_test_BOW=[feature_test_BOW;bow_feature];
end



[label_test_pred]=PredictSVM(feature_train_BOW,label_train, feature_test_BOW);
confusion=confusionmat(label_test,label_test_pred);
accuracy=(trace(confusion)/sum(sum(confusion)))*100;

end


