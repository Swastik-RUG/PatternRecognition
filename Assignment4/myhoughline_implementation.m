clc;
clear;
c = imread('cameraman.tif');
imshow(c);
title('Hough transform accumulator done by S4035593');
xlabel('\theta (Theta)')
ylabel('\rho (Rho)');
myhoughline(c,-21,-45);