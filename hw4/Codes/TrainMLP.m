function [w1,b1,w2,b2]=TrainMLP(mini_batch_x , mini_batch_y)

rng('default');


w1 = rand([30 196]);
b1 = rand([30,1]);
w2 = rand([10 30]);
b2 = rand([10,1]);


batches= size(mini_batch_x,1);
batch_size=size(mini_batch_x{1},2);
learning_rate=0.05;
decay_rate=0.75;
decay_interval=1000;
nIters=10000;

k=1;
for iIter= 1:nIters
    if rem(iIter,decay_interval)==0
     learning_rate=decay_rate*learning_rate;
    end
    dLdW1=0;
    dLdB1=0;
    dLdW2=0;
    dLdB2=0;
    
    for i=1: batch_size
        x=mini_batch_x{k}(:,i);
        a1 =FC(x,w1,b1);
        f1=ReLu(a1);
        a2=FC(f1,w2,b2);
        
        [L,dLdy]=Loss_cross_entropy_softmax(a2,mini_batch_y{k}(:,i));
        [dldx2 dldw2 dldb2]= FC_backward(dLdy, f1,w2,b2,a2);
        [dLdy1] = ReLu_backward(dldx2,a1,f1);
        [dldx1 dldw1 dldb1]= FC_backward(dLdy1, x,w1,b1,a1);
        dLdW1=dLdW1+dldw1;
        dLdB1=dLdB1+dldb1;
        dLdW2=dLdW2+dldw2;
        dLdB2=dLdB2+dldb2;
    end
    k=k+1;
    if k>batches
        k=1;
    end
    w1=w1-(learning_rate*dLdW1)/batch_size;
    b1=b1- (learning_rate*dLdB1)/batch_size;
    w2=w2-(learning_rate*dLdW2)/batch_size;
    b2=b2- (learning_rate*dLdB2)/batch_size;
    
  end

end