clc;
clear;
ID = "S4035593";
c = imread('cameraman.tif');
edges = edge(c, 'canny');
accum = myhough(edges);

[img,theta,rho] = myhough(edges);
figure(1);
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

function [accum, theta, rho] =myhough(E)
theta = -90:90;
[x, y] = size(E);

%boundary conditions
pmax =0;
for i =1:x
    for j=1:y
        if E(i,j) ==1
            for t = 1:length(theta)
                p = floor(i*cos(theta(t)) + j*sin(theta(t)));
                if abs(p) >pmax
                    pmax = abs(p);
                end
            end
        end
    end
end

accum = zeros(2*pmax,length(theta));
for i = 1:x
    for j = 1:y
        if E(i,j) ==1
            for t = 1:length(theta)
                angle = degtorad(theta(t));
                p = floor(pmax+1 + i*cos(angle) + j*sin(angle));
                accum(p,t) = accum(p,t) +1;
            end
        end
    end
end
rho = -pmax:pmax
end