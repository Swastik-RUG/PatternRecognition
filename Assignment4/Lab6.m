% Q1
I = imread('dogGrayRipples.png');
I = im2double(I);
f = fft2(I);
f = log(1+f);
fs= fftshift(f);
f = abs(fs);
imshow(f,[]);
%Q6
mask=zeros(size(f));
[x, y] =find(f==max(f));
rows = size(f,1)
cols = size(f,2)
radius = 1
center = [x'; y']; 
[xMat,yMat] = meshgrid(1:cols,1:rows);
for i =1:size(center,2)   
    distFromCenter = sqrt((xMat-center(1,i)).^2 + (yMat-center(2,i)).^2);
    mask(distFromCenter<=radius)=1;
end   

figure, imshow(~mask,[]);title('Mask')
%Q10
fs=fs.*(~mask);
f = ifftshift(fs);
I = real(ifft2(f));
figure, imshow(I, []), title('Reconstructed');
