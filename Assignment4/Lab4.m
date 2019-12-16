clear all;
close all;
ID = "S4151968";
rng(100)
I = imread('HeadTool0002.bmp');
I = im2double(I);
I2 = adapthisteq(I);
%'ObjectPolarity','bright',
sensitivities = [0.89, 0.90, 0.92, 0.932, 0.94, 0.95];
figure('NumberTitle', 'off', 'Name', "Head tool",'units','normalized','outerposition',[0 0 1 1])
for i=1:length(sensitivities)
    sp = subplot(2,3,i);
     sp.Position = sp.Position + [0 0 0.05 0];
    imshow(I2);
    [c, r] = imfindcircles(I2,[20 40],'Sensitivity',sensitivities(i));
    viscircles(c, r, 'EdgeColor', 'r')
    title(["HEAD TOOL WITH SENSITIVITY ="+sensitivities(i)+ "["+ID+"]"])
end

figure('NumberTitle', 'off', 'Name', "HEAD TOOL STRONGEST CIRCLE",'units','normalized','outerposition',[0 0 1 1])
imshow(I2);
[c, r] = imfindcircles(I2,[20 40],'Sensitivity',0.932);
viscircles(c, r, 'EdgeColor', 'r')
title(["HEAD TOOL WITH STRONGEST CIRCLE; SENSITIVITY = 0.932 ["+ID+"]"])

