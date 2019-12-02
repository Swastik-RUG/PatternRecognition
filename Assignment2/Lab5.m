x1 = -10:1:20;
y1 = [];
y2 = [];
for i=1:length(x1)
    x = x1(i);
    a = 0.375;
    b = 0.25; 
    c = (-0.25*x.^2)+(2*x)-7.8474;
    tmp = sqrt(b.^2 - 4*a*c)/(2*a);
    y1(i) = -b+tmp;
    y2(i) = -b-tmp;
end
%txt1 = ['x2 = 2+sqrt(4-12*2*(x*x)-16*x+8*-8.8188)/(2*2*(x*x)-16*x+8*-8.8188)'];

figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1)
a = plot(x1, real(y1), 'b.-');
title("x2 = -0.25+sqrt(0.0625-4*0.375*((-0.25*x*x)+(2*x)-7.8474)",'Units', 'normalized', 'Position', [0.5, -0.06, 0]);
hold on;
plot(3,5,'b*');
plot(2,1, 'r*');

subplot(1,3,2)
b = plot(x1, real(y2), 'r.-');
title("x2 = -0.25-sqrt(0.0625-4*0.375*((-0.25*x*x)+(2*x)-7.8474)",'Units', 'normalized', 'Position', [0.5, -0.06, 0]);
hold on
plot(3,5,'b*');
plot(2,1, 'r*');

subplot(1,3,3)
a = plot(x1, real(y1), 'b.-');
hold on;
plot(3,5,'b*');
plot(2,1, 'r*');
b = plot(x1, real(y2), 'r.-');
hold on
plot(3,5,'b*');
plot(2,1, 'r*');

