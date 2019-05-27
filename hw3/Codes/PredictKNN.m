function [label_test_pred]=PredictKNN(feature_train,label_train, feature_test,k)
mdl = fitcknn(feature_train,label_train,'NumNeighbors',k,'Standardize',1);
[label_test_pred] = predict(mdl,feature_test);
end