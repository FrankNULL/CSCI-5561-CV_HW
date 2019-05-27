function [x1, x2]=FindMatch (I1,I2)

Template_gray=rgb2gray(I1);
Target_gray=rgb2gray(I2);
IS1=single(Template_gray);
IS2=single(Target_gray);


% imshow(Template);
% imshow(Target);

[f1,d1] = vl_sift(IS1);
[f2,d2] = vl_sift(IS2);
[matches, scores] = vl_ubcmatch(d1, d2) ;
% x1=zeros(size(d1,1),2);
% x2=zeros(size(d2,1),2);

IDXLR = knnsearch(d2',d1','K',2);
matchIndex1LR=1:size(IDXLR);
matchIndex2LR=IDXLR';

% matchedPoint1=f1(1:2,matchIndex1);
% matchedPoint2=f2(1:2,matchIndex2());



  a=double(d1(:,matchIndex1LR))-double(d2(:,matchIndex2LR(1,:)));
  dist1_tempLR=a.*a;
  b=double(d1(:,matchIndex1LR))-double(d2(:,matchIndex2LR(2,:)));
  dist2_tempLR=b.*b;
  
  
  
  %dist1_tempLR=((double(d1(:,matchIndex1LR)-d2(:,matchIndex2LR(1,:))).*(double(d1(:,matchIndex1LR)-d2(:,matchIndex2LR(1,:))))));  
  %dist2_tempLR=((d1(:,matchIndex1LR)-d2(:,matchIndex2LR(2,:))).*(d1(:,matchIndex1LR)-d2(:,matchIndex2LR(2,:)))); 
  dist1LR=sqrt(sum(dist1_tempLR));
  dist2LR=sqrt(sum(dist2_tempLR));
  ratioLR=dist1LR./dist2LR;
  
  matchIndex2RatioTestLR=[];
  matchIndex1RatioTestLR=[];
  for i=1:size(dist1LR,2)
    if( ratioLR(1,i)<=0.7)
        indexLR=matchIndex2LR(1,i);
        matchIndex1RatioTestLR=[matchIndex1RatioTestLR;i];
        matchIndex2RatioTestLR=[matchIndex2RatioTestLR;indexLR];
    end
  end
  
matchedPoint1LR=f1(1:2,matchIndex1RatioTestLR);
matchedPoint2LR=f2(1:2,matchIndex2RatioTestLR);

% x1=matchedPoint1LR';
% x2=matchedPoint2LR';

%right to left
IDXRL = knnsearch(d1',d2','K',2);
matchIndex1RL=1:size(IDXRL);
matchIndex2RL=IDXRL';

% matchedPoint1=f1(1:2,matchIndex1);
% matchedPoint2=f2(1:2,matchIndex2());




  c=double(d2(:,matchIndex1RL))- double(d1(:,matchIndex2RL(1,:)));
  d=double(d2(:,matchIndex1RL))- double(d1(:,matchIndex2RL(2,:)));
  dist1_tempRL=c.*c;
  dist2_tempRL=d.*d;

  %dist1_tempRL=((d2(:,matchIndex1RL)-d1(:,matchIndex2RL(1,:)).*(d2(:,matchIndex1RL)-d1(:,matchIndex2RL(1,:)))));  
  %dist2_tempRL=((d2(:,matchIndex1RL)-d1(:,matchIndex2RL(2,:))).*(d2(:,matchIndex1RL)-d1(:,matchIndex2RL(2,:)))); 
  dist1RL=sqrt(sum(dist1_tempRL));
  dist2RL=sqrt(sum(dist2_tempRL));
  ratioRL=dist1RL./dist2RL;
  
  matchIndex2RatioTestRL=[];
  matchIndex1RatioTestRL=[];
  for i=1:size(dist1RL,2)
    if( ratioRL(1,i)<=0.7)
        indexRL=matchIndex2RL(1,i);
        matchIndex1RatioTestRL=[matchIndex1RatioTestRL;i];
        matchIndex2RatioTestRL=[matchIndex2RatioTestRL;indexRL];
    end
  end
  
matchedPoint1RL=f2(1:2,matchIndex1RatioTestRL);
matchedPoint2RL=f1(1:2,matchIndex2RatioTestRL);

x1=[];
x2=[];
for i=1:size(matchedPoint1LR,2)
    for j=1:size(matchedPoint1RL,2)
        
        if( (matchedPoint1LR(1,i)==matchedPoint2RL(1,j)) &&  (matchedPoint2LR(1,i)==matchedPoint1RL(1,j))  && ...
             (matchedPoint1LR(2,i)==matchedPoint2RL(2,j)) &&  (matchedPoint2LR(2,i)==matchedPoint1RL(2,j))    )
           temp=matchedPoint1LR(:,i)';
           x1=[x1;temp];
           temp=matchedPoint2LR(:,i)';
            x2=[x2;temp];
        end
    end
end



 %ShowMatchedPoints(x1,x2, Template_gray,Target_gray);
% clc;