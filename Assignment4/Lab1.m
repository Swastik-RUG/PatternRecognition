clc;
clear;
ID = "S4035593";
c = imread('cameraman.tif');
%imshow(c);
edges = edge(c, 'canny');
[hc, theta, rho] = hough(edges);
hcTh = hc;
hcTh(hcTh < 0.999 * max(hc(:))) = 0;

figure(1)
colormap('hot');
imagesc(hc);
title('Hough transform accumulator done by '+ID);
xlabel('\theta (Theta)')
ylabel('\rho (Rho)');
%figure(2);
%colormap(gray(256));
%imshow(hcTh);
[H,T,R] = hough(edges);
figure(3);
P  = houghpeaks(hc,5);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
title('five strongest local maxima points done by '+ID);
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(T(P(:,2)),R(P(:,1)),'s','color','yellow');

figure()
colormap('hot');
imshow(c)
% Get the strongest peak, i.e at position 1.
P  = P(1,:);
myhoughline(c, rho(P(:,1)), theta(P(:,2)))
title('CAMERAMAN.tif STRONGEST LINE done by '+ID);