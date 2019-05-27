function [dLdx] = Pool2x2_backward(dLdy, x, y)

[H,W,C]=size(x);
dLdx=zeros([H,W,C]);
pool_stride=2;
for i=1:pool_stride:H
    for j=1:pool_stride:W
        for k=1:C       
             if (x(i,j,k) == y((i+pool_stride-1)/2,(j+pool_stride-1)/2,k))
                dLdx(i,j,k) = dLdy((i+pool_stride-1)/2,(j+pool_stride-1)/2,k);
            elseif (x(i+pool_stride-1,j,k) == y((i+pool_stride-1)/2,(j+pool_stride-1)/2,k))
                dLdx(i+pool_stride-1,j,k) = dLdy((i+pool_stride-1)/2,(j+pool_stride-1)/2,k);
            elseif (x(i,j+pool_stride-1,k) == y((i+pool_stride-1)/2,(j+pool_stride-1)/2,k))
                dLdx(i,j+pool_stride-1,k) = dLdy((i+pool_stride-1)/2,(j+pool_stride-1)/2,k);
            else
                dLdx(i+pool_stride-1,j+pool_stride-1,k) = dLdy((i+pool_stride-1)/2,(j+pool_stride-1)/2,k);
            end
        end
    end
end
end