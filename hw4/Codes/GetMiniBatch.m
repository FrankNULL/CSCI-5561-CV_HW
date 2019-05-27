function [mini_batch_x, mini_batch_y] = GetMiniBatch(im_train, label_train, batch_size)

if rem(size(im_train,2),batch_size) ==0
    sz=size(im_train,2)/batch_size;
else
    sz=floor(size(im_train,2)/batch_size)+1;
end

mini_batch_x=cell(sz,1);
mini_batch_y=cell(sz,1);

[m n]=size(im_train);
trainSize=n;
labels_onehot=zeros(10,trainSize);
for i=1:trainSize
    labels_onehot(label_train(i)+1,i)=1;
end
p = randperm(trainSize);

for i=1:trainSize/batch_size
mini_batch_x{i}=im_train(:,   p((i-1)*batch_size+1:(i-1)*batch_size+batch_size));
mini_batch_y{i}=labels_onehot(:,   p((i-1)*batch_size+1:(i-1)*batch_size+batch_size));
end
%mini_batch_y=label_train





end