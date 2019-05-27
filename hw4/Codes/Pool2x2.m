function [y]=Pool2x2(x)

[H,W,C]=size(x);
pool_stride=2;
y=zeros(H/pool_stride,W/pool_stride,C);

for i=1:pool_stride:H
    for j=1:pool_stride:W
        for k=1:C
            
         pool_batch=[x(i,j,k),x(i+pool_stride-1,j,k),x(i,j+pool_stride-1,k),x(i+pool_stride-1,j+pool_stride-1,k)];
         y((i+pool_stride-1)/2,(j+pool_stride-1)/2,k) = max(pool_batch); 
            
        end
    end
end



end







