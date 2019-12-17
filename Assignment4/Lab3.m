ID = "S4035593";
I  = rgb2gray(imread('chess.jpg'));
BW = edge(I,'Canny');
[H,T,R] = hough(BW);
P  = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2));
y = R(P(:,1));
figure('NumberTitle', 'off', 'Name', "HOUGH POINTS")
%imshow(I);
hold on;
plot(x,y,'s','color','white');
set(gca,'Color','k')
title(["HOUGH POINTS ["+ID+"]"])

figure('NumberTitle', 'off', 'Name', "HOUGH LINES")
max_len = 0;
imshow(I);
hold on;
for i=1:length(x)
    myhoughline(I, y(i), x(i));
    hold on
end
title(["HOUGH LINES ["+ID+"]"])

