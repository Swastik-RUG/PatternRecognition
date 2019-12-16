ID = "S4151968";
I  = rgb2gray(imread('chess.jpg'));
BW = edge(I,'Canny');
[H,T,R] = hough(BW);
P  = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2));
y = R(P(:,1));
figure('NumberTitle', 'off', 'Name', "HOUGH POINTS")
imshow(I);
hold on;
plot(x,y,'s','color','white');
set(gca,'Color','k')
title(["HOUGH LINES ["+ID+"]"])

max_len = 0;
lines = houghlines(BW,T,R,P)
f = figure('NumberTitle', 'off', 'Name', "HOUGH LINES")
imshow(I);
hold on;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
title(["HOUGH LINES ["+ID+"]"])


