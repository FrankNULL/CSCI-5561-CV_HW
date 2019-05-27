function [disp] = DenseMatch(im1, im2)
im1_new=single(rgb2gray(im1));
im2_new=single(rgb2gray(im2));
im1_padded=zeros(size(im1,1)+9, size(im1,2)+9);
im2_padded=zeros(size(im1,1)+9, size(im1,2)+9);


for i=1:size(im1,1)
    for j=1:size(im1,2)
      im1_padded(i+5,j+5)=im1_new(i,j);
      im2_padded(i+5,j+5)=im2_new(i,j);
    end
end
[f1, d1] = vl_dsift(single(im1_padded),'step',1) ;
[f2, d2] = vl_dsift(single(im2_padded),'step',1) ;
d1_new=reshape(d1',[size(im1,1) size(im1,2),128]);
d2_new=reshape(d2',[size(im1,1) size(im1,2),128]);
disparity=zeros(size(im1,1), size(im1,2));
dscr_ctr=1;
for i=1:size(im1,1)
    for j=1:size(im1,2)
        %pixel_descriptor=zeros(1,size(im1,2));
        temp1=double(d1_new(i,j,:));
        t1=reshape(temp1,[128 1]);
         temp2=double(d2_new(i,1:j,:));
        t2=reshape(temp2,[j 128])';
        t1_rep=repmat(t1,[1 j]);
        pixel_descriptor=vecnorm(t1_rep-t2);
         [minimum,index]=min(pixel_descriptor);
         disparity(i,j)=abs(index-j);
    end
      
        
       
end
disp=disparity;
end