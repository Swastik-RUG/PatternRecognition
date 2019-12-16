clear all;
close all;
ID = "S4151968";
rng(100)
I = imread('HeadTool0002.bmp');
I = im2double(I);
I2 = adapthisteq(I, 'ClipLimit', 0.3);
%'ObjectPolarity','bright',
sensitivities = [0.89, 0.90];
figure('NumberTitle', 'off', 'Name', "Head tool",'units','normalized','outerposition',[0 0 1 1])
tolerance = 200;
for i=1:length(sensitivities)
    sp = subplot(1,2,i);
     sp.Position = sp.Position + [0 0 0.05 0];
    imshow(I2);
    [c, r] = imfindcircles(I2,[20 40],'Sensitivity',sensitivities(i));
    viscircles(c, r, 'EdgeColor', 'r')
    title(["HEAD TOOL WITH SENSITIVITY ="+sensitivities(i)+ "["+ID+"]"])
end

figure('NumberTitle', 'off', 'Name', "HEAD TOOL STRONGEST CIRCLE",'units','normalized','outerposition',[0 0 1 1])
imshow(I2);
[c, r] = imfindcircles(I2,[20 40],'Sensitivity',0.9);
circleRadiiVector = [c r];
sortedCircles = sortrows(circleRadiiVector, 3, 'desc');
centersStrong = sortedCircles(1:2,1:2); 
radiiStrong = sortedCircles(1:2,3);
viscircles(centersStrong, radiiStrong, 'EdgeColor', 'r')
title(["HEAD TOOL WITH STRONGEST CIRCLE; SENSITIVITY = 0.9 ["+ID+"]"])

