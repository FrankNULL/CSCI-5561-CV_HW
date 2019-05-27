function [vocab] = BuildVisualDictionary(training_image_cell, dic_size)
SIFT_pool=[];
step_size=20;
size_param=10;
SIFT_feature_cell_train={};
for i=1: size(training_image_cell,2)
    I=training_image_cell{1,i};
    [frames,descrs] = vl_dsift(single(I),'fast','step',step_size,'size',size_param);
    SIFT_pool=[SIFT_pool;descrs'];
    SIFT_feature_cell_train{end+1}=descrs';
end

save('SIFT_feature_cell_train.mat','SIFT_feature_cell_train');
rng(1);
[~,vocab] = kmeans((double(SIFT_pool)),dic_size, 'MaxIter',1000 );

end
