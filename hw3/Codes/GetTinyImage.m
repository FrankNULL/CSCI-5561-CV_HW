function [feature] = GetTinyImage(I,output_size)
feature=zeros(output_size(1)*output_size(2),1);
J = imresize(I,output_size);
B = reshape(J,[output_size(1)*output_size(2),1]);
avg=mean(B);
unitlength=sqrt(sum(B.*B));
feature=(double(B)-avg)/unitlength;
end
