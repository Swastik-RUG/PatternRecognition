clc;
clear;
ID = "S4035593";
c = imread('cameraman.tif');
%imshow(c);
edges = edge(c, 'canny');
hc = hough(edges);
figure(1)
imagesc(hc);
title('Hough transform accumulator done by '+ID);
xlabel('\theta (Theta)')
ylabel('\rho (Rho)');
%figure(2);
%colormap(gray(256));
%imshow(hcTh);
[H,T,R] = hough(edges);
figure(3);
colormap(gray(256));
P  = houghpeaks(hc,5);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
title('five strongest local maxima points done by '+ID);
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(T(P(:,2)),R(P(:,1)),'s','color','yellow');
