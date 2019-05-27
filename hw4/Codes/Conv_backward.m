function [dLdw, dLdb] = Conv_backward(dLdy, x, w_conv, b_conv, y)


[H,W,C1]=size(x);
[w_conv_H,w_conv_W,w_conv_C1,w_conv_C2]= size(w_conv);
padding=1;
X=padarray(x,[padding, padding]);

dLdw=zeros(size(w_conv));
dLdb=zeros(size(b_conv));


new_X = im2col(X,[3,3]);
new_dLdy = reshape(dLdy,[196 3]);

new_dLdw = new_X*new_dLdy;
dLdw = reshape(new_dLdw,[3 3 1 3]);

for i = 1:w_conv_C2
    dLdb(i,1) = sum(sum(dLdy(:,:,i)));
end

end