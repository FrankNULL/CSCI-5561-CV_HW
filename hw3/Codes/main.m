clc;
clear all;
close all;

 [confusion, accuracy] = ClassifyKNN_Tiny;
 figure;
 imagesc(confusion); 
 disp('KNNTiny Accuracy');
 disp(accuracy);

 [confusion, accuracy] = ClassifyKNN_BoW;
 figure;
 imagesc(confusion);
 disp('KNNBoW Accuracy');
 disp(accuracy);
 
[confusion, accuracy] = ClassifySVM_BoW ;
figure;
imagesc(confusion);
disp('SVMBoW Accuracy');
disp(accuracy);
