function [label_test_pred] = PredictSVM(feature_train, label_train, feature_test) 


%lambda = 0.00001 ;
rng(1);



scores_all=[];
for i=1:15
    B=label_train==i;
    eachlabel=ones(length(label_train),1);
    eachlabel(B==0) = -1;
   % SVMModel=fitcsvm(feature_train, eachlabel);
    SVMModel = fitcsvm(feature_train,eachlabel,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');
   [label,score]=predict(SVMModel,feature_test);
   scores_all=[scores_all;score(:,2)'];
  
end






[M,I] = max(scores_all);
label_test_pred=I';



end







