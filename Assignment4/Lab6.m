ID = "S4151968";
% Q1
I = imread('dogGrayRipples.png');
I = im2double(I);
f = fft2(I);
fs= fftshift(f);
f = abs(fs);
f = log(1+f);
imshow(f,[]);
title(["FOURIER TRANSFORMED ["+ID+"]"])

%Q6
[x, y] =find(f==max(f));
r = 13;
rows = size(f,1),cols = size(f,2),radius = r,center = [x'; y'];  
[xMat,yMat] = meshgrid(1:cols,1:rows);
mask=zeros(size(f));
for i =1:size(center,2)   
    distFromCenter = sqrt((xMat-center(1,i)).^2 + (yMat-center(2,i)).^2);
    mask(distFromCenter<=radius)=1;
end   

figure, imshow(~mask,[]);title('Mask')
title(["MASK ["+ID+"]"])

%Q10
fs=fs.*(~mask);
f = ifftshift(fs);
I = real(ifft2(f));

figure, imshow(I, []), title([sprintf("Reconstructed at Radius = %d by [%s]", radius, ID)])

