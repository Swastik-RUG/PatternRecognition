clc;
clear;
c = imread('cameraman.tif');
%imshow(c);
edges = edge(c, 'canny');
hc = hough(edges);
hcTh = 0.999*hc;
figure(1)
imagesc(hc);
title('Hough transform accumulator done by S4035593');
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
title('five strongest local maxima points done by S4035593');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(T(P(:,2)),R(P(:,1)),'s','color','yellow');


function myhoughline(image,r,theta)
[x,y]=size(image);
angle=deg2rad(theta);
if sin(angle)==0
    line([r r],[0,y],'Color','red')
else
    line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
end
end



