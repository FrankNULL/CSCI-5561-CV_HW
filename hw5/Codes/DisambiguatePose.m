function [R,C,X] = DisambiguatePose(R1,C1,X1,R2,C2,X2,R3,C3,X3,R4,C4,X4)

nValid=zeros(1,4);
for i=1:size(X1,1)
    cheirality1=R1(3,:)*(X1(i,:)-C1)';
    if cheirality1>0
        nValid(1,1)=nValid(1,1)+1;
    end
    
    cheirality2=R2(3,:)*(X2(i,:)-C2)';
    if cheirality2>0
        nValid(1,2)=nValid(1,2)+1;
    end
    
    cheirality3=R3(3,:)*(X3(i,:)-C3)';
    if cheirality3>0
        nValid(1,3)=nValid(1,3)+1;
    end
    
    cheirality4=R4(3,:)*(X4(i,:)-C4)';
    if cheirality4>0
        nValid(1,4)=nValid(1,4)+1;
    end
    
    
end

[m,i]=max(nValid);
if i==1
    R=R1;
    C=C1;
    X=X1;
end

if i==2
    R=R2;
    C=C2;
    X=X2;
end

if i==3
    R=R3;
    C=C3;
    X=X3;
end

if i==4
    R=R4;
    C=C4;
    X=X4;
end

end