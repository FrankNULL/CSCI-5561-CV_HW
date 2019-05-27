function [I_warped]= WarpImage(I,A,output_size)

% figure;
% imshow(I);
input_size=size(I);
I_warped=zeros(output_size,class(I));
for i=1:output_size(1)
    for j=1:output_size(2)
       x1=[j;i;1];
       x2=floor(A*x1);
       I_warped(x1(2),x1(1))=I(x2(2),x2(1));
                                                               
                                                               % for each
                                                               % pixel in
                                                               % template
                                                               % image, x1,
                                                               % multiply
                                                               % it with A
                                                               % and get
                                                               % corresponding
                                                               % point x2
                                                               % in target.
                                                               % Look up
                                                               % the value
                                                               % of that
                                                               % pixel in
                                                               % the target
                                                               % image and
                                                               % copy it
                                                               % back to
                                                               % the
                                                               % template.
                                                               % This is
                                                               % warping
                                                               % the target
                                                               % to the
                                                               % template.
                                                           
    end
end
%image(uint8(I_warped));

figure;
imshow(I_warped);