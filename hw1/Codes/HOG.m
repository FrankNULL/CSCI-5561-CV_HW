function [hog]=HOG(I) %This has been removed for the time being for the
%purpopurpose of execution. To be added later.

figure(1), imshow(I);
inputImage=rgb2gray(I);
inputdouble=im2double(inputImage);
cell_size=8;
block_size=3;
[filter_x,filter_y]= getDifferentialFilter();
im_filtered_x= filterImage(inputdouble,filter_x);
figure(2);
imagesc(im_filtered_x);
im_filtered_y=filterImage(inputdouble,filter_y);
figure(3);
imagesc(im_filtered_y);
[grad_mag,grad_angle]= getGradient(im_filtered_x,im_filtered_y);
figure(4), imagesc(grad_mag);
figure(5), imagesc(grad_angle);






%figure(6);
[m,n,p]=size(I);
[x,y]=meshgrid(1:2:n,1:2:m);


figure; imshow(inputImage); hold on
q=quiver(x,y,im_filtered_x(1:2:m,1:2:n),im_filtered_y(1:2:m,1:2:n));
q.AutoScaleFactor = 3;
q.ShowArrowHead = 'off';
q.Color='r';
q.LineWidth=2;


[ori_hist]=BuildHistogram(grad_mag,grad_angle,cell_size);
[ori_histo_normalized]=GetBlockDescriptor(ori_hist,block_size);

hog=zeros(size(ori_histo_normalized,1)*size(ori_histo_normalized,2)*size(ori_histo_normalized,3),1);
dim3=size(ori_histo_normalized,3);
k=1;
for i=1: size(ori_histo_normalized,1)
    for j=1: size(ori_histo_normalized,2)
        temp = permute(ori_histo_normalized(i,j,:),[3 2 1]);
        hog((k-1)*dim3 +1: dim3*k)=temp;
        k=k+1;
        
    end
end
        
        
        
        
        

%disp(hog);
%figure
[HOGoutput]= VisualizeHOG(ori_hist,I);




