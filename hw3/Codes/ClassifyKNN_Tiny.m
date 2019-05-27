function[confusion, accuracy]=ClassifyKNN_Tiny

fid_train = fopen('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw3\scene_classification_data\train.txt');
tline = fgetl(fid_train);
pre='E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw3\scene_classification_data\';
output_size=[16 16];
feature_train=[];
label_train=[];
while ischar(tline)
    %disp(tline);
    space = isspace(tline);
    idx = find(space~=0, 1, 'first');
    labelstring = extractBetween(tline,1,idx-1);
    imagestring=extractBetween(tline,idx+1,length(space));
    I=imread(strcat(pre,imagestring{1}));
    [feature] = GetTinyImage(I,output_size);
    feature_train=[feature_train;feature'];
    [label]=EncodeLabel(labelstring{1});
    label_train=[label_train;label];
    tline = fgetl(fid_train);
end
fclose(fid_train);



fid_test = fopen('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw3\scene_classification_data\test.txt');
tline = fgetl(fid_test);
feature_test=[];
label_test=[];

while ischar(tline)
   % disp(tline);
    space = isspace(tline);
    idx = find(space~=0, 1, 'first');
    labelstring = extractBetween(tline,1,idx-1);
    imagestring=extractBetween(tline,idx+1,length(space));
    I=imread(strcat(pre,imagestring{1}));
   [feature] = GetTinyImage(I,output_size);
   feature_test=[feature_test;feature'];
    [label]=EncodeLabel(labelstring{1});
    label_test=[label_test;label];  
    tline = fgetl(fid_test);
end
fclose(fid_test);


 k=5;
[label_test_pred]=PredictKNN(feature_train,label_train, feature_test,k);
confusion=confusionmat(label_test,label_test_pred);
accuracy=(trace(confusion)/sum(sum(confusion)))*100;
end