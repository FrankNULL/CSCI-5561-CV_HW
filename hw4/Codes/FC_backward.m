function [dLdx dLdw dLdb]= FC_backward(dLdy, x,w,b,y)

dLdw=dLdy*x';

dLdb= dLdy;

dLdx= w'*dLdy;



end