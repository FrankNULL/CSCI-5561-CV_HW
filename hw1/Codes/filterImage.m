function [im_filtered]=filterImage(im,filter)

[m,n]=size(im);
paddedImage=zeros(m+2, n+2);
for i=1: m
    for j=1:n
        paddedImage(i+1,j+1)=im(i,j);
%         disp(i);
%         disp(j)
    end
end  
% figure;
% imshow (paddedImage)

 [padded_m, padded_n]=size(paddedImage);
% [filter_m, filter_n]=size(filter);
 im_filtered=zeros(m,n);
% sumcell=0;
% for i=1:padded_m-2
%     for j=1:padded_n-2
%          for filter_x= 1:filter_m
%              for filter_y=1:filter_n
%                  offset_x=i-1;
%                  offset_y=j-1;
%                  sumcell=sumcell+(paddedImage(filter_x+offset_x,filter_y+offset_y)*filter(filter_x,filter_y));
%              end
%          end
%          im_filtered(i,j)=sumcell;
%          sumcell=0;
%     end
% end
% % figure(1);
% % imshow(im_filtered);
% % figure(2);
% % imshow(paddedImage);

for i=2:padded_m-1
    for j=2:padded_n-1
        im_filtered(i-1,j-1)=sum(sum(filter.*paddedImage(i-1:i+1,j-1:j+1)));
    end
end
%figure(1);
%imshow(im_filtered);
