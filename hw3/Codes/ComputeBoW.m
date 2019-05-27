function [bow_feature]=ComputeBoW(feature,vocab)
Idx = knnsearch(double(vocab),double(feature));
histo=histcounts(Idx,'BinLimits',[1, size(vocab,1)], 'BinMethod','integers');
bow_feature=histo/norm(histo);
end