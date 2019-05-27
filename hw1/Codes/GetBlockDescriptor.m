function [ori_histo_normalized]=GetBlockDescriptor(ori_hist,block_size)
[M,N,P]=size(ori_hist);
hi=zeros(1,1, P*block_size*block_size);
hi_hat=zeros(1,1, P*block_size*block_size);
e=0.001;
ori_histo_normalized=zeros(M-1,N-1,P*block_size*block_size);

for i=1:M-(block_size-1)
    for j=1:N-(block_size-1)
        temp = zeros(1,1,6*block_size*block_size);
        k= 1;
        for cnt1 = 1:block_size
            for cnt2=1:block_size
                holder = ori_hist(i+cnt1-1,j+cnt2-1,:);
            temp(1,1,(k-1)*6+1:6*k) = holder(:);    
            k =k+1;
            end
        end
%         hi=cat(3, ori_hist(i,j,:), ori_hist(i,j+1,:), ori_hist(i+1,j,:), ori_hist(i+1,j+1,:));
            hi = temp;
         hi_hat=hi/sqrt(sum(hi.*hi)+e*e);
         ori_histo_normalized(i,j,:)=hi_hat;
    end
end
        