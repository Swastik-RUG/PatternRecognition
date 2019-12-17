clc;
clear;
ID = "S4035593";
c = imread('cameraman.tif');
edges = edge(c, 'canny');

[img,theta,rho] = myhough(edges);
P1  = houghpeaks(img,5);
figure('NumberTitle', 'off', 'Name', 'Hough transform (myhough function) - ['+ID+']','units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
imagesc(img, 'xData',theta, 'yData', rho);
title('Hough transform (myhough function) - ['+ID+']');
xlabel('\theta (Theta)')
ylabel('\rho (Rho)');
axis on;
axis normal;
hold on;
plot(theta(P1(:,2)),rho(P1(:,1)),'s','color','yellow');

[hc, t, r]= hough(edges);
P2 = houghpeaks(hc,5);
subplot(1,2,2);
colormap('hot');
imagesc(hc, 'Xdata', t, 'Ydata', r);
title('Hough transform (hough function) - ['+ID+']');
xlabel('\theta (Theta)')
ylabel('\rho (Rho)');
hold on;
plot(t(P2(:,2)),r(P2(:,1)),'s','color','yellow');

function [hc, th, rh] =myhough(E)
[x, y] = size(E);
distMax = round(sqrt(x^2+y^2));
theta = -90:1:90;
rho = -distMax:1:distMax;

H = zeros(length(rho),length(theta));
for i =1:x
    for j=1:y
        if E(i,j) ~= 0
            for itheta = 1:length(theta)
                t = theta(itheta)*pi/180;
                dist = j*cos(t)+ i*sin(t);
                [d, irho] = min(abs(rho-dist));
                if d<=1
                    H(irho,itheta) = H(irho,itheta)+1;
                end
            end
        end
    end
end
hc = H;
th = theta;
rh = rho;
end