function [A_refined]=AlignImage(template,target,A)

Template_size=size(template);
I_warped=zeros(Template_size,class(template));
p=[A(1,1)-1; A(1,2); A(1,3); A(2,1); A(2,2)-1; A(2,3)];
[Ix,Iy] = imgradientxy(template);
H=zeros(6,6);

for i=1:Template_size(1)
    for j=1:Template_size(2)
       x1=[j;i;1];
       x2=floor(A*x1);
%        u=x2(1)-x1(1);
%        v=x2(2)-x1(2);
       delW_delp=[[x1(1) x1(2) 1 0 0 0]; [0 0 0 x1(1) x1(2) 1]];
       H=H+([Ix(i,j) Iy(i,j)]*delW_delp)'*([Ix(i,j) Iy(i,j)]*delW_delp);
    end
end

epsilon=0.03;
%F=zeros(6,1);
error=[];
iter=0;
while(iter<=300)
   I_warped=zeros(Template_size,class(template));
  F=zeros(6,1);
   for i=1:Template_size(1)
    for j=1:Template_size(2)
       x1=[j;i;1];
       x2=floor(A*x1);
       if x1(2)<1 || x1(2)> Template_size(1)  || x1(1)<1 || x1(1)> Template_size(2)
           continue;
           
       end
%        u=x2(1)-x1(1);
%        v=x2(2)-x1(2);
       delW_delp=[[x1(1) x1(2) 1 0 0 0]; [0 0 0 x1(1) x1(2) 1]];
       I_warped(x1(2),x1(1))=target(x2(2),x2(1));
       I_error=I_warped(i,j)-template(i,j);
       F=F+( ([Ix(i,j) Iy(i,j)]*delW_delp)'*[double(I_error)]);
    end 
   end
  
   delp=inv(H)*F;
  % p=p+delp;
 %  A_prev=[[p(1)+1 p(2) p(3)]; [p(4) p(5)+1 p(6)]; [0 0 1]];
   del_A=[[delp(1)+1 delp(2) delp(3)]; [delp(4) delp(5)+1 delp(6)]; [0 0 1]];
   A= A*inv(del_A);
  temp_error=norm(double((I_warped-template)), 'fro');
  error=[error; abs(temp_error)]
  iter=iter+1;
  
  
  
 if  norm(delp,'fro')<epsilon
        break;
        end

end
final_delp=norm(delp,'fro')
x=1:iter;
figure;
plot(x,error');
A_refined=A;

end


