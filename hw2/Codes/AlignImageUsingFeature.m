function [A]=AlignImageUsingFeature(x1,x2, ransac_thr,ransac_iter)

rng(1);
inliers=zeros(ransac_iter,1);
A_matrices=cell(ransac_iter,1);
iter=1;
while iter<=ransac_iter
    
    X1=[];
    X2=[];
    I=randperm(size(x1,1),3);
    cnt_inliers=0;
    X1=[  [x1(I(1),1) x1(I(1),2) 1]' ,[x1(I(2),1) x1(I(2),2) 1]' ,[x1(I(3),1) x1(I(3),2) 1]' ];
    X2=[  [x2(I(1),1) x2(I(1),2) 1]' ,[x2(I(2),1) x2(I(2),2) 1]' ,[x2(I(3),1) x2(I(3),2) 1]' ];
    
   % A_temp=inv(X1*X1')*X1*X2';
   A_temp=inv(X1')*X2';
    A_final=A_temp';
    for i=1:size(x1,1)
       % I_prime=randperm(size(x1,1),3); 
       % X1_check= [x1(I_prime(1),:); x1(I_prime(2),:); x1(I_prime(3),:)];
       %X1_check =[  [x1(I_prime(1),1)    x1(I_prime(1),2)    1]' ,[x1(I_prime(2),1)    x1(I_prime(2),2)    1]' ,[x1(I_prime(3),1)    x1(I_prime(3),2)    1]' ];
        %X2= [x2(I_prime(1),:); x2(I_prime(2),:); x2(I_prime(3),:)];
       %X2 =[  [x2(I_prime(1),1)    x2(I_prime(1),2)    1]' ,[x2(I_prime(2),1)    x2(I_prime(2),2)    1]' ,[x2(I_prime(3),1)    x2(I_prime(3),2)    1]' ];
        
       X1_check= [ x1(i,1); x1(i,2); 1];
       X2 = [ x2(i,1); x2(i,2); 1];
        
        X2_prime= A_final*X1_check;
        d= norm(abs(X2_prime-X2),'fro');
        d;
        if(d<ransac_thr)
            cnt_inliers=cnt_inliers+1;
        end
    end
    
    inliers(iter,1)=cnt_inliers;
    A_matrices{iter}= A_final;
    A_final=[];
    A_temp=[];
    
    
    iter=iter+1;
end

[val,idx]=max(inliers);
A=A_matrices{idx};



end
    