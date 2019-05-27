function [dLdx] = ReLu_backward(dLdy,x,y)
% dLdx=zeros(1,size(dLdy,2));
% for i=1:size(dLdy,2)
% if y(i)>0
%     dLdx(i)=dLdy(i);
% else
%     dLdx(i)=0;
% 
%      end
% 
%   end


    dLdx = dLdy.*(y >= 0);
end