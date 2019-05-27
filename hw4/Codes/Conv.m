function [y] = Conv(x, w_conv, b_conv)

[H,W,C1]=size(x);
[w_conv_H,w_conv_W,w_conv_C1,w_conv_C2]= size(w_conv);
y=zeros(H,W,w_conv_C2);
padding=1;
X=padarray(x,[padding, padding]);

X_transpose = im2col(X,[3,3]);
w = reshape(w_conv,[9,3]);
y_transpose = X_transpose'*w;
y = reshape(y_transpose,[14,14,3]);

for iBias = 1:w_conv_C2
    y(:,:,iBias) = y(:,:,iBias) + b_conv(iBias);
end