function [w_conv, b_conv, w_fc, b_fc] = TrainCNN(mini_batch_x, mini_batch_y)

rng('default');

w_conv = rand(3,3,1,3);
b_conv = rand(3,1);
w_fc = rand(10,147);
b_fc = rand(10,1);
k = 1;
batches= size(mini_batch_x,1);
batch_size=size(mini_batch_x{1},2);
learning_rate=0.1;
decay_rate=0.8;
decay_interval=1000;
nIters=10000;

for iIter= 1:nIters
    if rem(iIter,decay_interval)==0
     learning_rate=decay_rate*learning_rate;
    end
    dLdw_conv=0;
    dLdb_conv=0;
    dLdw_fc=0;
    dLdb_fc=0;
    loss_iter=0;
    for i=1: batch_size
        x=mini_batch_x{k}(:,i);
        X=reshape(x,[14 14 1]);
        convoluted_X=Conv(X,w_conv,b_conv);
        f=ReLu(convoluted_X);
        pooled_f=Pool2x2(f);
        flattened=Flattening(pooled_f);
        FC_layer=FC(flattened,w_fc,b_fc);
       [ L,dldyFC_layer] = Loss_cross_entropy_softmax(FC_layer,mini_batch_y{k}(:,i));
        
        [dldflattened, dldw_fc, dldb_fc] = FC_backward(dldyFC_layer, flattened, w_fc, b_fc, FC_layer);
        dldpooled = Flattening_backward(dldflattened, pooled_f, flattened);
        dldf = Pool2x2_backward(dldpooled, f, pooled_f);
        dldconvoluted_X = ReLu_backward(dldf, convoluted_X, f);
         [dldw_conv, dldb_conv] = Conv_backward(dldconvoluted_X,X, w_conv, b_conv, convoluted_X);
         dLdw_conv = dLdw_conv + dldw_conv;
         dLdb_conv = dLdb_conv + dldb_conv;
         dLdw_fc = dLdw_fc + dldw_fc;
         dLdb_fc = dLdb_fc + dldb_fc;
          loss_iter=loss_iter+L;
    end
    k=k+1;
    if k>batches
        k=1;
    end
    w_conv=w_conv-(learning_rate*dLdw_conv)/batch_size;
    b_conv=b_conv- (learning_rate*dLdb_conv)/batch_size;
    w_fc=w_fc-(learning_rate*dLdw_fc)/batch_size;
    b_fc=b_fc- (learning_rate*dLdb_fc)/batch_size;
    
    
  end

end