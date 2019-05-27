function [w, b] = TrainSLP(mini_batch_x, mini_batch_y)

rng('default');


w = normrnd(0,1,[10 196]);
b = normrnd(0,1,[10 1]);

batches= size(mini_batch_x,1);
batch_size=size(mini_batch_x{1},2);
learning_rate=0.2;
decay_rate=0.9;
decay_interval=1000;
nIters=10000;

k=1;
loss_iter=0;
for iIter= 1:nIters
    if rem(iIter,decay_interval)==0
     learning_rate=decay_rate*learning_rate;
    end
    dLdW=0;
    dLdB=0;
    
    for i=1: batch_size
        x=mini_batch_x{k}(:,i);
        y_tilde =FC(x,w,b);
        [L,dLdy]=Loss_cross_entropy_softmax(y_tilde,mini_batch_y{k}(:,i));
        [dldx dldw dldb]= FC_backward(dLdy, x,w,b,y_tilde);
        dLdW=dLdW+dldw;
        dLdB=dLdB+dldb;
        % loss_iter=loss_iter+L;
    end
    k=k+1;
    if k>batches
        k=1;
    end
    w=w-(learning_rate*dLdW)/batch_size;
    b=b- (learning_rate*dLdB)/batch_size;
     % loss_iter=loss_iter/batch_size
  end


end