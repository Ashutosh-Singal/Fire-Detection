img=imread('imageName');
tau=100;
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
hsv=rgb2hsv(img);
% Convert RGB to YCbCr
ycbcrmap=rgb2ycbcr(img);
Y=ycbcrmap(:,:,1);
Cb=ycbcrmap(:,:,2);
Cr=ycbcrmap(:,:,3);
% Calculate Ymean
[a,b]=size(Y);
SumaLinii=sum(Y);
total=sum(SumaLinii);
Ymean=total/(a*b);
% Calculate CbMean
[a,b]=size(Cb);
SumaLinii=sum(Cb);
total=sum(SumaLinii);
CbMean=total/(a*b);
% Calculate CrMean
[a,b]=size(Cr);
SumaLinii=sum(Cr);
total=sum(SumaLinii);
CrMean=total/(a*b);

h=hsv(:,:,1);
h=round(h,2);
s=hsv(:,:,2);
s=round(s,2);
v=hsv(:,:,3);
v=round(v,2);
[lin,col]=size(s);
test=ones(lin,col)*255;
for i=1:lin
    for j=1:col
        if(~(abs((Cb(i,j)-Cr(i,j))<tau) && (Y(i,j)>=Ymean) && (Cb(i,j)<=CbMean) && (Cr(i,j)>=CrMean) && Y(i,j)>=Cb(i,j) && Cr(i,j)>=Cb(i,j) && Cb(i,j)<=100 && Cr(i,j)>=150 ))
            test(i,j)=0;
        end
    end
end
BW2 = bwareaopen(test,100);
test=imclearborder(test);
imshowpair(img,test,'montage')
