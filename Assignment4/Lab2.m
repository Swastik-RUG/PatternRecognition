clc;
clear;
ID = "S4151968";
c = imread('cameraman.tif');
edges = edge(c, 'canny');
accum = myhough(edges);

[img,theta,rho] = myhough1(edges);
figure('NumberTitle', 'off', 'Name', 'Hough transform (myhough function) - ['+ID+']','units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
imshow(img, [], 'xData',theta, 'yData', rho, 'InitialMagnification','fit');
title('Hough transform (myhough function) - ['+ID+']');
xlabel('\theta (Theta)')
ylabel('\rho (Rho)');
axis on;
axis normal;


h= hough(edges);
subplot(1,2,2);
hc = hough(edges);
colormap(gray(256));
imagesc(hc);
title('Hough transform (hough function) - ['+ID+']');
xlabel('\theta (Theta)')
ylabel('\rho (Rho)');

function [H, theta, rho] =myhough1(E)
[x, y] = size(E);
distMax = round(sqrt(x^2+y^2));
theta = -90:1:89;
rho = -distMax:1:distMax;

H = zeros(length(rho),length(theta));
for i =1:x
    for j=1:y
        if E(i,j) ~= 0
            for itheta = 1:length(theta)
                t = theta(itheta)*pi/180;
                dist = x*cos(t)+ y*sin(t);
                [d, irho] = min(abs(rho-dist));
                if d<=1
                    H(irho,itheta) = H(irho,itheta)+1;
                end
            end
        end
    end
end
end