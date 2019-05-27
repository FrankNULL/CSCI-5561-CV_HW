function [L, dLdy] = Loss_cross_entropy_softmax(x, y) 

sf = softmax(x);
L=-y'*log(sf);
dLdy=(sf-y);

end