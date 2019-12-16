clc;
clear;
c = imread('cameraman.tif');
imshow(c);
title('Hough transform accumulator done by S4035593');
xlabel('\theta (Theta)')
ylabel('\rho (Rho)');
myhoughline(c,-21,-45);
function myhoughline(image,r,theta)
[x,y]=size(image);
angle=deg2rad(theta);
if sin(angle)==0
    line([r r],[0,y],'Color','red')
else
    line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
end
end