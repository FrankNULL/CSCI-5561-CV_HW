function [F] = ComputeF(x1, x2)

rng(1);
ransac_iter=100000;
inliers=zeros(ransac_iter,1);
F_matrices=cell(ransac_iter,1);
iter=1;
ransac_thr=0.01;

while iter<=ransac_iter
   
    I=randperm(size(x1,1),8);
    cnt_inliers=0;

    A=[  x1(I(1),1)*x2(I(1),1)   x1(I(1),2)*x2(I(1),1)   x2(I(1),1)   x1(I(1),1)*x2(I(1),2)    x1(I(1),2)*x2(I(1),2)   x2(I(1),2)  x1(I(1),1)  x1(I(1),2)   1;
             x1(I(2),1)*x2(I(2),1)   x1(I(2),2)*x2(I(2),1)   x2(I(2),1)   x1(I(2),1)*x2(I(2),2)    x1(I(2),2)*x2(I(2),2)   x2(I(2),2)  x1(I(2),1)  x1(I(2),2)   1;
             x1(I(3),1)*x2(I(3),1)   x1(I(3),2)*x2(I(3),1)   x2(I(3),1)   x1(I(3),1)*x2(I(3),2)    x1(I(3),2)*x2(I(3),2)   x2(I(3),2)  x1(I(3),1)  x1(I(3),2)   1;
             x1(I(4),1)*x2(I(4),1)   x1(I(4),2)*x2(I(4),1)   x2(I(4),1)   x1(I(4),1)*x2(I(4),2)    x1(I(4),2)*x2(I(4),2)   x2(I(4),2)  x1(I(4),1)  x1(I(4),2)   1;
             x1(I(5),1)*x2(I(5),1)   x1(I(5),2)*x2(I(5),1)   x2(I(5),1)   x1(I(5),1)*x2(I(5),2)    x1(I(5),2)*x2(I(5),2)   x2(I(5),2)  x1(I(5),1)  x1(I(5),2)   1;
             x1(I(6),1)*x2(I(6),1)   x1(I(6),2)*x2(I(6),1)   x2(I(6),1)   x1(I(6),1)*x2(I(6),2)    x1(I(6),2)*x2(I(6),2)   x2(I(6),2)  x1(I(6),1)  x1(I(6),2)   1;
             x1(I(7),1)*x2(I(7),1)   x1(I(7),2)*x2(I(7),1)   x2(I(7),1)   x1(I(7),1)*x2(I(7),2)    x1(I(7),2)*x2(I(7),2)   x2(I(7),2)  x1(I(7),1)  x1(I(7),2)   1;
             x1(I(8),1)*x2(I(8),1)   x1(I(8),2)*x2(I(8),1)   x2(I(8),1)   x1(I(8),1)*x2(I(8),2)    x1(I(8),2)*x2(I(8),2)   x2(I(8),2)  x1(I(8),1)  x1(I(8),2)   1];
   % A_temp=inv(X1*X1')*X1*X2';
   [U,S,V]=svd(A'*A);
   F_temp=reshape(V(:,9),[3 3])';
   F_temp=F_temp./F_temp(3,3);
   [U,D,V]=svd(F_temp);
   D(3,3)=0;
   F_temp=[];
   F_temp=U*D*V';
    for i=1:size(x1,1)
            
       v_transpose= [ x2(i,1); x2(i,2); 1]';
       u = [ x1(i,1); x1(i,2); 1];
       err=abs( v_transpose*F_temp*u);
        if(err<ransac_thr)
            cnt_inliers=cnt_inliers+1;
        end
    end
    
    inliers(iter,1)=cnt_inliers;
    F_matrices{iter}= F_temp;
    F_temp=[];
    
    
    iter=iter+1;
end

[val,idx]=max(inliers);
F=F_matrices{idx};

%%%%%% SVD cleanup%%%%%%%%%%%%%



end